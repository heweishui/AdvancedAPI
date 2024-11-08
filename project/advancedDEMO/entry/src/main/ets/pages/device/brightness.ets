//  @ts-nocheck
import prompt from '@ohos.prompt'

@Entry
@Component
struct Brightness {
  aboutToAppear() {
  }

  build() {
    Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
      Column({ space: 5 }) {
        List({ space: 20 }) {
          ListItem() {
            Text("屏幕亮度").fontSize(35)
          }
          ListItem() {
            Text("拖动改变屏幕亮度").fontSize(20)
          }
          ListItem() {
            Slider({
              value: this.vOutSetValueOne,
              style: SliderStyle.InSet,
            })
              .blockColor('#191970')
              .trackColor('#ADD8E6')
              .selectedColor('#4169E1')
              .width('80%')
              .showTips(true)
              .onChange((value: number, mode: SliderChangeMode) => {
                this.vOutSetValueOne = value
                console.info('value:' + value + 'mode:' + mode.toString())
                as.setScreenBrightness({
                  value: value / 100,
                  success: function() {
                    prompt.showToast({
                      message:`屏幕亮度设置成功：${value / 100}`
                    })
                    console.log(`[AdvancedAPI] setScreenBrightness success`);
                  },
                  fail: function() {
                    prompt.showToast({
                      message:`屏幕亮度设置失败`
                    })
                    console.log(`[AdvancedAPI] setScreenBrightness fail`);
                  }
                });
              })
          }

          ListItem() {
            Button("as.setScreenBrightness").width(300).onClick(() => {
              as.setScreenBrightness({
                value: 0.5,
                success: function() {
                  prompt.showToast({
                    message:`屏幕亮度设置成功`
                  })
                  console.log(`[AdvancedAPI] setScreenBrightness success`);
                },
                fail: function() {
                  prompt.showToast({
                    message:`屏幕亮度设置失败`
                  })
                  console.log(`[AdvancedAPI] setScreenBrightness fail`);
                }
              });
            })
          }
          ListItem() {
            Button("as.getScreenBrightness").width(300).onClick(() => {
              as.getScreenBrightness({
                success: function (res) {
                  prompt.showToast({
                    message:`屏幕亮度:${res.value}`
                  })
                  console.log(`[AdvancedAPI] getScreenBrightness value = ${res.value}`);
                },
                fail: function () {
                  prompt.showToast({
                    message:`获取屏幕亮度失败`
                  })
                  console.error(`[AdvancedAPI] getScreenBrightness fail`);
                }
              });
            })
          }
          ListItem() {
            Button("as.setKeepScreenOn(开启)").width(300).onClick(() => {
              as.setKeepScreenOn({
                keepScreenOn: true,
                success: function () {
                  prompt.showToast({
                    message:`setKeepScreenOn success`
                  })
                  console.log(`[AdvancedAPI] setKeepScreenOn handling success`)
                },
                fail: function () {
                  prompt.showToast({
                    message:`setKeepScreenOn fail`
                  })
                }
              });
            })
          }
          ListItem() {
            Button("as.setKeepScreenOn(取消)").width(300).onClick(() => {
              as.setKeepScreenOn({
                keepScreenOn: false,
                success: function () {
                  prompt.showToast({
                    message:`setKeepScreenOff success`
                  })
                  console.log(`[AdvancedAPI] setKeepScreenOff handling success`)
                },
                fail: function () {
                  prompt.showToast({
                    message:`setKeepScreenOff fail`
                  })
                }
              });
            })
          }

          // test
          ListItem() {
            // as.setScreenBrightness  value
            Column({ space: 10 }) {
              Text("setScreenBrightness 接口 ").fontSize(20).fontWeight(FontWeight.Bold)

              // as.setScreenBrightness  value  正常
              Button("value  参数正常").width(300).onClick(() => {
                as.setScreenBrightness({
                  value: 0.7,
                  success: function (res) {
                    console.log('[AdvancedAPI] setScreenBrightness--00 success' + JSON.stringify(res));
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI] setScreenBrightness--00 fail' + JSON.stringify(e));
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI] setScreenBrightness--00 complete' + JSON.stringify(res));
                  }
                })
              })

              // as.setScreenBrightness  value  无此参数
              Button("value  无此参数").width(300).onClick(() => {
                as.setScreenBrightness({
                  // value: -7,
                  success: function (res) {
                    console.log('[AdvancedAPI] setScreenBrightness--0 success' + JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI] setScreenBrightness--0 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI] setScreenBrightness--0 complete' + JSON.stringify(res))
                  }
                })
              })

              // as.setScreenBrightness  value  取值number负数，或者大于100
              Button("value number 负数").width(300).onClick(() => {
                as.setScreenBrightness({
                  value: -7,
                  success: function (res) {
                    console.log('[AdvancedAPI] setScreenBrightness--1 success' + JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI] setScreenBrightness--1 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI] setScreenBrightness--1 complete' + JSON.stringify(res))
                  }
                })
              })

              Button("value number 大于范围").width(300).onClick(() => {
                as.setScreenBrightness({
                  value: 210,
                  success: function (res) {
                    console.log('[AdvancedAPI] setScreenBrightness--11 success' + JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI] setScreenBrightness--11 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI] setScreenBrightness--11 complete' + JSON.stringify(res))
                  }
                })
              })

