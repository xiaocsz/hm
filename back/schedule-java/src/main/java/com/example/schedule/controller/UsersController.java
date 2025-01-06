package com.example.schedule.controller;

import com.example.schedule.common.ApiResponse;
import com.example.schedule.entity.Users;
import com.example.schedule.jwt.JwtUtil;
import com.example.schedule.jwt.UserContextUtil;
import com.example.schedule.service.IUsersService;
import lombok.AllArgsConstructor;
import lombok.Data;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author Admin
 * @since 2024-12-27
 */
@RestController
@RequestMapping("/users")
@AllArgsConstructor
public class UsersController {

    private final IUsersService usersService;

    /**
     * <p>用户注册</p>
     *
     * @author Admin
     * @time 2024-12-27 22:47:55
     */
    @PostMapping("auth/register")
    public ApiResponse addUser(@RequestBody Users user) {
        Users checkUser = usersService.lambdaQuery().eq(Users::getUsername, user.getUsername()).one();
        if (checkUser != null) {
            return ApiResponse.failure(403, "用户名已存在");
        }
        usersService.save(user);
        return ApiResponse.success("注册成功，跳转至登录页");
    }

    // 登录接口，返回 Access Token 和 Refresh Token
    @PostMapping("auth/login")
    public ApiResponse<AuthResponse> login(@RequestBody Users user) {

        // 这里简化了密码验证，实际开发中要验证用户的密码
        if (user.getUsername() == null || user.getPassword() == null) {
            return ApiResponse.failure(403, "用户名或密码为空");
        }
        // 根据用户名和密码查询用户
        Users userInfo = usersService.lambdaQuery()
                .select(Users::getUserId, Users::getUsername, Users::getRole, Users::getCreatedAt)
                .eq(Users::getRole, user.getRole())
                .eq(Users::getUsername, user.getUsername())
                .eq(Users::getPassword, user.getPassword())
                .one();

        if (userInfo == null) {
            return ApiResponse.failure(403, "用户名或密码错误");
        }

        // 生成 Access Token 和 Refresh Token
        String accessToken = JwtUtil.generateAccessToken(user.getUsername());
        String refreshToken = JwtUtil.generateRefreshToken(user.getUsername());

        // 返回带有 Access Token 和 Refresh Token 的响应
        AuthResponse response = new AuthResponse(accessToken, refreshToken, userInfo);
        return ApiResponse.success(response);
    }

    @Data
    @AllArgsConstructor
    // 定义响应对象
    public static class AuthResponse {
        private String accessToken;
        private String refreshToken;
        private Users user;
    }

    // 刷新 Access Token
    @PostMapping("/getAccessToken")
    public ApiResponse<String> refreshToken(@RequestBody String refreshToken) {
        try {
            String username = JwtUtil.extractUsername(refreshToken, JwtUtil.REFRESH_SECRET_KEY);

            // 校验 Refresh Token 是否有效
            if (username != null) {
                // 生成新的 Access Token
                String newAccessToken = JwtUtil.generateAccessToken(username);
                return ApiResponse.success(newAccessToken);
            } else {
                return ApiResponse.failure(403, "Invalid refresh token");
            }
        } catch (Exception e) {
            return ApiResponse.failure(400, "Failed to refresh token: " + e.getMessage());
        }
    }

    /**
     * <p>都刷新</p>
     *
     * @param refreshToken
     * @return com.example.schedule.common.ApiResponse<com.example.schedule.controller.UsersController.AuthResponse>
     * @methodName refreshAccessAndRefreshToken
     * @author Admin
     * @time 2024-12-28 00:36:05
     */
    // 刷新 Access Token 和 Refresh Token
    @PostMapping("/getAccessAndRefreshToken")
    public ApiResponse<AuthResponse> refreshAccessAndRefreshToken(@RequestBody String refreshToken) {
        try {
            // 提取 refreshToken 中的用户名
            String username = JwtUtil.extractUsername(refreshToken, JwtUtil.REFRESH_SECRET_KEY);

            // 校验 Refresh Token 是否有效
            if (username != null && JwtUtil.validateToken(refreshToken, username)) {
                // 生成新的 Access Token 和 Refresh Token
                String newAccessToken = JwtUtil.generateAccessToken(username);
                String newRefreshToken = JwtUtil.generateRefreshToken(username);

                // 返回新的 Access Token 和 Refresh Token
                AuthResponse response = new AuthResponse(newAccessToken, newRefreshToken, null);
                return ApiResponse.success(response);
            } else {
                return ApiResponse.failure(403, "Invalid refresh token");
            }
        } catch (Exception e) {
            return ApiResponse.failure(400, "Failed to refresh token: " + e.getMessage());
        }
    }

    @PutMapping("/changePassword")
    public ApiResponse changePassword(@RequestParam String oriPassword, @RequestParam String newPassword) {
        Users currentUser = UserContextUtil.getCurrentUser();
        if (currentUser != null) {
            if (currentUser.getPassword().equals(oriPassword)) {
                currentUser.setPassword(newPassword);
                usersService.updateById(currentUser);
                return ApiResponse.success("密码修改成功");
            } else {
                return ApiResponse.failure("原密码错误");
            }
        }
        return ApiResponse.failure("用户获取失败");
    }

    @GetMapping("getUserByRole")
    public ApiResponse<List<Users>> getUserByRole(@RequestParam String role) {
        List<Users> usersList = usersService.lambdaQuery()
                .select(Users::getUsername, Users::getRole, Users::getUserId, Users::getCreatedAt, Users::getUpdatedAt)
                .eq(Users::getRole, role).list();

        return ApiResponse.success(usersList);
    }
}
