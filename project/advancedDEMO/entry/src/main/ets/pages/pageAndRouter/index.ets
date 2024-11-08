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
            Text("页面和路由").fontSize(35)
          }
          ListItem() {
            Button("navigateTo").width(300).onClick(() => {
              router.pushUrl({ url: 'pages/pageAndRouter/navigateTo' })
            })
          }
          ListItem() {
            Button("redirectTo").width(300).onClick(() => {
              router.pushUrl({ url: 'pages/pageAndRouter/redirectTo' })
            })
          }
          ListItem() {
            Button("reLaunch").width(300).onClick(() => {
              router.pushUrl({ url: 'pages/pageAndRouter/reLaunch' })
            })
          }
          ListItem() {
            Button("navigateBack").width(300).onClick(() => {
              router.pushUrl({ url: 'pages/pageAndRouter/navigateBack' })
            })
          }
        }.divider({ strokeWidth: 2, color: 0xFFFFFF, startMargin: 20, endMargin: 20 }) // 每行之间的分界线
        .alignListItem(ListItemAlign.Center)
      }
    }
  }
}