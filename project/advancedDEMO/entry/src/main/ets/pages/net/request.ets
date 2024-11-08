@Entry
@Component
struct request {
  scroller: Scroller = new Scroller()
  private progressCallback1 = (res) => {
    console.log('[AdvancedAPI] progress changed ' + JSON.stringify(res))
  }
  private progressCallback2 = () => {
    console.log("[AdvancedAPI] progress changed")
  }
  private headersCallback1 = (res) => {
    console.log('[AdvancedAPI] receive headers ' + JSON.stringify(res))
  }
  private headersCallback2 = () => {
    console.log("[AdvancedAPI] receive headers")
  }

  build() {
    Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center })  {
      Column({ space: 5 }) {
        List({ space: 20, }){
          ListItem(){
            Text("as.request").fontSize(20).fontWeight(FontWeight.Bold)
          }

          ListItem(){
            Column ({ space: 10 }) {
              // request   url 正常传参 String类--有效网址（无其他参数）   sucess
              Button("url 正常传参").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: 'https://www.huawei.com',
                  success: (res) => {
                    console.log('[AdvancedAPI] request url success0 ' + res.data) // 内容太长时无法打印
                    console.log('[AdvancedAPI] request url success0 ' + res.statusCode) // 内容太长时无法打印
                    console.log('[AdvancedAPI] request url success0 ' + res.header) // 内容太长时无法打印
                    console.log('[AdvancedAPI] request url success0 ' + res.cookies) // 内容太长时无法打印
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request url fail0 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request url complete0 ' + JSON.stringify(res))
                  }
                })
              })

              // request   url 正常传参 String类--无效网址（无其他参数）  fail   {"errMsg":"Timeout was reached"}
              Button("url 正常传参 无效网址").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: 'http://m.downbook.org',
                  success: (res) => {
                    console.log('[AdvancedAPI] request url success1 ' + res.data)
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request url fail1 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request url complete1 ' + JSON.stringify(res))
                  }
                })
              })

              // request   无此url参数（无其他参数）
              Button("无此url参数").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  // url: 'https://www.huawei.com',
                  success: (res) => {
                    console.log('[AdvancedAPI] request url success2 ' + res.data)
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request url fail2 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request url complete2 ' + JSON.stringify(res))
                  }
                })
              })

              // request   url 类型不对 number（无其他参数）     类型不对，均是fail回调  {"errMsg":"URL using bad/illegal format or missing URL"}
              Button("number").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: 7788,
                  success: (res) => {
                    console.log('[AdvancedAPI] request url success3 ' + res.data)
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request url fail 3' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request url complete3 ' + JSON.stringify(res))
                  }
                })
              })

              // request   url 类型不对 boolean（无其他参数）
              Button("boolean").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: false,
                  success: (res) => {
                    console.log('[AdvancedAPI] request url success4 ' + res.data)
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request url fail4 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request url complete4 ' + JSON.stringify(res))
                  }
                })
              })

              // request   url 类型不对 object（无其他参数）
              Button("object").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: { 'name':'test' },
                  success: (res) => {
                    console.log('[AdvancedAPI] request url success5 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request url fail5 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request url complete5 ' + JSON.stringify(res))
                  }
                })
              })

              // request   url 类型不对 null（无其他参数）
              Button("null").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: null,
                  success: (res) => {
                    console.log('[AdvancedAPI] request url success6 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request url fail6 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request url complete6 ' + JSON.stringify(res))
                  }
                })
              })

              // request   url 类型不对 空字符（无其他参数）
              Button("空字符").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: '',
                  success: (res) => {
                    console.log('[AdvancedAPI] request url success7 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request url fail7 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request url complete7 ' + JSON.stringify(res))
                  }
                })
              })

              // request   url 类型不对 undefined（无其他参数）
              Button("undefined").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: undefined,
                  success: (res) => {
                    console.log('[AdvancedAPI] request url success8 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request url fail8 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request url complete8 ' + JSON.stringify(res))
                  }
                })
              })
            }
          }

          ListItem(){
            Column ({ space: 10 }) {
              // request   data 正常传参 Object
              Button("data 正常传参 Object").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: 'https://www.huawei.com',
                  data: {
                    text: 'as.request'
                  },
                  success: (res) => {
                    console.log('[AdvancedAPI] request data success 1 ' + res.data)
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request data fail 1 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request data complete 1 ' + JSON.stringify(res))
                  }
                })
              })

              // request   data 正常传参 String类
              Button("data 正常传参 String").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: 'https://www.huawei.com',
                  data: 'as.request',
                  success: (res) => {
                    console.log('[AdvancedAPI] request data success 2 ' + res.data)
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request data fail 2 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request data complete 2 ' + JSON.stringify(res))
                  }
                })
              })

              // request   data 正常传参 ArrayBuffer
              Button("data 正常传参 ArrayBuffer").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: 'https://www.huawei.com',
                  data: {
                    text: 'as.request'
                  },
                  success: (res) => {
                    console.log('[AdvancedAPI] request data success 3 ' + res.data)
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request data fail 3 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request data complete 3 ' + JSON.stringify(res))
                  }
                })
              })

              // request   无此data参数（无其他参数）
              Button("无此data参数").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: 'https://www.huawei.com',
                  //                  data: {
                  //                    text: 'as.request'
                  //                  },
                  success: (res) => {
                    console.log('[AdvancedAPI] request data success 4 ' + res.data)
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request data fail 4 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request data complete 4 ' + JSON.stringify(res))
                  }
                })
              })

              // request   data 类型不对 number（无其他参数）
              Button("number").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: 'https://www.huawei.com',
                  data: 7788,
                  success: (res) => {
                    console.log('[AdvancedAPI] request data success 5 ' + res.data)
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request data fail 5 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request data complete 5 ' + JSON.stringify(res))
                  }
                })
              })

              // request   data 类型不对 boolean（无其他参数）
              Button("boolean").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: 'https://www.huawei.com',
                  data: true,
                  success: (res) => {
                    console.log('[AdvancedAPI] request data success 6 ' + res.data)
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request data fail 6 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request data complete 6 ' + JSON.stringify(res))
                  }
                })
              })

              // request   data 类型不对 null（无其他参数）
              Button("null").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: 'https://www.huawei.com',
                  data: null,
                  success: (res) => {
                    console.log('[AdvancedAPI] request data success 7 ' + res.data)
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request data fail 7 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request data complete 7 ' + JSON.stringify(res))
                  }
                })
              })

              // request   data 类型不对 空字符（无其他参数）
              Button("空字符").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: 'https://www.huawei.com',
                  data: '',
                  success: (res) => {
                    console.log('[AdvancedAPI] request data success 8 ' + res.data)
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request data fail 8 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request data complete 8 ' + JSON.stringify(res))
                  }
                })
              })

              // request   data 类型不对 undefined（无其他参数）
              Button("undefined").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: 'https://www.huawei.com',
                  data: undefined,
                  success: (res) => {
                    console.log('[AdvancedAPI] request data success 9 ' + res.data)
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request data fail 9 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request data complete 9 ' + JSON.stringify(res))
                  }
                })
              })
            }
          }

          ListItem(){
            Column ({ space: 10 }) {
              // request   header 正常传参 header 中不能设置 Referer
              Button("header 正常传参").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: 'https://www.huawei.com',
                  header:{'content-type':'application/json'},
                  success: (res) => {
                    console.log('[AdvancedAPI] request header success 0 ' + res.data)
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request header fail 0 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request header complete 0 ' + JSON.stringify(res))
                  }
                })
              })

              // request   header 正常传参 header 中设置 Referer   --失败场景  success回调
              Button("header 设置 Referer1 ").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: 'https://www.huawei.com',
                  header:{'Referer':'https://www.huawei.com'},
                  success: (res) => {
                    console.log('[AdvancedAPI] request header success 1 ' + res.data)
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request header fail 1 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request header complete 1 ' + JSON.stringify(res))
                  }
                })
              })

              Button("header 设置 Referer2 ").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: 'http://photo.yupoo.com/vibius/GkRSowXr/medish.jpg',
                  header: { 'referer': 'http://photo.yupoo.com/' },
                  success: (res) => {
                    console.log('[AdvancedAPI] request header success 1 ' + res.data)
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request header fail 1 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request header complete 1 ' + JSON.stringify(res))
                  }
                })
              })

              Button("header 设置 Referer3 ").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: 'http://photo.yupoo.com/vibius/GkRSowXr/medish.jpg',
                  header: {'referer': 'https://www.zhihu.com/' },
                  success: (res) => {
                    console.log('[AdvancedAPI] request header success 1 ' + res.data)
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request header fail 1 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request header complete 1 ' + JSON.stringify(res))
                  }
                })
              })

              // request   无此header参数（无其他参数）
              Button("无此header参数").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: 'https://www.huawei.com',
                  //                  header:{'content-type':'application/json'},
                  success: (res) => {
                    console.log('[AdvancedAPI] request header success 2 ' + res.data)
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request header fail 2 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request header complete 2 ' + JSON.stringify(res))
                  }
                })
              })

              // request   header 类型不对 number（无其他参数）
              Button("number").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: 'https://www.huawei.com',
                  header:8899,
                  success: (res) => {
                    console.log('[AdvancedAPI] request header success 3 ' + res.data)
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request header fail 3 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request header complete 3 ' + JSON.stringify(res))
                  }
                })
              })

              // request   header 类型不对 boolean（无其他参数）
              Button("boolean").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: 'https://www.huawei.com',
                  header:true,
                  success: (res) => {
                    console.log('[AdvancedAPI] request header success 4 ' + res.data)
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request header fail 4 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request header complete 4 ' + JSON.stringify(res))
                  }
                })
              })

              // request   header 类型不对 String（无其他参数）
              Button("String").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: 'https://www.huawei.com',
                  header:'content-type',
                  success: (res) => {
                    console.log('[AdvancedAPI] request header success 5 ' + res.data)
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request header fail 5 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request header complete 5 ' + JSON.stringify(res))
                  }
                })
              })

              // request   header 类型不对 null（无其他参数）
              Button("null").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: 'https://www.huawei.com',
                  header:null,
                  success: (res) => {
                    console.log('[AdvancedAPI] request header success 6 ' + res.data)
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request header fail 6 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request header complete 6 ' + JSON.stringify(res))
                  }
                })
              })

              // request   header 类型不对 空字符（无其他参数）
              Button("空字符").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: 'https://www.huawei.com',
                  header:'',
                  success: (res) => {
                    console.log('[AdvancedAPI] request header success 7 ' + res.data)
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request header fail 7 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request header complete 7 ' + JSON.stringify(res))
                  }
                })
              })

              // request   header 类型不对 undefined（无其他参数）
              Button("undefined").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: 'https://www.huawei.com',
                  header:undefined,
                  success: (res) => {
                    console.log('[AdvancedAPI] request header success 8 ' + res.data)
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request header fail 8 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request header complete 8 ' + JSON.stringify(res))
                  }
                })
              })
            }
          }

          ListItem(){
            Column ({ space: 10 }) {
              // request   method 正常传参 GET String类--
              Button("method 有效值 GET").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: 'https://www.huawei.com',
                  method:'GET',
                  success: (res) => {
                    console.log('[AdvancedAPI] request method success 0' + res.data)
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request method fail 0 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request method complete 0 ' + JSON.stringify(res))
                  }
                })
              })

              // request   method 正常传参  POST String类--
              Button("method 有效值 POST ").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: 'https://www.huawei.com',
                  method:'POST',
                  success: (res) => {
                    console.log('[AdvancedAPI] request method success 1' + 111111)
                    console.log('[AdvancedAPI] request method success 1 ' + res.data) // 内容太长时无法打印
                    console.log('[AdvancedAPI] request method success 1' + res.statusCode) // 内容太长时无法打印
                    console.log('[AdvancedAPI] request method success 1 ' + res.header) // 内容太长时无法打印
                    console.log('[AdvancedAPI] request method success 1' + res.cookies) // 内容太长时无法打印
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request method fail 1 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request method complete 1 ' + JSON.stringify(res))
                  }
                })
              })
              // request   method PUT 正常传参 String类--

              Button("method 有效值 PUT ").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: 'https://www.huawei.com',
                  method:'PUT',
                  success: (res) => {
                    console.log('[AdvancedAPI] request method success 2' + 22222)
                    console.log('[AdvancedAPI] request method success 22' + res.data) // 内容太长时无法打印
                    console.log('[AdvancedAPI] request method success 222' + res.statusCode) // 内容太长时无法打印
                    console.log('[AdvancedAPI] request method success 2222' + res.header) // 内容太长时无法打印
                    console.log('[AdvancedAPI] request method success 22222' + res.cookies) // 内容太长时无法打印
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request method fail 2 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request method complete 2 ' + JSON.stringify(res))
                  }
                })
              })
              // request   method 正常传参  DELETE String类--

              Button("method 有效值 DELETE").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: 'https://www.huawei.com',
                  method:'DELETE',
                  success: (res) => {
                    console.log('[AdvancedAPI] request method success 3' + res.data)
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request method fail 3 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request method complete 3 ' + JSON.stringify(res))
                  }
                })
              })

              // request   method 正常传参 HEAD String类--
              Button("method 有效值 HEAD").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: 'https://www.huawei.com',
                  method:'HEAD',
                  success: (res) => {
                    console.log('[AdvancedAPI] request method success 4' + res.data)
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request method fail 4 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request method complete 4 ' + JSON.stringify(res))
                  }
                })
              })

              // request   method 正常传参 OPTIONS String类--
              Button("method 有效值 OPTIONS").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: 'https://www.huawei.com',
                  method:'OPTIONS',
                  success: (res) => {
                    console.log('[AdvancedAPI] request method success 5' + res.data)
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request method fail 5 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request method complete 5 ' + JSON.stringify(res))
                  }
                })
              })

              // request   method 正常传参 CONNECT String类--   app不支持
              Button("method 有效值 CONNECT").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: 'https://www.huawei.com',
                  method:'CONNECT',
                  success: (res) => {
                    console.log('[AdvancedAPI] request method success 6' + 66666)
                    console.log('[AdvancedAPI] request method success 6 ' + res.data) // 内容太长时无法打印
                    console.log('[AdvancedAPI] request method success 66' + res.statusCode) // 内容太长时无法打印
                    console.log('[AdvancedAPI] request method success 666 ' + res.header) // 内容太长时无法打印
                    console.log('[AdvancedAPI] request method success 6666' + res.cookies) // 内容太长时无法打印
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request method fail 6 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request method complete 6 ' + JSON.stringify(res))
                  }
                })
              })

              // request   method 正常传参 TRACE String类--   app不支持
              Button("method 有效值 TRACE").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: 'https://www.huawei.com',
                  method:'TRACE',
                  success: (res) => {
                    console.log('[AdvancedAPI] request method success 7' + res.data)
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request method fail 7 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request method complete 7 ' + JSON.stringify(res))
                  }
                })
              })

              // request   无此method参数（默认get）
              Button("无此method参数").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: 'https://www.huawei.com',
                  //                  method:'GET',
                  success: (res) => {
                    console.log('[AdvancedAPI] request method success 8' + res.data)
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request method fail 8 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request method complete 8 ' + JSON.stringify(res))
                  }
                })
              })

              // request   method 类型不对 number（无其他参数）
              Button("number").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: 'https://www.huawei.com',
                  method:666,
                  success: (res) => {
                    console.log('[AdvancedAPI] request method success 9' + res.data)
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request method fail 9 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request method complete 9 ' + JSON.stringify(res))
                  }
                })
              })

              // request   method 类型不对 boolean（无其他参数）
              Button("boolean").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: 'https://www.huawei.com',
                  method:false,
                  success: (res) => {
                    console.log('[AdvancedAPI] request method success 01' + res.data)
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request method fail 01 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request method complete 01 ' + JSON.stringify(res))
                  }
                })
              })

              // request   method 类型不对 object（无其他参数）
              Button("object").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: 'https://www.huawei.com',
                  method:{'name':'GET'},
                  success: (res) => {
                    console.log('[AdvancedAPI] request method success 02' + res.data)
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request method fail 02 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request method complete 02 ' + JSON.stringify(res))
                  }
                })
              })

              // request   method 类型不对 null（无其他参数）
              Button("null").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: 'https://www.huawei.com',
                  method:null,
                  success: (res) => {
                    console.log('[AdvancedAPI] request method success 03' + res.data)
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request method fail 03 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request method complete 03 ' + JSON.stringify(res))
                  }
                })
              })

              // request   method 类型不对 空字符（无其他参数）
              Button("空字符").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: 'https://www.huawei.com',
                  method:'',
                  success: (res) => {
                    console.log('[AdvancedAPI] request method success 04' + res.data)
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request method fail 04 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request method complete 04 ' + JSON.stringify(res))
                  }
                })
              })

              // request   method 类型不对 undefined（无其他参数）
              Button("undefined").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: 'https://www.huawei.com',
                  method:undefined,
                  success: (res) => {
                    console.log('[AdvancedAPI] request method success 05' + res.data)
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request method fail 05 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request method complete 05 ' + JSON.stringify(res))
                  }
                })
              })
            }
          }

          ListItem(){
            Column ({ space: 10 }) {
              // request   timeout 正常传参 Number类--有效网址（无其他参数）
              Button("timeout 正常传参").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: 'https://www.huawei.com',
                  timeout:6000,
                  success: (res) => {
                    console.log('[AdvancedAPI] request timeout success ' + res.data)
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request timeout fail ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request timeout complete ' + JSON.stringify(res))
                  }
                })
              })

              // request   无此timeout参数（默认60000ms）
              Button("无此timeout参数").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: 'https://www.huawei.com',
                  //                  timeout:6000,
                  success: (res) => {
                    console.log('[AdvancedAPI] request timeout success 1' + res.data)
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request timeout fail 1 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request timeout complete 1 ' + JSON.stringify(res))
                  }
                })
              })

              // request   timeout 类型不对 String（无其他参数）
              Button("number").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: 'https://www.huawei.com',
                  timeout:'test',
                  success: (res) => {
                    console.log('[AdvancedAPI] request timeout success 2' + res.data)
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request timeout fail 2' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request timeout complete 2' + JSON.stringify(res))
                  }
                })
              })

              // request   timeout 类型不对 boolean（无其他参数）
              Button("boolean").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: 'https://www.huawei.com',
                  timeout:false,
                  success: (res) => {
                    console.log('[AdvancedAPI] request timeout success 3' + res.data)
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request timeout fail 3' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request timeout complete 3' + JSON.stringify(res))
                  }
                })
              })

              // request   timeout 类型不对 object（无其他参数）
              Button("object").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: 'https://www.huawei.com',
                  timeout: { 'name':'test' },
                  success: (res) => {
                    console.log('[AdvancedAPI] request timeout success 4' + res.data)
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request timeout fail 4' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request timeout complete 4' + JSON.stringify(res))
                  }
                })
              })

              // request   timeout 类型不对 null（无其他参数）
              Button("null").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: 'https://www.huawei.com',
                  timeout:null,
                  success: (res) => {
                    console.log('[AdvancedAPI] request timeout success 5' + res.data)
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request timeout fail 5' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request timeout complete 5' + JSON.stringify(res))
                  }
                })
              })

              // request   timeout 类型不对 空字符（无其他参数）
              Button("空字符").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: 'https://www.huawei.com',
                  timeout:'',
                  success: (res) => {
                    console.log('[AdvancedAPI] request timeout success 6' + res.data)
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request timeout fail 6' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request timeout complete 6' + JSON.stringify(res))
                  }
                })
              })

              // request   timeout 类型不对 undefined（无其他参数）
              Button("undefined").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: 'https://www.huawei.com',
                  timeout:undefined,
                  success: (res) => {
                    console.log('[AdvancedAPI] request timeout success 7' + res.data)
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request timeout fail 7' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request timeout complete 7' + JSON.stringify(res))
                  }
                })
              })
            }
          }

          ListItem(){
            Column ({ space: 10 }) {
              // request   responseType 正常传参 String类
              Button("responseType 正常传参 text").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: 'https://www.huawei.com',
                  responseType:'text',
                  success: (res) => {
                    console.log('[AdvancedAPI] request responseType success 0' + res.data)
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request responseType fail 0' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request responseType complete 0' + JSON.stringify(res))
                  }
                })
              })

              // request   responseType 正常传参 String类
              Button("responseType 正常传参 arraybuffer").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: 'https://www.huawei.com',
                  responseType:'arraybuffer',
                  success: (res) => {
                    console.log('[AdvancedAPI] request responseType success 00' + res.data)
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request responseType fail 00' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request responseType complete 00' + JSON.stringify(res))
                  }
                })
              })

              // request   无此responseType参数（默认 text）
              Button("无此responseType参数").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: 'https://www.huawei.com',
                  //                  responseType:'text',
                  success: (res) => {
                    console.log('[AdvancedAPI] request responseType success 1' + res.data)
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request responseType fail 1' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request responseType complete 1' + JSON.stringify(res))
                  }
                })
              })

              // request   responseType类型不对 number（无其他参数）
              Button("number").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: 'https://www.huawei.com',
                  responseType:5599,
                  success: (res) => {
                    console.log('[AdvancedAPI] request responseType success 2' + res.data)
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request responseType fail 2' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request responseType complete 2' + JSON.stringify(res))
                  }
                })
              })

              // request   responseType 类型不对 boolean（无其他参数）
              Button("boolean").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: 'https://www.huawei.com',
                  responseType:false,
                  success: (res) => {
                    console.log('[AdvancedAPI] request responseType success 3' + res.data)
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request responseType fail 3' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request responseType complete 3' + JSON.stringify(res))
                  }
                })
              })

              // request   responseType 类型不对 object（无其他参数）
              Button("object").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: 'https://www.huawei.com',
                  responseType: { 'name':'text' },
                  success: (res) => {
                    console.log('[AdvancedAPI] request responseType success 4' + res.data)
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request responseType fail 4' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request responseType complete 4' + JSON.stringify(res))
                  }
                })
              })

              // request   responseType 类型不对 null（无其他参数）
              Button("null").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: 'https://www.huawei.com',
                  responseType:null,
                  success: (res) => {
                    console.log('[AdvancedAPI] request responseType success 5' + res.data)
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request responseType fail 5' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request responseType complete 5' + JSON.stringify(res))
                  }
                })
              })

              // request   responseType 类型不对 空字符（无其他参数）
              Button("空字符").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: 'https://www.huawei.com',
                  responseType:'',
                  success: (res) => {
                    console.log('[AdvancedAPI] request responseType success 6' + res.data)
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request responseType fail 6' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request responseType complete 6' + JSON.stringify(res))
                  }
                })
              })

              // request   responseType 类型不对 undefined（无其他参数）
              Button("undefined").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: 'https://www.huawei.com',
                  responseType:undefined,
                  success: (res) => {
                    console.log('[AdvancedAPI] request responseType success 7' + res.data)
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request responseType fail 7' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request responseType complete 7' + JSON.stringify(res))
                  }
                })
              })
            }
          }

          ListItem(){
            Column ({ space: 10 }) {
              // request   sslVerify 正常传参 boolean--true（无其他参数）
              Button("sslVerify 正常传参true").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: 'https://www.huawei.com',
                  sslVerify:true,
                  success: (res) => {
                    console.log('[AdvancedAPI] request sslVerify success ' + res.data)
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request sslVerify fail ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request sslVerify complete ' + JSON.stringify(res))
                  }
                })
              })

              // request   sslVerify 正常传参  boolean--false（无其他参数）
              Button("sslVerify 正常传参").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: 'https://www.huawei.com',
                  sslVerify:false,
                  success: (res) => {
                    console.log('[AdvancedAPI] request sslVerify success 0' + res.data)
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request sslVerify fail 0' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request sslVerify complete 0' + JSON.stringify(res))
                  }
                })
              })

              // request   sslVerify 无此参数--上面已验证，无需重复
              // request   sslVerify 类型不对 number（无其他参数）
              Button("类型不对 number").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: 'https://www.huawei.com',
                  sslVerify:5555,
                  success: (res) => {
                    console.log('[AdvancedAPI] request sslVerify success 1' + res.data)
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request sslVerify fail 1' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request sslVerify complete 1' + JSON.stringify(res))
                  }
                })
              })

              // request   sslVerify 类型不对 string（无其他参数）
              Button("无此sslVerify参数").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: 'https://www.huawei.com',
                  sslVerify:'test',
                  success: (res) => {
                    console.log('[AdvancedAPI] request sslVerify success 2' + res.data)
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request sslVerify fail 2' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request sslVerify complete 2' + JSON.stringify(res))
                  }
                })
              })

              // request   sslVerify 类型不对 null（无其他参数）
              Button("null").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: 'https://www.huawei.com',
                  sslVerify:null,
                  success: (res) => {
                    console.log('[AdvancedAPI] request sslVerify success 3' + res.data)
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request sslVerify fail 3' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request sslVerify complete 3' + JSON.stringify(res))
                  }
                })
              })

              // request   sslVerify 类型不对 空字符（无其他参数）
              Button("空字符").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: 'https://www.huawei.com',
                  sslVerify:'',
                  success: (res) => {
                    console.log('[AdvancedAPI] request sslVerify success 4' + res.data)
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request sslVerify fail 4' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request sslVerify complete 4' + JSON.stringify(res))
                  }
                })
              })

              // request   sslVerify 类型不对 undefined（无其他参数）
              Button("undefined").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: 'https://www.huawei.com',
                  sslVerify:undefined,
                  success: (res) => {
                    console.log('[AdvancedAPI] request sslVerify success 5' + res.data)
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request sslVerify fail 5' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request sslVerify complete 5' + JSON.stringify(res))
                  }
                })
              })

              // request   sslVerify 类型不对 object（无其他参数）
              Button("object").width(300).onClick(()=>{
                // @ts-ignore
                as.request({
                  url: 'https://www.huawei.com',
                  sslVerify: { 'name':'test' },
                  success: (res) => {
                    console.log('[AdvancedAPI] request sslVerify success 6' + res.data)
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request sslVerify fail 6' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request sslVerify complete 6' + JSON.stringify(res))
                  }
                })
              })
            }
          }

          ListItem(){
            Text("requestTask").fontSize(20).fontWeight(FontWeight.Bold)
          }
          ListItem(){
            Column ({ space: 10 }){
              Button("abort").width(300).onClick(()=> {
                // @ts-ignore
                this.requestTask = as.request({
                  url: 'https://www.google.com',
                  data: { text: 'as.request' },
                  header: { 'custom-header': 'hello' },
                  success: (res) => {
                    console.log('[AdvancedAPI] request success ' + res.data)
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request fail ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request complete ' + JSON.stringify(res))
                  }
                })
                // @ts-ignore
                this.requestTask.abort()
              })

              Button("onHeadersReceived").width(300).onClick(()=>{
                // @ts-ignore
                this.requestTask = as.request({
                  url: 'https://www.google.com',
                  data: { text: 'as.request' },
                  header: { 'custom-header': 'hello' },
                  success: (res) => {
                    console.log('[AdvancedAPI] request success ' + res.data)
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request fail ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request complete ' + JSON.stringify(res))
                  }
                })
                // @ts-ignore
                this.requestTask.onHeadersReceived(function (res) {
                  console.log('[AdvancedAPI] requestTask onHeadersReceived ：' + JSON.stringify(res))
                })
              })

              Button("offHeadersReceived").width(300).onClick(()=>{
                // @ts-ignore
                this.requestTask = as.request({
                  url: 'https://www.google.com',
                  data: { text: 'as.request' },
                  header: { 'custom-header': 'hello' },
                  success: (res) => {
                    console.log('[AdvancedAPI] request success ' + res.data)
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]request fail ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] request complete ' + JSON.stringify(res))
                  }
                })
                // @ts-ignore
                this.requestTask.onHeadersReceived(function (res) {
                  console.log('[AdvancedAPI] requestTask onHeadersReceived 2：' + JSON.stringify(res))
                })
                // @ts-ignore
                this.requestTask.offHeadersReceived()
              })
              }
          }
        }.alignListItem(ListItemAlign.Center)
      }
    }
  }
}