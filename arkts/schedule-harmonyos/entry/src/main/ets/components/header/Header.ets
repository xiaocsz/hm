import { router } from "@kit.ArkUI"

@Component
export default struct Header {
  @Prop title: string = ''
  @Prop showBack: boolean = true

  build() {
    Column() {
      Row() {
        Row({ space: 10 }) {
          Image($r('app.media.back')).height('60%')
        }
        .width('15%')
        .visibility(this.showBack ? Visibility.Visible : Visibility.Hidden)
        .onClick(() => router.back())

        Text(this.title)
          .fontSize(18)
          .fontWeight(500)
          .fontColor(Color.White)
        Row().width('15%')
      }
      .width('100%')
      .height('7%')
      .backgroundColor(Color.Gray)
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({ left: 20, right: 20 })
    }.width('100%')

  }
}