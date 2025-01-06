import { ComponentContent, promptAction, router } from "@kit.ArkUI"
import { RequestAxios } from "../../utils/RequestUtil";
import { CHANGE_PASSWORD } from "../../constants/Urls";
import { PromptActionClass } from "./PromptActionClass";

class Params {
  title: string = ""

  constructor(title: string) {
    this.title = title;
  }
}

interface PasswordObj {
  oriPassword: string
  newPassword: string
}

let oriPassword: string = ''
let newPassword: string = ''

@Builder
function buildText(params: Params) {

  Column() {
    Column({ space: 10 }) {
      Row() {
        Text(oriPassword)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')

      Row() {
        Column({ space: 20 }) {
          Row({ space: 15 }) {
            Text('原密码：')
            TextInput({ text: oriPassword, placeholder: '请输入原密码' })
              .height(50)
              .borderRadius(10)
              .type(InputType.Password)
              .onChange((value) => {
                oriPassword = value
              })
              .layoutWeight(1)
          }

          Row({ space: 15 }) {
            Text('新密码：')
            TextInput({ text: newPassword, placeholder: '请输入新密码' })
              .height(50)
              .borderRadius(10)
              .type(InputType.Password)
              .onChange((value) => {
                newPassword = value
              })
              .layoutWeight(1)
          }
        }
      }

      Row() {
        Button('取消')
          .onClick(() => {
            PromptActionClass.closeDialog()
          })

        Button('确认')
          .onClick(() => {
            const passwordObj: PasswordObj = { oriPassword, newPassword }
            // 修改密码
            RequestAxios.putWithParams<string>(CHANGE_PASSWORD, passwordObj).then(res => {
              if (res.data.msg === 'success') {
                PromptActionClass.closeDialog()
                promptAction.showToast({ message: '修改成功' })
              }
            })
          })
      }
      .margin({ top: 20 })
      .width('100%')
      .justifyContent(FlexAlign.SpaceAround)

    }
    .padding(20)
    .width('95%')
    .borderRadius(10)
    .backgroundColor(Color.White)

  }
  // .backgroundColor('#FFF0F0F0')
  .margin({ top: '20%' })
}

@Component
export default struct ChangePassword {
  @State message: string = "hello"
  private ctx: UIContext = this.getUIContext();
  private contentNode: ComponentContent<Object> =
    new ComponentContent(this.ctx, wrapBuilder(buildText), new Params('修改密码'));

  aboutToAppear(): void {
    PromptActionClass.setContext(this.ctx);
    PromptActionClass.setContentNode(this.contentNode);
    PromptActionClass.setOptions({ alignment: DialogAlignment.Top, offset: { dx: 0, dy: 50 } });
  }

  build() {
    Row() {
      Column() {
        Button("open dialog and update options")
          .margin({ top: 50 })
          .onClick(() => {
            PromptActionClass.openDialog()

          })
        Button("open dialog and update content")
          .margin({ top: 50 })
          .onClick(() => {
            PromptActionClass.openDialog()

            setTimeout(() => {
              this.contentNode.update(new Params('update'))
            }, 1500)
          })
      }
      .width('100%')
      .height('100%')
    }
    .height('100%')
  }
}

