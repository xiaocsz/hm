package com.example.schedule.controller;

import com.example.schedule.common.ApiResponse;
import com.example.schedule.entity.CourseEnrollments;
import com.example.schedule.jwt.UserContextUtil;
import com.example.schedule.service.ICourseEnrollmentsService;
import com.example.schedule.vo.CourseEnrollmentVO;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;
import org.springframework.stereotype.Controller;

import java.util.List;

/**
 * <p>
 * 选课表 前端控制器
 * </p>
 *
 * @author Admin
 * @since 2024-12-29
 */
@RestController
@RequestMapping("/courseEnrollments")
@AllArgsConstructor
public class CourseEnrollmentsController {

    private final ICourseEnrollmentsService courseEnrollmentsService;

    /**
     * <p>获取选课列表</p>
     *
     * @param
     * @return com.example.schedule.common.ApiResponse<java.util.List < com.example.schedule.vo.CourseEnrollmentVO>>
     * @methodName getCourseEnrollmentListByStudentId
     * @author Admin
     * @time 2024-12-29 13:17:06
     */
    @GetMapping("list")
    public ApiResponse<List<CourseEnrollmentVO>> getCourseEnrollmentListByStudentId(Integer weekDay) {
        return ApiResponse.success(courseEnrollmentsService.getCourseEnrollmentListByStudentId(weekDay));
    }

    /**
     * <p>添加课程</p>
     *
     * @param courseEnrollments
     * @return com.example.schedule.common.ApiResponse<java.lang.Boolean>
     * @methodName addCourseEnrollment
     * @author Admin
     * @time 2024-12-29 15:14:03
     */
    @PostMapping
    public ApiResponse<String> addCourseEnrollment(@RequestBody CourseEnrollments courseEnrollments) {
        Integer userId = UserContextUtil.getCurrentUser().getUserId();

        CourseEnrollments result = courseEnrollmentsService.lambdaQuery()
                .eq(CourseEnrollments::getStudentId, userId)
                .eq(CourseEnrollments::getCourseId, courseEnrollments.getCourseId())
                .one();

        if (result != null) {
            return ApiResponse.failure("该课程已选，请勿重复选择");
        } else {
            courseEnrollments.setStudentId(userId);
            courseEnrollmentsService.save(courseEnrollments);
            return ApiResponse.success("添加成功");
        }
    }

    @DeleteMapping("{id}")
    public ApiResponse<String> deleteCourseEnrollment(@PathVariable Integer id) {
        courseEnrollmentsService.removeById(id);
        return ApiResponse.success("删除成功");
    }
}
