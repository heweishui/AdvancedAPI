// @ts-nocheck
import prompt from '@ohos.prompt'
import router from '@ohos.router'

@Entry
@Component
struct Base {
  aboutToAppear() {
  }

  build() {
    Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
      Column({ space: 5 }) {
        List({ space: 20, initialIndex: 0 }) {
          ListItem() {
            Text("基础").fontSize(35)
          }
          ListItem() {
            Button("定时器").width(300).onClick(() => {
              router.pushUrl({ url: 'pages/base/timeout' })
            })
          }
          ListItem() {
            Button("base64ToArrayBuffer").width(300).onClick(() => {
              router.pushUrl({ url: 'pages/base/base64ToArrayBuffer' })
            })
          }
          ListItem() {
            Button("arrayBufferToBase64").width(300).onClick(() => {
              router.pushUrl({ url: 'pages/base/arrayBufferToBase64' })
            })
          }
          ListItem() {
            Button("应用级事件").width(300).onClick(() => {
              prompt.showToast({
                message:'接口暂不支持'
              })
//              router.pushUrl({ url: 'pages/ui/Prompt' })
            })
          }
          ListItem() {
            Button("拦截器").width(300).onClick(() => {
              router.pushUrl({ url: 'pages/base/interceptor' })
            })
          }
        }.divider({ strokeWidth: 2, color: 0xFFFFFF, startMargin: 20, endMargin: 20 }) // 每行之间的分界线
        .alignListItem(ListItemAlign.Center)
      }
    }
  }
}