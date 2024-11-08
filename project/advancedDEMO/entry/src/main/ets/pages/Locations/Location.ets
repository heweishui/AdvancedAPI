import promptAction from '@ohos.promptAction'
@Entry
@Component
struct Location {
  scroller: Scroller = new Scroller()
  aboutToAppear() {

  }
  callback1 = function (res) {
    console.log(`[AdvancedAPIDEMO] callback1 ${JSON.stringify(res)}`)
    promptAction.showToast({
      message: JSON.stringify(res)+'1',
      duration: 2000,
      bottom:500
    })
  }
  callback2 = function (res) {
    console.log(`[AdvancedAPIDEMO] callback2 ${JSON.stringify(res)}`)
    promptAction.showToast({
      message: JSON.stringify(res)+'2',
      duration: 2000,
      bottom:500
    })
  }
  build() {
    Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center })  {
      Column({ space: 5 }) {
        List({ space: 20, }){
          ListItem(){
            Text("地理位置").fontSize(35)
          }
          ListItem(){
            Button("as.getLocation").width(300).onClick(()=>{
              // @ts-ignore
              as.getLocation({
                success: function (res) {
                  promptAction.showToast({
                    message: JSON.stringify(res),
                    duration: 2000,
                    bottom:500
                  })
                },
                fail:function(data){
                  promptAction.showToast({
                    message: JSON.stringify(data),
                    duration: 2000,
                    bottom:500
                  })
                },
                complete:function(data){
                  promptAction.showToast({
                    message: JSON.stringify(data),
                    duration: 2000,
                    bottom:500
                  })
                }
              })
            })
          }
          ListItem(){
            Button("as.onLocationChange callback1").width(300).onClick(()=>{
              // @ts-ignore
              as.onLocationChange(this.callback1)
            })
          }
          ListItem(){
            Button("as.onLocationChange callback2").width(300).onClick(()=>{
              // @ts-ignore
              as.onLocationChange(this.callback2)
            })
          }
          ListItem(){
            Button("as.offLocationChange callback1").width(300).onClick(()=>{
              // @ts-ignore
              as.offLocationChange(this.callback1)
            })
          }
          ListItem(){
            Button("as.offLocationChange callback2").width(300).onClick(()=>{
              // @ts-ignore
              as.offLocationChange(this.callback2)
            })
          }
          ListItem(){
            Button("as.onLocationChangeError").width(300).onClick(()=>{
              // @ts-ignore
              as.onLocationChangeError(data=>{
                promptAction.showToast({
                  message: JSON.stringify(data),
                  duration: 2000,
                  bottom:500
                })
              })
            })
          }
          ListItem(){
            Button("as.offLocationChangeError").width(300).onClick(()=>{
              // @ts-ignore
              as.offLocationChangeError(()=>{
                promptAction.showToast({
                  message: 'offLocationChangeError ',
                  duration: 2000,
                  bottom:500
                })
              })
            })
          }
          ListItem(){
            Button("as.stopLocationUpdate").width(300).onClick(()=>{
              // @ts-ignore
              as.stopLocationUpdate({
                success:res=>{
                  promptAction.showToast({
                    message: '停止高阶API接收位置消息成功 ',
                    duration: 2000,
                    bottom:500
                  })
                },
                fail:err=>{
                  promptAction.showToast({
                    message: '停止高阶API接收位置消息失败：'+err,
                    duration: 2000,
                    bottom:500
                  })
                },
                complete:res=>{
                  promptAction.showToast({
                    message: '调用停止高阶API接收位置消息 API 完成',
                    duration: 2000,
                    bottom:500
                  })
                }
              })
            })
          }
          ListItem(){
            Button("as.startLocationUpdateBackground").width(300).onClick(()=>{
              // @ts-ignore
              as.startLocationUpdateBackground({
                success: res => {
                  promptAction.showToast({
                    message: '开启前后台高阶API接收位置消息成功',
                    duration: 2000,
                    bottom:500
                  })
                },
                fail: err => {
                  promptAction.showToast({
                    message: '开启前后台高阶API接收位置消息失败',
                    duration: 2000,
                    bottom:500
                  })
                },
                complete: msg => {
                  promptAction.showToast({
                    message: '调用开启前后台高阶API接收位置消息 API 完成',
                    duration: 2000,
                    bottom:500
                  })
                }
              });
            })
          }
          ListItem(){
            Button("as.startLocationUpdate").width(300).onClick(()=>{
              // @ts-ignore
              as.startLocationUpdate({
                success: res => {
                  promptAction.showToast({
                    message: '开启高阶API接收位置消息成功',
                    duration: 2000,
                    bottom:500
                  })
                },
                fail: err => {
                  promptAction.showToast({
                    message: '开启高阶API接收位置消息失败',
                    duration: 2000,
                    bottom:500
                  })
                },
                complete: msg => {
                  promptAction.showToast({
                    message: '调用开启高阶API接收位置消息 API 完成',
                    duration: 2000,
                    bottom:500
                  })
                }
              });
            })
          }
        }.alignListItem(ListItemAlign.Center)
      }
    }
  }
}