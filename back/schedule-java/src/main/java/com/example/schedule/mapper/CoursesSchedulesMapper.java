package com.example.schedule.mapper;

import com.example.schedule.entity.CoursesSchedules;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.schedule.vo.CourseScheduleVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 * Mapper 接口
 * </p>
 *
 * @author Admin
 * @since 2024-12-28
 */
public interface CoursesSchedulesMapper extends BaseMapper<CoursesSchedules> {

    List<CourseScheduleVO> getCourseScheduleInfo(@Param("teacherId") Integer teacherId, @Param("weekDay") Integer weekDay);
}
