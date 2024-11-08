// @ts-nocheck
import promptAction from '@ohos.promptAction'

@Entry
@Component
struct video {
  aboutToAppear() {
  }

  build() {
    Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
      Column({ space: 5 }) {
        List({ space: 20, initialIndex: 0 }) {
          ListItem(){
            Text("视频").fontSize(35)
          }

          ListItem(){
            Column({ space: 10 }) {
              Text("as.chooseVideo (Object)").fontSize(30)
              //sourceType 参数 Array<String>  album
              Button("sourceType album ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseVideo({
                  sourceType: ['album'],
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.chooseVideo  sourceType success' + JSON.stringify(res.tempFilePath));
                    console.log('[AdvancedAPIDEMO] as.chooseVideo  sourceType success' + JSON.stringify(res.tempFile));
                    console.log('[AdvancedAPIDEMO] as.chooseVideo  sourceType success ' + JSON.stringify(res.duration));
                    console.log('[AdvancedAPIDEMO] as.chooseVideo  sourceType success ' + JSON.stringify(res.size));
                    console.log('[AdvancedAPIDEMO] as.chooseVideo  sourceType success ' + JSON.stringify(res.height));
                    console.log('[AdvancedAPIDEMO] as.chooseVideo  sourceType success ' + JSON.stringify(res.width));
                    console.log('[AdvancedAPIDEMO] as.chooseVideo  sourceType success ' + JSON.stringify(res.name));
                    console.log('[AdvancedAPIDEMO] as.chooseVideo  sourceType success ' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.chooseVideo sourceType fail ' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.chooseVideo sourceType complete ' + JSON.stringify(res));
                  }
                })
              })
              //sourceType 参数 Array<String>  camera
              Button("sourceType camera ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseVideo({
                  sourceType: ['camera'],
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.chooseVideo  sourceType success0 ' + JSON.stringify(res.tempFilePath));
                    console.log('[AdvancedAPIDEMO] as.chooseVideo  sourceType success0 ' + JSON.stringify(res.tempFile));
                    console.log('[AdvancedAPIDEMO] as.chooseVideo  sourceType success 0' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.chooseVideo sourceType fail 0' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.chooseVideo sourceType complete 0' + JSON.stringify(res));
                  }
                })
              })
              //sourceType 参数 Array<String> camera，album
              Button("sourceType camera，album ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseVideo({
                  sourceType: ['camera','album'],
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.chooseVideo  sourceType success00 ' + JSON.stringify(res.tempFilePath));
                    console.log('[AdvancedAPIDEMO] as.chooseVideo  sourceType success00 ' + JSON.stringify(res.tempFile));
                    console.log('[AdvancedAPIDEMO] as.chooseVideo  sourceType success 00' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.chooseVideo sourceType fail 00' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.chooseVideo sourceType complete 00' + JSON.stringify(res));
                  }
                })
              })
              //sourceType 无此参数
              Button("sourceType 无此参数").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseVideo({
                  //                  sourceType: ['album'],
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.chooseVideo  sourceType success1 ' + JSON.stringify(res.tempFilePath));
                    console.log('[AdvancedAPIDEMO] as.chooseVideo  sourceType success1 ' + JSON.stringify(res.tempFile));
                    console.log('[AdvancedAPIDEMO] as.chooseVideo  sourceType success 1 ' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.chooseVideo sourceType fail 1' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.chooseVideo sourceType complete ' + JSON.stringify(res));
                  }
                })
              })
              //sourceType 参数取值类型不同 boolean
              Button("sourceType boolean ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseVideo({
                  sourceType: true,
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.chooseVideo  sourceType success2 ' + JSON.stringify(res.tempFilePath));
                    console.log('[AdvancedAPIDEMO] as.chooseVideo  sourceType success2 ' + JSON.stringify(res.tempFile));
                    console.log('[AdvancedAPIDEMO] as.chooseVideo  sourceType success 2' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.chooseVideo sourceType fail 2' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.chooseVideo sourceType complete 2' + JSON.stringify(res));
                  }
                })
              })
              //sourceType 参数取值类型不同 String
              Button("sourceType String ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseVideo({
                  sourceType: 'album',
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.chooseVideo  sourceType success3 ' + JSON.stringify(res.tempFilePath));
                    console.log('[AdvancedAPIDEMO] as.chooseVideo  sourceType success3 ' + JSON.stringify(res.tempFile));
                    console.log('[AdvancedAPIDEMO] as.chooseVideo  sourceType success 3' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.chooseVideo sourceType fail 3' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.chooseVideo sourceType complete 3' + JSON.stringify(res));
                  }
                })
              })
              //sourceType 参数取值类型不同 Object
              Button("sourceType Object ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseVideo({
                  sourceType: {'cate':'album'},
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.chooseVideo  sourceType success4 ' + JSON.stringify(res.tempFilePath));
                    console.log('[AdvancedAPIDEMO] as.chooseVideo  sourceType success4 ' + JSON.stringify(res.tempFile));
                    console.log('[AdvancedAPIDEMO] as.chooseVideo  sourceType success 4' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.chooseVideo sourceType fail 4' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.chooseVideo sourceType complete 4' + JSON.stringify(res));
                  }
                })
              })
              //sourceType 参数取值异常 null
              Button("sourceType null ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseVideo({
                  sourceType: null,
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.chooseVideo  sourceType success5 ' + JSON.stringify(res.tempFilePath));
                    console.log('[AdvancedAPIDEMO] as.chooseVideo  sourceType success5 ' + JSON.stringify(res.tempFile));
                    console.log('[AdvancedAPIDEMO] as.chooseVideo  sourceType success 5' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.chooseVideo sourceType fail 5' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.chooseVideo sourceType complete 5' + JSON.stringify(res));
                  }
                })
              })
              //sourceType 参数取值异常 空字符
              Button("sourceType 空字符 ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseVideo({
                  sourceType: '',
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.chooseVideo  sourceType success6 ' + JSON.stringify(res.tempFilePath));
                    console.log('[AdvancedAPIDEMO] as.chooseVideo  sourceType success6 ' + JSON.stringify(res.tempFile));
                    console.log('[AdvancedAPIDEMO] as.chooseVideo  sourceType success 6' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.chooseVideo sourceType fail 6' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.chooseVideo sourceType complete 6 ' + JSON.stringify(res));
                  }
                })
              })
              //sourceType 参数取值异常 undefined
              Button("sourceType undefined ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseVideo({
                  sourceType: undefined,
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.chooseVideo  sourceType success7 ' + JSON.stringify(res.tempFilePath));
                    console.log('[AdvancedAPIDEMO] as.chooseVideo  sourceType success7 ' + JSON.stringify(res.tempFile));
                    console.log('[AdvancedAPIDEMO] as.chooseVideo  sourceType success 7' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.chooseVideo sourceType fail 7' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.chooseVideo sourceType complete 7' + JSON.stringify(res));
                  }
                })
              })

            }
          }

          ListItem(){
            Column({ space: 10 }) {
              Text("as.chooseMedia (Object)").fontSize(30)
              //sourceType 参数 Array<String>  album
              Button("sourceType album ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseMedia({
                  sourceType: ['album'],
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.chooseMedia  sourceType success' + JSON.stringify(res.tempFilePath));
                    console.log('[AdvancedAPIDEMO] as.chooseMedia  sourceType success' + JSON.stringify(res.tempFile));
                    console.log('[AdvancedAPIDEMO] as.chooseMedia  sourceType success ' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.chooseMedia sourceType fail ' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.chooseMedia sourceType complete ' + JSON.stringify(res));
                  }
                })
              })
              //sourceType 参数 Array<String>  camera
              Button("sourceType camera ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseMedia({
                  sourceType: ['camera'],
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.chooseMedia  sourceType success0 ' + JSON.stringify(res.tempFilePath));
                    console.log('[AdvancedAPIDEMO] as.chooseMedia  sourceType success0 ' + JSON.stringify(res.tempFile));
                    console.log('[AdvancedAPIDEMO] as.chooseMedia  sourceType success 0' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.chooseMedia sourceType fail 0' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.chooseMedia sourceType complete 0' + JSON.stringify(res));
                  }
                })
              })
              //sourceType 参数 Array<String> camera，album
              Button("sourceType camera，album ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseMedia({
                  sourceType: ['camera','album'],
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.chooseMedia  sourceType success00 ' + JSON.stringify(res.tempFilePath));
                    console.log('[AdvancedAPIDEMO] as.chooseMedia  sourceType success00 ' + JSON.stringify(res.tempFile));
                    console.log('[AdvancedAPIDEMO] as.chooseMedia  sourceType success 00' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.chooseMedia sourceType fail 00' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.chooseMedia sourceType complete 00' + JSON.stringify(res));
                  }
                })
              })
              //sourceType 无此参数
              Button("sourceType 无此参数").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseMedia({
                  //                  sourceType: ['album'],
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.chooseMedia  sourceType success1 ' + JSON.stringify(res.tempFilePath));
                    console.log('[AdvancedAPIDEMO] as.chooseMedia  sourceType success1 ' + JSON.stringify(res.tempFile));
                    console.log('[AdvancedAPIDEMO] as.chooseMedia  sourceType success 1 ' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.chooseMedia sourceType fail 1' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.chooseMedia sourceType complete ' + JSON.stringify(res));
                  }
                })
              })
              //sourceType 参数取值类型不同 boolean
              Button("sourceType boolean ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseMedia({
                  sourceType: true,
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.chooseMedia  sourceType success2 ' + JSON.stringify(res.tempFilePath));
                    console.log('[AdvancedAPIDEMO] as.chooseMedia  sourceType success2 ' + JSON.stringify(res.tempFile));
                    console.log('[AdvancedAPIDEMO] as.chooseMedia  sourceType success 2' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.chooseMedia sourceType fail 2' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.chooseMedia sourceType complete 2' + JSON.stringify(res));
                  }
                })
              })
              //sourceType 参数取值类型不同 String
              Button("sourceType String ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseMedia({
                  sourceType: 'album',
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.chooseMedia  sourceType success3 ' + JSON.stringify(res.tempFilePath));
                    console.log('[AdvancedAPIDEMO] as.chooseMedia  sourceType success3 ' + JSON.stringify(res.tempFile));
                    console.log('[AdvancedAPIDEMO] as.chooseMedia  sourceType success 3' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.chooseMedia sourceType fail 3' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.chooseMedia sourceType complete 3' + JSON.stringify(res));
                  }
                })
              })
              //sourceType 参数取值类型不同 Object
              Button("sourceType Object ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseMedia({
                  sourceType: {'cate':'album'},
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.chooseMedia  sourceType success4 ' + JSON.stringify(res.tempFilePath));
                    console.log('[AdvancedAPIDEMO] as.chooseMedia  sourceType success4 ' + JSON.stringify(res.tempFile));
                    console.log('[AdvancedAPIDEMO] as.chooseMedia  sourceType success 4' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.chooseMedia sourceType fail 4' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.chooseMedia sourceType complete 4' + JSON.stringify(res));
                  }
                })
              })
              //sourceType 参数取值异常 null
              Button("sourceType null ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseMedia({
                  sourceType: null,
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.chooseMedia  sourceType success5 ' + JSON.stringify(res.tempFilePath));
                    console.log('[AdvancedAPIDEMO] as.chooseMedia  sourceType success5 ' + JSON.stringify(res.tempFile));
                    console.log('[AdvancedAPIDEMO] as.chooseMedia  sourceType success 5' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.chooseMedia sourceType fail 5' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.chooseMedia sourceType complete 5' + JSON.stringify(res));
                  }
                })
              })
              //sourceType 参数取值异常 空字符
              Button("sourceType 空字符 ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseMedia({
                  sourceType: '',
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.chooseMedia  sourceType success6 ' + JSON.stringify(res.tempFilePath));
                    console.log('[AdvancedAPIDEMO] as.chooseMedia  sourceType success6 ' + JSON.stringify(res.tempFile));
                    console.log('[AdvancedAPIDEMO] as.chooseMedia  sourceType success 6' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.chooseMedia sourceType fail 6' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.chooseMedia sourceType complete 6 ' + JSON.stringify(res));
                  }
                })
              })
              //sourceType 参数取值异常 undefined
              Button("sourceType undefined ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseMedia({
                  sourceType: undefined,
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.chooseMedia  sourceType success7 ' + JSON.stringify(res.tempFilePath));
                    console.log('[AdvancedAPIDEMO] as.chooseMedia  sourceType success7 ' + JSON.stringify(res.tempFile));
                    console.log('[AdvancedAPIDEMO] as.chooseMedia  sourceType success 7' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.chooseMedia sourceType fail 7' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.chooseMedia sourceType complete 7' + JSON.stringify(res));
                  }
                })
              })

            }
          }

          ListItem(){
            Column({ space: 10 }) {
              Text("as.saveVideoToPhotosAlbum").fontSize(30)
              //filePath，图片文件路径，可以是临时文件路径也可以是永久文件路径，不支持网络图片路径
              //filePath  String  相对路径
              Button("filePath 相对路径 ").width(300).onClick(()=>{
                // @ts-ignore
                as.saveVideoToPhotosAlbum({
                  filePath:  $r('app.media.video'),
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.saveVideoToPhotosAlbum  src success 0' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.saveVideoToPhotosAlbum src fail 0' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.saveVideoToPhotosAlbum src complete 0 ' + JSON.stringify(res));
                  }
                });
              })
              //filePath  String  绝对路径
              Button("filePath 网络http  png ").width(300).onClick(()=>{
                // @ts-ignore
                as.saveVideoToPhotosAlbum({
                  filePath:  'http://www.huawei.com/Assets/CBG/img/logo.png',
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.saveVideoToPhotosAlbum  src success 00' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.saveVideoToPhotosAlbum src fail 00' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.saveVideoToPhotosAlbum src complete 00 ' + JSON.stringify(res));
                  }
                });
              })
              //filePath  String  临时文件路径
              Button("filePath 临时文件路径 ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseVideo({
                  sourceType: ['album'],
                  success: function (res) {
                    // @ts-ignore
                    as.saveVideoToPhotosAlbum({
                      filePath: res.tempFilePath,
                      success: function (res) {
                        console.log('[AdvancedAPIDEMO] as.saveVideoToPhotosAlbum  src success 01' + JSON.stringify(res));
                      },
                      fail: (res) => {
                        console.error('[AdvancedAPIDEMO] as.saveVideoToPhotosAlbum src fail 01' + JSON.stringify(res));
                      },
                      complete: (res) => {
                        console.log('[AdvancedAPIDEMO] as.saveVideoToPhotosAlbum src complete 01 ' + JSON.stringify(res));
                      }
                    });
                  }
                })

              })
              //filePath  String  存储文件路径
              Button("filePath 存储文件路径 ").width(300).onClick(()=>{
                // @ts-ignore
                as.saveVideoToPhotosAlbum({
                  filePath: '',
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.saveVideoToPhotosAlbum  src success 02' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.saveVideoToPhotosAlbum src fail 02' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.saveVideoToPhotosAlbum src complete 02 ' + JSON.stringify(res));
                  }
                });
              })
              //filePath  String  网络图片路径
              Button("filePath 网络https jpg ").width(300).onClick(()=>{
                // @ts-ignore
                as.saveVideoToPhotosAlbum({
                  filePath: 'https://ss0.bdstatic.com/-0U0bnSm1A5BphGlnYG/cae-legoup-video-target/93be3d88-9fc2-4fbd-bd14-833bca731ca7.mp4',
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.saveVideoToPhotosAlbum  src success 1' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.saveVideoToPhotosAlbum src fail 1' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.saveVideoToPhotosAlbum src complete 1 ' + JSON.stringify(res));
                  }
                });
              })
              //src 参数取值类型不同 Boolean
              Button("filePath Boolean ").width(300).onClick(()=>{
                // @ts-ignore
                as.saveVideoToPhotosAlbum({
                  filePath: true,
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.saveVideoToPhotosAlbum  src success 2' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.saveVideoToPhotosAlbum src fail 2' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.saveVideoToPhotosAlbum src complete 2 ' + JSON.stringify(res));
                  }
                });
              })
              //filePath 参数取值类型不同 Number
              Button("filePath Number ").width(300).onClick(()=>{
                // @ts-ignore
                as.saveVideoToPhotosAlbum({
                  filePath: 999,
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.saveVideoToPhotosAlbum  src success 3' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.saveVideoToPhotosAlbum src fail 3' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.saveVideoToPhotosAlbum src complete 3 ' + JSON.stringify(res));
                  }
                });
              })
              //filePath 参数取值类型不同 Object
              Button("filePath Object ").width(300).onClick(()=>{
                // @ts-ignore
                as.saveVideoToPhotosAlbum({
                  filePath: { 'name':'test' },
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.saveVideoToPhotosAlbum  src success 4' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.saveVideoToPhotosAlbum src fail 4' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.saveVideoToPhotosAlbum src complete 4 ' + JSON.stringify(res));
                  }
                });
              })
              //filePath 参数取值异常 null
              Button("filePath null ").width(300).onClick(()=>{
                // @ts-ignore
                as.saveVideoToPhotosAlbum({
                  filePath: null,
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.saveVideoToPhotosAlbum  src success 5' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.saveVideoToPhotosAlbum src fail 5' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.saveVideoToPhotosAlbum src complete 5 ' + JSON.stringify(res));
                  }
                });
              })
              //filePath 参数取值异常 空字符
              Button("filePath 空字符 ").width(300).onClick(()=>{
                // @ts-ignore
                as.saveVideoToPhotosAlbum({
                  filePath: '',
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.saveVideoToPhotosAlbum  src success 6' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.saveVideoToPhotosAlbum src fail 6' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.saveVideoToPhotosAlbum src complete 6 ' + JSON.stringify(res));
                  }
                });
              })
              //filePath 参数取值异常 undefined
              Button("filePath undefined ").width(300).onClick(()=>{
                // @ts-ignore
                as.saveVideoToPhotosAlbum({
                  filePath: undefined,
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.saveVideoToPhotosAlbum  src success 7' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.saveVideoToPhotosAlbum src fail 7' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.saveVideoToPhotosAlbum src complete 7 ' + JSON.stringify(res));
                  }
                });
              })
            }
          }

          ListItem(){
            Column({ space: 10 }) {
              Text("as. getVideoInfo(Object)").fontSize(30)
              //图片的路径，可以是相对路径，临时文件路径，存储文件路径，网络图片路径
              //src  String  相对路径
              Button("src 相对路径 ").width(300).onClick(()=>{
                // @ts-ignore
                as.getVideoInfo({
                  src: $r('app.media.video'),
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.getVideoInfo  src success 1' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.getVideoInfo src fail 1' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.getVideoInfo src complete 1 ' + JSON.stringify(res));
                  }
                });

              })
              //src  String  绝对路径
              Button("src 网络https  mp4").width(300).onClick(()=>{
                // @ts-ignore
                as.getVideoInfo({
                  src: 'https://ss0.bdstatic.com/-0U0bnSm1A5BphGlnYG/cae-legoup-video-target/93be3d88-9fc2-4fbd-bd14-833bca731ca7.mp4',
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.getVideoInfo  src success 2' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.getVideoInfo src fail 2' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.getVideoInfo src complete 2 ' + JSON.stringify(res));
                  }
                });
              })
              //src  String  临时文件路径
              Button("src 临时文件路径 ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseVideo({
                  sourceType: ['album'],
                  success: function (res) {
                    // @ts-ignore
                    as.getVideoInfo({
                      src: res.tempFilePath,
                      success: function (res) {
                        console.log('[AdvancedAPIDEMO] as.getVideoInfo  src success 3' + JSON.stringify(res));
                      },
                      fail: (res) => {
                        console.error('[AdvancedAPIDEMO] as.getVideoInfo src fail 3' + JSON.stringify(res));
                      },
                      complete: (res) => {
                        console.log('[AdvancedAPIDEMO] as.getVideoInfo src complete 3 ' + JSON.stringify(res));
                      }
                    });
                  }
                })
              })
              //src  String  存储文件路径
              Button("src 存储文件路径  暂无构造 ").width(300).onClick(()=>{
                // @ts-ignore
                as.getVideoInfo({
                  src: '',
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.getVideoInfo  src success 4' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.getVideoInfo src fail 4' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.getVideoInfo src complete 4 ' + JSON.stringify(res));
                  }
                });

              })
              //src  String  网络图片路径
              Button("src 网络https MP4").width(300).onClick(()=>{
                // @ts-ignore
                as.getVideoInfo({
                  src: 'https://ss0.bdstatic.com/-0U0bnSm1A5BphGlnYG/cae-legoup-video-target/93be3d88-9fc2-4fbd-bd14-833bca731ca7.mp4',
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.getVideoInfo  src success 5' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.getVideoInfo src fail 5' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.getVideoInfo src complete 5 ' + JSON.stringify(res));
                  }
                });

              })
              //src 参数取值类型不同 Number
              Button("src Number ").width(300).onClick(()=>{
                // @ts-ignore
                as.getVideoInfo({
                  src: 7788,
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.getVideoInfo  src success 6' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.getVideoInfo src fail 6' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.getVideoInfo src complete 6 ' + JSON.stringify(res));
                  }
                });

              })
              //src 参数取值类型不同 Object
              Button("src  Object").width(300).onClick(()=>{
                // @ts-ignore
                as.getVideoInfo({
                  src: { 'name':'test' },
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.getVideoInfo  src success 7' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.getVideoInfo src fail 7' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.getVideoInfo src complete 7 ' + JSON.stringify(res));
                  }
                });

              })
              //src 参数取值异常 null
              Button("src null ").width(300).onClick(()=>{
                // @ts-ignore
                as.getVideoInfo({
                  src: null,
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.getVideoInfo  src success 8' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.getVideoInfo src fail 8' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.getVideoInfo src complete 8 ' + JSON.stringify(res));
                  }
                });

              })
              //src 参数取值异常 空字符
              Button("src  空字符").width(300).onClick(()=>{
                // @ts-ignore
                as.getVideoInfo({
                  src: '',
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.getVideoInfo  src success 9' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.getVideoInfo src fail 9' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.getVideoInfo src complete 9 ' + JSON.stringify(res));
                  }
                });

              })
              //src 参数取值异常 undefined
              Button("src undefined ").width(300).onClick(()=>{
                // @ts-ignore
                as.getVideoInfo({
                  src: undefined,
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.getVideoInfo  src success 10' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.getVideoInfo src fail 10' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.getVideoInfo src complete 10 ' + JSON.stringify(res));
                  }
                });

              })
              //src 参数取值类型不同 boolean
              Button("src boolean ").width(300).onClick(()=>{
                // @ts-ignore
                as.getVideoInfo({
                  src: true,
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.getVideoInfo  src success 11' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.getVideoInfo src fail 11' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.getVideoInfo src complete 11 ' + JSON.stringify(res));
                  }
                });

              })
            }
          }

        }.divider({ strokeWidth: 2, color: 0xFFFFFF, startMargin: 20, endMargin: 20 }) // 每行之间的分界线
        .alignListItem(ListItemAlign.Center)
      }
    }
  }
}