@Entry
@Component
struct CaptureScreen {
  scroller: Scroller = new Scroller()
  private windowClass = null;
  aboutToAppear() {

  }
  private callback = (path) => {
    console.log("[AdvancedAPI] screenshot happened, path: " + path);
    AlertDialog.show({ message: 'screenshot happened, callback path: ' + path, offset: { dx: 0, dy: -50 } })
  };

  private cb = () => {
    console.log("[AdvancedAPI] screenshot happened");
    AlertDialog.show({ message: 'screenshot happened, no params', offset: { dx: 0, dy: 50 } })
  };

  build() {
    Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center })  {
      Column({ space: 5 }) {
        List({ space: 20, }){
          ListItem(){
            Text("用户截屏事件").fontSize(35)
          }
          ListItem(){
            Text("as.onUserCaptureScreen").fontSize(20).fontWeight(FontWeight.Bold)
          }
          // TC1
          ListItem(){
            Button("callback参数path").width(300).onClick(()=>{
              // @ts-ignore
              as.onUserCaptureScreen(this.callback)
            })
          }
          // TC2
          ListItem(){
            Button("callback为空").width(300).onClick(()=>{
              // @ts-ignore
              as.onUserCaptureScreen()
            }).backgroundColor(Color.Orange)
          }
          // TC3
          ListItem(){
            Button("callback参数为空").width(300).onClick(()=>{
              // @ts-ignore
              as.onUserCaptureScreen(this.cb)
            }).backgroundColor(Color.Orange)
          }

          ListItem(){
            Text("as.offUserCaptureScreen").fontSize(20).fontWeight(FontWeight.Bold)
          }
          // TC1
          ListItem(){
            Button("取消带path监听").width(300).onClick(()=>{
              // @ts-ignore
              as.offUserCaptureScreen(this.callback)
            })
          }
          // TC2
          ListItem(){
            Button("取消全部监听").width(300).onClick(()=>{
              // @ts-ignore
              as.offUserCaptureScreen()
            }).backgroundColor(Color.Orange)
          }

          ListItem(){
            Text("as.setUserCaptureScreen").fontSize(20).fontWeight(FontWeight.Bold)
          }
          // TC1
          ListItem(){
            Button("设置禁止截屏").width(300).onClick(()=>{
              // @ts-ignore
              as.setUserCaptureScreen({
                enable: false,
                success: (res) => {
                  console.log("[AdvancedAPI] setUserCaptureScreen success: " + JSON.stringify(res));
                  AlertDialog.show({ message: 'setUserCaptureScreen success', offset: { dx: 0, dy: -50 } })
                },
                fail: (res) => {
                  console.log("[AdvancedAPI] setUserCaptureScreen fail: " + JSON.stringify(res));
                  AlertDialog.show({ message: 'setUserCaptureScreen fail', offset: { dx: 0, dy: -50 } })
                },
                complete: (res) => {
                  console.log("[AdvancedAPI] setUserCaptureScreen complete: " + JSON.stringify(res));
                  AlertDialog.show({ message: 'setUserCaptureScreen complete', offset: { dx: 0, dy: 50 } })
                }
              })
            })
          }
          // TC2
          ListItem(){
            Button("参数为空").width(300).onClick(()=>{
              // @ts-ignore
              as.setUserCaptureScreen({
              })
            }).backgroundColor(Color.Orange)
          }
          // TC3
          ListItem(){
            Button("参数不带必填参数enable").width(300).onClick(()=>{
              // @ts-ignore
              as.setUserCaptureScreen({
                success: (res) => {
                  console.log("[AdvancedAPI] setUserCaptureScreen success: " + JSON.stringify(res));
                  AlertDialog.show({ message: 'setUserCaptureScreen success', offset: { dx: 0, dy: -50 } })
                },
                fail: (res) => {
                  console.log("[AdvancedAPI] setUserCaptureScreen fail: " + JSON.stringify(res));
                  AlertDialog.show({ message: 'setUserCaptureScreen fail', offset: { dx: 0, dy: -50 } })
                }
              })
            }).backgroundColor(Color.Orange)
          }
          // TC4
          ListItem(){
            Button("enable参数传入数值").width(300).onClick(()=>{
              // @ts-ignore
              as.setUserCaptureScreen({
                enable: 1,
                success: (res) => {
                  console.log("[AdvancedAPI] setUserCaptureScreen success: " + JSON.stringify(res));
                  AlertDialog.show({ message: 'setUserCaptureScreen success', offset: { dx: 0, dy: -50 } })
                },
                fail: (res) => {
                  console.log("[AdvancedAPI] setUserCaptureScreen fail: " + JSON.stringify(res));
                  AlertDialog.show({ message: 'setUserCaptureScreen fail', offset: { dx: 0, dy: -50 } })
                }
              })
            }).backgroundColor(Color.Orange)
          }
          // TC5
          ListItem(){
            Button("设置允许截屏，只有complete回调").width(300).onClick(()=>{
              // @ts-ignore
              as.setUserCaptureScreen({
                enable: true,
                complete: (res) => {
                  console.log("[AdvancedAPI] setUserCaptureScreen complete: " + JSON.stringify(res));
                  AlertDialog.show({ message: 'setUserCaptureScreen complete', offset: { dx: 0, dy: 50 } })
                }
              })
            }).backgroundColor(Color.Orange)
          }

          // test
          //  截屏的常用方式：
          //  1、通过快捷键截屏：同时按住Home键+电源键（部分早期机器需要同时按住返回键和Home键）。
          //  2、助理菜单截屏：设置-辅助功能-敏捷度和互动-助理菜单开启-点击屏幕上的蓝色圆形加4个白色方框图标-向下滑动-截屏
          //  3、手势截屏：设置-高级功能-手掌滑动截屏-滑动开关，滑动时请保持掌沿与屏幕接触。
          //  4、快捷图标截屏：下拉屏幕顶帘菜单-向左滑动快捷图标-点击【截取屏幕】快捷图标即可。
          ListItem(){
            Column({ space: 5 }) {
              Button("enable：true").width(300).onClick(()=>{
                // @ts-ignore
                as.setUserCaptureScreen({
                  enable: true,
                  success: (res) => {
                    console.log("[AdvancedAPI] setUserCaptureScreen success: " + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.log("[AdvancedAPI] setUserCaptureScreen fail: " + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log("[AdvancedAPI] setUserCaptureScreen complete: " + JSON.stringify(res))
                  }
                })
              })

              Button("enable：false").width(300).onClick(()=>{
                // @ts-ignore
                as.setUserCaptureScreen({
                  enable: false,
                  success: (res) => {
                    console.log("[AdvancedAPI] setUserCaptureScreen success: " + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.log("[AdvancedAPI] setUserCaptureScreen fail: " + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log("[AdvancedAPI] setUserCaptureScreen complete: " + JSON.stringify(res))
                  }
                })
              })

              Button("无enable参数").width(300).onClick(()=>{
                // @ts-ignore
                as.setUserCaptureScreen({
                  //                  enable: false,
                  success: (res) => {
                    console.log("[AdvancedAPI] setUserCaptureScreen success: " + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.log("[AdvancedAPI] setUserCaptureScreen fail: " + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log("[AdvancedAPI] setUserCaptureScreen complete: " + JSON.stringify(res))
                  }
                })
              })

              Button("enable取值number").width(300).onClick(()=>{
                // @ts-ignore
                as.setUserCaptureScreen({
                  enable: 1,
                  success: (res) => {
                    console.log("[AdvancedAPI] setUserCaptureScreen success: " + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.log("[AdvancedAPI] setUserCaptureScreen fail: " + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log("[AdvancedAPI] setUserCaptureScreen complete: " + JSON.stringify(res))
                  }
                })
              })

              Button("enable取值String").width(300).onClick(()=>{
                // @ts-ignore
                as.setUserCaptureScreen({
                  enable: 'test',
                  success: (res) => {
                    console.log("[AdvancedAPI] setUserCaptureScreen success: " + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.log("[AdvancedAPI] setUserCaptureScreen fail: " + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log("[AdvancedAPI] setUserCaptureScreen complete: " + JSON.stringify(res))
                  }
                })
              })

              Button("enable取值object").width(300).onClick(()=>{
                // @ts-ignore
                as.setUserCaptureScreen({
                  enable: { 'name':'test' },
                  success: (res) => {
                    console.log("[AdvancedAPI] setUserCaptureScreen success: " + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.log("[AdvancedAPI] setUserCaptureScreen fail: " + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log("[AdvancedAPI] setUserCaptureScreen complete: " + JSON.stringify(res))
                  }
                })
              })

              Button("enable取值null").width(300).onClick(()=>{
                // @ts-ignore
                as.setUserCaptureScreen({
                  enable: null,
                  success: (res) => {
                    console.log("[AdvancedAPI] setUserCaptureScreen success: " + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.log("[AdvancedAPI] setUserCaptureScreen fail: " + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log("[AdvancedAPI] setUserCaptureScreen complete: " + JSON.stringify(res))
                  }
                })
              })

              Button("enable取值空字符").width(300).onClick(()=>{
                // @ts-ignore
                as.setUserCaptureScreen({
                  enable: '',
                  success: (res) => {
                    console.log("[AdvancedAPI] setUserCaptureScreen success: " + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.log("[AdvancedAPI] setUserCaptureScreen fail: " + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log("[AdvancedAPI] setUserCaptureScreen complete: " + JSON.stringify(res))
                  }
                })
              })

              Button("enable取值undefined").width(300).onClick(()=>{
                // @ts-ignore
                as.setUserCaptureScreen({
                  enable: undefined,
                  success: (res) => {
                    console.log("[AdvancedAPI] setUserCaptureScreen success: " + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.log("[AdvancedAPI] setUserCaptureScreen fail: " + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log("[AdvancedAPI] setUserCaptureScreen complete: " + JSON.stringify(res))
                  }
                })
              })
            }.backgroundColor(Color.Orange)
          }
        }.alignListItem(ListItemAlign.Center)
      }
    }
  }
}