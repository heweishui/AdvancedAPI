import router from '@ohos.router';

@Entry
@Component
struct Index {
  aboutToAppear() {

  }
  build() {
    Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
      Column({ space: 5 }) {
        List({ space: 20, initialIndex: 0 }) {
          ListItem() {
            Text("首页").fontSize(35)
          }
          ListItem() {
            Button("基础").width(300).onClick(() => {
              router.pushUrl({ url: 'pages/base/index' })
            })
          }
          ListItem() {
            Button("网络").width(300).onClick(() => {
              router.pushUrl({ url: 'pages/Network' })
            })
          }
          ListItem() {
            Button("网络").width(300).onClick(() => {
              router.pushUrl({ url: 'pages/net/index' })
            })
          }
          ListItem() {
            Button("页面和路由").width(300).onClick(() => {
              router.pushUrl({ url: 'pages/router' })
            })
          }
          ListItem() {
            Button("页面和路由-test").width(300).onClick(() => {
              router.pushUrl({ url: 'pages/pageAndRouter/index' })
            })
          }
          ListItem() {
            Button("位置").width(300).onClick(() => {
              router.pushUrl({ url: 'pages/Locations/index' })
            })
          }
          ListItem() {
            Button("设备").width(300).onClick(() => {
              router.pushUrl({ url: 'pages/device/index' })
            })
          }
          ListItem() {
            Button("界面").width(300).onClick(() => {
              router.pushUrl({ url: 'pages/ui/index' })
            })
          }
          ListItem() {
            Button("文件").width(300).onClick(() => {
              router.pushUrl({ url: 'pages/file/file' })
            })
          }
          ListItem() {
            Button("文件管理系统").width(300).onClick(() => {
              router.pushUrl({ url: 'pages/file/fileSystemManager' })
            })
          }
          ListItem() {
            Button("文件管理系统").width(300).onClick(() => {
              router.pushUrl({ url: 'pages/file/fileSystemManager_Supplement' })
            })
          }
          ListItem() {
            Button("数据缓存").width(300).onClick(() => {
              router.pushUrl({ url: 'pages/storage' })
            })
          }
          ListItem() {
            Button("数据缓存_test").width(300).onClick(() => {
              router.pushUrl({ url: 'pages/storageTest' })
            })
          }
          ListItem() {
            Button("媒体").width(300).onClick(() => {
              router.pushUrl({url:'pages/media/media'})
            })
          }
          ListItem() {
            Button("键盘").width(300).onClick(() => {
              router.pushUrl({ url: 'pages/Keyboard' })
            })
          }
          ListItem() {
            Button("帐号").width(300).onClick(() => {
              router.pushUrl({ url: 'pages/Account' })
            })
          }
        }.divider({ strokeWidth: 2, color: 0xFFFFFF, startMargin: 20, endMargin: 20 }) // 每行之间的分界线
        .alignListItem(ListItemAlign.Center)
      }
    }
  }
}