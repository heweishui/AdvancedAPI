@Entry
@Component
struct webSocket {
  scroller: Scroller = new Scroller()

  private connected = false;
  private connecting = false;
  private msg = false;
  private roomId = '';

  private progressCallback1 = (res) => {
    console.log('[AdvancedAPI] progress changed ' + JSON.stringify(res));
  };

  private progressCallback2 = () => {
    console.log("[AdvancedAPI] progress changed");
  };

  private headersCallback1 = (res) => {
    console.log('[AdvancedAPI] receive headers ' + JSON.stringify(res));
  };

  private headersCallback2 = () => {
    console.log("[AdvancedAPI] receive headers");
  };

  aboutToAppear() {

  }
  build() {
    Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center })  {
      Column({ space: 5 }) {
        List({ space: 20, }){
          ListItem(){
            Text("网络").fontSize(35)
          }
          ListItem(){
            Column({ space: 10 }) {
              Text("混合验证").fontSize(20).fontWeight(FontWeight.Bold)
              Button("连接webSocket服务").width(300).onClick(() => {
                // @ts-ignore
                as.connectSocket({
                  url: 'ws://websocket-echo.com',
                  success: (res) => {
                    console.log('[AdvancedAPI] webSocket connectSocket  success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] webSocket connectSocket  fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] webSocket connectSocket complete ' + JSON.stringify(res));
                  }
                })

                // @ts-ignore
                as.onSocketOpen((res) => {
                  console.log('[AdvancedAPI] webSocket onSocketOpen callback', res);
                })

                // @ts-ignore
                as.onSocketError(function (res) {
                  console.log('[AdvancedAPI] [AdvancedAPI] webSocket  onSocketError ' + JSON.stringify(res));
                })
              })

              Button("发送webSocket服务").width(300).onClick(() => {
                // @ts-ignore
                as.sendSocketMessage({
                  data: 'as.sendSocketMessage',
                  success: (res) => {
                    console.log('[AdvancedAPI]webSocket  sendSocketMessage data success 2 ' + res.data);
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]webSocket  sendSocketMessage data fail 2 ' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI]webSocket  sendSocketMessage data complete 2 ' + JSON.stringify(res));
                  }
                })

                // @ts-ignore
                as.onSocketMessage(function (res) {
                  console.log('[AdvancedAPI] [AdvancedAPI] webSocket  onSocketMessage ' + JSON.stringify(res));
                })
                // @ts-ignore
                as.onSocketError(function (res) {
                  console.log('[AdvancedAPI] [AdvancedAPI] webSocket  onSocketMessage ' + JSON.stringify(res));
                })
              })

              Button("关闭webSocket服务").width(300).onClick(() => {
                // @ts-ignore
                as.closeSocket({
                  code: 1000,
                  success: (res) => {
                    console.log('[AdvancedAPI] webSocket closeSocket code  success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] webSocket closeSocket code  fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] webSocket closeSocket code  complete ' + JSON.stringify(res));
                  }
                })

                // @ts-ignore
                as.onSocketError(function (res) {
                  console.log('[AdvancedAPI] [AdvancedAPI] webSocket  onSocketClose ' + JSON.stringify(res));
                })
                // @ts-ignore
                as.closeSocket(function (res) {
                  console.log('[AdvancedAPI] [AdvancedAPI] webSocket  closeSocket ' + JSON.stringify(res));
                })
              })
            }
          }

          //connectSocket
          ListItem(){
            Column({ space: 10 }) {
              Text("connectSocket").fontSize(20).fontWeight(FontWeight.Bold)
            }
          }
          //connectSocket -url
          ListItem(){
            Column({ space: 10 }) {
              Button("url 正常传参").width(300).onClick(() => {
                // @ts-ignore
                as.connectSocket({
                  url: 'ws://websocket-echo.com',
                  success: (res) => {
                    console.log('[AdvancedAPI] webSocket connectSocket url  success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] webSocket connectSocket url  fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] webSocket connectSocket url  complete ' + JSON.stringify(res));
                  }
                })
              })

              Button("url 无此参数").width(300).onClick(() => {
                // @ts-ignore
                as.connectSocket({
                  success: (res) => {
                    console.log('[AdvancedAPI] webSocket connectSocket url  success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] webSocket connectSocket url  fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] webSocket connectSocket url  complete ' + JSON.stringify(res));
                  }
                })
              })

              Button("url 无效网址String").width(300).onClick(() => {
                // @ts-ignore
                as.connectSocket({
                  url: 'test',
                  success: (res) => {
                    console.log('[AdvancedAPI] webSocket connectSocket url  success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] webSocket connectSocket url  fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] webSocket connectSocket url  complete ' + JSON.stringify(res));
                  }
                })
              })

              Button("url Number").width(300).onClick(() => {
                // @ts-ignore
                as.connectSocket({
                  url: 77777,
                  success: (res) => {
                    console.log('[AdvancedAPI] webSocket connectSocket url  success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] webSocket connectSocket url  fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] webSocket connectSocket url  complete ' + JSON.stringify(res));
                  }
                })
              })

              Button("url Object").width(300).onClick(() => {
                // @ts-ignore
                as.connectSocket({
                  url: {'name': 'ws://websocket-echo.com' },
                  success: (res) => {
                    console.log('[AdvancedAPI] webSocket connectSocket url  success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] webSocket connectSocket url  fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] webSocket connectSocket url  complete ' + JSON.stringify(res));
                  }
                })
              })

              Button("url Boolean").width(300).onClick(() => {
                // @ts-ignore
                as.connectSocket({
                  url: true,
                  success: (res) => {
                    console.log('[AdvancedAPI] webSocket connectSocket url  success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] webSocket connectSocket url  fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] webSocket connectSocket url  complete ' + JSON.stringify(res));
                  }
                })
              })

              Button("url null").width(300).onClick(() => {
                // @ts-ignore
                as.connectSocket({
                  url: null,
                  success: (res) => {
                    console.log('[AdvancedAPI] webSocket connectSocket url  success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] webSocket connectSocket url  fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] webSocket connectSocket url  complete ' + JSON.stringify(res));
                  }
                })
              })

              Button("url 空字符").width(300).onClick(() => {
                // @ts-ignore
                as.connectSocket({
                  url: '',
                  success: (res) => {
                    console.log('[AdvancedAPI] webSocket connectSocket url  success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] webSocket connectSocket url  fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] webSocket connectSocket url  complete ' + JSON.stringify(res));
                  }
                })
              })

              Button("url undefined").width(300).onClick(() => {
                // @ts-ignore
                as.connectSocket({
                  url: undefined,
                  success: (res) => {
                    console.log('[AdvancedAPI] webSocket connectSocket url  success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] webSocket connectSocket url  fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] webSocket connectSocket url  complete ' + JSON.stringify(res));
                  }
                })
              })
            }
          }
          //connectSocket-multiple
          ListItem(){
            Column({ space: 10 }) {
              //multiple无此参数上方已存在验证
              Button("multiple 正常传参-true").width(300).onClick(() => {
                // @ts-ignore
                as.connectSocket({
                  url : 'ws://websocket-echo.com',
                  multiple : true ,
                  success: (res) => {
                    console.log('[AdvancedAPI] webSocket connectSocket multiple  success 0' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] webSocket connectSocket multiple  fail 0' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] webSocket connectSocket multiple  complete 0' + JSON.stringify(res));
                  }
                })
              })

              Button("multiple 正常传参-false").width(300).onClick(() => {
                // @ts-ignore
                as.connectSocket({
                  url : 'ws://websocket-echo.com',
                  multiple : false ,
                  success: (res) => {
                    console.log('[AdvancedAPI] webSocket connectSocket multiple  success 1' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] webSocket connectSocket multiple  fail 1' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] webSocket connectSocket multiple  complete 1' + JSON.stringify(res));
                  }
                })
              })

              Button("multiple String").width(300).onClick(() => {
                // @ts-ignore
                as.connectSocket({
                  url : 'ws://websocket-echo.com',
                  multiple : 'test',
                  success: (res) => {
                    console.log('[AdvancedAPI] webSocket connectSocket multiple  success 2' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] webSocket connectSocket multiple  fail 2' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] webSocket connectSocket multiple  complete 2' + JSON.stringify(res));
                  }
                })
              })

              Button("multiple Number").width(300).onClick(() => {
                // @ts-ignore
                as.connectSocket({
                  url : 'ws://websocket-echo.com',
                  multiple : 77777,
                  success: (res) => {
                    console.log('[AdvancedAPI] webSocket connectSocket multiple  success 3' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] webSocket connectSocket multiple  fail 3' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] webSocket connectSocket multiple  complete 3' + JSON.stringify(res));
                  }
                })
              })

              Button("multiple Object").width(300).onClick(() => {
                // @ts-ignore
                as.connectSocket({
                  url : 'ws://websocket-echo.com',
                  multiple : {'name': 'test' },
                  success: (res) => {
                    console.log('[AdvancedAPI] webSocket connectSocket multiple  success 4' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] webSocket connectSocket multiple  fail 4' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] webSocket connectSocket multiple  complete 4' + JSON.stringify(res));
                  }
                })
              })

              Button("multiple null").width(300).onClick(() => {
                // @ts-ignore
                as.connectSocket({
                  url : 'ws://websocket-echo.com',
                  multiple : null,
                  success: (res) => {
                    console.log('[AdvancedAPI] webSocket connectSocket multiple  success 6' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] webSocket connectSocket multiple  fail 6' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] webSocket connectSocket multiple  complete 6' + JSON.stringify(res));
                  }
                })
              })

              Button("multiple 空字符").width(300).onClick(() => {
                // @ts-ignore
                as.connectSocket({
                  url : 'ws://websocket-echo.com',
                  multiple : '',
                  success: (res) => {
                    console.log('[AdvancedAPI] webSocket connectSocket multiple  success 7' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] webSocket connectSocket multiple  fail 7' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] webSocket connectSocket multiple  complete 7' + JSON.stringify(res));
                  }
                })
              })

              Button("multiple undefined").width(300).onClick(() => {
                // @ts-ignore
                as.connectSocket({
                  url : 'ws://websocket-echo.com',
                  multiple : undefined,
                  success: (res) => {
                    console.log('[AdvancedAPI] webSocket connectSocket multiple  success 8' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] webSocket connectSocket multiple  fail 8' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] webSocket connectSocket multiple  complete 8' + JSON.stringify(res));
                  }
                })
              })
            }
          }
          //connectSocket-header
          ListItem(){
            Column({ space: 10 }) {
              //header无此参数上方已存在验证
              Button("header Object 不设置 Referer").width(300).onClick(() => {
                // @ts-ignore
                as.connectSocket({
                  url : 'ws://websocket-echo.com',
                  header : {'content-type':'application/json'},
                  success: (res) => {
                    console.log('[AdvancedAPI] webSocket connectSocket header  success 0' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] webSocket connectSocket header  fail 0' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] webSocket connectSocket header  complete 0' + JSON.stringify(res));
                  }
                })
              })

              Button("header Object 设置 Referer").width(300).onClick(() => {
                // @ts-ignore
                as.connectSocket({
                  url : 'ws://websocket-echo.com',
                  header : {'Referer':'ws://'},
                  success: (res) => {
                    console.log('[AdvancedAPI] webSocket connectSocket header  success 1' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] webSocket connectSocket header  fail 1' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] webSocket connectSocket header  complete 1' + JSON.stringify(res));
                  }
                })
              })

              Button("header String").width(300).onClick(() => {
                // @ts-ignore
                as.connectSocket({
                  url : 'ws://websocket-echo.com',
                  header : 'test',
                  success: (res) => {
                    console.log('[AdvancedAPI] webSocket connectSocket header  success 2' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] webSocket connectSocket header  fail 2' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] webSocket connectSocket header  complete 2' + JSON.stringify(res));
                  }
                })
              })

              Button("header Number").width(300).onClick(() => {
                // @ts-ignore
                as.connectSocket({
                  url : 'ws://websocket-echo.com',
                  header : 77777,
                  success: (res) => {
                    console.log('[AdvancedAPI] webSocket connectSocket header  success 3' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] webSocket connectSocket header  fail 3' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] webSocket connectSocket header  complete 3' + JSON.stringify(res));
                  }
                })
              })

              Button("header Boolean").width(300).onClick(() => {
                // @ts-ignore
                as.connectSocket({
                  url : 'ws://websocket-echo.com',
                  header : true,
                  success: (res) => {
                    console.log('[AdvancedAPI] webSocket connectSocket header  success 5' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] webSocket connectSocket header  fail 5' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] webSocket connectSocket header  complete 5' + JSON.stringify(res));
                  }
                })
              })

              Button("header null").width(300).onClick(() => {
                // @ts-ignore
                as.connectSocket({
                  url : 'ws://websocket-echo.com',
                  header : null,
                  success: (res) => {
                    console.log('[AdvancedAPI] webSocket connectSocket header  success 6' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] webSocket connectSocket header  fail 6' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] webSocket connectSocket header  complete 6' + JSON.stringify(res));
                  }
                })
              })

              Button("header 空字符").width(300).onClick(() => {
                // @ts-ignore
                as.connectSocket({
                  url : 'ws://websocket-echo.com',
                  header : '',
                  success: (res) => {
                    console.log('[AdvancedAPI] webSocket connectSocket header  success 7' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] webSocket connectSocket header  fail 7' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] webSocket connectSocket header  complete 7' + JSON.stringify(res));
                  }
                })
              })

              Button("header undefined").width(300).onClick(() => {
                // @ts-ignore
                as.connectSocket({
                  url : 'ws://websocket-echo.com',
                  header : undefined,
                  success: (res) => {
                    console.log('[AdvancedAPI] webSocket connectSocket header  success 8' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] webSocket connectSocket header  fail 8' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] webSocket connectSocket header  complete 8' + JSON.stringify(res));
                  }
                })
              })
            }
          }
          //connectSocket-method   鸿蒙不支持此参数
          //connectSocket-protocols  鸿蒙不支持此参数
          //method 和 protocols参数设置不影响接口回调
          ListItem(){
            Column({ space: 10 }) {
              Button("method").width(300).onClick(() => {
                // @ts-ignore
                as.connectSocket({
                  url: 'ws://websocket-echo.com',
                  method: 'POST',
                  success: (res) => {
                    console.log('[AdvancedAPI] webSocket connectSocket method  success 0' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] webSocket connectSocket method  fail 0' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] webSocket connectSocket method  complete 0' + JSON.stringify(res));
                  }
                })
              })

              Button("protocols").width(300).onClick(() => {
                // @ts-ignore
                as.connectSocket({
                  url: 'ws://websocket-echo.com',
                  protocols: ['protocol1'],
                  success: (res) => {
                    console.log('[AdvancedAPI] webSocket connectSocket protocols  success 1' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] webSocket connectSocket protocols  fail 1' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] webSocket connectSocket protocols  complete 1' + JSON.stringify(res));
                  }
                })
              })
            }
          }

          //onSocketOpen      CALLBACK 返回参数: header鸿蒙不支持，鸿蒙只返回状态信息
          ListItem(){
            Column({ space: 10 }) {
              Text("onSocketOpen").fontSize(20).fontWeight(FontWeight.Bold)
              Button("callback").width(300).onClick(() => {
                // @ts-ignore
                as.onSocketOpen(function (res) {
                  console.log('[AdvancedAPI] [AdvancedAPI] webSocket  onSocketOpen ' + JSON.stringify(res));
                })
              })
            }
          }

          //onSocketError
          ListItem(){
            Column({ space: 10 }) {
              Text("onSocketError").fontSize(20).fontWeight(FontWeight.Bold)
              Button("callback").width(300).onClick(() => {
                // @ts-ignore
                as.onSocketError(function (res) {
                  console.log('[AdvancedAPI] [AdvancedAPI] webSocket  onSocketError ' + JSON.stringify(res));
                })
              })
            }
          }

          //sendSocketMessage
          ListItem(){
            Column({ space: 10 }) {
              Text("sendSocketMessage").fontSize(20).fontWeight(FontWeight.Bold)
              //data 正常传参 String类
              Button("data 正常传参 String").width(300).onClick(()=>{
                // @ts-ignore
                as.sendSocketMessage({
                  data: 'as.sendSocketMessage',
                  success: (res) => {
                    console.log('[AdvancedAPI]webSocket  sendSocketMessage data success 2 ' + res.data);
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]webSocket  sendSocketMessage data fail 2 ' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI]webSocket  sendSocketMessage data complete 2 ' + JSON.stringify(res));
                  }
                })
              })

              //data 正常传参 ArrayBuffer
              Button("data 正常传参 ArrayBuffer").width(300).onClick(()=>{
                // @ts-ignore
                as.sendSocketMessage({
                  data: {
                    text: 'as.sendSocketMessage'
                  },
                  success: (res) => {
                    console.log('[AdvancedAPI]webSocket  sendSocketMessage data success 3 ' + res.data);
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]webSocket  sendSocketMessage data fail 3 ' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI]webSocket  sendSocketMessage data complete 3 ' + JSON.stringify(res));
                  }
                })
              })

              //sendSocketMessage无此data参数（无其他参数）
              Button("无此data参数").width(300).onClick(()=>{
                // @ts-ignore
                as.sendSocketMessage({
                  //                  data: {
                  //                    text: 'as.sendSocketMessage'
                  //                  },
                  success: (res) => {
                    console.log('[AdvancedAPI]webSocket  sendSocketMessage data success 4 ' + res.data);
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]webSocket  sendSocketMessage data fail 4 ' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI]webSocket  sendSocketMessage data complete 4 ' + JSON.stringify(res));
                  }
                })
              })

              //data 类型不对 Object
              Button("data  Object").width(300).onClick(()=>{
                // @ts-ignore
                as.sendSocketMessage({
                  data: {
                    text: 'as.sendSocketMessage'
                  },
                  success: (res) => {
                    console.log('[AdvancedAPI]webSocket  sendSocketMessage data success 1 ' + res.data);
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]webSocket  sendSocketMessage data fail 1 ' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI]webSocket  sendSocketMessage data complete 1 ' + JSON.stringify(res));
                  }
                })
              })

              //data 类型不对 number（无其他参数）
              Button("number").width(300).onClick(()=>{
                // @ts-ignore
                as.sendSocketMessage({
                  data: 7788,
                  success: (res) => {
                    console.log('[AdvancedAPI]webSocket  sendSocketMessage data success 5 ' + res.data);
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]webSocket  sendSocketMessage data fail 5 ' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI]webSocket  sendSocketMessage data complete 5 ' + JSON.stringify(res));
                  }
                })
              })

              //data 类型不对 boolean（无其他参数）
              Button("boolean").width(300).onClick(()=>{
                // @ts-ignore
                as.sendSocketMessage({
                  data: true,
                  success: (res) => {
                    console.log('[AdvancedAPI]webSocket  sendSocketMessage data success 6 ' + res.data);
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]webSocket  sendSocketMessage data fail 6 ' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI]webSocket  sendSocketMessage data complete 6 ' + JSON.stringify(res));
                  }
                })
              })

              //data 类型不对 null（无其他参数）
              Button("null").width(300).onClick(()=>{
                // @ts-ignore
                as.sendSocketMessage({
                  data: null,
                  success: (res) => {
                    console.log('[AdvancedAPI]webSocket  sendSocketMessage data success 7 ' + res.data);
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]webSocket  sendSocketMessage data fail 7 ' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI]webSocket  sendSocketMessage data complete 7 ' + JSON.stringify(res));
                  }
                })
              })

              //data 类型不对 空字符（无其他参数）
              Button("空字符").width(300).onClick(()=>{
                // @ts-ignore
                as.sendSocketMessage({
                  data: '',
                  success: (res) => {
                    console.log('[AdvancedAPI]webSocket  sendSocketMessage data success 8 ' + res.data);
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]webSocket  sendSocketMessage data fail 8 ' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI]webSocket  sendSocketMessage data complete 8 ' + JSON.stringify(res));
                  }
                })
              })

              //data 类型不对 undefined（无其他参数）
              Button("undefined").width(300).onClick(()=>{
                // @ts-ignore
                as.sendSocketMessage({
                  data: undefined,
                  success: (res) => {
                    console.log('[AdvancedAPI]webSocket  sendSocketMessage data success 9 ' + res.data);
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]webSocket  sendSocketMessage data fail 9 ' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI]webSocket  sendSocketMessage data complete 9 ' + JSON.stringify(res));
                  }
                })
              })
            }
          }

          //onSocketMessage
          ListItem(){
            Column({ space: 10 }) {
              Text("onSocketMessage").fontSize(20).fontWeight(FontWeight.Bold)
              Button("callback").width(300).onClick(() => {
                // @ts-ignore
                as.onSocketMessage(function (res) {
                  console.log('[AdvancedAPI] [AdvancedAPI] webSocket  onSocketMessage ' + JSON.stringify(res));
                })
              })
            }
          }

          //closeSocket
          ListItem(){
            Column({ space: 10 }) {
              Text("closeSocket").fontSize(20).fontWeight(FontWeight.Bold)
            }
          }

          //closeSocket -code
          ListItem(){
            Column({ space: 10 }) {
              Button("code 正常传参Number").width(300).onClick(() => {
                // @ts-ignore
                as.closeSocket({
                  code: 1000,
                  success: (res) => {
                    console.log('[AdvancedAPI] webSocket closeSocket code  success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] webSocket closeSocket code  fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] webSocket closeSocket code  complete ' + JSON.stringify(res));
                  }
                })
              })

              Button("code 正常传参Number").width(300).onClick(() => {
                // @ts-ignore
                as.closeSocket({
                  code: 1020,
                  success: (res) => {
                    console.log('[AdvancedAPI] webSocket closeSocket code  success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] webSocket closeSocket code  fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] webSocket closeSocket code  complete ' + JSON.stringify(res));
                  }
                })
              })

              Button("code 无此参数").width(300).onClick(() => {
                // @ts-ignore
                as.closeSocket({
                  success: (res) => {
                    console.log('[AdvancedAPI] webSocket closeSocket code  success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] webSocket closeSocket code  fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] webSocket closeSocket code  complete ' + JSON.stringify(res));
                  }
                })
              })

              Button("code String").width(300).onClick(() => {
                // @ts-ignore
                as.closeSocket({
                  code: 'test',
                  success: (res) => {
                    console.log('[AdvancedAPI] webSocket closeSocket code  success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] webSocket closeSocket code  fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] webSocket closeSocket code  complete ' + JSON.stringify(res));
                  }
                })
              })

              Button("code Object").width(300).onClick(() => {
                // @ts-ignore
                as.closeSocket({
                  code: {'name': 'ws://websocket-echo.com' },
                  success: (res) => {
                    console.log('[AdvancedAPI] webSocket closeSocket code  success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] webSocket closeSocket code  fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] webSocket closeSocket code  complete ' + JSON.stringify(res));
                  }
                })
              })

              Button("code Boolean").width(300).onClick(() => {
                // @ts-ignore
                as.closeSocket({
                  code: true,
                  success: (res) => {
                    console.log('[AdvancedAPI] webSocket closeSocket code  success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] webSocket closeSocket code  fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] webSocket closeSocket code  complete ' + JSON.stringify(res));
                  }
                })
              })

              Button("code null").width(300).onClick(() => {
                // @ts-ignore
                as.closeSocket({
                  code: null,
                  success: (res) => {
                    console.log('[AdvancedAPI] webSocket closeSocket code  success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] webSocket closeSocket code  fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] webSocket closeSocket code  complete ' + JSON.stringify(res));
                  }
                })
              })

              Button("code 空字符").width(300).onClick(() => {
                // @ts-ignore
                as.closeSocket({
                  code: '',
                  success: (res) => {
                    console.log('[AdvancedAPI] webSocket closeSocket code  success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] webSocket closeSocket code  fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] webSocket closeSocket code  complete ' + JSON.stringify(res));
                  }
                })
              })

              Button("code undefined").width(300).onClick(() => {
                // @ts-ignore
                as.closeSocket({
                  code: undefined,
                  success: (res) => {
                    console.log('[AdvancedAPI] webSocket closeSocket code  success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] webSocket closeSocket code  fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] webSocket closeSocket code  complete ' + JSON.stringify(res));
                  }
                })
              })
            }
          }

          //closeSocket -reason
          ListItem(){
            Column({ space: 10 }) {
              Button("reason 正常传参String").width(300).onClick(() => {
                // @ts-ignore
                as.closeSocket({
                  reason: '0xED 0x80-0x9F 0x80-0xBF',
                  success: (res) => {
                    console.log('[AdvancedAPI] webSocket closeSocket reason  success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] webSocket closeSocket reason  fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] webSocket closeSocket reason  complete ' + JSON.stringify(res));
                  }
                })
              })

              Button("reason 无此参数").width(300).onClick(() => {
                // @ts-ignore
                as.closeSocket({
                  success: (res) => {
                    console.log('[AdvancedAPI] webSocket closeSocket reason  success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] webSocket closeSocket reason  fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] webSocket closeSocket reason  complete ' + JSON.stringify(res));
                  }
                })
              })

              Button("reason 超出String").width(300).onClick(() => {
                // @ts-ignore
                as.closeSocket({
                  reason: '0xED 0x80-0x9F 0x80-0xBF 0xED 0x80-0x9F 0x80-0xBF 0xED 0x80-0x9F 0x80-0xBF 0xED 0x80-0x9F 0x80-0xBF0xED 0x80-0x9F 0x80-0xBF 0xED 0x80-0x9F 0x80-0xBF',
                  success: (res) => {
                    console.log('[AdvancedAPI] webSocket closeSocket reason  success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] webSocket closeSocket reason  fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] webSocket closeSocket reason  complete ' + JSON.stringify(res));
                  }
                })
              })

              Button("reason Number").width(300).onClick(() => {
                // @ts-ignore
                as.closeSocket({
                  reason: 77777,
                  success: (res) => {
                    console.log('[AdvancedAPI] webSocket closeSocket reason  success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] webSocket closeSocket reason  fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] webSocket closeSocket reason  complete ' + JSON.stringify(res));
                  }
                })
              })

              Button("reason Object").width(300).onClick(() => {
                // @ts-ignore
                as.closeSocket({
                  reason: {'name': 'ws://websocket-echo.com' },
                  success: (res) => {
                    console.log('[AdvancedAPI] webSocket closeSocket reason  success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] webSocket closeSocket reason  fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] webSocket closeSocket reason  complete ' + JSON.stringify(res));
                  }
                })
              })

              Button("reason Boolean").width(300).onClick(() => {
                // @ts-ignore
                as.closeSocket({
                  reason: true,
                  success: (res) => {
                    console.log('[AdvancedAPI] webSocket closeSocket reason  success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] webSocket closeSocket reason  fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] webSocket closeSocket reason  complete ' + JSON.stringify(res));
                  }
                })
              })

              Button("reason null").width(300).onClick(() => {
                // @ts-ignore
                as.closeSocket({
                  reason: null,
                  success: (res) => {
                    console.log('[AdvancedAPI] webSocket closeSocket reason  success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] webSocket closeSocket reason  fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] webSocket closeSocket reason  complete ' + JSON.stringify(res));
                  }
                })
              })

              Button("reason 空字符").width(300).onClick(() => {
                // @ts-ignore
                as.closeSocket({
                  reason: '',
                  success: (res) => {
                    console.log('[AdvancedAPI] webSocket closeSocket reason  success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] webSocket closeSocket reason  fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] webSocket closeSocket reason  complete ' + JSON.stringify(res));
                  }
                })
              })

              Button("reason undefined").width(300).onClick(() => {
                // @ts-ignore
                as.closeSocket({
                  reason: undefined,
                  success: (res) => {
                    console.log('[AdvancedAPI] webSocket closeSocket reason  success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] webSocket closeSocket reason  fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] webSocket closeSocket reason  complete ' + JSON.stringify(res));
                  }
                })
              })
            }
          }

          //onSocketClose
          ListItem(){
            Column({ space: 10 }) {
              Text("onSocketClose").fontSize(20).fontWeight(FontWeight.Bold)
              Button("callback").width(300).onClick(() => {
                // @ts-ignore
                as.onSocketError(function (res) {
                  console.log('[AdvancedAPI] [AdvancedAPI] webSocket  onSocketClose ' + JSON.stringify(res));
                })
              })
            }
          }
        }.alignListItem(ListItemAlign.Center)
      }
    }
  }
}