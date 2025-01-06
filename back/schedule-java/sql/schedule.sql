/*

 Source Server         : docker-mysql
 Source Server Type    : MySQL
 Source Server Version : 80032 (8.0.32)
 Source Host           : localhost:3307
 Source Schema         : schedule

 Target Server Type    : MySQL
 Target Server Version : 80032 (8.0.32)
 File Encoding         : 65001

 Date: 29/12/2024 23:01:43
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for course_enrollments
-- ----------------------------
DROP TABLE IF EXISTS `course_enrollments`;
CREATE TABLE `course_enrollments` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键，自增',
  `student_id` int NOT NULL COMMENT '学生ID，关联users表',
  `course_id` int NOT NULL COMMENT '课程ID，关联courses表',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='选课表';

-- ----------------------------
-- Records of course_enrollments
-- ----------------------------
BEGIN;
INSERT INTO `course_enrollments` (`id`, `student_id`, `course_id`, `created_at`, `updated_at`) VALUES (21, 3, 1, '2024-12-29 14:42:22', '2024-12-29 14:42:22');
INSERT INTO `course_enrollments` (`id`, `student_id`, `course_id`, `created_at`, `updated_at`) VALUES (22, 3, 3, '2024-12-29 14:42:25', '2024-12-29 14:42:25');
INSERT INTO `course_enrollments` (`id`, `student_id`, `course_id`, `created_at`, `updated_at`) VALUES (23, 3, 2, '2024-12-29 14:43:15', '2024-12-29 14:43:15');
INSERT INTO `course_enrollments` (`id`, `student_id`, `course_id`, `created_at`, `updated_at`) VALUES (24, 3, 7, '2024-12-29 14:43:36', '2024-12-29 14:43:36');
COMMIT;

-- ----------------------------
-- Table structure for courses
-- ----------------------------
DROP TABLE IF EXISTS `courses`;
CREATE TABLE `courses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `course_name` varchar(255) NOT NULL,
  `course_code` varchar(50) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `course_code` (`course_code`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Records of courses
-- ----------------------------
BEGIN;
INSERT INTO `courses` (`id`, `course_name`, `course_code`, `created_at`, `updated_at`) VALUES (1, '计算机科学导论', 'CS101', '2024-12-28 09:06:43', '2024-12-28 09:06:43');
INSERT INTO `courses` (`id`, `course_name`, `course_code`, `created_at`, `updated_at`) VALUES (2, '数据结构与算法', 'CS102', '2024-12-28 09:06:43', '2024-12-28 09:06:43');
INSERT INTO `courses` (`id`, `course_name`, `course_code`, `created_at`, `updated_at`) VALUES (3, '操作系统', 'CS201', '2024-12-28 09:06:43', '2024-12-28 09:06:43');
INSERT INTO `courses` (`id`, `course_name`, `course_code`, `created_at`, `updated_at`) VALUES (4, '计算机网络', 'CS202', '2024-12-28 09:06:43', '2024-12-28 09:06:43');
INSERT INTO `courses` (`id`, `course_name`, `course_code`, `created_at`, `updated_at`) VALUES (5, '人工智能', 'CS301', '2024-12-28 09:06:43', '2024-12-28 09:06:43');
INSERT INTO `courses` (`id`, `course_name`, `course_code`, `created_at`, `updated_at`) VALUES (6, '数据库系统原理', 'CS302', '2024-12-28 09:06:43', '2024-12-28 09:06:43');
INSERT INTO `courses` (`id`, `course_name`, `course_code`, `created_at`, `updated_at`) VALUES (7, '软件工程', 'CS303', '2024-12-28 09:06:43', '2024-12-28 09:06:43');
INSERT INTO `courses` (`id`, `course_name`, `course_code`, `created_at`, `updated_at`) VALUES (8, '算法设计与分析', 'CS304', '2024-12-28 09:06:43', '2024-12-28 09:06:43');
INSERT INTO `courses` (`id`, `course_name`, `course_code`, `created_at`, `updated_at`) VALUES (9, '计算机图形学', 'CS401', '2024-12-28 09:06:43', '2024-12-28 09:06:43');
INSERT INTO `courses` (`id`, `course_name`, `course_code`, `created_at`, `updated_at`) VALUES (10, '操作系统原理', 'CS402', '2024-12-28 09:06:43', '2024-12-28 09:06:43');
INSERT INTO `courses` (`id`, `course_name`, `course_code`, `created_at`, `updated_at`) VALUES (11, '大学外语', 'CS501', '2024-12-29 14:34:39', '2024-12-29 14:34:39');
INSERT INTO `courses` (`id`, `course_name`, `course_code`, `created_at`, `updated_at`) VALUES (12, '高等数学', 'CS502', '2024-12-29 14:34:52', '2024-12-29 14:34:52');
COMMIT;

-- ----------------------------
-- Table structure for courses_schedules
-- ----------------------------
DROP TABLE IF EXISTS `courses_schedules`;
CREATE TABLE `courses_schedules` (
  `id` int NOT NULL AUTO_INCREMENT,
  `course_id` int NOT NULL,
  `week_day` tinyint NOT NULL,
  `period` int NOT NULL,
  `teacher_id` int NOT NULL,
  `location` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Records of courses_schedules
-- ----------------------------
BEGIN;
INSERT INTO `courses_schedules` (`id`, `course_id`, `week_day`, `period`, `teacher_id`, `location`, `created_at`, `updated_at`) VALUES (21, 1, 1, 1, 1, '第一教学楼', '2024-12-29 14:36:47', '2024-12-29 14:36:47');
INSERT INTO `courses_schedules` (`id`, `course_id`, `week_day`, `period`, `teacher_id`, `location`, `created_at`, `updated_at`) VALUES (22, 2, 1, 2, 1, '第二教学楼', '2024-12-29 14:37:20', '2024-12-29 14:37:20');
INSERT INTO `courses_schedules` (`id`, `course_id`, `week_day`, `period`, `teacher_id`, `location`, `created_at`, `updated_at`) VALUES (23, 3, 2, 3, 1, '第一教学楼', '2024-12-29 14:37:50', '2024-12-29 14:37:50');
INSERT INTO `courses_schedules` (`id`, `course_id`, `week_day`, `period`, `teacher_id`, `location`, `created_at`, `updated_at`) VALUES (24, 7, 1, 4, 2, '第五教学楼', '2024-12-29 14:40:21', '2024-12-29 14:40:50');
INSERT INTO `courses_schedules` (`id`, `course_id`, `week_day`, `period`, `teacher_id`, `location`, `created_at`, `updated_at`) VALUES (25, 8, 4, 3, 2, '第二教学楼', '2024-12-29 14:41:18', '2024-12-29 14:41:18');
COMMIT;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `user_id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('TEACHER','STUDENT') NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of users
-- ----------------------------
BEGIN;
INSERT INTO `users` (`user_id`, `username`, `password`, `role`, `created_at`, `updated_at`) VALUES (1, '赵丽', '111', 'TEACHER', '2024-12-29 14:35:29', '2024-12-29 14:35:29');
INSERT INTO `users` (`user_id`, `username`, `password`, `role`, `created_at`, `updated_at`) VALUES (2, '王强', '111', 'TEACHER', '2024-12-29 14:35:43', '2024-12-29 14:35:43');
INSERT INTO `users` (`user_id`, `username`, `password`, `role`, `created_at`, `updated_at`) VALUES (3, '张三', '111', 'STUDENT', '2024-12-29 14:35:58', '2024-12-29 14:35:58');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
