const BASE_URL: string = 'http://172.25.24.6:8080'

// 用户注册
export const ADD_USER = '/users/auth/register'

// 用户登录
export const USER_LOGIN = '/users/auth/login'

// 修改密码
export const CHANGE_PASSWORD = '/users/changePassword'

export const COURSE_LIST = '/courses/list'
// 根据角色获取用户信息
export const GET_USER_BY_ROLE = '/users/getUserByRole'

// 添加课程信息
export const ADD_COURSE_SCHEDULE = '/coursesSchedules'
export const EDIT_COURSE_SCHEDULE = '/coursesSchedules'
export const DELETE_COURSE_SCHEDULE = '/coursesSchedules'

// 获取课程维护信息
export const COURSE_SCHEDULE_LIST = '/coursesSchedules/list'

// 获取选课列表
export const COURSE_ENROLLMENTS_LIST = '/courseEnrollments/list'
// 添加课程
export const ADD_COURSE_ENROLLMENT = '/courseEnrollments'
// 删除课程
export const DELETE_COURSE_ENROLLMENT = '/courseEnrollments'