import promptAction from '@ohos.promptAction'

@Entry
@Component
struct Base642ArrayBuffer {
  build() {
    Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
      Column({ space: 5 }) {
        Text('base64转ArrayBuffer').fontSize(35)
        Button('as.base64ToArrayBuffer').width(300).onClick(() => {
          const base64 = 'test'
          // @ts-ignore
          const arrayBuffer = as.base64ToArrayBuffer(base64)
          console.log('[AdvancedAPI] arrayBuffer = ', arrayBuffer)
          promptAction.showToast({
            message: 'success'
          })
        })

        Button('arrayBuffer').width(300).onClick(() => {
          const test = new Uint8Array([55, 55, 55])
          // @ts-ignore
          const arrayBuffer = as.base64ToArrayBuffer(test)
          console.log('[AdvancedAPI] arrayBuffer = ', arrayBuffer)
          console.log('[AdvancedAPI] arrayBuffer = ', String.fromCharCode.apply(null, new Uint16Array(arrayBuffer)))
        })

        Button('Number').width(300).onClick(() => {
          // @ts-ignore
          const arrayBuffer = as.base64ToArrayBuffer(7788)
          console.log('[AdvancedAPI] arrayBuffer = ', arrayBuffer)
          console.log('[AdvancedAPI] arrayBuffer = ', String.fromCharCode.apply(null, new Uint16Array(arrayBuffer)))
        })

        Button('boolean').width(300).onClick(() => {
          // @ts-ignore
          const arrayBuffer = as.base64ToArrayBuffer(true)
          console.log('[AdvancedAPI] arrayBuffer = ', arrayBuffer)
          console.log('[AdvancedAPI] arrayBuffer = ', String.fromCharCode.apply(null, new Uint16Array(arrayBuffer)))
        })

        Button('Object').width(300).onClick(() => {
          // @ts-ignore
          const arrayBuffer = as.base64ToArrayBuffer({ 'name': 'test' })
          console.log('[AdvancedAPI] arrayBuffer = ', arrayBuffer)
          console.log('[AdvancedAPI] arrayBuffer = ', String.fromCharCode.apply(null, new Uint16Array(arrayBuffer)))
        })

        Button('无入参').width(300).onClick(() => {
          // @ts-ignore
          const arrayBuffer = as.base64ToArrayBuffer()
          console.log('[AdvancedAPI] arrayBuffer = ', arrayBuffer)
          console.log('[AdvancedAPI] arrayBuffer = ', String.fromCharCode.apply(null, new Uint16Array(arrayBuffer)))
        })

        Button('null').width(300).onClick(() => {
          // @ts-ignore
          const arrayBuffer = as.base64ToArrayBuffer(null)
          console.log('[AdvancedAPI] arrayBuffer = ', arrayBuffer)
          console.log('[AdvancedAPI] arrayBuffer = ', String.fromCharCode.apply(null, new Uint16Array(arrayBuffer)))
        })

        Button('空字符').width(300).onClick(() => {
          // @ts-ignore
          const arrayBuffer = as.base64ToArrayBuffer('')
          console.log('[AdvancedAPI] arrayBuffer = ', arrayBuffer)
          console.log('[AdvancedAPI] arrayBuffer = ', String.fromCharCode.apply(null, new Uint16Array(arrayBuffer)))
        })

        Button('undefined').width(300).onClick(() => {
          // @ts-ignore
          const arrayBuffer = as.base64ToArrayBuffer(undefined)
          console.log('[AdvancedAPI] arrayBuffer = ', arrayBuffer)
          console.log('[AdvancedAPI] arrayBuffer = ', String.fromCharCode.apply(null, new Uint16Array(arrayBuffer)))
        })

        Button('base64ToArrayBuffer与arrayBufferToBase64').width(300).onClick(() => {
          const base64 = 'test'
          // @ts-ignore
          const arrayBuffer = as.base64ToArrayBuffer(base64)
          console.log('[AdvancedAPI] arrayBuffer = ', arrayBuffer)
          console.log('[AdvancedAPI] arrayBuffer = ', String.fromCharCode.apply(null, new Uint16Array(arrayBuffer)))
          // @ts-ignore
          const base642 = as.arrayBufferToBase64(arrayBuffer)
          console.log('[AdvancedAPI] base64 = ', base642)

        })
      }
    }
  }
}