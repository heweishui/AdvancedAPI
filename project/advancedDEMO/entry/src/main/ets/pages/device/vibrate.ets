import promptAction from '@ohos.promptAction'

@Entry
@Component
struct Vibrate {
  netId = 0

  build() {
    Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
      Column({ space: 5 }) {
        Text('振动 vibrate').fontSize(35)
        Button('as.vibrate').width(300).onClick(() => {
          // @ts-ignore
          as.vibrate({
            success: function (data) {
              console.log('[AdvancedAPI] vibrate success data = '+JSON.stringify(data))
              promptAction.showToast({
                message: '振动成功'
              })
            },
            fail: function (err) {
              console.log('[AdvancedAPI] vibrate fail err = '+JSON.stringify(err))
              promptAction.showToast({
                message: '振动失败'
              })
            },
            complete: function (data) {
              console.log('[AdvancedAPI] vibrateShort complete data = '+JSON.stringify(data))
            }
          })
        })

        Button('as.vibrateLong').width(300).onClick(() => {
          // @ts-ignore
          as.vibrateLong({
            success: function (data) {
              console.log('[AdvancedAPI] vibrateLong success data = '+JSON.stringify(data))
              promptAction.showToast({
                message: '长振动成功'
              })
            },
            fail: function (err) {
              console.log('[AdvancedAPI] vibrateLong fail err = '+JSON.stringify(err))
              promptAction.showToast({
                message: '长振动失败'
              })
            },
            complete: function (data) {
              console.log('[AdvancedAPI] vibrateLong complete data = '+JSON.stringify(data))
            }
          })
        })

        Button('as.vibrateShort').width(300).onClick(() => {
          // @ts-ignore
          as.vibrateShort({
            success: function (data) {
              console.log('[AdvancedAPI] vibrateShort success data = '+JSON.stringify(data))
              promptAction.showToast({
                message: '短振动成功'
              })
            },
            fail: function (err) {
              console.log('[AdvancedAPI] vibrateShort fail err = '+JSON.stringify(err))
              promptAction.showToast({
                message: '短振动失败'
              })
            },
            complete: function (data) {
              console.log('[AdvancedAPI] vibrateShort complete data = '+JSON.stringify(data))
            }
          })
        })
      }
    }
  }
}