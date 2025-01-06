package com.example.schedule.jwt;

import com.example.schedule.entity.Users;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.RequestAttributes;

public class UserContextUtil {

    private static final String CURRENT_USER = "currentUser";

    /**
     * 将当前用户存储到请求上下文中
     *
     * @param user 当前用户对象
     */
    public static void setCurrentUser(Users user) {
        // 获取当前请求的上下文属性
        RequestAttributes requestAttributes = RequestContextHolder.getRequestAttributes();
        if (requestAttributes != null) {
            // 将当前用户存储到请求上下文中
            requestAttributes.setAttribute(CURRENT_USER, user, RequestAttributes.SCOPE_REQUEST);
        }
    }

    /**
     * 从请求上下文中获取当前用户
     *
     * @return 当前用户对象，如果没有则返回 null
     */
    public static Users getCurrentUser() {
        // 获取当前请求的上下文属性
        RequestAttributes requestAttributes = RequestContextHolder.getRequestAttributes();
        if (requestAttributes != null) {
            // 从上下文中获取 "currentUser"
            return (Users) requestAttributes.getAttribute(CURRENT_USER, RequestAttributes.SCOPE_REQUEST);
        }
        return null;  // 如果没有存储用户信息，返回 null
    }

}
