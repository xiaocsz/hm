import {
  ADD_COURSE_SCHEDULE,
  COURSE_LIST,
  DELETE_COURSE_SCHEDULE,
  EDIT_COURSE_SCHEDULE,
  GET_USER_BY_ROLE
} from '../constants/Urls'
import { Courses, CourseSchedule } from '../model/Courses'
import { Role, User } from '../model/UserInfo'
import { RequestAxios } from '../utils/RequestUtil'
import { promptAction, router } from '@kit.ArkUI'
import Header from '../components/header/Header'


export interface SelectInfo {
  value: number
  label: string
}

@Entry
@Component
struct ScheduleManagementPage {
  @State courseList: Courses[] = []
  @State teacherList: User[] = []
  @State courseSchedule: CourseSchedule = {
    id: 0,
    courseId: 0,
    weekDay: 0,
    period: 0,
    location: "",
    teacherId: null,
    createdAt: "",
    updatedAt: "",
  }
  private periodList: SelectInfo[] = [
    { value: 1, label: "第一节" },
    { value: 2, label: "第二节" },
    { value: 3, label: "第三节" },
    { value: 4, label: "第四节" },
    { value: 5, label: "第五节" },
    { value: 6, label: "第六节" }
  ]
  private weekDayList: SelectInfo[] = [
    { value: 1, label: '星期一' },
    { value: 2, label: '星期二' },
    { value: 3, label: '星期三' },
    { value: 4, label: '星期四' },
    { value: 5, label: '星期五' },
    { value: 6, label: '星期六' },
    { value: 7, label: '星期日' }
  ]
  dialogController: CustomDialogController | null = new CustomDialogController({
    builder: CustomDialogLocation({
      cancel: () => {
        this.onCancel()
      },
      confirm: (value: string) => {
        this.onAccept(value)
      },
      textValue: this.courseSchedule.location,
    }),
    cancel: this.exitApp,
    autoCancel: false,
    onWillDismiss: (dismissDialogAction: DismissDialogAction) => {
      console.info("reason=" + JSON.stringify(dismissDialogAction.reason))
      console.log("dialog onWillDismiss")
      if (dismissDialogAction.reason == DismissReason.PRESS_BACK) {
        dismissDialogAction.dismiss()
      }
      if (dismissDialogAction.reason == DismissReason.TOUCH_OUTSIDE) {
        dismissDialogAction.dismiss()
      }
    },
    alignment: DialogAlignment.Center,
    // offset: { dx: 0, dy: -20 },
    gridCount: 4,
    customStyle: false,
    cornerRadius: 10,
  })

  onCancel() {
    console.info('Callback when the first button is clicked')
  }

  onAccept(value: string) {
    this.courseSchedule.location = value
  }

  exitApp() {
    console.info('Click the callback in the blank area')
  }

  // 在自定义组件即将析构销毁时将dialogController置空
  aboutToDisappear() {
    this.dialogController = null // 将dialogController置空
  }

