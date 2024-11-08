// @ts-nocheck
import promptAction from '@ohos.promptAction'

@Entry
@Component
struct recorderManager {
  aboutToAppear() {
  }

  build() {
    Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
      Column({ space: 5 }) {
        List({ space: 20, initialIndex: 0 }) {
          ListItem(){
            Text("录音管理").fontSize(35)
          }
          ListItem() {
            Button("as.getRecorderManager(录制10s)").width(300).onClick(async () => {
              // @ts-ignore
              const recorderMgr =  as.getRecorderManager()
              await recorderMgr.start({
                    duration:10000
                  })
              recorderMgr.onStop(res => {
                promptAction.showToast({
                  message: JSON.stringify(res),
                  duration: 2000,
                  bottom:500
                })
                console.log('[AdvancedAPIDEMO] recorder path is ' + res.tempFilePath)
              })
            })
          }
          ListItem() {
            Button("as.getRecorderManager(第5秒暂停，第10秒继续，第15秒结束)").width(300).onClick(async () => {
              // @ts-ignore
              const recorderMgr = as.getRecorderManager()
              recorderMgr.onStart(() => {
                promptAction.showToast({
                  message: '录音开始',
                  duration: 2000,
                  bottom:500
                })
              })

              recorderMgr.onPause(() => {
                promptAction.showToast({
                  message: '录音暂停',
                  duration: 2000,
                  bottom:500
                })
              })
              recorderMgr.onResume(() => {
                promptAction.showToast({
                  message: '录音继续',
                  duration: 2000,
                  bottom:500
                })
              })
              recorderMgr.onStop(res => {
                promptAction.showToast({
                  message: '停止'+JSON.stringify(res),
                  duration: 2000,
                  bottom:500
                })
              })
              await recorderMgr.start({
                duration:20000
              })
              setTimeout(()=>{
                recorderMgr.pause()
              },5000)
              setTimeout(()=>{
                recorderMgr.resume()
              },10000)
              setTimeout(()=>{
                recorderMgr.stop()
              },15000)
            })
          }

        }.divider({ strokeWidth: 2, color: 0xFFFFFF, startMargin: 20, endMargin: 20 }) // 每行之间的分界线
        .alignListItem(ListItemAlign.Center)
      }
    }
  }
}