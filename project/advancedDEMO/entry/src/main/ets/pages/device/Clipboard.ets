// @ts-nocheck
import prompt from '@ohos.prompt'
@Entry
@Component
struct Clipboard {
  aboutToAppear() {
  }

  build() {
    Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
      Column({ space: 20 }) {
        List({ space: 20, initialIndex: 0 }){
          ListItem() {
            Column ({ space: 10 }) {
              Text("剪切板").fontSize(35)
              Button("as.setClipboardData").width(300).onClick(() => {
                as.setClipboardData({
                  data: 'hello',
                  showToast: true,
                  success: function () {
                    console.log('[AdvancedAPI] setClipboardData success' + JSON.stringify(res));
                  }
                });
              })
              Button("as.getClipboardData").width(300).onClick(() => {
                as.getClipboardData({
                  success: function (res) {
                    prompt.showToast({
                      message: 'getClipboardData:${res.data}'
                    })
                    console.log('[AdvancedAPI] getClipboardData success data = ' + res.data);
                  }
                });
              })
            }
          }
          // test
          ListItem(){
            Column ({ space: 10 }) {
              Text('setClipboardData').fontSize(35)
              // 正常验证剪切板 set
              Button("data 正常入参String").width(300).onClick(() => {
                as.setClipboardData({
                  data: 'hello',
                  success: function (res) {
                    console.log('[AdvancedAPI] setClipboardData success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI] setClipboardData fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI] setClipboardData complete' + JSON.stringify(res))
                  }
                })
              })

              // 剪切板 setClipboardData--data-无此参数验证  fail
              Button("无此参数").width(300).onClick(() => {
                as.setClipboardData({
                  //             data: 'hello',
                  success: function (res) {
                    console.log('[AdvancedAPI] setClipboardData--data1 success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI] setClipboardData--data1 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI] setClipboardData--data1 complete' + JSON.stringify(res))
                  }
                })
              })

              // 剪切板 setClipboardData--data-int参数验证   fail
              Button("Number").width(300).onClick(() => {
                as.setClipboardData({
                  data: 1111,
                  success: function (res) {
                    console.log('[AdvancedAPI] setClipboardData--data2 success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI] setClipboardData--data2 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI] setClipboardData--data2 complete' + JSON.stringify(res))
                  }
                })
              })

              // 剪切板 setClipboardData--data-object参数验证 fail
              Button("Object").width(300).onClick(() => {
                as.setClipboardData({
                  data: { "name":"aaa" },
                  success: function (res) {
                    console.log('[AdvancedAPI] setClipboardData--data3 success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI] setClipboardData--data3 fail' + JSON.stringify(e))
                  },
                  complete:function(){
                    console.log('[AdvancedAPI] setClipboardData--data3 complete'+ JSON.stringify(res))
                  }
                })
              })

              // 剪切板 setClipboardData--data-boolean参数验证 fail
              Button("Boolean").width(300).onClick(() => {
                as.setClipboardData({
                  data: false,
                  success: function (res) {
                    console.log('[AdvancedAPI] setClipboardData--data4 success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI] setClipboardData--data4 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI] setClipboardData--data4 complete' + JSON.stringify(res))
                  }
                })
              })

              // 剪切板 setClipboardData--data--空字符参数验证   success 回调
              Button("空字符").width(300).onClick(() => {
                as.setClipboardData({
                  data: "",
                  success: function (res) {
                    console.log('[AdvancedAPI] setClipboardData--data5 success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI] setClipboardData--data5 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI] setClipboardData--data5 complete' +  JSON.stringify(res))
                  }
                })
              })

              // 剪切板 setClipboardData--data--null参数验证 fail
              Button("null").width(300).onClick(() => {
                as.setClipboardData({
                  data: null,
                  success: function (res) {
                    console.log('[AdvancedAPI] setClipboardData--data6 success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI] setClipboardData--data6 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI] setClipboardData--data6 complete' + JSON.stringify(res))
                  }
                })
              })

              // 剪切板 setClipboardData--data--undefined参数验证  fail
              Button("undefined").width(300).onClick(() => {
                as.setClipboardData({
                  data: undefined,
                  success: function (res) {
                    console.log('[AdvancedAPI] setClipboardData--data7 success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI] setClipboardData--data7 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI] setClipboardData--data7 complete' + JSON.stringify(res))
                  }
                })
              })

              // 剪切板 setClipboardData--data--关于此参数长度的参数验证
              Button("String 超长").width(300).onClick(() => {
                as.setClipboardData({
                  data: "听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。" +
                  "听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。" +
                  "听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。" +
                  "听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。" +
                  "听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。" +
                  "听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。" +
                  "听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。" +
                  "听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。" +
                  "听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。" +
                  "听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。" +
                  "听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。" +
                  "听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。",
                  success: function (res) {
                    console.log('[AdvancedAPI] setClipboardData--data8 success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI] setClipboardData--data8 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI] setClipboardData--data8 complete' + JSON.stringify(res))
                  }
                })
              })
            }
          }
          ListItem(){
            Column ({ space: 10 }) {
              // 剪切板 setClipboardData--showToast-无此参数验证 success 回调
              Button("showToast 无此参数（默认值）").width(300).onClick(() => {
                as.setClipboardData({
                  data: 'hello',
                  success: function (res) {
                    prompt.showToast({
                      message:'setClipboardData success '
                    })
                    console.log('[AdvancedAPI] setClipboardData--showToast1 success' + JSON.stringify(res))
                  },
                  fail: function (e) {
                    prompt.showToast({
                      message:'setClipboardData fail '
                    })
                    console.log('[AdvancedAPI] setClipboardData--showToast1 fail' + JSON.stringify(e))
                  },
                  complete: function (res) {
                    console.log('[AdvancedAPI] setClipboardData--showToast1 complete' + JSON.stringify(res))
                  }
                })
              })

              // 剪切板 setClipboardData--showToast-取值true  fail回调
              Button("Boolean --true").width(300).onClick(() => {
                as.setClipboardData({
                  data: 'hello',
                  showToast: true,
                  success: function (res) {
                    prompt.showToast({
                      message:'setClipboardData success '
                    })
                    console.log('[AdvancedAPI] setClipboardData--showToast2 success' + JSON.stringify(res))
                  },
                  fail: function (e) {
                    prompt.showToast({
                      message:'setClipboardData fail '
                    })
                    console.log('[AdvancedAPI] setClipboardData--showToast2 fail' + JSON.stringify(e))
                  },
                  complete: function (res) {
                    console.log('[AdvancedAPI] setClipboardData--showToast2 complete' + JSON.stringify(res))
                  }
                })
              })

              // 剪切板 setClipboardData--showToast-取值false success 回调
              Button("Boolean --false").width(300).onClick(() => {
                as.setClipboardData({
                  data: 'hello',
                  showToast: false,
                  success: function (res) {
                    prompt.showToast({
                      message:'setClipboardData success '
                    })
                    console.log('[AdvancedAPI] setClipboardData--showToast3 success' + JSON.stringify(res))
                  },
                  fail: function (e) {
                    prompt.showToast({
                      message:'setClipboardData fail '
                    })
                    console.log('[AdvancedAPI] setClipboardData--showToast3 fail' + JSON.stringify(e))
                  },
                  complete: function (res) {
                    console.log('[AdvancedAPI] setClipboardData--showToast3 complete' + JSON.stringify(res))
                  }
                })
              })

              // 剪切板 setClipboardData--showToast-取值String success 回调
              Button("String").width(300).onClick(() => {
                as.setClipboardData({
                  data: 'hello',
                  showToast: "showToast String",
                  success: function (res) {
                    prompt.showToast({
                      message:'setClipboardData success '
                    })
                    console.log('[AdvancedAPI] setClipboardData--showToast4 success' + JSON.stringify(res))
                  },
                  fail: function (e) {
                    prompt.showToast({
                      message:'setClipboardData fail '
                    })
                    console.log('[AdvancedAPI] setClipboardData--showToast4 fail' + JSON.stringify(e))
                  },
                  complete: function (res) {
                    console.log('[AdvancedAPI] setClipboardData--showToast4 complete' + JSON.stringify(res))
                  }
                })
              })

              // 剪切板 setClipboardData--showToast-取值object fail回调
              Button("Object").width(300).onClick(() => {
                as.setClipboardData({
                  data: 'hello',
                  showToast: { "qqq": "showToast String" },
                  success: function (res) {
                    prompt.showToast({
                      message:'setClipboardData success '
                    })
                    console.log('[AdvancedAPI] setClipboardData--showToast5 success' + JSON.stringify(res))
                  },
                  fail: function (e) {
                    prompt.showToast({
                      message:'setClipboardData fail '
                    })
                    console.log('[AdvancedAPI] setClipboardData--showToast5 fail' + JSON.stringify(e))
                  },
                  complete: function (res) {
                    console.log('[AdvancedAPI] setClipboardData--showToast5 complete' + JSON.stringify(res))
                  }
                })
              })

              // 剪切板 setClipboardData--showToast-取值Int(非0或1) fail回调
              Button("Number").width(300).onClick(() => {
                as.setClipboardData({
                  data: 'hello',
                  showToast: 2222,
                  success: function (res) {
                    prompt.showToast({
                      message:'setClipboardData success '
                    })
                    console.log('[AdvancedAPI] setClipboardData--showToast6 success' + JSON.stringify(res))
                  },
                  fail: function (e) {
                    prompt.showToast({
                      message:'setClipboardData fail '
                    })
                    console.log('[AdvancedAPI] setClipboardData--showToast6 fail' + JSON.stringify(e))
                  },
                  complete: function (res) {
                    console.log('[AdvancedAPI] setClipboardData--showToast6 complete' + JSON.stringify(res))
                  }
                })
              })

              // 剪切板 setClipboardData--showToast-取值null  success 回调
              Button("null").width(300).onClick(() => {
                as.setClipboardData({
                  data: 'hello',
                  showToast: null,
                  success: function (res) {
                    prompt.showToast({
                      message:'setClipboardData success '
                    })
                    console.log('[AdvancedAPI] setClipboardData--showToast7 success' + JSON.stringify(res))
                  },
                  fail: function (e) {
                    prompt.showToast({
                      message:'setClipboardData fail '
                    })
                    console.log('[AdvancedAPI] setClipboardData--showToast7 fail' + JSON.stringify(e))
                  },
                  complete: function (res) {
                    console.log('[AdvancedAPI] setClipboardData--showToast7 complete' + JSON.stringify(res))
                  }
                })
              })

              // 剪切板 setClipboardData--showToast-取值空字符串  success 回调
              Button("空字符").width(300).onClick(() => {
                as.setClipboardData({
                  data: 'hello',
                  showToast: "",
                  success: function (res) {
                    prompt.showToast({
                      message:'setClipboardData success '
                    })
                    console.log('[AdvancedAPI] setClipboardData--showToast8 success' + JSON.stringify(res))
                  },
                  fail: function (e) {
                    prompt.showToast({
                      message:'setClipboardData fail '
                    })
                    console.log('[AdvancedAPI] setClipboardData--showToast8 fail' + JSON.stringify(e))
                  },
                  complete: function (res) {
                    console.log('[AdvancedAPI] setClipboardData--showToast8 complete' + JSON.stringify(res))
                  }
                })
              })

              // 剪切板 setClipboardData--showToast-取值undefined success 回调
              Button("undefined").width(300).onClick(() => {
                as.setClipboardData({
                  data: 'hello',
                  showToast: undefined,
                  success: function (res) {
                    prompt.showToast({
                      message:'setClipboardData success '
                    })
                    console.log('[AdvancedAPI] setClipboardData--showToast9 success' + JSON.stringify(res))
                  },
                  fail: function (e) {
                    prompt.showToast({
                      message:'setClipboardData fail '
                    })
                    console.log('[AdvancedAPI] setClipboardData--showToast9 fail' + JSON.stringify(e))
                  },
                  complete: function (res) {
                    console.log('[AdvancedAPI] setClipboardData--showToast9 complete' + JSON.stringify(res))
                  }
                })
              })
            }
          }

          // 剪切板 setClipboardData  接口调用 success fail  complete的返回值可参照上方接口日志
          ListItem(){
            Column ({ space: 10 }) {
              Text('getClipboardData').fontSize(35)
              // 剪切板 getClipboardData 的接口回调
              Button("回调验证+弹窗").width(300).onClick(() => {
                as.getClipboardData({
                  success: function (res) {
                    prompt.showToast({
                      message: 'getClipboardData success' + JSON.stringify(res.data)
                    })
                    console.log('[AdvancedAPI] getClipboardData success data = ' + JSON.stringify(res))
                  },
                  fail: function (e) {
                    prompt.showToast({
                      message: 'getClipboardData fail'
                    })
                    console.log('[AdvancedAPI] getClipboardData fail' + JSON.stringify(e))
                  },
                  complete: function (res) {
                    console.log('[AdvancedAPI] getClipboardData  complete' + JSON.stringify(res))
                  }
                })
              })
            }
          }
        }.alignListItem(ListItemAlign.Center) // 每行之间的分界线
      }
    }
  }
}