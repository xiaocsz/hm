import { router } from '@kit.ArkUI';
import HomeIndex from '../components/home/HomeIndex';
import MyIndex from '../components/my/MyIndex';
import { StorageKeys } from '../constants/StorageKeys';
import { User } from '../model/UserInfo';
import PreferenceUtil from '../utils/PreferenceUtil';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';
  @StorageLink(StorageKeys.USER_INFO) currentUser: User | null = null

  async aboutToAppear(): Promise<void> {
    const currentUser = await PreferenceUtil.getPreferenceValue(StorageKeys.USER_INFO, null) as User
    this.currentUser = currentUser
  }

  build() {
    Column() {
      Tabs() {
        TabContent() {
          HomeIndex()
        }.tabBar('首页')

        TabContent() {
          MyIndex()
        }.tabBar('我的')
      }
      .barPosition(BarPosition.End)
      .barBackgroundColor('#fff')
    }

    .height('100%')
    .width('100%')
  }
}