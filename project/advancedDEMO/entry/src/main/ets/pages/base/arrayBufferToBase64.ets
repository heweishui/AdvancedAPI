import promptAction from '@ohos.promptAction'

@Entry
@Component
struct ArrayBufferToBase64 {
  build() {
    Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
      Column({ space: 5 }) {
        Text('ArrayBuffer转base64').fontSize(35)
        Button('as.arrayBufferToBase64').width(300).onClick(() => {
          const arrayBuffer = new Uint8Array([55, 55, 55])
          // @ts-ignore
          const base64 = as.arrayBufferToBase64(arrayBuffer)
          console.log('[AdvancedAPI] base64 = ', base64)
          promptAction.showToast({
            message: 'success: base64 = ' + base64
          })
        })

        Button('arrayBuffer 单 数组').width(300).onClick(() => {
          const arrayBuffer = new Uint8Array([77])
          // @ts-ignore
          const base64 = as.arrayBufferToBase64(arrayBuffer)
          console.log('[AdvancedAPI] base64 = ', base64)
          promptAction.showToast({
            message: 'success: base64 = ' + base64
          })
        })

        Button('arrayBuffer 数据量').width(300).onClick(() => {
          const arrayBuffer = new Uint8Array([7788, 7788, 7788, 7788, 7788, 7788, 7788, 7788, 7788, 7788, 7788, 7788, 7788, 7788, 7788])
          // @ts-ignore
          const base64 = as.arrayBufferToBase64(arrayBuffer)
          console.log('[AdvancedAPI] base64 = ', base64)
          promptAction.showToast({
            message: 'success: base64 = ' + base64
          })
        })

        Button('String').width(300).onClick(() => {
          // @ts-ignore
          const base64 = as.arrayBufferToBase64('test')
          console.log('[AdvancedAPI] base64 = ', base64)
        })

        Button('Number').width(300).onClick(() => {
          // @ts-ignore
          const base64 = as.arrayBufferToBase64(7788)
          console.log('[AdvancedAPI] base64 = ', base64)
        })

        Button('boolean').width(300).onClick(() => {
          // @ts-ignore
          const base64 = as.arrayBufferToBase64(true)
          console.log('[AdvancedAPI] base64 = ', base64)
        })

        Button('Object').width(300).onClick(() => {
          // @ts-ignore
          const base64 = as.arrayBufferToBase64({ 'name': 'test' })
          console.log('[AdvancedAPI] base64 = ', base64)
        })

        Button('无入参').width(300).onClick(() => {
          // @ts-ignore
          const base64 = as.arrayBufferToBase64()
          console.log('[AdvancedAPI] base64 = ', base64)
        })

        Button('null').width(300).onClick(() => {
          // @ts-ignore
          const base64 = as.arrayBufferToBase64(null)
          console.log('[AdvancedAPI] base64 = ', base64)
        })

        Button('空字符').width(300).onClick(() => {
          // @ts-ignore
          const base64 = as.arrayBufferToBase64('')
          console.log('[AdvancedAPI] base64 = ', base64)
        })

        Button('undefined').width(300).onClick(() => {
          // @ts-ignore
          const base64 = as.arrayBufferToBase64(undefined)
          console.log('[AdvancedAPI] base64 = ', base64)
        })

        Button('arrayBufferToBase64与base64ToArrayBuffer').width(300).onClick(() => {
          const arrayBuffer = new Uint8Array([55, 55, 55])
          // @ts-ignore
          const base64 = as.arrayBufferToBase64(arrayBuffer)
          console.log('[AdvancedAPI] base64 = ', base64)
          // @ts-ignore
          const arrayBuffer2 = as.base64ToArrayBuffer(base64)
          console.log('[AdvancedAPI] arrayBuffer = ', arrayBuffer2)
          console.log('[AdvancedAPI] arrayBuffer = ', JSON.stringify(arrayBuffer2))
        })
      }
    }
  }
}