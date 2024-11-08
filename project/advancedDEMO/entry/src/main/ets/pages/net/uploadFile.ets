import File from '@system.file';
@Entry
@Component
struct uploadFile {
  scroller: Scroller = new Scroller()

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
            Text("as.uploadFile").fontSize(20).fontWeight(FontWeight.Bold)
          }

          //url String 参数  --验证ok
          ListItem(){
            Column ({ space: 10 }) {
              // uploadFile   url 正常传参 String类
              Button("url 正常传参  + filePath + name").width(300).onClick(()=>{
                // @ts-ignore
                as.uploadFile({
                  url: 'https://unidemo.dcloud.net.cn/upload',
                  name: 'file',
                  filePath: 'internal://cache/logo.png',
                  success: (res) => {
                    console.log('[AdvancedAPI] uploadFile url success0 ' + res.data)
                    console.log('[AdvancedAPI] uploadFile url success0 ' + res.statusCode)
                    console.log('[AdvancedAPI] uploadFile url success0 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]uploadFile url fail0 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] uploadFile url complete0 ' + JSON.stringify(res))
                  }
                })
              })

              // uploadFile   url 正常传参 String类
              Button("url 正常传参 无效网址 + filePath + name").width(300).onClick(()=>{
                // @ts-ignore
                as.uploadFile({
                  url: 'http://test',
                  name: 'file',
                  filePath: 'internal://cache/logo.png',
                  success: (res) => {
                    console.log('[AdvancedAPI] uploadFile url success1 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]uploadFile url fail1 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] uploadFile url complete1 ' + JSON.stringify(res))
                  }
                })
              })

              // uploadFile   无此url参数（无其他参数）
              Button("无此任何参数").width(300).onClick(()=>{
                // @ts-ignore
                as.uploadFile({
                  // url: 'https://www.huawei.com',
                  // name: 'file',
                  // filePath: 'internal://cache/logo.png',
                  success: (res) => {
                    console.log('[AdvancedAPI] uploadFile url success22 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]uploadFile url fail22 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] uploadFile url complete22 ' + JSON.stringify(res))
                  }
                })
              })

              Button("无此url参数 + filePath + name").width(300).onClick(()=>{
                // @ts-ignore
                as.uploadFile({
                  // url: 'https://www.huawei.com',
                  name: 'file',
                  filePath: 'internal://cache/logo.png',
                  success: (res) => {
                    console.log('[AdvancedAPI] uploadFile url success2 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]uploadFile url fail2 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] uploadFile url complete2 ' + JSON.stringify(res))
                  }
                })
              })

              // uploadFile   url 类型不对 number
              Button("number + filePath + name").width(300).onClick(()=>{
                // @ts-ignore
                as.uploadFile({
                  url: 7788,
                  name: 'file',
                  filePath: 'internal://cache/logo.png',
                  success: (res) => {
                    console.log('[AdvancedAPI] uploadFile url success3 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]uploadFile url fail 3' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] uploadFile url complete3 ' + JSON.stringify(res))
                  }
                })
              })

              // uploadFile   url 类型不对 boolean（无其他参数）
              Button("boolean + filePath + name").width(300).onClick(()=>{
                // @ts-ignore
                as.uploadFile({
                  url: false,
                  name: 'file',
                  filePath: 'internal://cache/logo.png',
                  success: (res) => {
                    console.log('[AdvancedAPI] uploadFile url success4 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]uploadFile url fail4 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] uploadFile url complete4 ' + JSON.stringify(res))
                  }
                })
              })

              // uploadFile   url 类型不对 object（无其他参数）
              Button("object + filePath + name").width(300).onClick(()=>{
                // @ts-ignore
                as.uploadFile({
                  url: { 'name':'test' },
                  name: 'file',
                  filePath: 'internal://cache/logo.png',
                  success: (res) => {
                    console.log('[AdvancedAPI] uploadFile url success5 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]uploadFile url fail5 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] uploadFile url complete5 ' + JSON.stringify(res))
                  }
                })
              })

              // uploadFile   url 类型不对 null（无其他参数）
              Button("null + filePath + name").width(300).onClick(()=>{
                // @ts-ignore
                as.uploadFile({
                  url: null,
                  name: 'file',
                  filePath: 'internal://cache/logo.png',
                  success: (res) => {
                    console.log('[AdvancedAPI] uploadFile url success6 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]uploadFile url fail6 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] uploadFile url complete6 ' + JSON.stringify(res))
                  }
                })
              })

              // uploadFile   url 类型不对 空字符（无其他参数）
              Button("空字符 + filePath + name").width(300).onClick(()=>{
                // @ts-ignore
                as.uploadFile({
                  url: '',
                  name: 'file',
                  filePath: 'internal://cache/logo.png',
                  success: (res) => {
                    console.log('[AdvancedAPI] uploadFile url success7 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]uploadFile url fail7 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] uploadFile url complete7 ' + JSON.stringify(res))
                  }
                })
              })

              // uploadFile   url 类型不对 undefined（无其他参数）
              Button("undefined + filePath + name").width(300).onClick(()=>{
                // @ts-ignore
                as.uploadFile({
                  url: undefined,
                  name: 'file',
                  filePath: 'internal://cache/logo.png',
                  success: (res) => {
                    console.log('[AdvancedAPI] uploadFile url success8 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]uploadFile url fail8 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] uploadFile url complete8 ' + JSON.stringify(res))
                  }
                })
              })
            }
          }
          //files Array 参数
          ListItem(){
            Column ({ space: 10 }) {
              // uploadFile   files 正常传参 Array类
              Button("files 正常传参 多个 + url + name").width(300).onClick(()=>{
                // @ts-ignore
                as.uploadFile({
                  url: 'https://unidemo.dcloud.net.cn/upload',
                  name: 'file',
                  files:['','',''],
                  success: (res) => {
                    console.log('[AdvancedAPI] uploadFile files success0 ' + res.data)
                    console.log('[AdvancedAPI] uploadFile files success0 ' + res.statusCode)
                    console.log('[AdvancedAPI] uploadFile files success0 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]uploadFile files fail0 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] uploadFile files complete0 ' + JSON.stringify(res))
                  }
                })
              })

              // uploadFile   files 正常传参 Array类
              Button("files 正常传参 单个  + url + name").width(300).onClick(()=>{
                const myFile = new File();
                // @ts-ignore
                as.uploadFile({
                  files:[{
                    'name':'test',
                    'file': myFile,
                    'uri':'internal://cache/logo.png'
                  }],
                  url: 'https://unidemo.dcloud.net.cn/upload',
                  name: 'file',
                  success: (res) => {
                    console.log('[AdvancedAPI] uploadFile files success1 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]uploadFile files fail1 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] uploadFile files complete1 ' + JSON.stringify(res))
                  }
                })
              })

              // uploadFile   无此url参数（无其他参数）
              Button("无此files参数 + url + name").width(300).onClick(()=>{
                // @ts-ignore
                as.uploadFile({
                  // files:'https://www.huawei.com',
                  url: 'https://unidemo.dcloud.net.cn/upload',
                  // name: 'file',
                  success: (res) => {
                    console.log('[AdvancedAPI] uploadFile files success2 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]uploadFile files fail2 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] uploadFile files complete2 ' + JSON.stringify(res))
                  }
                })
              })

              // uploadFile   files 类型不对 String
              Button("String + url + name").width(300).onClick(()=>{
                // @ts-ignore
                as.uploadFile({
                  files:"test",
                  url: 'https://unidemo.dcloud.net.cn/upload',
                  name: 'file',
                  success: (res) => {
                    console.log('[AdvancedAPI] uploadFile files success3 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]uploadFile files fail 3' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] uploadFile files complete3 ' + JSON.stringify(res))
                  }
                })
              })

              // uploadFile   files 类型不对 number
              Button("number + url + name").width(300).onClick(()=>{
                // @ts-ignore
                as.uploadFile({
                  files:7788,
                  url: 'https://unidemo.dcloud.net.cn/upload',
                  name: 'file',
                  success: (res) => {
                    console.log('[AdvancedAPI] uploadFile files success3 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]uploadFile files fail 3' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] uploadFile files complete3 ' + JSON.stringify(res))
                  }
                })
              })

              // uploadFile   files 类型不对 boolean（无其他参数）
              Button("boolean + url + name").width(300).onClick(()=>{
                // @ts-ignore
                as.uploadFile({
                  files:false,
                  url: 'https://unidemo.dcloud.net.cn/upload',
                  name: 'file',
                  success: (res) => {
                    console.log('[AdvancedAPI] uploadFile files success4 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]uploadFile files fail4 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] uploadFile files complete4 ' + JSON.stringify(res))
                  }
                })
              })

              // uploadFile   files 类型不对 object（无其他参数）
              Button("object + url + name").width(300).onClick(()=>{
                // @ts-ignore
                as.uploadFile({
                  files:{ 'name':'test' },
                  url: 'https://unidemo.dcloud.net.cn/upload',
                  name: 'file',
                  success: (res) => {
                    console.log('[AdvancedAPI] uploadFile files success5 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]uploadFile files fail5 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] uploadFile files complete5 ' + JSON.stringify(res))
                  }
                })
              })

              // uploadFile   files 类型不对 null（无其他参数）
              Button("null + url + name").width(300).onClick(()=>{
                // @ts-ignore
                as.uploadFile({
                  files:null,
                  url: 'https://unidemo.dcloud.net.cn/upload',
                  name: 'file',
                  success: (res) => {
                    console.log('[AdvancedAPI] uploadFile files success6 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]uploadFile files fail6 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] uploadFile files complete6 ' + JSON.stringify(res))
                  }
                })
              })

              // uploadFile   files 类型不对 空字符（无其他参数）
              Button("空字符 + url + name").width(300).onClick(()=>{
                // @ts-ignore
                as.uploadFile({
                  files:'',
                  url: 'https://unidemo.dcloud.net.cn/upload',
                  name: 'file',
                  success: (res) => {
                    console.log('[AdvancedAPI] uploadFile files success7 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]uploadFile files fail7 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] uploadFile files complete7 ' + JSON.stringify(res))
                  }
                })
              })

              // uploadFile   files 类型不对 undefined（无其他参数）
              Button("undefined + url + name").width(300).onClick(()=>{
                // @ts-ignore
                as.uploadFile({
                  files:undefined,
                  url: 'https://unidemo.dcloud.net.cn/upload',
                  name: 'file',
                  success: (res) => {
                    console.log('[AdvancedAPI] uploadFile files success8 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]uploadFile files fail8 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] uploadFile files complete8 ' + JSON.stringify(res))
                  }
                })
              })
            }
          }
          //fileType String 参数 --鸿蒙不支持

          //file File 参数   --鸿蒙不支持

          //filePath String 参数  --文件路径在鸿蒙上需要为internal协议路径
          ListItem(){
            Column ({ space: 10 }) {
              // uploadFile   filePath 正常传参 Array类
              Button("filePath 正常传参  + url + name").width(300).onClick(()=>{
                // @ts-ignore
                as.uploadFile({
                  url: 'https://unidemo.dcloud.net.cn/upload',
                  name: 'file',
                  filePath: 'internal://cache/logo.png',
                  success: (res) => {
                    console.log('[AdvancedAPI] uploadFile filePath success0 ' + res.data)
                    console.log('[AdvancedAPI] uploadFile filePath success0 ' + res.statusCode)
                    console.log('[AdvancedAPI] uploadFile filePath success0 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]uploadFile filePath fail0 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] uploadFile filePath complete0 ' + JSON.stringify(res))
                  }
                })
              })

              // uploadFile   无此url参数（无其他参数）
              Button("无此filePath参数 + url + name").width(300).onClick(()=>{
                // @ts-ignore
                as.uploadFile({
                  // filePath:'https://www.huawei.com',
                  url: 'https://unidemo.dcloud.net.cn/upload',
                  name: 'file',
                  success: (res) => {
                    console.log('[AdvancedAPI] uploadFile filePath success2 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]uploadFile filePath fail2 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] uploadFile filePath complete2 ' + JSON.stringify(res))
                  }
                })
              })

              // uploadFile   filePath 类型不对 String
              Button("String + url + name").width(300).onClick(()=>{
                // @ts-ignore
                as.uploadFile({
                  filePath:"test",
                  url: 'https://unidemo.dcloud.net.cn/upload',
                  name: 'file',
                  success: (res) => {
                    console.log('[AdvancedAPI] uploadFile filePath success3 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]uploadFile filePath fail 3' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] uploadFile filePath complete3 ' + JSON.stringify(res))
                  }
                })
              })

              // uploadFile   filePath 类型不对 number
              Button("number + url + name").width(300).onClick(()=>{
                // @ts-ignore
                as.uploadFile({
                  filePath:7788,
                  url: 'https://unidemo.dcloud.net.cn/upload',
                  name: 'file',
                  success: (res) => {
                    console.log('[AdvancedAPI] uploadFile filePath success3 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]uploadFile filePath fail 3' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] uploadFile filePath complete3 ' + JSON.stringify(res))
                  }
                })
              })

              // uploadFile   filePath 类型不对 boolean（无其他参数）
              Button("boolean + url + name").width(300).onClick(()=>{
                // @ts-ignore
                as.uploadFile({
                  filePath:false,
                  url: 'https://unidemo.dcloud.net.cn/upload',
                  name: 'file',
                  success: (res) => {
                    console.log('[AdvancedAPI] uploadFile filePath success4 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]uploadFile filePath fail4 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] uploadFile filePath complete4 ' + JSON.stringify(res))
                  }
                })
              })

              // uploadFile   filePath 类型不对 object（无其他参数）
              Button("object + url + name").width(300).onClick(()=>{
                // @ts-ignore
                as.uploadFile({
                  filePath:{ 'name':'test' },
                  url: 'https://unidemo.dcloud.net.cn/upload',
                  name: 'file',
                  success: (res) => {
                    console.log('[AdvancedAPI] uploadFile filePath success5 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]uploadFile filePath fail5 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] uploadFile filePath complete5 ' + JSON.stringify(res))
                  }
                })
              })

              // uploadFile   filePath 类型不对 null（无其他参数）
              Button("null + url + name").width(300).onClick(()=>{
                // @ts-ignore
                as.uploadFile({
                  filePath:null,
                  url: 'https://unidemo.dcloud.net.cn/upload',
                  name: 'file',
                  success: (res) => {
                    console.log('[AdvancedAPI] uploadFile filePath success6 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]uploadFile filePath fail6 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] uploadFile filePath complete6 ' + JSON.stringify(res))
                  }
                })
              })

              // uploadFile   filePath 类型不对 空字符（无其他参数）
              Button("空字符 + url + name").width(300).onClick(()=>{
                // @ts-ignore
                as.uploadFile({
                  filePath: '',
                  url: 'https://unidemo.dcloud.net.cn/upload',
                  name: 'file',
                  success: (res) => {
                    console.log('[AdvancedAPI] uploadFile filePath success7 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]uploadFile filePath fail7 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] uploadFile filePath complete7 ' + JSON.stringify(res))
                  }
                })
              })

              // uploadFile   filePath 类型不对 undefined（无其他参数）
              Button("undefined + url + name").width(300).onClick(()=>{
                // @ts-ignore
                as.uploadFile({
                  filePath:undefined,
                  url: 'https://unidemo.dcloud.net.cn/upload',
                  name: 'file',
                  success: (res) => {
                    console.log('[AdvancedAPI] uploadFile filePath success8 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]uploadFile filePath fail8 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] uploadFile filePath complete8 ' + JSON.stringify(res))
                  }
                })
              })
            }
          }

          //name String 参数 --验证ok
          ListItem(){
            Column ({ space: 10 }) {
              // uploadFile   name  正常传参 Array类
              Button('name 正常传参  + url + filePath').width(300).onClick(()=>{
                // @ts-ignore
                as.uploadFile({
                  url: 'https://unidemo.dcloud.net.cn/upload',
                  name: 'file',
                  filePath: 'internal://cache/logo.png',
                  success: (res) => {
                    console.log('[AdvancedAPI] uploadFile name  success0 ' + res.data)
                    console.log('[AdvancedAPI] uploadFile name  success0 ' + res.statusCode)
                    console.log('[AdvancedAPI] uploadFile name  success0 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]uploadFile name  fail0 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] uploadFile name  complete0 ' + JSON.stringify(res))
                  }
                })
              })

              // uploadFile   无此url参数（无其他参数）
              Button('无此 name 参数 + url + filePath').width(300).onClick(()=>{
                // @ts-ignore
                as.uploadFile({
                  url: 'https://unidemo.dcloud.net.cn/upload',
                  filePath: 'internal://cache/logo.png',
                  success: (res) => {
                    console.log('[AdvancedAPI] uploadFile name  success2 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]uploadFile name  fail2 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] uploadFile name  complete2 ' + JSON.stringify(res))
                  }
                })
              })

              // uploadFile   name  类型不对 String
              Button('String + url + filePath').width(300).onClick(()=>{
                // @ts-ignore
                as.uploadFile({
                  url: 'https://unidemo.dcloud.net.cn/upload',
                  filePath: 'internal://cache/logo.png',
                  name: 'test',
                  success: (res) => {
                    console.log('[AdvancedAPI] uploadFile name  success3 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]uploadFile name  fail 3' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] uploadFile name  complete3 ' + JSON.stringify(res))
                  }
                })
              })

              // uploadFile   name  类型不对 number
              Button('number + url + filePath').width(300).onClick(()=>{
                // @ts-ignore
                as.uploadFile({
                  url: 'https://unidemo.dcloud.net.cn/upload',
                  filePath: 'internal://cache/logo.png',
                  name: 7788,
                  success: (res) => {
                    console.log('[AdvancedAPI] uploadFile name  success3 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]uploadFile name  fail 3' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] uploadFile name  complete3 ' + JSON.stringify(res))
                  }
                })
              })

              // uploadFile   name  类型不对 boolean（无其他参数）
              Button('boolean + url + filePath').width(300).onClick(()=>{
                // @ts-ignore
                as.uploadFile({
                  url: 'https://unidemo.dcloud.net.cn/upload',
                  filePath: 'internal://cache/logo.png',
                  name: true,
                  success: (res) => {
                    console.log('[AdvancedAPI] uploadFile name  success4 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]uploadFile name  fail4 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] uploadFile name  complete4 ' + JSON.stringify(res))
                  }
                })
              })

              // uploadFile   name  类型不对 object（无其他参数）
              Button('object + url + filePath').width(300).onClick(()=>{
                // @ts-ignore
                as.uploadFile({
                  url: 'https://unidemo.dcloud.net.cn/upload',
                  filePath: 'internal://cache/logo.png',
                  name: {'name':'file'},
                  success: (res) => {
                    console.log('[AdvancedAPI] uploadFile name  success5 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]uploadFile name  fail5 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] uploadFile name  complete5 ' + JSON.stringify(res))
                  }
                })
              })

              // uploadFile   name  类型不对 null（无其他参数）
              Button('null + url + filePath').width(300).onClick(()=>{
                // @ts-ignore
                as.uploadFile({
                  url: 'https://unidemo.dcloud.net.cn/upload',
                  filePath: 'internal://cache/logo.png',
                  name: null,
                  success: (res) => {
                    console.log('[AdvancedAPI] uploadFile name  success6 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]uploadFile name  fail6 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] uploadFile name  complete6 ' + JSON.stringify(res))
                  }
                })
              })

              // uploadFile   name  类型不对 空字符（无其他参数）
              Button('空字符 + url + filePath').width(300).onClick(()=>{
                // @ts-ignore
                as.uploadFile({
                  url: 'https://unidemo.dcloud.net.cn/upload',
                  filePath: 'internal://cache/logo.png',
                  name: '',
                  success: (res) => {
                    console.log('[AdvancedAPI] uploadFile name  success7 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]uploadFile name  fail7 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] uploadFile name  complete7 ' + JSON.stringify(res))
                  }
                })
              })

              // uploadFile   name  类型不对 undefined（无其他参数）
              Button('undefined + url + filePath').width(300).onClick(()=>{
                // @ts-ignore
                as.uploadFile({
                  url: 'https://unidemo.dcloud.net.cn/upload',
                  filePath: 'internal://cache/logo.png',
                  name: undefined,
                  success: (res) => {
                    console.log('[AdvancedAPI] uploadFile name  success8 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]uploadFile name  fail8 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] uploadFile name  complete8 ' + JSON.stringify(res))
                  }
                })
              })
            }
          }

          //header Object 参数
          ListItem(){
            Column({ space: 10 }) {
              // uploadFile    header  正常传参 Array类
              Button(' header 设置 Referer + url + filePath +name').width(300).onClick(() => {
                // @ts-ignore
                as.uploadFile({
                  url: 'https://unidemo.dcloud.net.cn/upload',
                  header: {'Referer':'http://192.168.43.120'},
                  name: 'file',
                  filePath: 'internal://cache/logo.png',
                  success: (res) => {
                    console.log('[AdvancedAPI] uploadFile  header  success0 ' + res.data)
                    console.log('[AdvancedAPI] uploadFile  header  success0 ' + res.statusCode)
                    console.log('[AdvancedAPI] uploadFile  header  success0 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]uploadFile  header  fail0 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] uploadFile  header  complete0 ' + JSON.stringify(res))
                  }
                })
              })

              Button(' header 正常传参 + url + filePath +name').width(300).onClick(() => {
                // @ts-ignore
                as.uploadFile({
                  url: 'https://unidemo.dcloud.net.cn/upload',
                  header: {'content-type':'application/json'},
                  name: 'file',
                  filePath: 'internal://cache/logo.png',
                  success: (res) => {
                    console.log('[AdvancedAPI] uploadFile  header  success0 ' + res.data)
                    console.log('[AdvancedAPI] uploadFile  header  success0 ' + res.statusCode)
                    console.log('[AdvancedAPI] uploadFile  header  success0 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]uploadFile  header  fail0 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] uploadFile  header  complete0 ' + JSON.stringify(res))
                  }
                })
              })

              // uploadFile   无此url参数（无其他参数）
              Button('无此  header 参数+ url + filePath +name').width(300).onClick(() => {
                // @ts-ignore
                as.uploadFile({
                  url: 'https://unidemo.dcloud.net.cn/upload',
                  name: 'file',
                  filePath: 'internal://cache/logo.png',
                  success: (res) => {
                    console.log('[AdvancedAPI] uploadFile  header  success2 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]uploadFile  header  fail2 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] uploadFile  header  complete2 ' + JSON.stringify(res))
                  }
                })
              })

              // uploadFile    header  类型不对 String
              Button('String+ url + filePath +name').width(300).onClick(() => {
                // @ts-ignore
                as.uploadFile({
                  url: 'https://unidemo.dcloud.net.cn/upload',
                  name: 'file',
                  filePath: 'internal://cache/logo.png',
                  header: 'test',
                  success: (res) => {
                    console.log('[AdvancedAPI] uploadFile  header  success3 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]uploadFile  header  fail 3' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] uploadFile  header  complete3 ' + JSON.stringify(res))
                  }
                })
              })

              // uploadFile    header  类型不对 number
              Button('number+ url + filePath +name').width(300).onClick(() => {
                // @ts-ignore
                as.uploadFile({
                  url: 'https://unidemo.dcloud.net.cn/upload',
                  name: 'file',
                  filePath: 'internal://cache/logo.png',
                  header: 7788,
                  success: (res) => {
                    console.log('[AdvancedAPI] uploadFile  header  success3 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]uploadFile  header  fail 3' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] uploadFile  header  complete3 ' + JSON.stringify(res))
                  }
                })
              })

              // uploadFile    header  类型不对 boolean（无其他参数）
              Button('boolean+ url + filePath +name').width(300).onClick(() => {
                // @ts-ignore
                as.uploadFile({
                  url: 'https://unidemo.dcloud.net.cn/upload',
                  name: 'file',
                  filePath: 'internal://cache/logo.png',
                  header: true,
                  success: (res) => {
                    console.log('[AdvancedAPI] uploadFile  header  success4 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]uploadFile  header  fail4 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] uploadFile  header  complete4 ' + JSON.stringify(res))
                  }
                })
              })

              // uploadFile    header  类型不对 object（无其他参数）
              Button('object+ url + filePath +name').width(300).onClick(() => {
                // @ts-ignore
                as.uploadFile({
                  url: 'https://unidemo.dcloud.net.cn/upload',
                  name: 'file',
                  filePath: 'internal://cache/logo.png',
                  header: { 'name': 'file' },
                  success: (res) => {
                    console.log('[AdvancedAPI] uploadFile  header  success5 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]uploadFile  header  fail5 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] uploadFile  header  complete5 ' + JSON.stringify(res))
                  }
                })
              })

              // uploadFile    header  类型不对 null（无其他参数）
              Button('null+ url + filePath +name').width(300).onClick(() => {
                // @ts-ignore
                as.uploadFile({
                  url: 'https://unidemo.dcloud.net.cn/upload',
                  name: 'file',
                  filePath: 'internal://cache/logo.png',
                  header: null,
                  success: (res) => {
                    console.log('[AdvancedAPI] uploadFile  header  success6 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]uploadFile  header  fail6 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] uploadFile  header  complete6 ' + JSON.stringify(res))
                  }
                })
              })

              // uploadFile    header  类型不对 空字符（无其他参数）
              Button('空字符+ url + filePath +name').width(300).onClick(() => {
                // @ts-ignore
                as.uploadFile({
                  url: 'https://unidemo.dcloud.net.cn/upload',
                  name: 'file',
                  filePath: 'internal://cache/logo.png',
                  header: '',
                  success: (res) => {
                    console.log('[AdvancedAPI] uploadFile  header  success7 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]uploadFile  header  fail7 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] uploadFile  header  complete7 ' + JSON.stringify(res))
                  }
                })
              })

              // uploadFile    header  类型不对 undefined（无其他参数）
              Button('undefined+ url + filePath +name').width(300).onClick(() => {
                // @ts-ignore
                as.uploadFile({
                  url: 'https://unidemo.dcloud.net.cn/upload',
                  name: 'file',
                  filePath: 'internal://cache/logo.png',
                  header: undefined,
                  success: (res) => {
                    console.log('[AdvancedAPI] uploadFile  header  success8 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]uploadFile  header  fail8 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] uploadFile  header  complete8 ' + JSON.stringify(res))
                  }
                })
              })
            }
          }
          //timeout Number 参数 --鸿蒙不支持

          //formData Object 参数
          ListItem(){
            Column({ space: 10 }) {
              // uploadFile    formData  正常传参 Array类
              Button(' formData 正常传参 + url + filePath +name').width(300).onClick(() => {
                // @ts-ignore
                as.uploadFile({
                  url: 'https://unidemo.dcloud.net.cn/upload',
                  formData: { 'user': 'test' },
                  name: 'file',
                  filePath: 'internal://cache/logo.png',
                  success: (res) => {
                    console.log('[AdvancedAPI] uploadFile  formData  success0 ' + res.data)
                    console.log('[AdvancedAPI] uploadFile  formData  success0 ' + res.statusCode)
                    console.log('[AdvancedAPI] uploadFile  formData  success0 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]uploadFile  formData  fail0 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] uploadFile  formData  complete0 ' + JSON.stringify(res))
                  }
                })
              })

              // uploadFile   无此url参数（无其他参数）
              Button('无此  formData 参数+ url + filePath +name').width(300).onClick(() => {
                // @ts-ignore
                as.uploadFile({
                  url: 'https://unidemo.dcloud.net.cn/upload',
                  name: 'file',
                  filePath: 'internal://cache/logo.png',
                  success: (res) => {
                    console.log('[AdvancedAPI] uploadFile  formData  success2 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]uploadFile  formData  fail2 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] uploadFile  formData  complete2 ' + JSON.stringify(res))
                  }
                })
              })

              // uploadFile    formData  类型不对 String
              Button('String+ url + filePath +name').width(300).onClick(() => {
                // @ts-ignore
                as.uploadFile({
                  url: 'https://unidemo.dcloud.net.cn/upload',
                  name: 'file',
                  filePath: 'internal://cache/logo.png',
                  formData: 'test',
                  success: (res) => {
                    console.log('[AdvancedAPI] uploadFile  formData  success3 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]uploadFile  formData  fail 3' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] uploadFile  formData  complete3 ' + JSON.stringify(res))
                  }
                })
              })

              // uploadFile    formData  类型不对 number
              Button('number+ url + filePath +name').width(300).onClick(() => {
                // @ts-ignore
                as.uploadFile({
                  url: 'https://unidemo.dcloud.net.cn/upload',
                  name: 'file',
                  filePath: 'internal://cache/logo.png',
                  formData: 7788,
                  success: (res) => {
                    console.log('[AdvancedAPI] uploadFile  formData  success3 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]uploadFile  formData  fail 3' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] uploadFile  formData  complete3 ' + JSON.stringify(res))
                  }
                })
              })

              // uploadFile    formData  类型不对 boolean（无其他参数）
              Button('boolean+ url + filePath +name').width(300).onClick(() => {
                // @ts-ignore
                as.uploadFile({
                  url: 'https://unidemo.dcloud.net.cn/upload',
                  name: 'file',
                  filePath: 'internal://cache/logo.png',
                  formData: true,
                  success: (res) => {
                    console.log('[AdvancedAPI] uploadFile  formData  success4 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]uploadFile  formData  fail4 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] uploadFile  formData  complete4 ' + JSON.stringify(res))
                  }
                })
              })

              // uploadFile    formData  类型不对 object（无其他参数）
              Button('object+ url + filePath +name').width(300).onClick(() => {
                // @ts-ignore
                as.uploadFile({
                  url: 'https://unidemo.dcloud.net.cn/upload',
                  name: 'file',
                  filePath: 'internal://cache/logo.png',
                  formData: { 'name': 'file' },
                  success: (res) => {
                    console.log('[AdvancedAPI] uploadFile  formData  success5 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]uploadFile  formData  fail5 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] uploadFile  formData  complete5 ' + JSON.stringify(res))
                  }
                })
              })

              // uploadFile    formData  类型不对 null（无其他参数）
              Button('null+ url + filePath +name').width(300).onClick(() => {
                // @ts-ignore
                as.uploadFile({
                  url: 'https://unidemo.dcloud.net.cn/upload',
                  name: 'file',
                  filePath: 'internal://cache/logo.png',
                  formData: null,
                  success: (res) => {
                    console.log('[AdvancedAPI] uploadFile  formData  success6 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]uploadFile  formData  fail6 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] uploadFile  formData  complete6 ' + JSON.stringify(res))
                  }
                })
              })

              // uploadFile    formData  类型不对 空字符（无其他参数）
              Button('空字符+ url + filePath +name').width(300).onClick(() => {
                // @ts-ignore
                as.uploadFile({
                  url: 'https://unidemo.dcloud.net.cn/upload',
                  name: 'file',
                  filePath: 'internal://cache/logo.png',
                  formData: '',
                  success: (res) => {
                    console.log('[AdvancedAPI] uploadFile  formData  success7 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]uploadFile  formData  fail7 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] uploadFile  formData  complete7 ' + JSON.stringify(res))
                  }
                })
              })

              // uploadFile    formData  类型不对 undefined（无其他参数）
              Button('undefined+ url + filePath +name').width(300).onClick(() => {
                // @ts-ignore
                as.uploadFile({
                  url: 'https://unidemo.dcloud.net.cn/upload',
                  name: 'file',
                  filePath: 'internal://cache/logo.png',
                  formData: undefined,
                  success: (res) => {
                    console.log('[AdvancedAPI] uploadFile  formData  success8 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]uploadFile  formData  fail8 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] uploadFile  formData  complete8 ' + JSON.stringify(res))
                  }
                })
              })
            }
          }

          //uploadTask
          ListItem(){
            Column({ space: 10 }) {
              Text("uploadTask").fontSize(20).fontWeight(FontWeight.Bold)
              Button(' abort 与 onProgressUpdate').width(300).onClick(() => {
                // @ts-ignore
                as.chooseVideo({
                  sourceType: ['album'],
                  success: (res) => {
                    const tempFilePath = res.tempFilePath;
                    // @ts-ignore
                    const uploadTask = as.uploadFile({
                      url: 'https://unidemo.dcloud.net.cn/upload', //uniapp的服务器
                      filePath: tempFilePath,
                      name: 'file',
                      formData: {
                        'user': 'test'
                      },
                      success: (uploadFileRes) => {
                        console.log('uploadFileRes success ----'+ uploadFileRes.data);
                      }
                    });

                    uploadTask.onProgressUpdate((res) => {
                      console.log('uploadTask 上传进度' + res.progress);
                      console.log('uploadTask 已经上传的数据长度' + res.totalBytesSent);
                      console.log('uploadTask 预期需要上传的数据总长度' + res.totalBytesExpectedToSend);

                      // 测试条件，取消上传任务。
                      if (res.progress > 50) {
                        uploadTask.abort();
                      }
                    });
                  }
                });
              })

            }
          }

          // TC1
          ListItem(){
            Button("上传文件").width(300).onClick(()=>{
              // @ts-ignore
              as.uploadFile({
                url: 'https://unidemo.dcloud.net.cn/upload',
                filePath: 'internal://cache/logo.png',
                name: 'file',
                formData: {
                  'user': 'test'
                },
                success: (res) => {
                  console.log('[AdvancedAPI] 文件上传成功 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'upload success', offset: { dx: 0, dy: -50 } })
                },
                fail: (err) => {
                  console.error('[AdvancedAPI] 文件上传失败 ' + JSON.stringify(err));
                  AlertDialog.show({ message: 'upload fail', offset: { dx: 0, dy: -50 } })
                },
                complete: (res) => {
                  console.log('[AdvancedAPI] 文件上传完成 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'upload complete', offset: { dx: 0, dy: 50 } })
                }
              })
            })
          }
          // TC2
          ListItem(){
            Button("参数为空").width(300).onClick(()=>{
              // @ts-ignore
              as.uploadFile()
            }).backgroundColor(Color.Orange)
          }
          // TC3
          ListItem(){
            Button("无必填参数url").width(300).onClick(()=>{
              // @ts-ignore
              as.uploadFile({
                filePath: 'internal://cache/logo.png',
                name: 'file',
                formData: {
                  'user': 'test'
                },
                success: (res) => {
                  console.log('[AdvancedAPI] 文件上传成功 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'upload success', offset: { dx: 0, dy: -50 } })
                },
                fail: (err) => {
                  console.error('[AdvancedAPI] 文件上传失败 ' + JSON.stringify(err));
                  AlertDialog.show({ message: 'upload fail', offset: { dx: 0, dy: -50 } })
                },
                complete: (res) => {
                  console.log('[AdvancedAPI] 文件上传完成 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'upload complete', offset: { dx: 0, dy: 50 } })
                }
              })
            }).backgroundColor(Color.Orange)
          }
          // TC4
          ListItem(){
            Button("无必填参数filePath").width(300).onClick(()=>{
              // @ts-ignore
              as.uploadFile({
                url: 'https://unidemo.dcloud.net.cn/upload',
                name: 'file',
                formData: {
                  'user': 'test'
                },
                success: (res) => {
                  console.log('[AdvancedAPI] 文件上传成功 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'upload success', offset: { dx: 0, dy: -50 } })
                },
                fail: (err) => {
                  console.error('[AdvancedAPI] 文件上传失败 ' + JSON.stringify(err));
                  AlertDialog.show({ message: 'upload fail', offset: { dx: 0, dy: -50 } })
                },
                complete: (res) => {
                  console.log('[AdvancedAPI] 文件上传完成 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'upload complete', offset: { dx: 0, dy: 50 } })
                }
              })
            }).backgroundColor(Color.Orange)
          }
          // TC5
          ListItem(){
            Button("不可访问的url").width(300).onClick(()=>{
              // @ts-ignore
              as.uploadFile({
                url: 'http://192.168.1.1/upload',
                filePath: 'internal://cache/logo.png',
                name: 'file',
                formData: {
                  'user': 'test'
                },
                success: (res) => {
                  console.log('[AdvancedAPI] 文件上传成功 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'upload success', offset: { dx: 0, dy: -50 } })
                },
                fail: (err) => {
                  console.error('[AdvancedAPI] 文件上传失败 ' + JSON.stringify(err));
                  AlertDialog.show({ message: 'upload fail', offset: { dx: 0, dy: -50 } })
                },
                complete: (res) => {
                  console.log('[AdvancedAPI] 文件上传完成 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'upload complete', offset: { dx: 0, dy: 50 } })
                }
              })
            }).backgroundColor(Color.Orange)
          }
          // TC6
          ListItem(){
            Button("不合法的路径").width(300).onClick(()=>{
              // @ts-ignore
              as.uploadFile({
                url: 'https://unidemo.dcloud.net.cn/upload',
                filePath: '/cache/logo.png',
                name: 'file',
                formData: {
                  'user': 'test'
                },
                success: (res) => {
                  console.log('[AdvancedAPI] 文件上传成功 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'upload success', offset: { dx: 0, dy: -50 } })
                },
                fail: (err) => {
                  console.error('[AdvancedAPI] 文件上传失败 ' + JSON.stringify(err));
                  AlertDialog.show({ message: 'upload fail', offset: { dx: 0, dy: -50 } })
                },
                complete: (res) => {
                  console.log('[AdvancedAPI] 文件上传完成 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'upload complete', offset: { dx: 0, dy: 50 } })
                }
              })
            }).backgroundColor(Color.Orange)
          }
          // TC7
          ListItem(){
            Button("不存在的文件").width(300).onClick(()=>{
              // @ts-ignore
              as.uploadFile({
                url: 'https://unidemo.dcloud.net.cn/upload',
                filePath: 'internal://cache/aaa.png',
                name: 'file',
                formData: {
                  'user': 'test'
                },
                success: (res) => {
                  console.log('[AdvancedAPI] 文件上传成功 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'upload success', offset: { dx: 0, dy: -50 } })
                },
                fail: (err) => {
                  console.error('[AdvancedAPI] 文件上传失败 ' + JSON.stringify(err));
                  AlertDialog.show({ message: 'upload fail', offset: { dx: 0, dy: -50 } })
                },
                complete: (res) => {
                  console.log('[AdvancedAPI] 文件上传完成 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'upload complete', offset: { dx: 0, dy: 50 } })
                }
              })
            }).backgroundColor(Color.Orange)
          }
          // TC8
          ListItem(){
            Button("无必填参数name").width(300).onClick(()=>{
              // @ts-ignore
              as.uploadFile({
                url: 'https://unidemo.dcloud.net.cn/upload',
                filePath: 'internal://cache/logo.png',
                formData: {
                  'user': 'test'
                },
                success: (res) => {
                  console.log('[AdvancedAPI] 文件上传成功 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'upload success', offset: { dx: 0, dy: -50 } })
                },
                fail: (err) => {
                  console.error('[AdvancedAPI] 文件上传失败 ' + JSON.stringify(err));
                  AlertDialog.show({ message: 'upload fail', offset: { dx: 0, dy: -50 } })
                },
                complete: (res) => {
                  console.log('[AdvancedAPI] 文件上传完成 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'upload complete', offset: { dx: 0, dy: 50 } })
                }
              })
            }).backgroundColor(Color.Orange)
          }

          ListItem(){
            Text("uploadTask").fontSize(20).fontWeight(FontWeight.Bold)
          }
          // TC1
          ListItem(){
            Button("abort").width(300).onClick(()=>{
              // @ts-ignore
              this.task = as.uploadFile({
                url: 'https://unidemo.dcloud.net.cn/upload',
                filePath: 'internal://cache/logo.png',
                name: 'file',
                formData: {
                  'user': 'test'
                },
                success: (res) => {
                  console.log('[AdvancedAPI] 文件上传成功 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'upload success', offset: { dx: 0, dy: -50 } })
                },
                fail: (err) => {
                  console.error('[AdvancedAPI] 文件上传失败 ' + JSON.stringify(err));
                  AlertDialog.show({ message: 'upload fail', offset: { dx: 0, dy: -50 } })
                },
                complete: (res) => {
                  console.log('[AdvancedAPI] 文件上传完成 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'upload complete', offset: { dx: 0, dy: 50 } })
                }
              })
              // @ts-ignore
              this.task.abort()
            })
          }
          // TC2
          ListItem(){
            Button("onProgressUpdate").width(300).onClick(()=>{
              // @ts-ignore
              this.task = as.uploadFile({
                url: 'https://unidemo.dcloud.net.cn/upload',
                filePath: 'internal://cache/logo.png',
                name: 'file',
                formData: {
                  'user': 'test'
                },
                success: (res) => {
                  console.log('[AdvancedAPI] 文件上传成功');
                },
                fail: (err) => {
                  console.error('[AdvancedAPI] 文件上传失败 ' + JSON.stringify(err));
                },
                complete: () => {
                  console.log('[AdvancedAPI] 文件上传完成');
                }
              })
              // @ts-ignore
              this.task.onProgressUpdate(this.progressCallback1)
            })
          }
          // TC3
          ListItem(){
            Button("onProgressUpdate 多个监听").width(300).onClick(()=>{
              // @ts-ignore
              this.task = as.uploadFile({
                url: 'https://unidemo.dcloud.net.cn/upload',
                filePath: 'internal://cache/logo.png',
                name: 'file',
                formData: {
                  'user': 'test'
                },
                success: (res) => {
                  console.log('[AdvancedAPI] 文件上传成功');
                },
                fail: (err) => {
                  console.error('[AdvancedAPI] 文件上传失败 ' + JSON.stringify(err));
                },
                complete: () => {
                  console.log('[AdvancedAPI] 文件上传完成');
                }
              })
              // @ts-ignore
              this.task.onProgressUpdate(this.progressCallback2)
              // @ts-ignore
              this.task.onProgressUpdate(this.progressCallback1)
            }).backgroundColor(Color.Orange)
          }
          // TC4
          ListItem(){
            Button("onProgressUpdate 回调空").width(300).onClick(()=>{
              // @ts-ignore
              this.task = as.uploadFile({
                url: 'https://unidemo.dcloud.net.cn/upload',
                filePath: 'internal://cache/logo.png',
                name: 'file',
                formData: {
                  'user': 'test'
                },
                success: (res) => {
                  console.log('[AdvancedAPI] 文件上传成功');
                },
                fail: (err) => {
                  console.error('[AdvancedAPI] 文件上传失败 ' + JSON.stringify(err));
                },
                complete: () => {
                  console.log('[AdvancedAPI] 文件上传完成');
                }
              })
              // @ts-ignore
              this.task.onProgressUpdate()
            }).backgroundColor(Color.Orange)
          }
          // TC5
          ListItem(){
            Button("offProgressUpdate").width(300).onClick(()=>{
              // @ts-ignore
              this.task = as.uploadFile({
                url: 'https://unidemo.dcloud.net.cn/upload',
                filePath: 'internal://cache/logo.png',
                name: 'file',
                formData: {
                  'user': 'test'
                },
                success: (res) => {
                  console.log('[AdvancedAPI] 文件上传成功');
                },
                fail: (err) => {
                  console.error('[AdvancedAPI] 文件上传失败 ' + JSON.stringify(err));
                },
                complete: () => {
                  console.log('[AdvancedAPI] 文件上传完成');
                }
              })
              // @ts-ignore
              this.task.onProgressUpdate(this.progressCallback2)
              // @ts-ignore
              this.task.onProgressUpdate(this.progressCallback1)
              // @ts-ignore
              this.task.offProgressUpdate(this.progressCallback1)
            })
          }
          // TC6
          ListItem(){
            Button("offProgressUpdate 取消不存在").width(300).onClick(()=>{
              // @ts-ignore
              this.task = as.uploadFile({
                url: 'https://unidemo.dcloud.net.cn/upload',
                filePath: 'internal://cache/logo.png',
                name: 'file',
                formData: {
                  'user': 'test'
                },
                success: (res) => {
                  console.log('[AdvancedAPI] 文件上传成功');
                },
                fail: (err) => {
                  console.error('[AdvancedAPI] 文件上传失败 ' + JSON.stringify(err));
                },
                complete: () => {
                  console.log('[AdvancedAPI] 文件上传完成');
                }
              })
              // @ts-ignore
              this.task.onProgressUpdate(this.progressCallback1)
              // @ts-ignore
              this.task.offProgressUpdate(() => {})
            }).backgroundColor(Color.Orange)
          }
          // TC7
          ListItem(){
            Button("offProgressUpdate 取消全部").width(300).onClick(()=>{
              // @ts-ignore
              this.task = as.uploadFile({
                url: 'https://unidemo.dcloud.net.cn/upload',
                filePath: 'internal://cache/logo.png',
                name: 'file',
                formData: {
                  'user': 'test'
                },
                success: (res) => {
                  console.log('[AdvancedAPI] 文件上传成功');
                },
                fail: (err) => {
                  console.error('[AdvancedAPI] 文件上传失败 ' + JSON.stringify(err));
                },
                complete: () => {
                  console.log('[AdvancedAPI] 文件上传完成');
                }
              })
              // @ts-ignore
              this.task.onProgressUpdate(this.progressCallback1)
              // @ts-ignore
              this.task.onProgressUpdate(this.progressCallback2)
              // @ts-ignore
              this.task.offProgressUpdate()
            }).backgroundColor(Color.Orange)
          }
          // TC8
          ListItem(){
            Button("onHeadersReceived").width(300).onClick(()=>{
              // @ts-ignore
              this.task = as.uploadFile({
                url: 'https://unidemo.dcloud.net.cn/upload',
                filePath: 'internal://cache/logo.png',
                name: 'file',
                formData: {
                  'user': 'test'
                },
                success: (res) => {
                  console.log('[AdvancedAPI] 文件上传成功');
                },
                fail: (err) => {
                  console.error('[AdvancedAPI] 文件上传失败 ' + JSON.stringify(err));
                },
                complete: () => {
                  console.log('[AdvancedAPI] 文件上传完成');
                }
              })
              // @ts-ignore
              this.task.onHeadersReceived(this.headersCallback1)
            })
          }
          // TC9
          ListItem(){
            Button("onHeadersReceived 多个监听").width(300).onClick(()=>{
              // @ts-ignore
              this.task = as.uploadFile({
                url: 'https://unidemo.dcloud.net.cn/upload',
                filePath: 'internal://cache/logo.png',
                name: 'file',
                formData: {
                  'user': 'test'
                },
                success: (res) => {
                  console.log('[AdvancedAPI] 文件上传成功');
                },
                fail: (err) => {
                  console.error('[AdvancedAPI] 文件上传失败 ' + JSON.stringify(err));
                },
                complete: () => {
                  console.log('[AdvancedAPI] 文件上传完成');
                }
              })
              // @ts-ignore
              this.task.onHeadersReceived(this.headersCallback1)
              // @ts-ignore
              this.task.onHeadersReceived(this.headersCallback2)
            }).backgroundColor(Color.Orange)
          }
          // TC10
          ListItem(){
            Button("offHeadersReceived").width(300).onClick(()=>{
              // @ts-ignore
              this.task = as.uploadFile({
                url: 'https://unidemo.dcloud.net.cn/upload',
                filePath: 'internal://cache/logo.png',
                name: 'file',
                formData: {
                  'user': 'test'
                },
                success: (res) => {
                  console.log('[AdvancedAPI] 文件上传成功');
                },
                fail: (err) => {
                  console.error('[AdvancedAPI] 文件上传失败 ' + JSON.stringify(err));
                },
                complete: () => {
                  console.log('[AdvancedAPI] 文件上传完成');
                }
              })
              // @ts-ignore
              this.task.onHeadersReceived(this.headersCallback1)
              // @ts-ignore
              this.task.onHeadersReceived(this.headersCallback2)
              // @ts-ignore
              this.task.offHeadersReceived(this.headersCallback1)
            })
          }
          // TC11
          ListItem(){
            Button("offHeadersReceived 取消全部").width(300).onClick(()=>{
              // @ts-ignore
              this.task = as.uploadFile({
                url: 'https://unidemo.dcloud.net.cn/upload',
                filePath: 'internal://cache/logo.png',
                name: 'file',
                formData: {
                  'user': 'test'
                },
                success: (res) => {
                  console.log('[AdvancedAPI] 文件上传成功');
                },
                fail: (err) => {
                  console.error('[AdvancedAPI] 文件上传失败 ' + JSON.stringify(err));
                },
                complete: () => {
                  console.log('[AdvancedAPI] 文件上传完成');
                }
              })
              // @ts-ignore
              this.task.onHeadersReceived(this.headersCallback1)
              // @ts-ignore
              this.task.onHeadersReceived(this.headersCallback2)
              // @ts-ignore
              this.task.offHeadersReceived()
            }).backgroundColor(Color.Orange)
          }
        }.alignListItem(ListItemAlign.Center)
      }
    }
  }
}