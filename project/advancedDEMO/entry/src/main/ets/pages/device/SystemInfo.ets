import promptAction from '@ohos.promptAction'
@Entry
@Component
struct SystemInfo {
  scroller: Scroller = new Scroller()
  aboutToAppear() {

  }
  build() {
    Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center })  {
      Column({ space: 5 }) {
        List({ space: 20, }){
          ListItem(){
            Text("系统信息").fontSize(35)
          }
          ListItem(){
            Button("as.getSystemInfo").width(300).onClick(()=>{
              // @ts-ignore
              as.getSystemInfo({
                success: function (res) {
                  promptAction.showToast({
                    message: JSON.stringify(res),
                    duration: 2000,
                    bottom:500
                  })
                }
              });
            })
          }
          ListItem(){
            Button("as.getSystemInfoSync").width(300).onClick(()=>{
              // @ts-ignore
              const  res = as.getSystemInfoSync();
              promptAction.showToast({
                message: JSON.stringify(res),
                duration: 2000,
                bottom:500
              })
            })
          }
          ListItem(){
            Button("as.getDeviceInfo").width(300).onClick(()=>{
              // @ts-ignore
              const deviceInfo = as.getDeviceInfo();
              promptAction.showToast({
                message: JSON.stringify(deviceInfo),
                duration: 2000,
                bottom:500
              });
            })
          }
          ListItem(){
            Button("as.getWindowInfo").width(300).onClick(()=>{
              // @ts-ignore
              const  res = as.getWindowInfo();
              promptAction.showToast({
                message: JSON.stringify(res),
                duration: 2000,
                bottom:500
              })
            })
          }
          ListItem(){
            Button("as.getAppBaseInfo").width(300).onClick(()=>{
              // @ts-ignore
              const  res = as.getAppBaseInfo();
              promptAction.showToast({
                message: JSON.stringify(res),
                duration: 2000,
                bottom:500
              })
            })
          }
          ListItem(){
            Button("as.getAppAuthorizeSetting").width(300).onClick(()=>{
              // @ts-ignore
              const  res = as.getAppAuthorizeSetting();
              promptAction.showToast({
                message: JSON.stringify(res),
                duration: 2000,
                bottom:500
              })
            })
          }
          ListItem(){
            Button("as.getSystemSetting").width(300).onClick(()=>{
              // @ts-ignore
              const systemSetting = as.getSystemSetting();
              promptAction.showToast({
                message: JSON.stringify(systemSetting),
                duration: 2000,
                bottom:500
              });
            })
          }
          ListItem(){
            Button("as.openAppAuthorizeSetting").width(300).onClick(()=>{
              // @ts-ignore
              as.openAppAuthorizeSetting({
                success (res) {
                  promptAction.showToast({
                    message: JSON.stringify(res),
                    duration: 2000
                  });
                }
              })
            })
          }
        }.alignListItem(ListItemAlign.Center)
      }
    }
  }
}