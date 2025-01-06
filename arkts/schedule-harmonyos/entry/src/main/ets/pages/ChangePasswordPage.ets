import { CHANGE_PASSWORD } from '../constants/Urls'
import { RequestAxios } from '../utils/RequestUtil'
import { promptAction, router } from '@kit.ArkUI'
import Header from '../components/header/Header'

interface PasswordObj {
  oriPassword: string
  newPassword: string
}

@Entry
@Component
struct ChangePasswordPage {
  @State passwordObj: PasswordObj = {
    oriPassword: '',
    newPassword: ''
  }

  build() {
    Column() {
      Header({ title: '修改密码' })
      Row() {
        Column({ space: 20 }) {
          Row({ space: 15 }) {
            Text('原密码：')
            TextInput({ text: this.passwordObj.oriPassword, placeholder: '请输入原密码' })
              .height(50)
              .borderRadius(10)
              .type(InputType.Password)
              .onChange((value) => {
                this.passwordObj.oriPassword = value
              })
              .layoutWeight(1)
          }

          Row({ space: 15 }) {
            Text('新密码：')
            TextInput({ text: this.passwordObj.newPassword, placeholder: '请输入新密码' })
              .height(50)
              .borderRadius(10)
              .type(InputType.Password)
              .onChange((value) => {
                this.passwordObj.newPassword = value
              })
              .layoutWeight(1)
          }

          Button('确认').type(ButtonType.Normal).borderRadius(8).width('100%')
            .onClick(() => {
              if (this.passwordObj.oriPassword && this.passwordObj.newPassword) {
                // 修改密码
                RequestAxios.putWithParams<string>(CHANGE_PASSWORD, this.passwordObj).then(res => {
                  if (res.data.msg === 'success') {
                    promptAction.showToast({ message: '修改成功' })
                    router.back()
                  }
                })
              } else {
                promptAction.showToast({ message: '请输入完整' })
              }

            })
        }

      }.padding(15)

    }
    .height('100%')
    .width('100%')

  }
}