// @ts-nocheck
import promptAction from '@ohos.promptAction'

@Entry
@Component
struct cameraContext {
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
            Button("as.createCameraContext takePhoto").width(300).onClick(()=>{
              // @ts-ignore
              const camera = as.createCameraContext()
              camera.takePhoto({
                success:res=>{
                  promptAction.showToast({
                    message: JSON.stringify(res),
                    duration: 2000,
                    bottom:500
                  })
                  console.log('[AdvancedAPIDEMO]' + res.tempImagePath );
                }
              })
            })
          }
          ListItem(){
            Button("as.createCameraContext startRecord").width(300).onClick(()=>{
              // @ts-ignore
              const camera = as.createCameraContext()
              camera.startRecord({
                success: ()=>{
                  console.log('[AdvancedAPIDEMO] startRecord success' );
                  camera.stopRecord({
                    success:res=>{
                      promptAction.showToast({
                        message: JSON.stringify(res),
                        duration: 2000,
                        bottom:500
                      })
                      console.log('[AdvancedAPIDEMO]' + res.tempVideoPath  );
                    }
                  })
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