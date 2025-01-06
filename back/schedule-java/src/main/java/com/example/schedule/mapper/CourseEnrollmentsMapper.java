package com.example.schedule.mapper;

import com.example.schedule.entity.CourseEnrollments;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.schedule.vo.CourseEnrollmentVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 * 选课表 Mapper 接口
 * </p>
 *
 * @author Admin
 * @since 2024-12-29
 */
public interface CourseEnrollmentsMapper extends BaseMapper<CourseEnrollments> {

    List<CourseEnrollmentVO> getCourseEnrollmentListByStudentId(@Param("studentId") Integer studentId, @Param("weekDay") Integer weekDay);
}
