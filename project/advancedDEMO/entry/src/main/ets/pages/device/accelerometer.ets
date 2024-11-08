import promptAction from '@ohos.promptAction'
@Entry
@Component
struct accelerometer {

  private listener = function (res) {
    console.log('TestCase res x：' + res.x + ' res y：' + res.y + ' res z：' + res.z);
    promptAction.showToast({
      message:'TestCase res x：' + res.x + ' res y：' + res.y + ' res z：' + res.z,
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
            Text("加速度传感器").fontSize(35)
          }
          ListItem() {
            Text("Normal").fontSize(25)
          }
          ListItem() {
            Button("as.onAccelerometerChange").width(300).onClick(() => {
              // @ts-ignore
              as.onAccelerometerChange(this.listener)
            })
          }
          ListItem() {
            Button("as.offAccelerometerChange").width(300).onClick(() => {
              try {
                // @ts-ignore
                as.offAccelerometerChange(this.listener)
              } catch (e) {
                // error
                console.log('TestCase offAccelerometerChange : ' + e);
              }
            })
          }
          ListItem() {
            Button("as.startAccelerometer").width(300).onClick(() => {
              // @ts-ignore
              as.startAccelerometer({
                interval: 'game',
                success: function (data) {
                  console.log('TestCase startAccelerometer : ' + data);
                }
              });
            })
          }
          ListItem() {
            Button("as.stopAccelerometer").width(300).onClick(() => {
              // @ts-ignore
              try {
                // @ts-ignore
                as.stopAccelerometer({
                  success: function (data) {
                    console.log('TestCase stopAccelerometer : ' + data);
                  }
                });
              } catch (e) {
                // error
                console.log('TestCase stopAccelerometer sync exception: ' + e);
              }
            })
          }
          ListItem() {
            Text("Exceptions").fontSize(25).textAlign(TextAlign.Start)
          }
          ListItem() {
            Button("onAcceChange pListener is null").width(300).onClick(() => {
              // @ts-ignore
              as.onAccelerometerChange()
            }).backgroundColor(Color.Orange)
          }
          ListItem() {
            Button("onAcceChange pListener is number").width(300).onClick(() => {
              // @ts-ignore
              as.onAccelerometerChange(100)
            }).backgroundColor(Color.Orange)
          }
          ListItem() {
            Button("onAcceChange pListener is undef").width(300).onClick(() => {
              // @ts-ignore
              as.onAccelerometerChange(undefined)
            }).backgroundColor(Color.Orange)
          }
          ListItem() {
            Button("onAcceChange pListener is string").width(300).onClick(() => {
              // @ts-ignore
              as.onAccelerometerChange("123456")
            }).backgroundColor(Color.Orange)
          }
          ListItem() {
            Button("offAcceChange pListener is null").width(300).onClick(() => {
              // @ts-ignore
              as.offAccelerometerChange()
            }).backgroundColor(Color.Orange)
          }
          ListItem() {
            Button("offAcceChange pListener is number").width(300).onClick(() => {
              // @ts-ignore
              as.offAccelerometerChange(100)
            }).backgroundColor(Color.Orange)
          }
          ListItem() {
            Button("offAcceChange pListener is undef").width(300).onClick(() => {
              // @ts-ignore
              as.offAccelerometerChange(undefined)
            }).backgroundColor(Color.Orange)
          }
          ListItem() {
            Button("offAcceChange pListener is string").width(300).onClick(() => {
              // @ts-ignore
              as.offAccelerometerChange("123456")
            }).backgroundColor(Color.Orange)
          }
          ListItem() {
            Button("startAcce pinterval is number").width(300).onClick(() => {
              // @ts-ignore
              as.startAccelerometer({
                interval: 123,
                success: function (data) {
                  console.log('TestCase startAccelerometer : ' + data);
                }
              });
            }).backgroundColor(Color.Orange)
          }
          ListItem() {
            Button("startAcce pinterval is undefined").width(300).onClick(() => {
              // @ts-ignore
              as.startAccelerometer({
                interval: undefined,
                success: function (data) {
                  console.log('TestCase startAccelerometer : ' + data);
                }
              });
            }).backgroundColor(Color.Orange)
          }
          ListItem() {
            Button("startAcce pinterval is illegal String").width(300).onClick(() => {
              // @ts-ignore
              as.startAccelerometer({
                interval: "12345",
                success: function (data) {
                  console.log('TestCase startAccelerometer : ' + data);
                }
              });
            }).backgroundColor(Color.Orange)
          }
        }.listDirection(Axis.Vertical) // 排列方向
        .divider({ strokeWidth: 2, color: 0xFFFFFF, startMargin: 20, endMargin: 20 }) // 每行之间的分界线
        .alignListItem(ListItemAlign.Center)
      }
    }
  }
}