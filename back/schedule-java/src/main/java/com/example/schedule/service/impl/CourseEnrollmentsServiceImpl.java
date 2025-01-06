package com.example.schedule.service.impl;

import com.example.schedule.entity.CourseEnrollments;
import com.example.schedule.entity.Users;
import com.example.schedule.jwt.UserContextUtil;
import com.example.schedule.mapper.CourseEnrollmentsMapper;
import com.example.schedule.service.ICourseEnrollmentsService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.example.schedule.vo.CourseEnrollmentVO;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;

/**
 * <p>
 * 选课表 服务实现类
 * </p>
 *
 * @author Admin
 * @since 2024-12-29
 */
@Service
public class CourseEnrollmentsServiceImpl extends ServiceImpl<CourseEnrollmentsMapper, CourseEnrollments> implements ICourseEnrollmentsService {

    @Override
    public List<CourseEnrollmentVO> getCourseEnrollmentListByStudentId(Integer weekDay) {
        Users currentUser = UserContextUtil.getCurrentUser();
        return baseMapper.getCourseEnrollmentListByStudentId(currentUser.getUserId(), weekDay);
    }
}
