// @ts-nocheck
import prompt from '@ohos.prompt'
@Entry
@Component
struct Clipboard {
  @State text: string = ''
  aboutToAppear() {
  }
  /*
    data：2023/04/18
   */

  build() {
    Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
      Column({ space: 20 }) {
        Text("扫码").fontSize(35)

        List({ space: 20, initialIndex: 0 }){
          ListItem(){
            Column ({ space: 10 }) {
              Text('scanCode').fontSize(28).backgroundColor(Color.Orange)
              // makePhoneCall   phoneNumber  String 正常入参
              Button("scanCode").width(300).onClick(() => {
                as.scanCode({
                  success: function (res) {
                    console.log('[AdvancedAPI] scanCode success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI] scanCode fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI] scanCode complete' + JSON.stringify(res))
                  }
                })
              })
              Button("scanCode只扫条形码").width(300).onClick(() => {
                as.scanCode({
                  scanType:['barCode'],
                  success: function (res) {
                    console.log('[AdvancedAPI] scanCode success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI] scanCode fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI] scanCode complete' + JSON.stringify(res))
                  }
                })
              })
              Button("scanCode只扫二维码").width(300).onClick(() => {
                as.scanCode({
                  scanType:['qrCode'],
                  success: function (res) {
                    console.log('[AdvancedAPI] scanCode success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI] scanCode fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI] scanCode complete' + JSON.stringify(res))
                  }
                })
              })
              Button("scanCode onlyFromCamera ").width(300).onClick(() => {
                as.scanCode({
                  onlyFromCamera:true,
                  success: function (res) {
                    console.log('[AdvancedAPI] scanCode success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI] scanCode fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI] scanCode complete' + JSON.stringify(res))
                  }
                })
              })
            }.alignItems(HorizontalAlign.Center).width('90%').border({ width: 1 })
          }
        }.divider({ strokeWidth: 2, color: 0xFFFFFF, startMargin: 20, endMargin: 20 }) // 每行之间的分界线
        .alignListItem(ListItemAlign.Center)
      }
    }
  }
}