// @ts-nocheck
import promptAction from '@ohos.promptAction'

@Entry
@Component
struct innerAudioContext {
  aboutToAppear() {
  }

  build() {
    Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
      Column({ space: 5 }) {
        List({ space: 20, initialIndex: 0 }) {
          ListItem(){
            Text("音频组件控制").fontSize(35)
          }
          ListItem() {
            Button("as.createInnerAudioContext").width(300).onClick(() => {
              // @ts-ignore
              const audioManager = as.createInnerAudioContext()
              // @ts-ignore
              as.chooseFile({
                success: async function (res) {
                  promptAction.showToast({
                    message: JSON.stringify(res),
                    duration: 2000,
                    bottom:500
                  })
                  audioManager.startTime = 2
                  console.log('[AdvancedAPIDEMO]' + JSON.stringify(res.tempFilePaths));
                  audioManager.autoplay = true
                  audioManager.src = res.tempFilePaths[0]
                }
              })
            })
          }

          ListItem() {
            Button("as.createInnerAudioContext 验证监听事件").width(300).onClick(() => {
              // @ts-ignore
              const audioManager = as.createInnerAudioContext()
              // @ts-ignore
              as.chooseFile({
                success: async function (res) {
                  console.log('[AdvancedAPIDEMO]' + JSON.stringify(res.tempFilePaths));
                  audioManager.onCanplay(()=>{

                    audioManager.play()
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
                  audioManager.onSeeking(()=>{
                    promptAction.showToast({
                      message: 'seek',
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