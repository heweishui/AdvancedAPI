// @ts-nocheck
import promptAction from '@ohos.promptAction'

@Entry
@Component
struct backgroundAudioManager {
  aboutToAppear() {
  }

  build() {
    Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
      Column({ space: 5 }) {
        List({ space: 20, initialIndex: 0 }) {
          ListItem(){
            Text("背景音频播放管理").fontSize(35)
          }
          ListItem() {
            Button("as.getBackgroundAudioManager 从第2秒开始播放，3秒后打印长度和时间").width(300).onClick(() => {
              // @ts-ignore
              const audioManager = as.getBackgroundAudioManager()
              // @ts-ignore
              as.chooseFile({
                success: async function (res) {
                  console.log('[AdvancedAPIDEMO]' + JSON.stringify(res.tempFilePaths));
                  audioManager.startTime = 2
                  audioManager.src = res.tempFilePaths[0]
                  setTimeout(()=>{
                    promptAction.showToast({
                      message: `音频长度${audioManager.duration},当前时间${audioManager.currentTime}`,
                      duration: 2000,
                      bottom:500
                    })
                  },3000)
                }
              })
            })
          }

          ListItem() {
            Button("as.getBackgroundAudioManager验证监听事件").width(300).onClick(() => {
              // @ts-ignore
              const audioManager = as.getBackgroundAudioManager()
              // @ts-ignore
              as.chooseFile({
                success: async function (res) {
                  console.log('[AdvancedAPIDEMO]' + JSON.stringify(res.tempFilePaths));
                  audioManager.onCanplay(()=>{
                    promptAction.showToast({
                      message: '进入可以播放状态',
                      duration: 2000,
                      bottom:500
                    })
                  })
                  audioManager.onPlay(()=>{
                    promptAction.showToast({
                      message: '播放',
                      duration: 2000,
                      bottom:500
                    })
                  })
                  audioManager.onPause(()=>{
                    promptAction.showToast({
                      message: '暂停',
                      duration: 2000,
                      bottom:500
                    })
                  })
                  audioManager.onStop(()=>{
                    promptAction.showToast({
                      message: '停止',
                      duration: 2000,
                      bottom:500
                    })
                  })
                  audioManager.onEnded(()=>{
                    promptAction.showToast({
                      message: '结束',
                      duration: 2000,
                      bottom:500
                    })
                  })
                  audioManager.src = res.tempFilePaths[0]

                  setTimeout(()=>{
                    audioManager.pause()
                  },3000)
                  setTimeout(()=>{
                    audioManager.play()
                  },5000)

                  setTimeout(()=>{
                    audioManager.seek(1)
                  },8000)
                  setTimeout(()=>{
                    audioManager.stop()
                  },13000)

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