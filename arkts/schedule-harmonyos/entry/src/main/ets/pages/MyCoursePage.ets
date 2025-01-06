import Header from '../components/header/Header'
import {
  ADD_COURSE_ENROLLMENT,
  COURSE_ENROLLMENTS_LIST,
  COURSE_LIST,
  DELETE_COURSE_ENROLLMENT
} from '../constants/Urls'
import { CourseEnrollment, CourseEnrollmentVO, Courses } from '../model/Courses'
import { RequestAxios } from '../utils/RequestUtil'
import { JSON } from '@kit.ArkTS'
import { promptAction } from '@kit.ArkUI'

@Entry
@Component
struct MyCoursePage {
  @State courseList: Courses[] = []
  @State courseEnrollmentList: CourseEnrollmentVO[] = []
  @State courseEnrollment: CourseEnrollment = {
    id: null,
    studentId: null,
    courseId: null,
    createdAt: '',
    updatedAt: ''
  }
  private scroller: ListScroller = new ListScroller()

  onPageShow(): void {
    this.getCourseList()
    this.getCourseEnrollmentList()
  }

  /**
   * 获取课程列表
   */
  getCourseList() {
    RequestAxios.get<Courses[]>(COURSE_LIST).then(res => {
      this.courseList = res.data.result
    })
  }

  /**
   * 获取选课列表
   */
  getCourseEnrollmentList() {
    RequestAxios.get<CourseEnrollmentVO[]>(COURSE_ENROLLMENTS_LIST).then((res) => {
      this.courseEnrollmentList = res.data.result
    })
  }

  /**
   * 删除课程
   * @param id
   */
  deleteCourseEnrollment(item: CourseEnrollmentVO) {
    RequestAxios.delete<string>(`${DELETE_COURSE_ENROLLMENT}/${item.id}`).then(res => {
      promptAction.showToast({ message: res.data.result })
      let index = this.courseEnrollmentList.indexOf(item)
      this.courseEnrollmentList.splice(index, 1)
    })
  }

  @Builder
  itemEnd(item: CourseEnrollmentVO) {
    Row() {
      Button("删除")
        .type(ButtonType.Normal)
        .borderRadius(8)
        .margin({ left: 10 })
        .onClick(() => {
          this.deleteCourseEnrollment(item)
        })
      /*Button("Set").margin("4vp").onClick(() => {
        this.scroller.closeAllSwipeActions()
      })*/
    }
  }

  build() {
    Column() {
      Header({ title: '我的选课' })
      Column() {
        Column() {
          Button('添加课程').type(ButtonType.Normal).borderRadius(6)
            .onClick(() => {
              TextPickerDialog.show({
                range: this.courseList.map(item => item.courseName),
                selected: this.courseEnrollment.courseId,
                onAccept: (value: TextPickerResult) => {
                  // 设置select为按下确定按钮时候的选中项index，这样当弹窗再次弹出时显示选中的是上一次确定的选项
                  this.courseEnrollment.courseId = this.courseList[value.index as number].id
                  RequestAxios.post<string>(ADD_COURSE_ENROLLMENT, this.courseEnrollment).then(res => {
                    promptAction.showToast({ message: res.data.result })
                    this.getCourseEnrollmentList()
                  })
                }
              })
            })

        }
        .width('100%')
        .alignItems(HorizontalAlign.End)

        List({ space: 12, initialIndex: 0, scroller: this.scroller }) {
          ForEach(this.courseEnrollmentList, (item: CourseEnrollmentVO) => {
            if (item.teacherId) {
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
                .borderRadius(10)

                .padding(15)
                .backgroundColor(Color.White)
              }
              .transition({ type: TransitionType.Delete, opacity: 0 })
              .swipeAction({
                end: {
                  builder: () => {
                    this.itemEnd(item)
                  },
                  onAction: () => {
                    animateTo({ duration: 1000 }, () => {
                      // 删除
                      this.deleteCourseEnrollment(item)
                    })
                  },
                  actionAreaDistance: 56
                }
              })
            } else {
              ListItem() {
                Column({ space: 15 }) {
                  Row({ space: 20 }) {
                    Text(item.courseName).fontSize(20).fontWeight(700)
                  }
                  .width('100%')

                  Row() {
                    Text('课程资源分配中')
                  }.width('100%')

                }.backgroundColor(Color.White)
                .padding(15)
                .borderRadius(10)
              }
              .transition({ type: TransitionType.Delete, opacity: 0 })
              .swipeAction({
                end: {
                  builder: () => {
                    this.itemEnd(item)
                  },
                  onAction: () => {
                    animateTo({ duration: 1000 }, () => {
                      // 删除
                      this.deleteCourseEnrollment(item)
                    })
                  },
                  actionAreaDistance: 56
                }
              })
            }

          }, (item: CourseEnrollmentVO) => JSON.stringify(item))
        }
        .scrollBar(BarState.Off)
        .friction(0.6)
        .margin({ top: 10, bottom: 90 })
        .width('100%')


        /*Row() {
          Text('课程名称')
          Text(this.courseList.find(item => item.id === this.courseEnrollment.courseId)?.courseName)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)*/
      }
      .padding(15)

    }
    .height('100%')
    .width('100%')
    .backgroundColor('#f0f0f0')
  }
}