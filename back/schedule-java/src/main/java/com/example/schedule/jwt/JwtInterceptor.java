package com.example.schedule.jwt;

import com.example.schedule.entity.Users;
import com.example.schedule.service.IUsersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Component
public class JwtInterceptor implements HandlerInterceptor {

    @Autowired
    private IUsersService usersService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        // 获取 Token
        String token = request.getHeader("Authorization");
        if (token == null || !token.startsWith("Bearer ")) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("Unauthorized: Token missing or malformed.");
            return false;  // 如果没有 Token 或格式不正确，拒绝请求
        }

        // 去除 Bearer 前缀
        token = token.substring(7);

        // 解析 Token，获取用户名
        String username = JwtUtil.extractUsername(token);
        if (username != null && JwtUtil.validateToken(token, username)) {
            // 从数据库中查询用户信息
            Users currentUser = usersService.lambdaQuery().eq(Users::getUsername, username).one();

            // 将当前用户信息存储到请求上下文中
            // 将当前用户存储到请求上下文中
            UserContextUtil.setCurrentUser(currentUser);
//            RequestContextHolder.getRequestAttributes().setAttribute("currentUser", user, RequestAttributes.SCOPE_REQUEST);

            return true;  // Token 校验通过，继续处理请求
        } else {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("Unauthorized: Invalid or expired token.");
            return false;  // Token 无效
        }
    }
}
