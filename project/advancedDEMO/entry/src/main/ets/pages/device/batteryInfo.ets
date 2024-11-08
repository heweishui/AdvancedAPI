// @ts-nocheck
import prompt from '@ohos.prompt'
@Entry
@Component
struct BatteryInfo {
  aboutToAppear() {
  }

  build() {
    Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
      Column({ space: 20 }) {
        Text("电量信息").fontSize(35)
        Button("as.getBatteryInfo").width(300).onClick(() => {
          as.getBatteryInfo({
            success: (res) => {
              prompt.showToast({
                message:`电量：${res.level} 是否在充电：${res.isCharging}`
              })
              console.log(JSON.stringify(res))
            }
          });
        })

        // test
        Button("as.getBatteryInfo").width(300).onClick(() => {
          // 接口验证兼顾场景：1 手机正常充电   2 手机未连接usb接口充电  3 电量极地的情况是否正常获取
          as.getBatteryInfo({
            success: (res) => {
              prompt.showToast({
                message:`电量：${res.level} 是否在充电：${res.isCharging}`
              })
              console.log('[AdvancedAPI] getBatteryInfo success'+ JSON.stringify(res))
            },
            fail:function (e){
              console.log('[AdvancedAPI] getBatteryInfo fail' + JSON.stringify(e))
            },
            complete:function(res){
              console.log('[AdvancedAPI] getBatteryInfo complete' + JSON.stringify(res))
            }
          })
        })
      }
    }
  }
}