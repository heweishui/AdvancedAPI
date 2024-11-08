// @ts-nocheck
import prompt from '@ohos.prompt'
@Entry
@Component
struct Window {
  private windowResizeCallback = (res) => {
    prompt.showToast({ message: `[AdvancedAPI] 变化后的窗口宽度= ${JSON.stringify(res)}`})
    console.log('[AdvancedAPI] 变化后的窗口宽度=' + JSON.stringify(res))
  }

  aboutToAppear() {
  }

  build() {
    Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
      Column({ space: 5 }) {
        List({ space: 20, initialIndex: 0 }) {
          ListItem() {
            Text("窗口").fontSize(35)
          }
          ListItem() {
            Button("as.onWindowResize").width(300).onClick(() => {
              as.onWindowResize(this.windowResizeCallback)
            })
          }
          ListItem() {
            Button("as.offWindowResize").width(300).onClick(() => {
              as.offWindowResize(this.windowResizeCallback)
            })
          }
        }.divider({ strokeWidth: 2, color: 0xFFFFFF, startMargin: 20, endMargin: 20 }) // 每行之间的分界线
        .alignListItem(ListItemAlign.Center)
      }
    }
  }
}