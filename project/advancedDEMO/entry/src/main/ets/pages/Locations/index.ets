// @ts-nocheck
import prompt from '@ohos.prompt'
import router from '@ohos.router';

@Entry
@Component
struct Locations {
  aboutToAppear() {
  }

  build() {
    Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
      Column({ space: 5 }) {
        List({ space: 20, initialIndex: 0 }) {
          ListItem() {
            Text("位置").fontSize(35)
          }
          ListItem() {
            Button("地理位置").width(300).onClick(() => {
              router.pushUrl({ url: 'pages/Locations/Location' })
            })
          }
        }.divider({ strokeWidth: 2, color: 0xFFFFFF, startMargin: 20, endMargin: 20 }) // 每行之间的分界线
        .alignListItem(ListItemAlign.Center)
      }
    }
  }
}