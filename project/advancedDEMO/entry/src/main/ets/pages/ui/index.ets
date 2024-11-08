// @ts-nocheck
import prompt from '@ohos.prompt'
import router from '@ohos.router';

@Entry
@Component
struct UI {
  aboutToAppear() {
  }

  build() {
    Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
      Column({ space: 5 }) {
        List({ space: 20, initialIndex: 0 }) {
          ListItem() {
            Text("界面").fontSize(35)
          }
          ListItem() {
            Button("交互反馈").width(300).onClick(() => {
              router.pushUrl({ url: 'pages/ui/Prompt' })
            })
          }
          ListItem() {
              Button("窗口").width(300).onClick(() => {
                router.pushUrl({ url: 'pages/ui/window' })
              })
          }
          ListItem() {
            Button("背景").width(300).onClick(() => {
              router.pushUrl({ url: 'pages/ui/background' })
            })
          }
        }.divider({ strokeWidth: 2, color: 0xFFFFFF, startMargin: 20, endMargin: 20 }) // 每行之间的分界线
        .alignListItem(ListItemAlign.Center)
      }
    }
  }
}