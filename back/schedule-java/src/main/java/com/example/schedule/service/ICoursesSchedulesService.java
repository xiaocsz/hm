package com.example.schedule.service;

import com.example.schedule.entity.CoursesSchedules;
import com.baomidou.mybatisplus.extension.service.IService;
import com.example.schedule.vo.CourseScheduleVO;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author Admin
 * @since 2024-12-28
 */
public interface ICoursesSchedulesService extends IService<CoursesSchedules> {

    List<CourseScheduleVO> getCourseScheduleInfo(Integer weekDay);
}
