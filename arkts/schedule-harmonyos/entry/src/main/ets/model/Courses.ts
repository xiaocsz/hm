export interface CourseSchedule {
  id: number; // 课程安排的 ID
  courseId: number; // 课程 ID
  weekDay: number; // 星期几
  period: number; // 大节次，1 表示第一节，2 表示第二节等
  teacherId: number | null;
  location: string; // 上课地点
  createdAt: string; // 创建时间，通常是字符串类型的时间格式
  updatedAt: string; // 更新时间，通常是字符串类型的时间格式
}

export interface Courses {
  id: number; // 课程ID
  courseName: string; // 课程名称
  courseCode: string; // 课程代码
  createdAt: string; // 创建时间，通常是ISO格式的字符串
  updatedAt: string; // 更新时间，通常是ISO格式的字符串
}


export interface CourseScheduleVO {
  id: number; // 课程安排的 ID
  userId: number; // 用户 ID
  username: string; // 教师的用户名
  courseId: number; // 课程 ID
  courseName: string; // 课程名称
  courseCode: string; // 课程代码
  weekDay: number; // 星期几
  weekDayLabel: string; // 星期几的中文名称（通过 CASE 映射得到）
  period: number; // 节次（1, 2, 3, ...）
  teacherId: number; // 教师 ID
  location: string; // 上课地点
}

export interface CourseEnrollment {
  id: number | null; // 主键，自增
  studentId: number | null; // 学生ID，关联users表
  courseId: number | null; // 课程ID，关联courses表
  createdAt: string; // 创建时间，通常是字符串类型的时间格式
  updatedAt: string; // 更新时间，通常是字符串类型的时间格式
}

export interface CourseEnrollmentVO {
  id: number;
  studentId: number; // 学生ID，关联users表
  courseId: number; // 课程ID，关联courses表
  courseName: string; // 课程名称
  courseCode: string; // 课程编号
  weekDay: number; // 星期几，1-7表示星期一到星期天
  weekDayLabel: string; // 星期几的中文名称，如"星期一"
  period: number; // 第几节，1表示第一节，2表示第二节等
  teacherId: number; // 教师ID，关联users表
  location: string; // 上课地点
  username: string; // 上课教师
}
