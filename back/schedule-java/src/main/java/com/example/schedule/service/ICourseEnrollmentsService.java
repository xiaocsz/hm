package com.example.schedule.service;

import com.example.schedule.entity.CourseEnrollments;
import com.baomidou.mybatisplus.extension.service.IService;
import com.example.schedule.vo.CourseEnrollmentVO;

import java.util.List;

/**
 * <p>
 * 选课表 服务类
 * </p>
 *
 * @author Admin
 * @since 2024-12-29
 */
public interface ICourseEnrollmentsService extends IService<CourseEnrollments> {

    List<CourseEnrollmentVO> getCourseEnrollmentListByStudentId(Integer weekDay);
}