  aboutToAppear(): void {

    // 修改操作
    if (router.getParams()) {
      this.courseSchedule = router.getParams() as CourseSchedule
    }

    this.getCourseList()
    this.getTeacherList()
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
   * 获取教师列表
   */
  getTeacherList() {
    RequestAxios.get<User[]>(GET_USER_BY_ROLE, { params: { role: Role.TEACHER } }).then(res => {
      this.teacherList = res.data.result
    })
  }

  build() {
    Column() {
      Header({ title: '课程维护' })
      Column({ space: 5 }) {
        Row() {
          Text('课程名称')
          Text(this.courseList.find(item => item.id === this.courseSchedule.courseId)?.courseName)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .backgroundColor(Color.White)
        .padding(20)
        .onClick(() => {
          TextPickerDialog.show({
            range: this.courseList.map(item => item.courseName),
            selected: this.courseSchedule.courseId,

            onAccept: (value: TextPickerResult) => {
              // 设置select为按下确定按钮时候的选中项index，这样当弹窗再次弹出时显示选中的是上一次确定的选项
              this.courseSchedule.courseId = this.courseList[value.index as number].id
              console.info("TextPickerDialog:onAccept()" + JSON.stringify(value))
            }
          })
        })


        Row() {
          Text('课节')
          Text(this.periodList.find(item => item.value === this.courseSchedule.period)?.label)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .backgroundColor(Color.White)
        .padding(20)
        .onClick(() => {
          TextPickerDialog.show({
            range: this.periodList.map(item => item.label),
            selected: this.courseSchedule.period,
            onAccept: (value: TextPickerResult) => {
              // 设置select为按下确定按钮时候的选中项index，这样当弹窗再次弹出时显示选中的是上一次确定的选项
              this.courseSchedule.period = this.periodList[value.index as number].value
              console.info("TextPickerDialog:onAccept()" + JSON.stringify(value))
            }
          })
        })

        Row() {
          Text('星期')
          Text(this.weekDayList.find(item => item.value === this.courseSchedule.weekDay)?.label)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .backgroundColor(Color.White)
        .padding(20)
        .onClick(() => {
          TextPickerDialog.show({
            range: this.weekDayList.map(item => item.label),
            selected: this.courseSchedule.weekDay,
            onAccept: (value: TextPickerResult) => {
              // 设置select为按下确定按钮时候的选中项index，这样当弹窗再次弹出时显示选中的是上一次确定的选项
              this.courseSchedule.weekDay = this.weekDayList[value.index as number].value
              console.info("TextPickerDialog:onAccept()" + JSON.stringify(value))
            }
          })
        })


        /*Row() {
          Text('授课教师')
          Text(this.teacherList.find(item => item.userId === this.courseSchedule.teacherId)?.username)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .backgroundColor(Color.White)
        .padding(20)
        .onClick(() => {
          TextPickerDialog.show({
            range: this.teacherList.map(item => item.username),
            selected: this.courseSchedule.teacherId,
            onAccept: (value: TextPickerResult) => {
              // 设置select为按下确定按钮时候的选中项index，这样当弹窗再次弹出时显示选中的是上一次确定的选项
              this.courseSchedule.teacherId = this.teacherList[value.index as number].userId
              console.info("TextPickerDialog:onAccept()" + JSON.stringify(value))
            }
          })
        })*/

        Row() {
          Text('地点')
          Text(this.courseSchedule.location)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .backgroundColor(Color.White)
        .padding(20)
        .onClick(() => {
          this.dialogController?.open()
        })

      }.width('100%')

      Row() {
        Button('删除')
          .type(ButtonType.Normal)
          .borderRadius(8)
          .onClick(() => {
            RequestAxios.delete<string>(`${DELETE_COURSE_SCHEDULE}/${this.courseSchedule.id}`).then(res => {
              promptAction.showToast({ message: res.data.result })
              router.back()
            })
          })

        Button('保存')
          .type(ButtonType.Normal)
          .borderRadius(8)
          .onClick(() => {
            if (!this.courseSchedule.courseId) {
              promptAction.showToast({ message: '请选择课程' })
              return
            }
            if (!this.courseSchedule.period) {
              promptAction.showToast({ message: '请选择课节' })
              return
            }
            if (!this.courseSchedule.weekDay) {
              promptAction.showToast({ message: '请选择星期' })
              return
            }
            if (!this.courseSchedule.location) {
              promptAction.showToast({ message: '请填写位置信息' })
              return
            }

            if (this.courseSchedule.id) {
              RequestAxios.put<null>(EDIT_COURSE_SCHEDULE, this.courseSchedule).then(res => {
                promptAction.showToast({ message: res.data.result })
                router.back()
              })
            } else {
              RequestAxios.post<null>(ADD_COURSE_SCHEDULE, this.courseSchedule).then(res => {
                promptAction.showToast({ message: res.data.result })
                router.back()
              })
            }
          })
      }
      .padding(10)
      .width('100%')
      .justifyContent(FlexAlign.SpaceAround)
    }

    .width('100%')
    .height('100%')
    .backgroundColor('#f0f0f0')

  }
}

@CustomDialog
@Component
struct CustomDialogLocation {
  @State textValue: string = ''
  controller?: CustomDialogController
  // 若尝试在CustomDialog中传入多个其他的Controller，以实现在CustomDialog中打开另一个或另一些CustomDialog，那么此处需要将指向自己的controller放在所有controller的后面
  cancel: () => void = () => {
  }
  confirm: (value: string) => void = () => {
  }

  build() {
    Column({ space: 10 }) {
      Row() {
        Text('上课地点').fontSize(20)
      }.width('100%')

      TextInput({ placeholder: '请输入上课地点', text: this.textValue }).height(50).width('100%')
        .onChange((value: string) => {
          this.textValue = value
        })
        .borderRadius(10)
      Flex({ justifyContent: FlexAlign.SpaceAround }) {
        Button('取消')
          .onClick(() => {
            if (this.controller != undefined) {
              this.controller.close()
              this.cancel()
            }
          })
        Button('确定')
          .onClick(() => {
            if (this.controller != undefined) {
              this.controller.close()
              this.confirm(this.textValue)
              this.textValue = ''
            }
          })
      }

    }
    .padding(20)
    .borderRadius(10)

    // 如果需要使用border属性或cornerRadius属性，请和borderRadius属性一起使用。
  }
}