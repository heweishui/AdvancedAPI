import promptAction from '@ohos.promptAction'
@Entry
@Component
struct compass {

  private listener = function (res) {
    console.log('TestCase  direction：' + res.direction);
    promptAction.showToast({
      message:'TestCase direction：' + res.direction,
      duration: 2000,
    });
  }
  aboutToAppear() {

  }
  build() {
    Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center })  {
      Column({ space: 5 }) {
        List({ space: 20, initialIndex: 0 }) {
          ListItem() {
            Text("罗盘传感器").fontSize(35)
          }
          ListItem() {
            Text("Normal").fontSize(25)
          }
          ListItem() {
            Button("as.onCompassChange").width(300).onClick(() => {
              // @ts-ignore
              as.onCompassChange(this.listener)
            })
          }

          ListItem() {
            Button("as.offCompassChange").width(300).onClick(() => {
              try {
                // @ts-ignore
                as.offCompassChange(this.listener)
              } catch (e) {
                // error
                console.log('TestCase offCompassChange : ' + e);
              }
            })
          }

          ListItem() {
            Button("as.startCompass").width(300).onClick(() => {
              // @ts-ignore
              as.startCompass();
            })
          }
          ListItem() {
            Button("as.stopCompass").width(300).onClick(() => {
              // @ts-ignore
              try {
                // @ts-ignore
                as.stopCompass();
              } catch (e) {
                // error
                console.log('TestCase stopCompass sync exception: ' + e);
              }
            })
          }
          ListItem() {
            Text("Exceptions").fontSize(25)
          }

          ListItem() {
            Button("onCompChange pListener is null").width(300).onClick(() => {
              // @ts-ignore
              as.onCompassChange()
            }).backgroundColor(Color.Orange)
          }
          ListItem() {
            Button("onCompChange pListener is num").width(300).onClick(() => {
              // @ts-ignore
              as.onCompassChange(100)
            }).backgroundColor(Color.Orange)
          }
          ListItem() {
            Button("onCompChange pListener is undef").width(300).onClick(() => {
              // @ts-ignore
              as.onCompassChange(undefined)
            }).backgroundColor(Color.Orange)
          }
          ListItem() {
            Button("onCompChange pListener is str").width(300).onClick(() => {
              // @ts-ignore
              as.onCompassChange("123456")
            }).backgroundColor(Color.Orange)
          }
          ListItem() {
            Button("offCompChange pListener is null").width(300).onClick(() => {
              // @ts-ignore
              as.offCompassChange()
            }).backgroundColor(Color.Orange)
          }
          ListItem() {
            Button("offCompChange pListener is num").width(300).onClick(() => {
              // @ts-ignore
              as.offCompassChange(100)
            }).backgroundColor(Color.Orange)
          }
          ListItem() {
            Button("offCompChange pListener is undef").width(300).onClick(() => {
              // @ts-ignore
              as.offCompassChange(undefined)
            }).backgroundColor(Color.Orange)
          }
          ListItem() {
            Button("offCompChange pListener is string").width(300).onClick(() => {
              // @ts-ignore
              as.offCompassChange("123456")
            }).backgroundColor(Color.Orange)
          }
        }.listDirection(Axis.Vertical) // 排列方向
        .divider({ strokeWidth: 2, color: 0xFFFFFF, startMargin: 20, endMargin: 20 }) // 每行之间的分界线
        .alignListItem(ListItemAlign.Center)
      }
    }
  }
}