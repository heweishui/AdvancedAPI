import promptAction from '@ohos.promptAction'

@Entry
@Component
struct Interceptor {
  netId = 0

  build() {
    Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
      Column({ space: 5 }) {
        Text('拦截器').fontSize(35)

        Button('添加startWifi拦截器').width(300).onClick(() => {
          // @ts-ignore
          as.addInterceptor('startWifi', {
            invoke: (args) => {
              console.log(`[AdvancedAPI] 拦截器 invoke args = `+JSON.stringify(args));
              promptAction.showToast({
                message: 'startWifi 拦截触发前回调'
              })
            },
            returnValue: (args) => {
              console.log(`[AdvancedAPI] 拦截器 returnValue args = `+JSON.stringify(args));
              promptAction.showToast({
                message: 'startWifi 拦截返回值回调'
              })
              return args
            },
            success: (args) => {
              console.log('[AdvancedAPI] 拦截器 success args = '+JSON.stringify(args))
              promptAction.showToast({
                message: 'startWifi 拦截成功回调'
              })
            },
            fail: (err) => {
              console.log('[AdvancedAPI] 拦截器 fail'+JSON.stringify(err))
              promptAction.showToast({
                message: 'startWifi 拦截失败回调'
              })
            },
            complete: (res) => {
              console.log('[AdvancedAPI] 拦截器 complete '+JSON.stringify(res))
              promptAction.showToast({
                message: 'startWifi 拦截完成回调'
              })
            }
          })
        })

        Button('取消startWifi拦截器').width(300).onClick(() => {
          // @ts-ignore
          as.removeInterceptor('startWifi')
        })

        Button('添加全局拦截器').width(300).onClick(() => {
          // @ts-ignore
          as.addInterceptor({
            invoke: (args) => {
              //  触发前拼接 url
              console.log(`[AdvancedAPI] 全局拦截器 invoke args = `+JSON.stringify(args));
              promptAction.showToast({
                message: '全局拦截触发前回调'
              })
            },
            returnValue: (args) => {
              // 只返回 data 字段
              console.log(`[AdvancedAPI] 全局拦截器 returnValue args = `+JSON.stringify(args));
              promptAction.showToast({
                message: '全局拦截返回值回调'
              })
              return args
            },
            success: (args) => {
              console.log('[AdvancedAPI] 全局拦截器 success args = '+JSON.stringify(args))
              promptAction.showToast({
                message: '全局拦截成功前回调'
              })
            },
            fail: (err) => {
              console.log('[AdvancedAPI] 全局拦截器 fail'+JSON.stringify(err))
              promptAction.showToast({
                message: '全局拦截失败前回调'
              })
            },
            complete: (res) => {
              console.log('[AdvancedAPI] 全局拦截器 complete '+JSON.stringify(res))
              promptAction.showToast({
                message: '全局拦截完成前回调'
              })
            }
          })
        })

        Button('as.startWifi').width(300).onClick(() => {
          // @ts-ignore
          as.startWifi({
            data: {
              name: 'testName'
            },
            success: function (data) {
              console.log('[AdvancedAPI] startWifi success data = '+JSON.stringify(data))
              promptAction.showToast({
                message: 'startWifi success'
              })
            },
            fail: function (data) {
              console.log('[AdvancedAPI] startWifi fail data = '+JSON.stringify(data))
              promptAction.showToast({
                message: 'startWifi fail'
              })
            },
            complete: function (data) {
              console.log('[AdvancedAPI] startWifi complete data = '+ JSON.stringify(data))
              promptAction.showToast({
                message: 'startWifi complete'
              })
            }
          })
        })
      }
    }
  }
}