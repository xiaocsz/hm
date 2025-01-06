package com.example.schedule.vo;

import lombok.Data;

@Data
public class CourseEnrollmentVO {

    private Integer id;
    private Integer studentId;    // 学生ID，关联users表
    private Integer courseId;     // 课程ID，关联courses表
    private String courseName; // 课程名称
    private String courseCode; // 课程编号
    private Integer weekDay;   // 星期几，1-7表示星期一到星期天
    private String weekDayLabel; // 星期几的中文名称，如"星期一"
    private Integer period;    // 第几节，1表示第一节，2表示第二节等
    private Long teacherId;    // 教师ID，关联users表
    private String location;   // 上课地点
    private String username;   // 上课教师

}
