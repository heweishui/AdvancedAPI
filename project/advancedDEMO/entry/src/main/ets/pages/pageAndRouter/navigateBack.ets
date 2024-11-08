@Entry
@Component
struct navigateBack {
  scroller: Scroller = new Scroller()

  build() {
    Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center })  {
      Column({ space: 5 }) {
        List({ space: 20, initialIndex: 0 }) {
          ListItem(){
            Column({ space: 10 }) {
              Text("navigateBack").fontSize(30)
              Button('delta Number 小于现有页数').width(300).onClick(() => {
                // @ts-ignore
                as.navigateBack({
                  delta: 2,
                  success: function (data) {
                    console.log('[AdvancedAPI] navigateBack success 0  data = ' + JSON.stringify(data))
                  },
                  fail: function (err) {
                    console.log('[AdvancedAPI] navigateBack fail 0  data = ' + JSON.stringify(err))
                  },
                  complete: function (data) {
                    console.log('[AdvancedAPI] navigateBack complete 0  data = ' + JSON.stringify(data))
                  }
                })
              })

              Button('delta Number 大于现有页数').width(300).onClick(() => {
                // @ts-ignore
                as.navigateBack({
                  delta: 6,
                  success: function (data) {
                    console.log('[AdvancedAPI] navigateBack success 00  data = ' + JSON.stringify(data))
                  },
                  fail: function (err) {
                    console.log('[AdvancedAPI] navigateBack fail 00  data = ' + JSON.stringify(err))
                  },
                  complete: function (data) {
                    console.log('[AdvancedAPI] navigateBack complete 00  data = ' + JSON.stringify(data))
                  }
                })
              })

              Button('delta Number ').width(300).onClick(() => {
                // @ts-ignore
                uni
              })

              Button('delta Number 负数').width(300).onClick(() => {
                // @ts-ignore
                as.navigateBack({
                  delta: -3,
                  success: function (data) {
                    console.log('[AdvancedAPI] navigateBack success 01  data = ' + JSON.stringify(data))
                  },
                  fail: function (err) {
                    console.log('[AdvancedAPI] navigateBack fail 01  data = ' + JSON.stringify(err))
                  },
                  complete: function (data) {
                    console.log('[AdvancedAPI] navigateBack complete 01  data = ' + JSON.stringify(data))
                  }
                })
              })

              Button('delta 无此参数').width(300).onClick(() => {
                // @ts-ignore
                as.navigateBack({
                  // delta: -3,
                  success: function (data) {
                    console.log('[AdvancedAPI] navigateBack success 01  data = ' + JSON.stringify(data))
                  },
                  fail: function (err) {
                    console.log('[AdvancedAPI] navigateBack fail 01  data = ' + JSON.stringify(err))
                  },
                  complete: function (data) {
                    console.log('[AdvancedAPI] navigateBack complete 01  data = ' + JSON.stringify(data))
                  }
                })
              })

              Button('delta String').width(300).onClick(() => {
                // @ts-ignore
                as.navigateBack({
                  delta: 'test',
                  success: function (data) {
                    console.log('[AdvancedAPI] navigateBack success  1 data = ' + JSON.stringify(data))
                  },
                  fail: function (err) {
                    console.log('[AdvancedAPI] navigateBack fail 1  data = ' + JSON.stringify(err))
                  },
                  complete: function (data) {
                    console.log('[AdvancedAPI] navigateBack complete 1  data = ' + JSON.stringify(data))
                  }
                })
              })

              Button('delta Boolean').width(300).onClick(() => {
                // @ts-ignore
                as.navigateBack({
                  delta: true,
                  success: function (data) {
                    console.log('[AdvancedAPI] navigateBack success 2  data = ' + JSON.stringify(data))
                  },
                  fail: function (err) {
                    console.log('[AdvancedAPI] navigateBack fail 2  data = ' + JSON.stringify(err))
                  },
                  complete: function (data) {
                    console.log('[AdvancedAPI] navigateBack complete 2  data = ' + JSON.stringify(data))
                  }
                })
              })

              Button('delta Object').width(300).onClick(() => {
                // @ts-ignore
                as.navigateBack({
                  delta: {'name':'test'},
                  success: function (data) {
                    console.log('[AdvancedAPI] navigateBack success 3  data = ' + JSON.stringify(data))
                  },
                  fail: function (err) {
                    console.log('[AdvancedAPI] navigateBack fail 3  data = ' + JSON.stringify(err))
                  },
                  complete: function (data) {
                    console.log('[AdvancedAPI] navigateBack complete 3  data = ' + JSON.stringify(data))
                  }
                })
              })

              Button('delta null').width(300).onClick(() => {
                // @ts-ignore
                as.navigateBack({
                  delta: null,
                  success: function (data) {
                    console.log('[AdvancedAPI] navigateBack success 4  data = ' + JSON.stringify(data))
                  },
                  fail: function (err) {
                    console.log('[AdvancedAPI] navigateBack fail 4  data = ' + JSON.stringify(err))
                  },
                  complete: function (data) {
                    console.log('[AdvancedAPI] navigateBack complete  4 data = ' + JSON.stringify(data))
                  }
                })
              })

              Button('delta 空字符').width(300).onClick(() => {
                // @ts-ignore
                as.navigateBack({
                  delta: '',
                  success: function (data) {
                    console.log('[AdvancedAPI] navigateBack success 5  data = ' + JSON.stringify(data))
                  },
                  fail: function (err) {
                    console.log('[AdvancedAPI] navigateBack fail 5  data = ' + JSON.stringify(err))
                  },
                  complete: function (data) {
                    console.log('[AdvancedAPI] navigateBack complete 5  data = ' + JSON.stringify(data))
                  }
                })
              })

              Button('delta undefined').width(300).onClick(() => {
                // @ts-ignore
                as.navigateBack({
                  delta: undefined,
                  success: function (data) {
                    console.log('[AdvancedAPI] navigateBack success 6  data = ' + JSON.stringify(data))
                  },
                  fail: function (err) {
                    console.log('[AdvancedAPI] navigateBack fail 6  data = ' + JSON.stringify(err))
                  },
                  complete: function (data) {
                    console.log('[AdvancedAPI] navigateBack complete 6  data = ' + JSON.stringify(data))
                  }
                })
              })

            }
          }

        }.divider({ strokeWidth: 2, color: 0xFFFFFF, startMargin: 20, endMargin: 20 }) // 每行之间的分界线
        .alignListItem(ListItemAlign.Center)
      }
    }
  }
}