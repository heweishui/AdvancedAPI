import promptAction from '@ohos.promptAction'

@Entry
@Component
struct Timeout {
  netId = 0
  private timer  = null;

  build() {
    Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
      Column ({ space: 10 }) {
        Text('日志打印').fontSize(35)

        Button('点击过滤查看日志输出').width(300).onClick(() => {
          // log info warn error  (debug)
          console.log('[AdvancedAPI] console log')
          console.info('[AdvancedAPI] console info')
          console.debug('[AdvancedAPI] console debug')
          console.warn('[AdvancedAPI] console warn')
          console.error('[AdvancedAPI] console error')
        })

        Text('定时器').fontSize(35)

        Button('setInterval与clearInterval').width(300).onClick(() => {
          // @ts-ignore
          this.timer = setInterval(() => {
            for(let i = 0; i <= 5; i++){
              console.log('[AdvancedAPI] setInterval  ' + i)
              if(i > 3){
                 clearInterval(this.timer)
              }
            }
          },2000)
        })

        Button('setTimeout与clearTimeout').width(300).onClick(() => {
          // @ts-ignore
          this.timer = setTimeout(() => {
            for(let i = 0; i <= 7; i++){
              console.log('[AdvancedAPI] setTimeout  ' + i)
              if(i > 2){
                clearTimeout(this.timer)
              }
            }
          },2000)
        })

      }
    }
  }
}