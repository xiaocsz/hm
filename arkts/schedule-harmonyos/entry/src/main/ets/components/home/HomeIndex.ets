import { router } from "@kit.ArkUI"
import { CourseEnrollmentVO, CourseScheduleVO } from "../../model/Courses"
import { Role, User } from "../../model/UserInfo"
import { SelectInfo } from "../../pages/ScheduleManagementPage"
import { RequestAxios } from "../../utils/RequestUtil"
import { StorageKeys } from "../../constants/StorageKeys"
import { COURSE_ENROLLMENTS_LIST, COURSE_SCHEDULE_LIST } from "../../constants/Urls"

@Component
export default struct HomeIndex {
  @StorageLink(StorageKeys.USER_INFO) currentUser: User | null = null
  @State courseEnrollmentList: CourseEnrollmentVO[] = []
  // @State courseScheduleList: CourseScheduleVO[] = []
  private weekDayList: SelectInfo[] = [
    { value: 1, label: '星期一' },
    { value: 2, label: '星期二' },
    { value: 3, label: '星期三' },
    { value: 4, label: '星期四' },
    { value: 5, label: '星期五' },
    { value: 6, label: '星期六' },
    { value: 7, label: '星期日' }
  ]

  aboutToAppear(): void {
    this.getCourseList()
  }

  /**
   * 获取课程列表
   * @param weekDay
   */
  getCourseList(weekDay: number = 1) {
    if (this.currentUser?.role === Role.STUDENT) {
      this.getCourseEnrollmentList(weekDay)
    } else {
      this.getCourseScheduleList(weekDay)
    }
  }

  /**
   * 教师端获取课程列表
   * @param weekDay
   */
  getCourseScheduleList(weekDay: number) {
    RequestAxios.get<CourseEnrollmentVO[]>(COURSE_SCHEDULE_LIST, { params: { weekDay } }).then(res => {
      this.courseEnrollmentList = res.data.result
    })
  }

  /**
   * 学生端获取选课列表
   */
  getCourseEnrollmentList(weekDay: number) {
    RequestAxios.get<CourseEnrollmentVO[]>(COURSE_ENROLLMENTS_LIST, { params: { weekDay } }).then((res) => {
      this.courseEnrollmentList = res.data.result
    })
  }

  build() {
    Column({ space: 10 }) {

      Row() {
        Text('最新活动').fontSize(20).fontWeight(500)
      }.width('100%')

      Swiper() {
        Image($r('app.media.p_02'))
          .width('100%')

        Image($r('app.media.p_01'))
          .width('100%')

        Image($r('app.media.p_03'))
          .width('100%')

      }
      .loop(true)
      .borderRadius(6)
      .height('25%')

      Row() {
        Text('我的课程').fontSize(20).fontWeight(500)
        Button('刷新')
          .type(ButtonType.Normal)
          .fontSize(16)
          .height(35)
          .borderRadius(8)
          .onClick(() => {
            this.getCourseList()
          })
      }.width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Column() {
        Tabs({ barPosition: BarPosition.Start }) {
          ForEach(this.weekDayList, (item: SelectInfo) => {
            TabContent() {
              if (this.courseEnrollmentList.length > 0) {
                List({ space: 12, initialIndex: 0 }) {
                  ForEach(this.courseEnrollmentList, (item: CourseEnrollmentVO) => {
                    ListItem() {
                      Column({ space: 15 }) {
                        Row({ space: 20 }) {
                          Text(item.courseName).fontSize(18).fontWeight(600)
                          Text(`第 ${item.period} 节`).fontSize(20).fontWeight(600)
                        }
                        .width('100%')

                        Row() {
                          Column({ space: 10 }) {
                            Text(`授课教师：${item.username}`).fontSize(16).width('100%')
                            Text(`上课地点：${item.location}`).fontSize(16).width('100%')
                          }

                        }.width('100%')
                        .justifyContent(FlexAlign.SpaceBetween)
                      }
                      .borderRadius(10)

                      .padding({
                        left: 15,
                        right: 15,
                        top: 10,
                        bottom: 10
                      })
                      .backgroundColor(Color.White)
                    }
                    .transition({ type: TransitionType.Delete, opacity: 0 })

                  }, (item: CourseEnrollmentVO) => JSON.stringify(item))
                }
                .scrollBar(BarState.Off)
                .friction(0.6)
                .padding({ top: 10, bottom: 10 })
                // .margin({ top: 10, bottom: 90 })
                .width('100%')
                .height('100%')
                .divider({
                  strokeWidth: 1,
                  color: '#f0f0f0',
                  startMargin: 8,
                  endMargin: 8
                })
              } else {
                Column() {
                  Image($r('app.media.data_empty')).height(100)
                  Text('暂无课程')
                }
              }
            }
            .tabBar(item.label)
          }, (item: SelectInfo) => item.value.toString())

        }
        .vertical(true)
        .barWidth(100)
        .scrollable(false)
        .divider({
          strokeWidth: 2,
          color: '#f0f0f0',
          startMargin: 5,
          endMargin: 5
        })
        .onChange(index => {
          let weekDay = this.weekDayList[index].value
          this.getCourseList(weekDay)
        })

        // .barHeight(400)
      }.backgroundColor(Color.White)
      .borderRadius(10)
      .height('60%')

    }.width('100%')
    .height('100%')
    .backgroundColor('#f0f0f0')
    .padding(15)
  }
}