// @ts-nocheck
import prompt from '@ohos.prompt'
import router from '@ohos.router';

@Entry
@Component
struct Device {
  aboutToAppear() {
  }

  build() {
    Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
      Column({ space: 5 }) {
        List({ space: 20, initialIndex: 0 }) {
          ListItem() {
            Text("设备").fontSize(35)
          }
          ListItem() {
            Button("系统").width(300).onClick(() => {
              router.pushUrl({ url: 'pages/device/SystemInfo' })
            })
          }
          ListItem() {
            Button("网络状态").width(300).onClick(() => {
              router.pushUrl({ url: 'pages/device/NetworkState' })
            })
          }
          ListItem() {
            Button("剪切板").width(300).onClick(() => {
              router.pushUrl({ url: 'pages/device/Clipboard' })
            })
          }
          ListItem() {
            Button("屏幕亮度").width(300).onClick(() => {
              router.pushUrl({ url: 'pages/device/brightness' })
            })
          }
	        ListItem() {
            Button("用户截屏事件").width(300).onClick(() => {
              router.pushUrl({ url: 'pages/device/CaptureScreen' })
            })
          }
          ListItem() {
            Button("振动").width(300).onClick(() => {
              router.pushUrl({ url: 'pages/device/vibrate' })
            })
          }
          ListItem() {
            Button("手机联系人").width(300).onClick(() => {
              router.pushUrl({ url: 'pages/device/contact' })
            })
          }
          ListItem() {
            Button("蓝牙").width(300).onClick(() => {
              router.pushUrl({ url: 'pages/device/Bluetooth' })
            })
          }
          ListItem() {
            Button("wifi").width(300).onClick(() => {
              router.pushUrl({ url: 'pages/device/wifi' })
            })
          }
          ListItem() {
            Button("电量").width(300).onClick(() => {
              router.pushUrl({ url: 'pages/device/batteryInfo' })
            })
          }
          ListItem() {
            Button("生物认证").width(300).onClick(() => {
              router.pushUrl({ url: 'pages/device/authentication' })
            })
          }
          ListItem() {
            Button("加速度传感器").width(300).onClick(() => {
              router.pushUrl({url:'pages/device/accelerometer'})
            })
          }
          ListItem() {
            Button("罗盘传感器").width(300).onClick(() => {
              router.pushUrl({url:'pages/device/compass'})
            })
          }
          ListItem() {
            Button("陀螺仪传感器").width(300).onClick(() => {
              router.pushUrl({url:'pages/device/gyroscope'})
            })
          }
          ListItem() {
            Button("拨打电话").width(300).onClick(() => {
              router.pushUrl({url:'pages/device/makePhoneCall'})
            })
          }
          ListItem() {
            Button("扫码").width(300).onClick(() => {
              router.pushUrl({url:'pages/device/scanCode'})
            })
          }
        }.divider({ strokeWidth: 2, color: 0xFFFFFF, startMargin: 20, endMargin: 20 }) // 每行之间的分界线
        .alignListItem(ListItemAlign.Center)
      }
    }
  }
}