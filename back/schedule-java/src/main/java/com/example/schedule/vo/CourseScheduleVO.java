package com.example.schedule.vo;

import lombok.Data;

@Data
public class CourseScheduleVO {
    private Integer id;              // 课程安排的 ID
    private Integer userId;          // 用户 ID
    private String username;      // 教师的用户名
    private Integer courseId;        // 课程 ID
    private String courseName;    // 课程名称
    private String courseCode;    // 课程代码
    private Integer weekDay;  // 星期几
    private String weekDayLabel;  // 星期几的中文名称（通过 CASE 映射得到）
    private Integer period;       // 节次（1, 2, 3, ...）
    private Long teacherId;       // 教师 ID
    private String location;      // 上课地点
}