              // as.setScreenBrightness  value  取值number，小数点精确超出2位
              Button("value number 小数点超2位").width(300).onClick(() => {
                as.setScreenBrightness({
                  value: 0.456123,
                  success: function (res) {
                    console.log('[AdvancedAPI] setScreenBrightness--2 success' + JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI] setScreenBrightness--2 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI] setScreenBrightness--2 complete' + JSON.stringify(res))
                  }
                })
              })

              // as.setScreenBrightness  value  取值String
              Button("value String 内容是小数").width(300).onClick(() => {
                as.setScreenBrightness({
                  value: '0.3',
                  success: function (res) {
                    console.log('[AdvancedAPI] setScreenBrightness--3 success' + JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI] setScreenBrightness--3 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI] setScreenBrightness--3 complete' + JSON.stringify(res))
                  }
                })
              })

              Button("value String ").width(300).onClick(() => {
                as.setScreenBrightness({
                  value: 'test',
                  success: function (res) {
                    console.log('[AdvancedAPI] setScreenBrightness--33 success' + JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI] setScreenBrightness--33 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI] setScreenBrightness--33 complete' + JSON.stringify(res))
                  }
                })
              })

              // as.setScreenBrightness  value  int取值Boolean true  success 1
              Button("value Boolean true ").width(300).onClick(() => {
                as.setScreenBrightness({
                  value: true,
                  success: function res() {
                    console.log('[AdvancedAPI] setScreenBrightness--4 success' + JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI] setScreenBrightness--4 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI] setScreenBrightness--4 complete' + JSON.stringify(res))
                  }
                })
              })

              // as.setScreenBrightness  value  int取值Boolean false success 0
              Button("value Boolean false").width(300).onClick(() => {
                as.setScreenBrightness({
                  value: false,
                  success: function (res) {
                    console.log('[AdvancedAPI] setScreenBrightness--5 success' + JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI] setScreenBrightness--5 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI] setScreenBrightness--5 complete' + JSON.stringify(res))
                  }
                })
              })

              // as.setScreenBrightness  value  取值object
              Button("value object").width(300).onClick(() => {
                as.setScreenBrightness({
                  value: { 'name':'test' },
                  success: function (res) {
                    console.log('[AdvancedAPI] setScreenBrightness--6 success' + JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI] setScreenBrightness--6 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI] setScreenBrightness--6 complete' + JSON.stringify(res))
                  }
                })
              })

              // as.setScreenBrightness  value  取值null  success
              Button("value null").width(300).onClick(() => {
                as.setScreenBrightness({
                  value: null,
                  success: function (res) {
                    console.log('[AdvancedAPI] setScreenBrightness--7 success' + JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI] setScreenBrightness--7 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI] setScreenBrightness--7 complete' + JSON.stringify(res))
                  }
                })
              })

              // as.setScreenBrightness  value  取值空字符
              Button("value 空字符").width(300).onClick(() => {
                as.setScreenBrightness({
                  value: '',
                  success: function (res) {
                    console.log('[AdvancedAPI] setScreenBrightness--8 success' + JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI] setScreenBrightness--8 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI] setScreenBrightness--8 complete' + JSON.stringify(res))
                  }
                })
              })

              // as.setScreenBrightness  value  取值undefined
              Button("value undefined").width(300).onClick(() => {
                as.setScreenBrightness({
                  value: undefined,
                  success: function (res) {
                    console.log('[AdvancedAPI] setScreenBrightness--9 success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI] setScreenBrightness--9 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI] setScreenBrightness--9 complete' + JSON.stringify(res))
                  }
                })
              })
            }
          }

          ListItem() {
            // as.setKeepScreenOn  keepScreenOn
            Column({ space: 10 }) {
              // as.setKeepScreenOn  keepScreenOn  取值Boolean true
              Button("keepScreenOn Boolean true").width(300).onClick(() => {
                as.setKeepScreenOn({
                  keepScreenOn: true,
                  success: function (res) {
                    console.log('[AdvancedAPI] keepScreenOn--0 success' + JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI] keepScreenOn--0 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI] keepScreenOn--0 complete' + JSON.stringify(res))
                  }
                })
              })

              // as.setKeepScreenOn  keepScreenOn  int取值Boolean false
              Button("keepScreenOn Boolean false").width(300).onClick(() => {
                as.setKeepScreenOn({
                  keepScreenOn: false,
                  success: function (res) {
                    console.log('[AdvancedAPI] keepScreenOn--1 success' + JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI] keepScreenOn--1 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI] keepScreenOn--1 complete' + JSON.stringify(res))
                  }
                })
              })

              // as.setKeepScreenOn  keepScreenOn  无此参数
              Button("keepScreenOn  无此参数").width(300).onClick(() => {
                as.setKeepScreenOn({
                  //  keepScreenOn: true,
                  success: function (res) {
                    console.log('[AdvancedAPI] keepScreenOn--2 success' + JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI] keepScreenOn--2 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI] keepScreenOn--2 complete' + JSON.stringify(res))
                  }
                })
              })

              // as.setKeepScreenOn  keepScreenOn  取值number
              Button("keepScreenOn  number").width(300).onClick(() => {
                as.setKeepScreenOn({
                  keepScreenOn: 77,
                  success: function (res) {
                    console.log('[AdvancedAPI] keepScreenOn--3 success' + JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI] keepScreenOn--3 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI] keepScreenOn--3 complete' + JSON.stringify(res))
                  }
                })
              })

              // as.setKeepScreenOn  keepScreenOn  取值String
              Button("keepScreenOn  String").width(300).onClick(() => {
                as.setKeepScreenOn({
                  keepScreenOn: 'test',
                  success: function (res) {
                    console.log('[AdvancedAPI] keepScreenOn--5 success' + JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI] keepScreenOn--5 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI] keepScreenOn--5 complete' + JSON.stringify(res))
                  }
                })
              })

              // as.setKeepScreenOn  keepScreenOn  取值object
              Button("keepScreenOn  object").width(300).onClick(() => {
                as.setKeepScreenOn({
                  keepScreenOn: { 'name':'test' },
                  success: function (res) {
                    console.log('[AdvancedAPI] keepScreenOn--6 success' + JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI] keepScreenOn--6 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI] keepScreenOn--6 complete' + JSON.stringify(res))
                  }
                })
              })

              // as.setKeepScreenOn  keepScreenOn  取值null
              Button("keepScreenOn  null").width(300).onClick(() => {
                as.setKeepScreenOn({
                  keepScreenOn: null,
                  success: function (res) {
                    console.log('[AdvancedAPI] keepScreenOn--7 success' + JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI] keepScreenOn--7 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI] keepScreenOn--7 complete' + JSON.stringify(res))
                  }
                })
              })

              // as.setKeepScreenOn  keepScreenOn  取值空字符
              Button("keepScreenOn  空字符").width(300).onClick(() => {
                as.setKeepScreenOn({
                  keepScreenOn: '',
                  success: function (res) {
                    console.log('[AdvancedAPI] keepScreenOn--8 success' + JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI] keepScreenOn--8 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI] keepScreenOn--8 complete' + JSON.stringify(res))
                  }
                })
              })

              // as.setKeepScreenOn  keepScreenOn  取值undefined
              Button("keepScreenOn  undefined").width(300).onClick(() => {
                as.setKeepScreenOn({
                  keepScreenOn: undefined,
                  success: function (res) {
                    console.log('[AdvancedAPI] keepScreenOn--9 success' + JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI] keepScreenOn--9 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI] keepScreenOn--9 complete' + JSON.stringify(res))
                  }
                })
              })
            }
          }

          ListItem() {
            Button("as.getScreenBrightness").width(300).onClick(() => {
              as.getScreenBrightness({
                success: function (res) {
                  console.log('[AdvancedAPI] getScreenBrightness success' + JSON.stringify(res))
                },
                fail:function (e){
                  console.log('[AdvancedAPI] getScreenBrightness fail' + JSON.stringify(e))
                },
                complete:function(res){
                  console.log('[AdvancedAPI] getScreenBrightness complete' + JSON.stringify(res))
                }
              })
            })
          }
        }.listDirection(Axis.Vertical) //  排列方向
        .divider({ strokeWidth: 2, color: 0xFFFFFF, startMargin: 20, endMargin: 20 }) //  每行之间的分界线
        .alignListItem(ListItemAlign.Center)
      }
    }
  }
}