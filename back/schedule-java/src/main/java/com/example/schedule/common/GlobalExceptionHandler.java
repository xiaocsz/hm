package com.example.schedule.common;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
public class GlobalExceptionHandler {
    @ExceptionHandler(JwtParseException.class)  // 处理 JwtParseException 异常
    public ResponseEntity<ApiResponse<String>> handleJwtParseException(JwtParseException e) {
        ApiResponse<String> response = new ApiResponse<>(HttpStatus.UNAUTHORIZED.value(), "JWT解析失败", null);
        return new ResponseEntity<>(response, HttpStatus.UNAUTHORIZED);  // 返回 401 错误码
    }

    @ExceptionHandler(Exception.class)
    public ApiResponse<String> handleException(Exception e) {
        e.printStackTrace();
        return ApiResponse.failure("Internal Server Error: " + e.getMessage());
    }

    /*@ExceptionHandler(Exception.class)
    public ResponseEntity<ApiResponse<String>> handleException(Exception e) {
        // 返回 500 错误码，表示服务器内部错误
        ApiResponse<String> response = new ApiResponse<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), "Internal Server Error: " + e.getMessage(), null);
        return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);  // 返回 500 错误码
    }*/
}
