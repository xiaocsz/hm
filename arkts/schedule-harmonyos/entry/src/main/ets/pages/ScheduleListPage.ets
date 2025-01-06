import { COURSE_SCHEDULE_LIST } from '../constants/Urls'
import { CourseSchedule, CourseScheduleVO } from '../model/Courses'
import { RequestAxios } from '../utils/RequestUtil'
import { router } from '@kit.ArkUI'
import Header from '../components/header/Header'

@Entry
@Component
struct ScheduleListPage {
  @State courseScheduleList: CourseScheduleVO[] = []

  onPageShow(): void {
    this.getCourseScheduleList()
  }

  getCourseScheduleList() {
    RequestAxios.get<CourseScheduleVO[]>(COURSE_SCHEDULE_LIST).then(res => {
      this.courseScheduleList = res.data.result
    })
  }

  build() {
    Column() {
      Header({ title: '课程列表' })
      Row() {
        Button('刷新')
          .type(ButtonType.Normal)
          .borderRadius(8)
          .onClick(() => this.getCourseScheduleList())

        Button('添加')
          .type(ButtonType.Normal)
          .borderRadius(8)
          .onClick(() => {
          router.pushUrl({
            url: 'pages/ScheduleManagementPage',
            params: null
          })
        })
      }.justifyContent(FlexAlign.SpaceAround).width('100%')
      .margin({ top: 10 })

      List({ space: 12, initialIndex: 0 }) {
        ForEach(this.courseScheduleList, (item: CourseScheduleVO) => {
          ListItem() {
            Column({ space: 15 }) {
              Row({ space: 20 }) {
                Text(item.courseName).fontSize(20).fontWeight(700)
                Text(`第 ${item.period} 节`).fontSize(20).fontWeight(700)
              }
              .width('100%')

              Row() {
                Column({ space: 10 }) {
                  Text(`授课教师：${item.username}`).width('70%')
                  Text(`上课地点：${item.location}`).width('70%')
                }

                Row() {
                  Text(item.weekDayLabel)
                }
                .padding(20)
                .backgroundColor('#f0f0f0')
                .borderRadius('50%')

              }.width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
            }
          }
          .width('100%')
          .padding(15)
          .borderRadius(10)
          .backgroundColor(Color.White)
          .onClick(() => {
            router.pushUrl({
              url: 'pages/ScheduleManagementPage',
              params: item
            })
          })
        }, (item: CourseScheduleVO) => JSON.stringify(item))
      }
      .width('90%')
      .scrollBar(BarState.Off)
      .friction(0.6)
      .margin({ top: 10 })
      .layoutWeight(1)
    }
    .height('100%')
    .width('100%')
    .backgroundColor('#f0f0f0')
    .padding({ bottom: 20 })
  }
}