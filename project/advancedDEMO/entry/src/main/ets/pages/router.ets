// @ts-nocheck

@Entry
@Component
struct Router {
  build() {
    Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
      Column({ space: 20 }) {
        Text('路由').fontSize(35)
        List ({ space: 20, initialIndex: 0 }) {
          ListItem () {
            Column ({ space: 10 }) {
              Button('as.navigateTo').width(300).onClick(() => {
                as.navigateTo({
                  url: 'pages/Index',
                  success: function (data) {
                    console.log(`[AdvancedAPI] navigateTo success data = ${JSON.stringify(data)}`)
                  },
                  fail: function (err) {
                    console.log(`[AdvancedAPI] navigateTo fail data = ${JSON.stringify(err)}`)
                  }
                })
              })

              Button('as.navigateTo url不填').width(300).onClick(() => {
                as.navigateTo({
                  url: undefined,
                  success: function (data) {
                    console.log(`[AdvancedAPI] navigateTo success data = ${JSON.stringify(data)}`)
                  },
                  fail: function (err) {
                    console.log(`[AdvancedAPI] navigateTo fail data = ${JSON.stringify(err)}`)
                  }
                })
              })

              Button('as.navigateTo url携带参数').width(300).onClick(() => {
                as.navigateTo({
                  url: 'pages/Index?id=1&name=uniapp',
                  success: function (data) {
                    console.log(`[AdvancedAPI] navigateTo success data = ${JSON.stringify(data)}`)
                  },
                  fail: function (err) {
                    console.log(`[AdvancedAPI] navigateTo fail data = ${JSON.stringify(err)}`)
                  }
                })
              })

              Button('as.redirectTo').width(300).onClick(() => {
                as.redirectTo({
                  url: 'pages/Index',
                  success: function (data) {
                    console.log(`[AdvancedAPI] redirectTo success data = ${JSON.stringify(data)}`)
                  },
                  fail: function (err) {
                    console.log(`[AdvancedAPI] redirectTo fail ${JSON.stringify(err)}}`)
                  }
                })
              })

              Button('as.redirectTo url 携带参数').width(300).onClick(() => {
                as.redirectTo({
                  url: 'pages/Index?id=1&name=uniapp',
                  success: function (data) {
                    console.log(`[AdvancedAPI] redirectTo success data = ${JSON.stringify(data)}`)
                  },
                  fail: function (err) {
                    console.log(`[AdvancedAPI] redirectTo fail ${JSON.stringify(err)}}`)
                  }
                })
              })

              Button('as.reLaunch').width(300).onClick(() => {
                as.reLaunch({
                  url: 'pages/Index',
                  success: function (data) {
                    console.log(`[AdvancedAPI] redirectTo success data = ${JSON.stringify(data)}`)
                  },
                  fail: function (err) {
                    console.log(`[AdvancedAPI] redirectTo fail ${JSON.stringify(err)}`)
                  },
                  complete: function () {}
                })
              })

              Button('as.reLaunch url 携带参数').width(300).onClick(() => {
                as.reLaunch({
                  url: 'pages/Index?id=1&name=uniapp',
                  success: function (data) {
                    console.log(`[AdvancedAPI] redirectTo success data = ${JSON.stringify(data)}`)
                  },
                  fail: function (err) {
                    console.log(`[AdvancedAPI] redirectTo fail ${JSON.stringify(err)}`)
                  },
                  complete: function () {}
                })
              })

              Button('as.reLaunch url传递number').width(300).onClick(() => {
                as.reLaunch({
                  url: 1,
                  success: function (data) {
                    console.log(`[AdvancedAPI] redirectTo success data = ${JSON.stringify(data)}`)
                  },
                  fail: function (err) {
                    console.log(`[AdvancedAPI] redirectTo fail ${JSON.stringify(err)}`)
                  }
                })
              })

              Button('as.navigateBack 返回上一页').width(300).onClick(() => {
                as.navigateBack({
                  delta: 1,
                  success: function (data) {
                    console.log(`[AdvancedAPI] navigateBack success data = ${JSON.stringify(data)}`)
                  },
                  fail: function (err) {
                    console.log(`[AdvancedAPI] navigateBack fail ${JSON.stringify(err)}`)
                  }
                })
              })

              Button('as.navigateBack delta的值大于当前页面栈长度').width(300).onClick(() => {
                as.navigateBack({
                  delta: 5,
                  success: function (data) {
                    console.log(`[AdvancedAPI] navigateBack success data = ${JSON.stringify(data)}`)
                  },
                  fail: function (err) {
                    console.log(`[AdvancedAPI] navigateBack fail ${JSON.stringify(err)}`)
                  }
                })
              })

              Button('as.navigateBack delata值string "a"').width(300).onClick(() => {
                as.navigateBack({
                  delta: 'a',
                  success: function (data) {
                    console.log(`[AdvancedAPI] navigateBack success data = ${JSON.stringify(data)}`)
                  },
                  fail: function (err) {
                    console.log(`[AdvancedAPI] navigateBack fail ${JSON.stringify(err)}`)
                  }
                })
              })

              Button('as.navigateBack delata值string "1"').width(300).onClick(() => {
                as.navigateBack({
                  delta: '1',
                  success: function (data) {
                    console.log(`[AdvancedAPI] navigateBack success data = ${JSON.stringify(data)}`)
                  },
                  fail: function (err) {
                    console.log(`[AdvancedAPI] navigateBack fail ${JSON.stringify(err)}`)
                  }
                })
              })

              Button('as.navigateBack delata值undefined').width(300).onClick(() => {
                as.navigateBack({
                  delta: undefined,
                  success: function (data) {
                    console.log(`[AdvancedAPI] navigateBack success data = ${JSON.stringify(data)}`)
                  },
                  fail: function (err) {
                    console.log(`[AdvancedAPI] navigateBack fail ${JSON.stringify(err)}`)
                  }
                })
              })

              Button('as.navigateBack delata值null').width(300).onClick(() => {
                as.navigateBack({
                  delta: null,
                  success: function (data) {
                    console.log(`[AdvancedAPI] navigateBack success data = ${JSON.stringify(data)}`)
                  },
                  fail: function (err) {
                    console.log(`[AdvancedAPI] navigateBack fail ${JSON.stringify(err)}`)
                  }
                })
              })

              Button('as.navigateBack delta值是object').width(300).onClick(() => {
                as.navigateBack({
                  delta: {},
                  success: function (data) {
                    console.log(`[AdvancedAPI] navigateBack success data = ${JSON.stringify(data)}`)
                  },
                  fail: function (err) {
                    console.log(`[AdvancedAPI] navigateBack fail ${JSON.stringify(err)}`)
                  }
                })
              })
            }
          }
        }.alignListItem(ListItemAlign.Center)
      }
    }
  }
}