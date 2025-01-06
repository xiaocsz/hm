import { promptAction, router } from "@kit.ArkUI"
import { Role, User } from "../../model/UserInfo"
import PreferenceUtil from "../../utils/PreferenceUtil"
import { StorageKeys } from "../../constants/StorageKeys"
import ChangePassword from "./ChangePassword"

@Component
export default struct MyIndex {
  @StorageLink(StorageKeys.USER_INFO) currentUser: User | null = null

  build() {
    Column({ space: 15 }) {

      Row() {
        Text('我的名片').fontSize(20).fontWeight(500)
      }.width('100%').margin({ top: 20 })

      Row() {
        Image($r('app.media.touxiang')).height('100%').borderRadius(10)
        Column({ space: 15 }) {
          if (this.currentUser) {
            Text(this.currentUser.username).width('100%').fontSize(20).fontWeight(500)
            Text(`ID号码：${this.currentUser.userId}`).width('100%').fontSize(15).fontWeight(400)
            Text(`注册时间：${this.currentUser.createdAt}`).width('100%').fontSize(15).fontWeight(400)
          } else {
            Text('未登录').fontSize(20).fontWeight(600)
          }

        }.justifyContent(FlexAlign.SpaceAround).height('100%')
        .padding({ left: 20 })
      }
      .width('100%')
      .height('15%')
      .backgroundColor(Color.White)
      .padding(10)

      .borderRadius(10)

      if (this.currentUser) {

        Row() {
          Text('功能列表').fontSize(20).fontWeight(500)
        }.width('100%')

        Column() {
          List({ space: 5 }) {
            ListItem() {
              Text('修改密码')
                .fontSize(18)

            }
            .padding(10)
            .onClick(() => {
              router.pushUrl({ url: 'pages/ChangePasswordPage' })
            })

            if (this.currentUser?.role === Role.TEACHER) {


              ListItem() {
                Text('课表维护').fontSize(18)
              }.padding(10)
              .onClick(() => {
                router.pushUrl({ url: 'pages/ScheduleManagementPage' })
              })

              ListItem() {
                Text('课表列表').fontSize(18).onClick(() => {
                  router.pushUrl({ url: 'pages/ScheduleListPage' })
                })
              }.padding(10)
            }

            if (this.currentUser?.role === Role.STUDENT) {
              ListItem() {
                Text('我的选课').fontSize(18).onClick(() => {
                  router.pushUrl({ url: 'pages/MyCoursePage' })
                })
              }.padding(10)
            }
          }.divider({ strokeWidth: 1, color: '#f0f0f0' })

        }.width('100%')
        .backgroundColor(Color.White)
        .borderRadius(10)
        .padding(10)
      }
      Row() {
        Text('登录 / 退出').fontSize(20).fontWeight(500)
      }.width('100%')

      if (this.currentUser) {
        Button('退出登录')
          .type(ButtonType.Normal)
          .width('100%')
          .borderRadius(8)
          .fontSize(18)
          .onClick(() => {
            AlertDialog.show(
              {
                title: '退出登录',
                message: '确定退出登录？',
                autoCancel: true,
                alignment: DialogAlignment.Center,
                gridCount: 4,
                offset: { dx: 0, dy: -20 },
                primaryButton: {
                  value: '取消',
                  action: () => {
                    console.info('Callback when the first button is clicked')
                  }
                },
                secondaryButton: {
                  enabled: true,
                  defaultFocus: true,
                  style: DialogButtonStyle.HIGHLIGHT,
                  value: '确定',
                  action: async () => {
                    const token = await PreferenceUtil.getPreferenceValue(StorageKeys.ACCESS_TOKEN, '')
                    if (!token) {
                      promptAction.showToast({ message: '当前状态未登录' })
                      return
                    }
                    await PreferenceUtil.putPreferenceValue(StorageKeys.ACCESS_TOKEN, '')
                    await PreferenceUtil.putPreferenceValue(StorageKeys.REFRESH_TOKEN, '')
                    await PreferenceUtil.putPreferenceValue(StorageKeys.USER_INFO, null)
                    this.currentUser = null
                    promptAction.showToast({ message: '账号已退出' })
                  }
                },
                cancel: () => {
                  console.info('Closed callbacks')
                },
                onWillDismiss: (dismissDialogAction: DismissDialogAction) => {
                  console.info("reason=" + JSON.stringify(dismissDialogAction.reason))
                  console.log("dialog onWillDismiss")
                  if (dismissDialogAction.reason == DismissReason.PRESS_BACK) {
                    dismissDialogAction.dismiss()
                  }
                  if (dismissDialogAction.reason == DismissReason.TOUCH_OUTSIDE) {
                    dismissDialogAction.dismiss()
                  }
                }
              }
            )

          })
      } else {
        Button('点击登录')
          .type(ButtonType.Normal)
          .borderRadius(8)
          .width('100%')
          .onClick(() => {
            router.pushUrl({ url: 'pages/LoginPage' })
          })
      }


    }.width('100%')
    .height('100%')
    .backgroundColor('#f0f0f0')
    .padding({ left: 15, right: 15 })
  }
}