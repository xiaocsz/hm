import preferences from '@ohos.data.preferences';
import { StorageKeys } from '../constants/StorageKeys';
import Logger from './Logger';

const TAG = 'SCHEDULE'

class PreferenceUtil {
  private pref: preferences.Preferences

  async loadPreference(context) {
    try { // 加载preferences
      this.pref = await preferences.getPreferences(context, StorageKeys.SCHEDULE_STORE)
      Logger.showDebug(TAG, `加载Preferences[${StorageKeys.SCHEDULE_STORE}]成功`)
    } catch (e) {
      Logger.showDebug(TAG, `加载Preferences[${StorageKeys.SCHEDULE_STORE}]失败，${JSON.stringify(e)}`)
    }
  }

  async putPreferenceValue(key: string, value: preferences.ValueType) {
    if (!this.pref) {
      Logger.showDebug(TAG, `Preferences[${StorageKeys.SCHEDULE_STORE}]尚未初始化！`)
      return
    }
    try {
      // 写入数据
      await this.pref.put(key, value)
      // 刷盘
      await this.pref.flush()
      Logger.showDebug(TAG, `保存Preferences[${key} = ${value}]成功`)
    } catch (e) {
      Logger.showDebug(TAG, `保存Preferences[${key} = ${value}]失败，${JSON.stringify(e)}`)
    }
  }

  async getPreferenceValue(key: string, defaultValue: preferences.ValueType) {
    if (!this.pref) {
      Logger.showDebug(TAG, `Preferences[${StorageKeys.SCHEDULE_STORE}]尚未初始化！`)
      return
    }
    try {
      // 读数据
      let value = await this.pref.get(key, defaultValue)
      Logger.showDebug(TAG, `读取Preferences[${key} = ${value}]成功`)
      return value
    } catch (e) {
      Logger.showDebug(TAG, `读取Preferences[${key}]失败，${JSON.stringify(e)}`)
    }
  }
}

const preferenceUtil = new PreferenceUtil()

export default preferenceUtil as PreferenceUtil