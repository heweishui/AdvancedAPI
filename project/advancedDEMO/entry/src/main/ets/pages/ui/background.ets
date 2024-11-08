@Entry
@Component
struct Background {
  build() {
    Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
      Column({ space: 20 }) {
        Text('背景').fontSize(35)
        Button('as.setBackgroundColor').width(300).onClick(() => {
          // @ts-ignore
          as.setBackgroundColor({
            backgroundColor: '#333333',
            success: function (data) {
              console.log('[AdvancedAPI] setBackgroundColor success data = '+JSON.stringify(data))
            },
            fail: function (err) {
              console.log('[AdvancedAPI] setBackgroundColor fail err = ' + JSON.stringify(err))
            }
          })
        })
      }
    }
  }
}