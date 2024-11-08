// @ts-nocheck
import promptAction from '@ohos.promptAction'

@Entry
@Component
struct cameraContext {
  private cameraContext  = as.createCameraContext();
  aboutToAppear() {
  }

  build() {
    Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
      Column({ space: 5 }) {
        List({ space: 20, initialIndex: 0 }) {
          ListItem(){
            Text("相机").fontSize(35)
          }
          ListItem(){
            Button("takePhoto").width(300).onClick(()=>{
              // @ts-ignore
              this.cameraContext.takePhoto({
                success: function (res) {
//                  console.log('[AdvancedAPIDEMO] cameraContext.takePhoto success ' + JSON.stringify(res));
//                  console.log('[AdvancedAPIDEMO] cameraContext.takePhoto success ' + JSON.stringify(res));
                  console.log('[AdvancedAPIDEMO] cameraContext.takePhoto success ' + JSON.stringify(res));
                },
                fail: (res) => {
                  console.error('[AdvancedAPIDEMO] cameraContext.takePhoto fail ' + JSON.stringify(res));
                },
                complete: (res) => {
                  console.log('[AdvancedAPIDEMO] cameraContext.takePhoto complete  ' + JSON.stringify(res));
                }
              })
            })
          }

          ListItem(){
            Button("startRecord").width(300).onClick(()=>{
              // @ts-ignore
              this.cameraContext.startRecord({
                success: function (res) {
                  console.log('[AdvancedAPIDEMO] cameraContext.startRecord success ' + JSON.stringify(res));
                },
                fail: (res) => {
                  console.error('[AdvancedAPIDEMO] cameraContext.startRecord fail ' + JSON.stringify(res));
                },
                complete: (res) => {
                  console.log('[AdvancedAPIDEMO] cameraContext.startRecord complete  ' + JSON.stringify(res));
                }
              })
            })
          }

          ListItem(){
            Button("stopRecord").width(300).onClick(()=>{
              // @ts-ignore
              this.cameraContext.stopRecord({
                success: function (res) {
                  console.log('[AdvancedAPIDEMO] cameraContext.stopRecord success ' + JSON.stringify(res));
                },
                fail: (res) => {
                  console.error('[AdvancedAPIDEMO] cameraContext.stopRecord fail ' + JSON.stringify(res));
                },
                complete: (res) => {
                  console.log('[AdvancedAPIDEMO] cameraContext.stopRecord complete  ' + JSON.stringify(res));
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