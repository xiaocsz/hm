package com.example.schedule.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
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
public class Courses implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    private String courseName;

    private String courseCode;

    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;
}
