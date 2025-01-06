import { StorageKeys } from '../constants/StorageKeys';
import { USER_LOGIN } from '../constants/Urls';
import { Role, User, UserToken } from '../model/UserInfo';
import Logger from '../utils/Logger';
import PreferenceUtil from '../utils/PreferenceUtil';
import { RequestAxios } from '../utils/RequestUtil';
import { promptAction, router } from '@kit.ArkUI';
import Header from '../components/header/Header';

@Entry
@Component
struct LoginPage {
  @State roleChecked: boolean = true
  @State userInfo: User = {
    userId: null,
    username: '',
    password: '',
    role: Role.STUDENT,
    createdAt: '',
    updatedAt: ''
  }
  @StorageLink(StorageKeys.USER_INFO) currentUser: User | null = null

  /**
   * 用户登录
   */
  userLogin() {

    if (!this.userInfo.username) {
      promptAction.showToast({ message: '用户名不能为空' })
      return
    }

    if (!this.userInfo.password) {
      promptAction.showToast({ message: '密码不能为空' })
      return
    }

    RequestAxios.post<UserToken>(USER_LOGIN, this.userInfo).then((res) => {
      if (res.data.result) {
        PreferenceUtil.putPreferenceValue(StorageKeys.ACCESS_TOKEN, res.data.result.accessToken)
        PreferenceUtil.putPreferenceValue(StorageKeys.REFRESH_TOKEN, res.data.result.refreshToken)
        PreferenceUtil.putPreferenceValue(StorageKeys.USER_INFO, res.data.result.user)
        this.currentUser = res.data.result.user
        promptAction.showToast({ message: '登录成功' })

        // 返回首页
        setTimeout(() => {
          // router.back()
          router.replaceUrl({
            url: 'pages/Index'
          })
        }, 500)
      }
    })
  }

  build() {
    Column() {
      Header({ title: '登录' })
      Column({ space: 15 }) {
        Text('欢迎登录课程表')
          .fontSize(30)
          .fontWeight(700)
          .margin({ top: 20, bottom: 10 })
        TextInput({ text: this.userInfo.username, placeholder: '请输入用户名' })
          .height(50)
          .borderRadius(10)
          .onChange((value) => {
            this.userInfo.username = value
          })

        TextInput({ text: this.userInfo.password, placeholder: '请输入密码' })
          .height(50)
          .borderRadius(10)
          .type(InputType.Password)
          .onChange((value) => {
            this.userInfo.password = value
          })

        Row({ space: 50 }) {
          Row({ space: 5 }) {
            Radio({ value: 'Radio1', group: 'userRole' })
              .checked(!this.roleChecked)
              .onChange((isChecked: boolean) => {
                if (isChecked) {
                  this.userInfo.role = Role.TEACHER
                }
              })
            Text('教师')
          }

          Row({ space: 5 }) {
            Radio({ value: 'Radio2', group: 'userRole' })
              .checked(this.roleChecked)
              .onChange((isChecked: boolean) => {
                if (isChecked) {
                  this.userInfo.role = Role.STUDENT
                }
              })
            Text('学生')
          }
        }

        Button('登录')
          .type(ButtonType.Normal)
          .borderRadius(8)
          .onClick(() => {
            this.userLogin()
          })
          .borderRadius(10)
          .width('100%')

        Button('注册')
          .type(ButtonType.Normal)
          .borderRadius(8)
          .onClick(() => {
            router.replaceUrl({ url: 'pages/Register' })
          })
          .borderRadius(10)
          .width('100%')
      }
      .padding({ left: 15, right: 15 })
      .margin({ top: 70 })
    }
    .height('100%')
    .width('100%')
  }
}