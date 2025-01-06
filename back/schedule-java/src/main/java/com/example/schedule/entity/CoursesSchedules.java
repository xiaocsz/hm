package com.example.schedule.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.time.LocalDateTime;
import lombok.Getter;
import lombok.Setter;

/**
 * <p>
 * 
 * </p>
 *
 * @author Admin
 * @since 2024-12-28
 */
@Getter
@Setter
@TableName("courses_schedules")
public class CoursesSchedules implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    private Integer courseId;

    private Byte weekDay;

    private Integer period;

    private Integer teacherId;

    private String location;

    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;
}
