import prompt from '@ohos.prompt'

@Entry
@Component
struct Prompt {
  private moduleName = 'prompt'
  aboutToAppear() {

  }
  build() {
    Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center })  {
      Column({ space: 20 }) {
        List({ space: 20, initialIndex: 0 }) {
          ListItem() {
            Text("prompt").fontSize(35)
          }

          ListItem() {
            Button("as.showToast duration 5000ms").width(300).onClick(()=>{
              // @ts-ignore
              as.showToast({
                title: 'duration 5000ms',
                duration: 5000,
                success: (data) => {
                  console.log(`[AdvancedAPI] ${this.moduleName} showToast success data = ${JSON.stringify(data)}`)
                },
                fail: (err) => {
                  console.log(`[AdvancedAPI] ${this.moduleName} showToast fail err = ${JSON.stringify(err)}}`)
                },
                complete: () => {
                  console.log(`[AdvancedAPI] ${this.moduleName} showToast complete`)
                }
              })
            })
          }

          ListItem() {
            Button("as.showToast duration null").width(300).onClick(()=>{
              // @ts-ignore
              as.showToast({
                title: 'duration null',
                duration: null,
                success: (data) => {
                  console.log(`[AdvancedAPI] ${this.moduleName} showToast success data = ${JSON.stringify(data)}`)
                },
                fail: (err) => {
                  console.log(`[AdvancedAPI] ${this.moduleName} showToast fail err = ${JSON.stringify(err)}}`)
                },
                complete: () => {
                  console.log(`[AdvancedAPI] ${this.moduleName} showToast complete`)
                }
              })
            })
          }

          ListItem() {
            Button("as.showToast duration undefined").width(300).onClick(()=>{
              // @ts-ignore
              as.showToast({
                title: 'duration undefined',
                duration: undefined,
                success: (data) => {
                  console.log(`[AdvancedAPI] ${this.moduleName} showToast success data = ${JSON.stringify(data)}`)
                },
                fail: (err) => {
                  console.log(`[AdvancedAPI] ${this.moduleName} showToast fail err = ${JSON.stringify(err)}}`)
                },
                complete: () => {
                  console.log(`[AdvancedAPI] ${this.moduleName} showToast complete`)
                }
              })
            })
          }

          ListItem() {
            Button("as.showToast duration ['2345']").width(300).onClick(()=>{
              // @ts-ignore
              as.showToast({
                title: "duration ['2345']",
                duration: ['2345'],
                success: (data) => {
                  console.log(`[AdvancedAPI] ${this.moduleName} showToast success data = ${JSON.stringify(data)}`)
                },
                fail: (err) => {
                  console.log(`[AdvancedAPI] ${this.moduleName} showToast fail err = ${JSON.stringify(err)}}`)
                },
                complete: () => {
                  console.log(`[AdvancedAPI] ${this.moduleName} showToast complete`)
                }
              })
            })
          }

          ListItem() {
            Button("as.showToast position top").width(300).onClick(()=>{
              // @ts-ignore
              as.showToast({
                title: 'position top',
                position: 'top',
                duration: 3000, // 不应该生效
                success: (data) => {
                  console.log(`[AdvancedAPI] ${this.moduleName} showToast success data = ${JSON.stringify(data)}`)
                },
                fail: (err) => {
                  console.log(`[AdvancedAPI] ${this.moduleName} showToast fail err = ${JSON.stringify(err)}}`)
                },
                complete: () => {
                  console.log(`[AdvancedAPI] ${this.moduleName} showToast complete`)
                }
              })
            })
          }

          ListItem() {
            Button("as.showToast position center").width(300).onClick(()=>{
              // @ts-ignore
              as.showToast({
                title: 'position center',
                position: 'center',
                duration: 1000, // 不应该生效
                success: (data) => {
                  console.log(`[AdvancedAPI] ${this.moduleName} showToast success data = ${JSON.stringify(data)}`)
                },
                fail: (err) => {
                  console.log(`[AdvancedAPI] ${this.moduleName} showToast fail err = ${JSON.stringify(err)}}`)
                },
                complete: () => {
                  console.log(`[AdvancedAPI] ${this.moduleName} showToast complete`)
                }
              })
            })
          }

          ListItem() {
            Button("as.showToast position bottom").width(300).onClick(()=>{
              // @ts-ignore
              as.showToast({
                title: ['position', 'bottom'],
                position: 'bottom',
                duration: 1000, // 不应该生效
                success: (data) => {
                  console.log(`[AdvancedAPI] ${this.moduleName} showToast success data = ${JSON.stringify(data)}`)
                },
                fail: (err) => {
                  console.log(`[AdvancedAPI] ${this.moduleName} showToast fail err = ${JSON.stringify(err)}}`)
                },
                complete: () => {
                  console.log(`[AdvancedAPI] ${this.moduleName} showToast complete`)
                }
              })
            })
          }

          ListItem() {
            Button("as.showToast title 我是提示").width(300).onClick(()=>{
              // @ts-ignore
              as.showToast({
                title: '我是提示',
                duration: 5000,
                success: (data) => {
                  console.log(`[AdvancedAPI] ${this.moduleName} showToast success data = ${JSON.stringify(data)}`)
                },
                fail: (err) => {
                  console.log(`[AdvancedAPI] ${this.moduleName} showToast fail err = ${JSON.stringify(err)}}`)
                },
                complete: () => {
                  console.log(`[AdvancedAPI] ${this.moduleName} showToast complete`)
                }
              })
            })
          }

          ListItem() {
            Button("as.showToast title ['我是提示','1']").width(300).onClick(()=>{
              // @ts-ignore
              as.showToast({
                title: ['我是提示','1'],
                duration: 5000,
                success: (data) => {
                  console.log(`[AdvancedAPI] ${this.moduleName} showToast success data = ${JSON.stringify(data)}`)
                },
                fail: (err) => {
                  console.log(`[AdvancedAPI] ${this.moduleName} showToast fail err = ${JSON.stringify(err)}}`)
                },
                complete: () => {
                  console.log(`[AdvancedAPI] ${this.moduleName} showToast complete`)
                }
              })
            })
          }

          ListItem() {
            Button("as.showToast title undefined").width(300).onClick(()=>{
              // @ts-ignore
              as.showToast({
                title: undefined,
                duration: 3000,
                success: (data) => {
                  console.log(`[AdvancedAPI] ${this.moduleName} showToast success data = ${JSON.stringify(data)}`)
                },
                fail: (err) => {
                  console.log(`[AdvancedAPI] ${this.moduleName} showToast fail err = ${JSON.stringify(err)}}`)
                },
                complete: () => {
                  console.log(`[AdvancedAPI] ${this.moduleName} showToast complete`)
                }
              })
            })
          }

          ListItem() {
            Button("as.showToast title 123").width(300).onClick(()=>{
              // @ts-ignore
              as.showToast({
                title: 123,
                duration: 3000,
                success: (data) => {
                  console.log(`[AdvancedAPI] ${this.moduleName} showToast success data = ${JSON.stringify(data)}`)
                },
                fail: (err) => {
                  console.log(`[AdvancedAPI] ${this.moduleName} showToast fail err = ${JSON.stringify(err)}}`)
                },
                complete: () => {
                  console.log(`[AdvancedAPI] ${this.moduleName} showToast complete`)
                }
              })
            })
          }

          ListItem() {
            Button("as.showToast title {name:'xiaoming'}").width(300).onClick(() => {
              // @ts-ignore
              as.showToast({
                title: { name: 'xiaoming' },
                duration: 3000,
                success: (data) => {
                  console.log(`[AdvancedAPI] ${this.moduleName} showToast success data = ${JSON.stringify(data)}`)
                },
                fail: (err) => {
                  console.log(`[AdvancedAPI] ${this.moduleName} showToast fail err = ${JSON.stringify(err)}}`)
                },
                complete: () => {
                  console.log(`[AdvancedAPI] ${this.moduleName} showToast complete`)
                }
              })
            })
          }

          ListItem() {
            Button("as.showModal").width(300).onClick(() => {
              // @ts-ignore
              as.showModal({
                title: '提示',
                content: '这是一个模态弹窗',
                cancelText: '取消按钮',
                confirmText: '确认按钮',
                success: function (data) {
                  console.log(`[AdvancedAPI] showModal data = `+JSON.stringify(data))
                },
                fail: function () {
                  console.log(`[AdvancedAPI] showModal fail`)
                },
                complete: function () {
                  console.log('[AdvancedAPI] complete')
                }
              })
            })
          }

          ListItem() {
            Button("as.showModal 没有title").width(300).onClick(() => {
              // @ts-ignore
              as.showModal({
                content: '这是一个模态弹窗',
                cancelText: '取消按钮',
                confirmText: '确认按钮',
                success: function (data) {
                  console.log(`[AdvancedAPI] showModal data = `+JSON.stringify(data))
                },
                fail: function (data) {
                  console.log(`[AdvancedAPI] showModal fail`+JSON.stringify(data))
                },
                complete: function () {
                  console.log('[AdvancedAPI] complete')
                }
              })
            })
          }

          ListItem() {
            Button("as.showModal 没有content").width(300).onClick(() => {
              // @ts-ignore
              as.showModal({
                title: '我是标题',
                cancelText: '取消按钮',
                confirmText: '确认按钮',
                success: function (data) {
                  console.log(`[AdvancedAPI] showModal data = `+JSON.stringify(data))
                },
                fail: function (data) {
                  console.log(`[AdvancedAPI] showModal fail`+JSON.stringify(data))
                },
                complete: function () {
                  console.log('[AdvancedAPI] complete')
                }
              })
            })
          }

          ListItem() {
            Button("as.showModal 只有确认按钮，红色").width(300).onClick(() => {
              // @ts-ignore
              as.showModal({
                title: '我是标题',
                content: '这是一个模态弹窗',
                confirmText: '确认按钮',
                confirmColor: '#ff0000',
                success: function (data) {
                  console.log(`[AdvancedAPI] showModal data = `+JSON.stringify(data))
                },
                fail: function (data) {
                  console.log(`[AdvancedAPI] showModal fail`+JSON.stringify(data))
                },
                complete: function () {
                  console.log('[AdvancedAPI] complete')
                }
              })
            })
          }

          ListItem() {
            Button("as.showModal 只有确认，取消按钮").width(300).onClick(() => {
              // @ts-ignore
              as.showModal({
                showCancel: true,
                cancelText: '点我取消',
                cancelColor: '#00ff00',
                confirmText: '确认按钮',
                confirmColor: '#ff0000',
                success: function (data) {
                  console.log(`[AdvancedAPI] showModal data = `+JSON.stringify(data))
                },
                fail: function (data) {
                  console.log(`[AdvancedAPI] showModal fail`+JSON.stringify(data))
                },
                complete: function () {
                  console.log('[AdvancedAPI] complete')
                }
              })
            })
          }

          ListItem() {
            Button("as.showModal 不显示取消按钮").width(300).onClick(() => {
              // @ts-ignore
              as.showModal({
                showCancel: false,
                cancelText: '点我取消',
                cancelColor: '#00ff00',
                confirmText: '确认按钮',
                confirmColor: '#ff0000',
                success: function (data) {
                  console.log(`[AdvancedAPI] showModal data = `+JSON.stringify(data))
                },
                fail: function (data) {
                  console.log(`[AdvancedAPI] showModal fail`+JSON.stringify(data))
                },
                complete: function () {
                  console.log('[AdvancedAPI] complete')
                }
              })
            })
          }

          ListItem() {
            Button("as.showModal showCancel不填").width(300).onClick(() => {
              // @ts-ignore
              as.showModal({
                cancelText: '点我取消',
                cancelColor: '#00ff00',
                confirmText: '确认按钮',
                confirmColor: '#ff0000',
                success: function (data) {
                  console.log(`[AdvancedAPI] showModal data = `+JSON.stringify(data))
                },
                fail: function (data) {
                  console.log(`[AdvancedAPI] showModal fail`+JSON.stringify(data))
                },
                complete: function () {
                  console.log('[AdvancedAPI] complete')
                }
              })
            })
          }

          ListItem() {
            Button("as.showModal 只有标题").width(300).onClick(() => {
              // @ts-ignore
              as.showModal({
                title: '我是标题',
                success: function (data) {
                  console.log(`[AdvancedAPI] showModal data = `+JSON.stringify(data))
                },
                fail: function (data) {
                  console.log(`[AdvancedAPI] showModal fail`+JSON.stringify(data))
                },
                complete: function () {
                  console.log('[AdvancedAPI] complete')
                }
              })
            })
          }

          ListItem() {
            Button("as.showModal 取消按钮颜色值#00f").width(300).onClick(() => {
              // @ts-ignore
              as.showModal({
                title: '我是标题',
                cancelText: '点我取消',
                cancelColor: '#00f',
                confirmText: '确认按钮',
                confirmColor: '#ff0000',
                success: function (data) {
                  console.log(`[AdvancedAPI] showModal data = `+JSON.stringify(data))
                },
                fail: function (data) {
                  console.log(`[AdvancedAPI] showModal fail`+JSON.stringify(data))
                },
                complete: function () {
                  console.log('[AdvancedAPI] complete')
                }
              })
            })
          }

          ListItem() {
            Button("as.showModal 取消按钮颜色值#f").width(300).onClick(() => {
              // @ts-ignore
              as.showModal({
                title: '我是标题',
                cancelText: '点我取消',
                cancelColor: '#f',
                confirmText: '确认按钮',
                confirmColor: '#ff0000',
                success: function (data) {
                  console.log(`[AdvancedAPI] showModal data = `+JSON.stringify(data))
                },
                fail: function (data) {
                  console.log(`[AdvancedAPI] showModal fail`+JSON.stringify(data))
                },
                complete: function () {
                  console.log('[AdvancedAPI] complete')
                }
              })
            })
          }

          ListItem() {
            Button("as.showActionSheet").width(300).onClick(() => {
              // @ts-ignore
              as.showActionSheet({
                title: '提示1',
                alertText: '我是警告',
                itemList: ['A', 'B', 'C'],
                itemColor: '#0f0',
                popover: {
                  top: 10,
                  left: 10
                },
                success: function (data) {
                  console.log(`[AdvancedAPI] showActionSheet data = `+JSON.stringify(data))
                },
                fail: function (data) {
                  console.log(`[AdvancedAPI] showActionSheet fail`+JSON.stringify(data))
                },
                complete: function () {
                  console.log('[AdvancedAPI] showActionSheet complete')
                }
              })
            })
          }

          ListItem() {
            Button("as.showActionSheet  没有title").width(300).onClick(() => {
              // @ts-ignore
              as.showActionSheet({
                alertText: '我是警告',
                itemList: ['A', 'B', 'C'],
                itemColor: '#0f0',
                popover: {
                  top: 10,
                  left: 10
                },
                success: function (data) {
                  console.log(`[AdvancedAPI] showActionSheet data = `+JSON.stringify(data))
                },
                fail: function (data) {
                  console.log(`[AdvancedAPI] showActionSheet fail`+JSON.stringify(data))
                },
                complete: function () {
                  console.log('[AdvancedAPI] showActionSheet complete')
                }
              })
            })
          }

          ListItem() {
            Button("as.showActionSheet 没有itemList").width(300).onClick(() => {
              // @ts-ignore
              as.showActionSheet({
                title: '提示1',
                itemColor: '#0f0',
                popover: {
                  top: 10,
                  left: 10
                },
                success: function (data) {
                  console.log(`[AdvancedAPI] showActionSheet data = ` + JSON.stringify(data))
                },
                fail: function (data) {
                  console.log(`[AdvancedAPI] showActionSheet fail`+JSON.stringify(data))
                },
                complete: function () {
                  console.log('[AdvancedAPI] showActionSheet complete')
                }
              })
            })
          }


          ListItem() {
            Button("as.showActionSheet itemList类型不正确").width(300).onClick(() => {
              // @ts-ignore
              as.showActionSheet({
                title: '提示1',
                itemList: { 'name': 'test' },
                itemColor: '#0f0',
                popover: {
                  top: 10,
                  left: 10
                },
                success: function (data) {
                  console.log(`[AdvancedAPI] showActionSheet data = ` + JSON.stringify(data))
                },
                fail: function (data) {
                  console.log(`[AdvancedAPI] showActionSheet fail`+JSON.stringify(data))
                },
                complete: function () {
                  console.log('[AdvancedAPI] showActionSheet complete')
                }
              })
            })
          }

          ListItem() {
            Button("as.showActionSheet itemColor #0").width(300).onClick(() => {
              // @ts-ignore
              as.showActionSheet({
                title: '提示1',
                itemList: ['A', 'B', 'C'],
                itemColor: '#0',
                success: function (data) {
                  console.log(`[AdvancedAPI] showActionSheet data = ` + JSON.stringify(data))
                },
                fail: function (data) {
                  console.log(`[AdvancedAPI] showActionSheet fail`+JSON.stringify(data))
                },
                complete: function () {
                  console.log('[AdvancedAPI] showActionSheet complete')
                }
              })
            })
          }

          ListItem() {
            Button("as.showActionSheet itemList异常").width(300).onClick(() => {
              // @ts-ignore
              as.showActionSheet({
                title: '提示1',
                itemList: [{ name: 'test' }, 'B', 'C'],
                itemColor: '#0',
                success: function (data) {
                  console.log(`[AdvancedAPI] showActionSheet data = ` + JSON.stringify(data))
                },
                fail: function (data) {
                  console.log(`[AdvancedAPI] showActionSheet fail`+JSON.stringify(data))
                },
                complete: function () {
                  console.log('[AdvancedAPI] showActionSheet complete')
                }
              })
            })
          }
        }
          .divider({ strokeWidth: 2, color: 0xFFFFFF, startMargin: 20, endMargin: 20 })
          .alignListItem(ListItemAlign.Center)
      }
    }
  }
}