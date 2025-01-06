package com.example.schedule.controller;

import com.example.schedule.common.ApiResponse;
import com.example.schedule.service.ICoursesService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RestController;

/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author Admin
 * @since 2024-12-28
 */
@RestController
@RequestMapping("/courses")
@AllArgsConstructor
public class CoursesController {

    private final ICoursesService coursesService;

    @GetMapping("list")
    public ApiResponse getCourses() {
        return ApiResponse.success(coursesService.list());
    }


}
