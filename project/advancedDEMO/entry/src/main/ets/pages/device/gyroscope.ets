import promptAction from '@ohos.promptAction'
@Entry
@Component
struct gyroscope {

  private listener = function (res) {
    console.log('TestCase res x：' + res.x + ' res y：' + res.y + ' res z：' + res.z)
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
            Text("陀螺传感器").fontSize(35)
          }
          ListItem() {
            Text("Normal").fontSize(25)
          }
          ListItem() {
            Button("as.onChange(start的前提)").width(300).onClick(() => {
              // @ts-ignore
              as.onGyroscopeChange(this.listener)
            })
          }
          ListItem() {
            Button("as.startGyroscope").width(300).onClick(() => {
              try {
                // @ts-ignore
                as.startGyroscope({
                  interval: 'game',
                  success: function (data) {
                    console.log('TestCase startGyroscope : ' + data);
                  }
                });
              } catch (e) {
                // error
                console.log('TestCase startGyroscope : ' + e);
              }
            })
          }
          ListItem() {
            Button("as.stopGyroscope").width(300).onClick(() => {
              // @ts-ignore
              as.stopGyroscope({
                success: function () {
                  console.log('stop stopGyroscope success!')
                },
                fail: function () {
                  console.log('stop stopGyroscope fail!')
                }
              });
            })
          }
          ListItem() {
            Text("Exceptions").fontSize(25)
          }
          ListItem() {
            Button("onGyroChange pListener is null").width(300).onClick(() => {
              // @ts-ignore
              as.onGyroscopeChange()
            }).backgroundColor(Color.Orange)
          }
          ListItem() {
            Button("onGyroChange pListener is num").width(300).onClick(() => {
              // @ts-ignore
              as.onGyroscopeChange(100)
            }).backgroundColor(Color.Orange)
          }
          ListItem() {
            Button("onGyroChange pListener is undef").width(300).onClick(() => {
              // @ts-ignore
              as.onGyroscopeChange(undefined)
            }).backgroundColor(Color.Orange)
          }
          ListItem() {
            Button("onGyroChange pListener is str").width(300).onClick(() => {
              // @ts-ignore
              as.onGyroscopeChange("123456")
            }).backgroundColor(Color.Orange)
          }
          ListItem() {
            Button("startGyro pinterval is null").width(300).onClick(() => {
              // @ts-ignore
              as.startGyroscope({
                interval: null,
                success: function (data) {
                  console.log('TestCase startGyroscope : ' + data);
                }
              });
            }).backgroundColor(Color.Orange)
          }
          ListItem() {
            Button("startGyro pinterval is num").width(300).onClick(() => {
              // @ts-ignore
              as.startGyroscope({
                interval: 123,
                success: function (data) {
                  console.log('TestCase startGyroscope : ' + data);
                }
              });
            }).backgroundColor(Color.Orange)
          }
          ListItem() {
            Button("startGyro pinterval is undef").width(300).onClick(() => {
              // @ts-ignore
              as.startGyroscope({
                interval: undefined,
                success: function (data) {
                  console.log('TestCase startGyroscope : ' + data);
                }
              });
            }).backgroundColor(Color.Orange)
          }
          ListItem() {
            Button("startGyro pinterval is illegal str").width(300).onClick(() => {
              // @ts-ignore
              as.startGyroscope({
                interval: '123456',
                success: function (data) {
                  console.log('TestCase startGyroscope : ' + data);
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