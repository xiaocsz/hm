package com.example.schedule.service.impl;

import com.example.schedule.entity.CoursesSchedules;
import com.example.schedule.jwt.UserContextUtil;
import com.example.schedule.mapper.CoursesSchedulesMapper;
import com.example.schedule.service.ICoursesSchedulesService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.example.schedule.vo.CourseScheduleVO;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author Admin
 * @since 2024-12-28
 */
@Service
public class CoursesSchedulesServiceImpl extends ServiceImpl<CoursesSchedulesMapper, CoursesSchedules> implements ICoursesSchedulesService {

    @Override
    public List<CourseScheduleVO> getCourseScheduleInfo(Integer weekDay) {
        return baseMapper.getCourseScheduleInfo(UserContextUtil.getCurrentUser().getUserId(), weekDay);
    }
}
