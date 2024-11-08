// @ts-nocheck
import prompt from '@ohos.prompt'
@Entry
@Component
struct NetworkState {
  private subcribecb1 (res) {
    prompt.showToast({
      message:`onNetworkStatusChange1 isConnected:${res.isConnected}  networkType:${res.networkType}`,
    })
    console.log('[AdvancedAPI]onNetworkStatusChange1 isConnected ' + res.isConnected);
    console.log('[AdvancedAPI]onNetworkStatusChange1 networkType ' + res.networkType);
  }
  private subcribecb2 (res) {
    prompt.showToast({
      message:`onNetworkStatusChange2 isConnected:${res.isConnected}  networkType:${res.networkType}`,
    })
    console.log('[AdvancedAPI]onNetworkStatusChange2 isConnected ' + res.isConnected);
    console.log('[AdvancedAPI]onNetworkStatusChange2 networkType ' + res.networkType);
  }

  aboutToAppear() {
  }

  build() {
    Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
      Column({ space: 20 }) {
        Text("网络状态").fontSize(35)
        Button("as.getNetworkType").width(300).onClick(() => {
          as.getNetworkType({
            success: function (res) {
              prompt.showToast({
                message:`网络状态：${res.networkType}`,
              })
              console.log('[AdvancedAPI] getNetworkType ' + res.networkType);
            }
          });
        })
        //getNetworkType 兼顾场景1：wifi  2：流量卡  3：无网络
        Button("as.getNetworkType").width(300).onClick(() => {
          as.getNetworkType({
            success: function (res) {
              console.log('[AdvancedAPI] getNetworkType success1111');
              console.log('[AdvancedAPI] getNetworkType success'+JSON.stringify(res));
              console.log('[AdvancedAPI] getNetworkType success'+res.isConnected);
              console.log('[AdvancedAPI] getNetworkType success'+res.networkType);
            },
            fail:function (e){
              console.log('[AdvancedAPI] getNetworkType fail' + JSON.stringify(e));
            },
            complete:function(res){
              console.log('[AdvancedAPI] getNetworkType complete' + JSON.stringify(res));
            }
          });
        })
        Button("as.onNetworkStatusChange1").width(300).onClick(() => {
          as.onNetworkStatusChange(this.subcribecb1)
        })
        Button("as.onNetworkStatusChange2").width(300).onClick(() => {
          as.onNetworkStatusChange(this.subcribecb2)
        })
        Button("as.offNetworkStatusChange1").width(300).onClick(() => {
          as.offNetworkStatusChange(this.subcribecb1)
        })
        Button("as.offNetworkStatusChange2").width(300).onClick(() => {
          as.offNetworkStatusChange(this.subcribecb2)
        })
      }
    }
  }
}