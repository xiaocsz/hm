import axios, { InternalAxiosRequestConfig, AxiosError, AxiosResponse, AxiosRequestConfig } from '@ohos/axios'
import { promptAction, router } from '@kit.ArkUI'
import PreferenceUtil from './PreferenceUtil'
import { StorageKeys } from '../constants/StorageKeys'

// 增加类型
export interface APIErrorType {
  message: string
  msg: string
  code: string
}

// 实例化 通用配置
const instance = axios.create({
  baseURL: 'http://10.0.2.2:8080',
  timeout: 5000,
  headers: { 'Content-Type': 'application/json' }
})

// 拦截器配置
// 请求拦截器
// token配置等
instance.interceptors.request.use(async (config: InternalAxiosRequestConfig) => {
  const token = await PreferenceUtil.getPreferenceValue(StorageKeys.ACCESS_TOKEN, '')

  if (token) {
    config.headers['Authorization'] = `Bearer ${token}`
  }
  return config
}, (error: AxiosError) => {
  return Promise.reject(error)
})


// 添加响应拦截器
// 错误统一处理等
instance.interceptors.response.use((response: ResponseType<object>) => {
  // 业务异常
  if (response.data.code !== 200) {
    promptAction.showToast({ message: response.data.msg })
  }
  return response
}, (error: AxiosError<APIErrorType>) => {
  if (error.response?.status === 401) {
    promptAction.showToast({ message: '登录过期' })
    // 删除用户信息 去登录页
    // auth.removeUser()
    router.pushUrl({
      url: 'pages/LoginPage'
    })
  } else {
    promptAction.showToast({ message: error.response?.data.msg })
  }
  return Promise.reject(error)
})


export interface HttpResponse<T> {
  code: number
  msg: string
  result: T
}

export type ResponseType<T> = AxiosResponse<HttpResponse<T>>

// 网络请求封装请求方法
export class RequestAxios {
  static get<T>(url: string, config?: AxiosRequestConfig): Promise<ResponseType<T>> {
    return instance.get<null, ResponseType<T>>(url, config)
  }

  static post<T>(url: string, data?: object): Promise<ResponseType<T>> {
    return instance.post<null, ResponseType<T>>(url, data)
  }

  static delete<T>(url: string, data?: object): Promise<ResponseType<T>> {
    return instance.delete<null, ResponseType<T>>(url, data)
  }

  static put<T>(url: string, data?: object): Promise<ResponseType<T>> {
    return instance.put<null, ResponseType<T>>(url, data)
  }

  static putWithParams<T>(url: string, data?: object): Promise<ResponseType<T>> {
    // 如果 data 存在，将其转化为查询参数
    // 如果 data 存在，将其转化为查询参数
    const params =
      data ? Object.keys(data).map(key => `${encodeURIComponent(key)}=${encodeURIComponent(data[key])}`).join('&') : '';

    // 在 URL 后面添加查询参数
    const fullUrl = `${url}?${params}`;


    // 发送 PUT 请求，参数附加在 URL 中
    return instance.put<null, ResponseType<T>>(fullUrl);
  }
}

