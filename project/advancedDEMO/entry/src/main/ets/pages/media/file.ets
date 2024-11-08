// @ts-nocheck
import promptAction from '@ohos.promptAction'

@Entry
@Component
struct file {
  aboutToAppear() {
  }

  build() {
    Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
      Column({ space: 5 }) {
        List({ space: 20, initialIndex: 0 }) {
          ListItem(){
            Text("文件").fontSize(35)
          }
          ListItem(){
            Button("as.chooseFile").width(300).onClick(()=>{
              // @ts-ignore
              as.chooseFile({
                success: function (res) {
                  promptAction.showToast({
                    message: JSON.stringify(res),
                    duration: 2000,
                    bottom:500
                  })
                  console.log('[AdvancedAPIDEMO]' + JSON.stringify(res.tempFilePaths));
                }
              })
            })
          }

        }.divider({ strokeWidth: 2, color: 0xFFFFFF, startMargin: 20, endMargin: 20 }) // 每行之间的分界线
        .alignListItem(ListItemAlign.Center)
      }
    }
  }
}