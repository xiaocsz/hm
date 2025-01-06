package com.example.schedule.controller;

import com.example.schedule.common.ApiResponse;
import com.example.schedule.entity.CourseEnrollments;
import com.example.schedule.entity.CoursesSchedules;
import com.example.schedule.jwt.UserContextUtil;
import com.example.schedule.service.ICourseEnrollmentsService;
import com.example.schedule.service.ICoursesSchedulesService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;
import org.springframework.stereotype.Controller;

import java.util.List;
import java.util.stream.Collectors;

/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author Admin
 * @since 2024-12-28
 */
@RestController
@RequestMapping("/coursesSchedules")
@AllArgsConstructor
public class CoursesSchedulesController {

    private final ICoursesSchedulesService coursesSchedulesService;
    private final ICourseEnrollmentsService courseEnrollmentsService;


    @PostMapping
    public ApiResponse addSchedule(@RequestBody CoursesSchedules schedules) {
        CoursesSchedules courseResult = coursesSchedulesService.lambdaQuery().eq(CoursesSchedules::getCourseId, schedules.getCourseId()).one();

        if (courseResult != null) {
            return ApiResponse.failure("该课程计划已存在");
        }

        CoursesSchedules weekDayResult = coursesSchedulesService.lambdaQuery()
                .eq(CoursesSchedules::getWeekDay, schedules.getWeekDay())
                .eq(CoursesSchedules::getPeriod, schedules.getPeriod())
                .eq(CoursesSchedules::getTeacherId, UserContextUtil.getCurrentUser().getUserId())
                .one();

        if (weekDayResult != null) {
            return ApiResponse.failure("该时间段已有其他课程安排");
        }

        schedules.setTeacherId(UserContextUtil.getCurrentUser().getUserId());
        coursesSchedulesService.save(schedules);
        return ApiResponse.success("保存成功");
    }

    @PutMapping
    public ApiResponse editSchedule(@RequestBody CoursesSchedules schedules) {


        CoursesSchedules result = coursesSchedulesService.lambdaQuery()
                .eq(CoursesSchedules::getWeekDay, schedules.getWeekDay())
                .eq(CoursesSchedules::getPeriod, schedules.getPeriod())
                .eq(CoursesSchedules::getTeacherId, UserContextUtil.getCurrentUser().getUserId())
                .one();

        if (result != null) {
            if (result.getCourseId() != schedules.getCourseId()) {
                return ApiResponse.failure("该时间段已有其他课程安排");
            }
        }

        coursesSchedulesService.updateById(schedules);
        return ApiResponse.success("修改成功");
    }

    @GetMapping("list")
    public ApiResponse listSchedules(Integer weekDay) {
        return ApiResponse.success(coursesSchedulesService.getCourseScheduleInfo(weekDay));
    }

    @DeleteMapping("{id}")
    public ApiResponse deleteSchedule(@PathVariable Integer id) {
        // 查询是否有学生选课
        Integer courseId = coursesSchedulesService.lambdaQuery().select(CoursesSchedules::getCourseId)
                .eq(CoursesSchedules::getId, id).one().getCourseId();

        List<CourseEnrollments> list = courseEnrollmentsService.lambdaQuery().eq(CourseEnrollments::getCourseId, courseId).list();
        if (list.size() > 0) {
            // 该课程已有学生选课，无法删除
            List<Integer> removeList = list.stream().map(item -> item.getId()).collect(Collectors.toList());
            courseEnrollmentsService.removeByIds(removeList);
        }
        coursesSchedulesService.removeById(id);
        return ApiResponse.success("删除成功");
    }
}
