@Entry
@Component
struct Keyboard {
  controller: TextAreaController = new TextAreaController()

  private callback = (res) => {
    console.log('[AdvancedAPI] keyboard height changed ' + res.height);
  };

  private cb = () => {
    console.log("[AdvancedAPI] keyboard height changed");
  };

  build() {
    Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
      Column({ space: 5 }) {
        List({ space: 20, }) {
          ListItem() {
            Text("键盘").fontSize(35)
          }

          ListItem() {
            TextArea({
              placeholder: '点此弹出键盘',
              controller: this.controller
            }).fontSize(20).width('80%')
          }

          ListItem(){
            Text("as.hideKeyboard").fontSize(20).fontWeight(FontWeight.Bold)
          }
          // TC1
          ListItem() {
            Button("隐藏键盘").width(300).onClick(() => {
              // @ts-ignore
              as.hideKeyboard()
            })
          }
          // TC2
          ListItem() {
            Button("传入任意参数").width(300).onClick(() => {
              // @ts-ignore
              as.hideKeyboard('test')
            }).backgroundColor(Color.Orange)
          }

          ListItem(){
            Text("as.onKeyboardHeightChange").fontSize(20).fontWeight(FontWeight.Bold)
          }
          // TC1
          ListItem() {
            Button("监听键盘高度").width(300).onClick(() => {
              // @ts-ignore
              as.onKeyboardHeightChange(this.callback)
            })
          }
          // TC2
          ListItem() {
            Button("监听键盘高度，无回调").width(300).onClick(() => {
              // @ts-ignore
              as.onKeyboardHeightChange()
            }).backgroundColor(Color.Orange)
          }
          // TC3
          ListItem() {
            Button("监听键盘高度，回调不带参数").width(300).onClick(() => {
              // @ts-ignore
              as.onKeyboardHeightChange(this.cb)
            }).backgroundColor(Color.Orange)
          }

          ListItem(){
            Text("as.offKeyboardHeightChange").fontSize(20).fontWeight(FontWeight.Bold)
          }
          // TC1
          ListItem() {
            Button("取消指定监听").width(300).onClick(() => {
              // @ts-ignore
              as.offKeyboardHeightChange(this.callback)
            })
          }
          // TC2
          ListItem() {
            Button("取消不存在的监听").width(300).onClick(() => {
              // @ts-ignore
              as.offKeyboardHeightChange(function (res) {})
            }).backgroundColor(Color.Orange)
          }
          // TC3
          ListItem() {
            Button("取消全部监听").width(300).onClick(() => {
              // @ts-ignore
              as.offKeyboardHeightChange()
            }).backgroundColor(Color.Orange)
          }
        }.alignListItem(ListItemAlign.Center)
      }
    }
  }
}