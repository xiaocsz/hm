export enum Role {
  TEACHER = "TEACHER",
  STUDENT = "STUDENT",
}

export interface User {
  userId: number | null; // 使用 `number` 类型表示自增的 ID
  username: string;
  password: string;
  role: Role; // 使用枚举来确保只有 'TEACHER' 或 'STUDENT'
  createdAt: string; // 时间戳或日期字符串
  updatedAt: string; // 时间戳或日期字符串
}

export interface UserToken {
  accessToken: string;
  refreshToken: string;
  user: User;
}