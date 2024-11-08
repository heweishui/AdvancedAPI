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
            Text("网络").fontSize(35)
          }
          ListItem() {
            Button("网络请求").width(300).onClick(() => {
              router.pushUrl({ url: 'pages/net/request' })
            })
          }
          ListItem() {
            Button("上传文件").width(300).onClick(() => {
              router.pushUrl({ url: 'pages/net/uploadFile' })
            })
          }
          ListItem() {
            Button("下载文件").width(300).onClick(() => {
              router.pushUrl({ url: 'pages/net/downloadFile' })
            })
          }
          ListItem() {
            Button("webSocket").width(300).onClick(() => {
              router.pushUrl({ url: 'pages/net/webSocket' })
            })
          }
        }.divider({ strokeWidth: 2, color: 0xFFFFFF, startMargin: 20, endMargin: 20 }) // 每行之间的分界线
        .alignListItem(ListItemAlign.Center)
      }
    }
  }
}