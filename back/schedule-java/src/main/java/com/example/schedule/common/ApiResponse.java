package com.example.schedule.common;

public class ApiResponse<T> {

    private int code;           // 响应码
    private String msg;         // 响应消息
    private T result;           // 返回的数据，可以是任意类型，泛型 T

    // 构造函数
    public ApiResponse(int code, String msg, T result) {
        this.code = code;
        this.msg = msg;
        this.result = result;
    }

    // 获取响应码
    public int getCode() {
        return code;
    }

    // 设置响应码
    public void setCode(int code) {
        this.code = code;
    }

    // 获取响应消息
    public String getMsg() {
        return msg;
    }

    // 设置响应消息
    public void setMsg(String msg) {
        this.msg = msg;
    }

    // 获取返回的结果数据
    public T getResult() {
        return result;
    }

    // 设置返回的结果数据
    public void setResult(T result) {
        this.result = result;
    }

    // 静态方法：构造成功的响应
    public static <T> ApiResponse<T> success(T result) {
        return new ApiResponse<>(200, "success", result);
    }

    public static <T> ApiResponse<T> success() {
        return new ApiResponse<>(200, "success", null);
    }

    // 静态方法：构造失败的响应
    public static <T> ApiResponse<T> failure(String msg) {
        return new ApiResponse<>(500, msg, null);
    }

    // 静态方法：构造失败的响应
    public static <T> ApiResponse<T> failure(int code, String msg) {
        return new ApiResponse<>(code, msg, null);
    }

    // 你也可以根据需求添加更多的辅助方法
}
