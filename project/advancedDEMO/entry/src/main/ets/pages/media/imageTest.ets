// @ts-nocheck
import promptAction from '@ohos.promptAction'

@Entry
@Component
struct image {
  aboutToAppear() {
  }
  build() {
    Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
      Column({ space: 5 }) {
        List({ space: 20, initialIndex: 0 }) {
          ListItem(){
            Text("图片").fontSize(35)
          }
          ListItem(){
            Column({ space: 10 }) {
              Text("as. chooseImage (Object)").fontSize(30)
              //count 参数取值正常值内 Number
              Button("count 取值正常 ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseImage({
                  count: 6,
                  success: function (res) {
                    //                    for (i=0;i<=res.tempFilePaths.length;i++) {
                    //                      res.tempFilePaths
                    //                    }
                    console.log('[AdvancedAPIDEMO] as.chooseImage  count success ' + JSON.stringify(res.tempFilePaths));
                    console.log('[AdvancedAPIDEMO] as.chooseImage  count success ' + JSON.stringify(res.tempFilePaths.length));
                    console.log('[AdvancedAPIDEMO] as.chooseImage  count success ' + JSON.stringify(res.tempFiles));
                    console.log('[AdvancedAPIDEMO] as.chooseImage  count success ' + JSON.stringify(res.tempFiles.length));
                    console.log('[AdvancedAPIDEMO] as.chooseImage  count success ' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.chooseImage count fail ' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.chooseImage count complete ' + JSON.stringify(res));
                  }
                })
              })
              //count 参数 Number -7  小于
              Button("count  -7 ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseImage({
                  count: -7,
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.chooseImage  count success 1' + JSON.stringify(res.tempFilePaths));
                    console.log('[AdvancedAPIDEMO] as.chooseImage  count success 1' + JSON.stringify(res.tempFilePaths.length));
                    console.log('[AdvancedAPIDEMO] as.chooseImage  count success 1' + JSON.stringify(res.tempFiles));
                    console.log('[AdvancedAPIDEMO] as.chooseImage  count success 1' + JSON.stringify(res.tempFiles.length));
                    console.log('[AdvancedAPIDEMO] as.chooseImage  count success 1 ' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.chooseImage count fail 1' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.chooseImage count complete 1' + JSON.stringify(res));
                  }
                })
              })
              //count 参数 Number 12  大于
              Button("count 12 ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseImage({
                  count: 12,
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.chooseImage  count success 2' + JSON.stringify(res.tempFilePaths.length));
                    console.log('[AdvancedAPIDEMO] as.chooseImage  count success 2' + JSON.stringify(res.tempFiles.length));
                    console.log('[AdvancedAPIDEMO] as.chooseImage  count success 2' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.chooseImage count fail 2' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.chooseImage count complete 2' + JSON.stringify(res));
                  }
                })
              })
              //count 参数 Number 0  极端值
              Button("count 0 ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseImage({
                  count: 0,
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.chooseImage  count success 3' + JSON.stringify(res.tempFilePaths.length));
                    console.log('[AdvancedAPIDEMO] as.chooseImage  count success 3' + JSON.stringify(res.tempFiles.length));
                    console.log('[AdvancedAPIDEMO] as.chooseImage  count success 3' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.chooseImage count fail 3' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.chooseImage count complete 3' + JSON.stringify(res));
                  }
                })
              })
              //count 无此参数
              Button("无此参数count ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseImage({
                  //                  count: 6,
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.chooseImage  count success 4' + JSON.stringify(res.tempFilePaths.length));
                    console.log('[AdvancedAPIDEMO] as.chooseImage  count success 4' + JSON.stringify(res.tempFiles.length));
                    console.log('[AdvancedAPIDEMO] as.chooseImage  count success 4' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.chooseImage count fail 4' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.chooseImage count complete 4' + JSON.stringify(res));
                  }
                })
              })
              //count 参数取值类型不同 boolean
              Button("count boolean ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseImage({
                  count: true,
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.chooseImage  count success 5' + JSON.stringify(res.tempFilePaths.length));
                    console.log('[AdvancedAPIDEMO] as.chooseImage  count success 5' + JSON.stringify(res.tempFiles.length));
                    console.log('[AdvancedAPIDEMO] as.chooseImage  count success 5' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.chooseImage count fail 5' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.chooseImage count complete 5 ' + JSON.stringify(res));
                  }
                })
              })
              //count 参数取值类型不同 String
              Button("count String ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseImage({
                  count: 'test',
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.chooseImage  count success 6' + JSON.stringify(res.tempFilePaths.length));
                    console.log('[AdvancedAPIDEMO] as.chooseImage  count success 6' + JSON.stringify(res.tempFiles.length));
                    console.log('[AdvancedAPIDEMO] as.chooseImage  count success 6' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.chooseImage count fail 6' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.chooseImage count complete 6' + JSON.stringify(res));
                  }
                })
              })
              //count 参数取值类型不同 Object
              Button("count Object ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseImage({
                  count: { 'name':'test' },
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.chooseImage  count success 7' + JSON.stringify(res.tempFilePaths.length));
                    console.log('[AdvancedAPIDEMO] as.chooseImage  count success 7' + JSON.stringify(res.tempFiles.length));
                    console.log('[AdvancedAPIDEMO] as.chooseImage  count success 7' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.chooseImage count fail 7' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.chooseImage count complete 7' + JSON.stringify(res));
                  }
                })
              })
              //count 参数取值异常 null
              Button("count null ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseImage({
                  count: null,
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.chooseImage  count success 8' + JSON.stringify(res.tempFilePaths.length));
                    console.log('[AdvancedAPIDEMO] as.chooseImage  count success 8' + JSON.stringify(res.tempFiles.length));
                    console.log('[AdvancedAPIDEMO] as.chooseImage  count success 8' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.chooseImage count fail 8' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.chooseImage count complete 8' + JSON.stringify(res));
                  }
                })
              })
              //count 参数取值异常 空字符
              Button("count 空字符 ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseImage({
                  count: '',
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.chooseImage  count success 9' + JSON.stringify(res.tempFilePaths.length));
                    console.log('[AdvancedAPIDEMO] as.chooseImage  count success 9' + JSON.stringify(res.tempFiles.length));
                    console.log('[AdvancedAPIDEMO] as.chooseImage  count success 9' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.chooseImage count fail 9' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.chooseImage count complete 9' + JSON.stringify(res));
                  }
                })
              })
              //count 参数取值异常 undefined
              Button("count undefined ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseImage({
                  count: undefined,
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.chooseImage  count success 10' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.chooseImage count fail 10' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.chooseImage count complete 10' + JSON.stringify(res));
                  }
                })
              })

              //sourceType 参数 Array<String>  album
              Button("sourceType album ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseImage({
                  sourceType: ['album'],
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.chooseImage  sourceType success' + JSON.stringify(res.tempFilePaths.length));
                    console.log('[AdvancedAPIDEMO] as.chooseImage  sourceType success' + JSON.stringify(res.tempFiles.length));
                    console.log('[AdvancedAPIDEMO] as.chooseImage  sourceType success ' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.chooseImage sourceType fail ' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.chooseImage sourceType complete ' + JSON.stringify(res));
                  }
                })
              })
              //sourceType 参数 Array<String>  camera
              Button("sourceType camera ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseImage({
                  sourceType: ['camera'],
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.chooseImage  sourceType success0 ' + JSON.stringify(res.tempFilePaths.length));
                    console.log('[AdvancedAPIDEMO] as.chooseImage  sourceType success0 ' + JSON.stringify(res.tempFiles.length));
                    console.log('[AdvancedAPIDEMO] as.chooseImage  sourceType success 0' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.chooseImage sourceType fail 0' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.chooseImage sourceType complete 0' + JSON.stringify(res));
                  }
                })
              })
              //sourceType 参数 Array<String> camera，album
              Button("sourceType camera，album ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseImage({
                  sourceType: ['camera','album'],
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.chooseImage  sourceType success00 ' + JSON.stringify(res.tempFilePaths.length));
                    console.log('[AdvancedAPIDEMO] as.chooseImage  sourceType success00 ' + JSON.stringify(res.tempFiles.length));
                    console.log('[AdvancedAPIDEMO] as.chooseImage  sourceType success 00' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.chooseImage sourceType fail 00' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.chooseImage sourceType complete 00' + JSON.stringify(res));
                  }
                })
              })
              //sourceType 无此参数
              Button("sourceType 无此参数").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseImage({
                  //                  sourceType: ['album'],
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.chooseImage  sourceType success1 ' + JSON.stringify(res.tempFilePaths.length));
                    console.log('[AdvancedAPIDEMO] as.chooseImage  sourceType success1 ' + JSON.stringify(res.tempFiles.length));
                    console.log('[AdvancedAPIDEMO] as.chooseImage  sourceType success 1 ' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.chooseImage sourceType fail 1' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.chooseImage sourceType complete ' + JSON.stringify(res));
                  }
                })
              })
              //sourceType 参数取值类型不同 boolean
              Button("sourceType boolean ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseImage({
                  sourceType: true,
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.chooseImage  sourceType success2 ' + JSON.stringify(res.tempFilePaths.length));
                    console.log('[AdvancedAPIDEMO] as.chooseImage  sourceType success2 ' + JSON.stringify(res.tempFiles.length));
                    console.log('[AdvancedAPIDEMO] as.chooseImage  sourceType success 2' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.chooseImage sourceType fail 2' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.chooseImage sourceType complete 2' + JSON.stringify(res));
                  }
                })
              })
              //sourceType 参数取值类型不同 String
              Button("sourceType String ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseImage({
                  sourceType: 'album',
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.chooseImage  sourceType success3 ' + JSON.stringify(res.tempFilePaths.length));
                    console.log('[AdvancedAPIDEMO] as.chooseImage  sourceType success3 ' + JSON.stringify(res.tempFiles.length));
                    console.log('[AdvancedAPIDEMO] as.chooseImage  sourceType success 3' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.chooseImage sourceType fail 3' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.chooseImage sourceType complete 3' + JSON.stringify(res));
                  }
                })
              })
              //sourceType 参数取值类型不同 Object
              Button("sourceType Object ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseImage({
                  sourceType: {'cate':'album'},
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.chooseImage  sourceType success4 ' + JSON.stringify(res.tempFilePaths.length));
                    console.log('[AdvancedAPIDEMO] as.chooseImage  sourceType success4 ' + JSON.stringify(res.tempFiles.length));
                    console.log('[AdvancedAPIDEMO] as.chooseImage  sourceType success 4' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.chooseImage sourceType fail 4' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.chooseImage sourceType complete 4' + JSON.stringify(res));
                  }
                })
              })
              //sourceType 参数取值异常 null
              Button("sourceType null ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseImage({
                  sourceType: null,
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.chooseImage  sourceType success5 ' + JSON.stringify(res.tempFilePaths.length));
                    console.log('[AdvancedAPIDEMO] as.chooseImage  sourceType success5 ' + JSON.stringify(res.tempFiles.length));
                    console.log('[AdvancedAPIDEMO] as.chooseImage  sourceType success 5' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.chooseImage sourceType fail 5' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.chooseImage sourceType complete 5' + JSON.stringify(res));
                  }
                })
              })
              //sourceType 参数取值异常 空字符
              Button("sourceType 空字符 ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseImage({
                  sourceType: '',
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.chooseImage  sourceType success6 ' + JSON.stringify(res.tempFilePaths.length));
                    console.log('[AdvancedAPIDEMO] as.chooseImage  sourceType success6 ' + JSON.stringify(res.tempFiles.length));
                    console.log('[AdvancedAPIDEMO] as.chooseImage  sourceType success 6' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.chooseImage sourceType fail 6' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.chooseImage sourceType complete 6 ' + JSON.stringify(res));
                  }
                })
              })
              //sourceType 参数取值异常 undefined
              Button("sourceType undefined ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseImage({
                  sourceType: undefined,
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.chooseImage  sourceType success7 ' + JSON.stringify(res.tempFilePaths.length));
                    console.log('[AdvancedAPIDEMO] as.chooseImage  sourceType success7 ' + JSON.stringify(res.tempFiles.length));
                    console.log('[AdvancedAPIDEMO] as.chooseImage  sourceType success 7' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.chooseImage sourceType fail 7' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.chooseImage sourceType complete 7' + JSON.stringify(res));
                  }
                })
              })

            }
          }

          ListItem(){
            Column({ space: 10 }) {
              Text("as. getImageInfo(Object)").fontSize(30)
              //图片的路径，可以是相对路径，临时文件路径，存储文件路径，网络图片路径
              //src  String  相对路径
              Button("src 相对路径 ").width(300).onClick(()=>{
                // @ts-ignore
                as.getImageInfo({
                  src: $r('app.media.icon'),
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.getImageInfo  src success 1' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.getImageInfo src fail 1' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.getImageInfo src complete 1 ' + JSON.stringify(res));
                  }
                });

              })
              //src  String  绝对路径
              Button("src 网络http  png").width(300).onClick(()=>{
                // @ts-ignore
                as.getImageInfo({
                  src: 'http://www.huawei.com/Assets/CBG/img/logo.png',
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.getImageInfo  src success 2' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.getImageInfo src fail 2' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.getImageInfo src complete 2 ' + JSON.stringify(res));
                  }
                });

              })
              //src  String  临时文件路径
              Button("src 临时文件路径 ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseImage({
                  count: 1,
                  sourceType: ['album'],
                  success: function (res) {
                    // @ts-ignore
                    as.getImageInfo({
                      src: res.tempFilePaths[0],
                      success: function (res) {
                        console.log('[AdvancedAPIDEMO] as.getImageInfo  src success 3' + JSON.stringify(res));
                      },
                      fail: (res) => {
                        console.error('[AdvancedAPIDEMO] as.getImageInfo src fail 3' + JSON.stringify(res));
                      },
                      complete: (res) => {
                        console.log('[AdvancedAPIDEMO] as.getImageInfo src complete 3 ' + JSON.stringify(res));
                      }
                    });
                  }
                })
              })
              //src  String  存储文件路径
              Button("src 存储文件路径 ").width(300).onClick(()=>{
                // @ts-ignore
                as.getImageInfo({
                  src: 'datashare:///media/image/2',
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.getImageInfo  src success 4' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.getImageInfo src fail 4' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.getImageInfo src complete 4 ' + JSON.stringify(res));
                  }
                });

              })
              //src  String  网络图片路径
              Button("src 网络https jpg").width(300).onClick(()=>{
                // @ts-ignore
                as.getImageInfo({
                  src: 'https://www-file.huawei.com/-/media/corporate/images/home/video/fully_connecte_world_960.jpg',
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.getImageInfo  src success 5' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.getImageInfo src fail 5' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.getImageInfo src complete 5 ' + JSON.stringify(res));
                  }
                });

              })
              //src 参数取值类型不同 Number
              Button("src Number ").width(300).onClick(()=>{
                // @ts-ignore
                as.getImageInfo({
                  src: 7788,
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.getImageInfo  src success 6' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.getImageInfo src fail 6' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.getImageInfo src complete 6 ' + JSON.stringify(res));
                  }
                });

              })
              //src 参数取值类型不同 Object
              Button("src  Object").width(300).onClick(()=>{
                // @ts-ignore
                as.getImageInfo({
                  src: { 'name':'test' },
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.getImageInfo  src success 7' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.getImageInfo src fail 7' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.getImageInfo src complete 7 ' + JSON.stringify(res));
                  }
                });

              })
              //src 参数取值异常 null
              Button("src null ").width(300).onClick(()=>{
                // @ts-ignore
                as.getImageInfo({
                  src: null,
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.getImageInfo  src success 8' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.getImageInfo src fail 8' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.getImageInfo src complete 8 ' + JSON.stringify(res));
                  }
                });

              })
              //src 参数取值异常 空字符
              Button("src  空字符").width(300).onClick(()=>{
                // @ts-ignore
                as.getImageInfo({
                  src: '',
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.getImageInfo  src success 9' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.getImageInfo src fail 9' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.getImageInfo src complete 9 ' + JSON.stringify(res));
                  }
                });

              })
              //src 参数取值异常 undefined
              Button("src undefined ").width(300).onClick(()=>{
                // @ts-ignore
                as.getImageInfo({
                  src: undefined,
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.getImageInfo  src success 10' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.getImageInfo src fail 10' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.getImageInfo src complete 10 ' + JSON.stringify(res));
                  }
                });

              })
              //src 参数取值类型不同 boolean
              Button("src boolean ").width(300).onClick(()=>{
                // @ts-ignore
                as.getImageInfo({
                  src: true,
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.getImageInfo  src success 11' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.getImageInfo src fail 11' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.getImageInfo src complete 11 ' + JSON.stringify(res));
                  }
                });
              })

              Button("src 无此参数").width(300).onClick(()=>{
                // @ts-ignore
                as.getImageInfo({
                  // src: true,
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.getImageInfo  src success 12' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.getImageInfo src fail 12' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.getImageInfo src complete 12 ' + JSON.stringify(res));
                  }
                });
              })



            }
          }

          ListItem(){
            Column({ space: 10 }) {
              Text("as.saveImageToPhotosAlbum").fontSize(30)
              //filePath，图片文件路径，可以是临时文件路径也可以是永久文件路径，不支持网络图片路径
              //filePath  String  相对路径
              Button("filePath 相对路径 ").width(300).onClick(()=>{
                // @ts-ignore
                as.saveImageToPhotosAlbum({
                  filePath:  $r('app.media.icon'),
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.saveImageToPhotosAlbum  src success 0' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.saveImageToPhotosAlbum src fail 0' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.saveImageToPhotosAlbum src complete 0 ' + JSON.stringify(res));
                  }
                });
              })
              //filePath  String  绝对路径
              Button("filePath 网络http  png ").width(300).onClick(()=>{
                // @ts-ignore
                as.saveImageToPhotosAlbum({
                  filePath:  'http://www.huawei.com/Assets/CBG/img/logo.png',
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.saveImageToPhotosAlbum  src success 00' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.saveImageToPhotosAlbum src fail 00' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.saveImageToPhotosAlbum src complete 00 ' + JSON.stringify(res));
                  }
                });
              })
              //filePath  String  临时文件路径
              Button("filePath 临时文件路径 ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseImage({
                  count: 1,
                  sourceType: ['album'],
                  success: function (res) {
                    // @ts-ignore
                    as.saveImageToPhotosAlbum({
                      filePath: res.tempFilePaths[0],
                      success: function (res) {
                        console.log('[AdvancedAPIDEMO] as.saveImageToPhotosAlbum  src success 01' + JSON.stringify(res));
                      },
                      fail: (res) => {
                        console.error('[AdvancedAPIDEMO] as.saveImageToPhotosAlbum src fail 01' + JSON.stringify(res));
                      },
                      complete: (res) => {
                        console.log('[AdvancedAPIDEMO] as.saveImageToPhotosAlbum src complete 01 ' + JSON.stringify(res));
                      }
                    });
                  }
                })

              })
              //filePath  String  存储文件路径
              Button("filePath 存储文件路径 ").width(300).onClick(()=>{
                // @ts-ignore
                as.saveImageToPhotosAlbum({
                  filePath: 'datashare:///media/image/2',
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.saveImageToPhotosAlbum  src success 02' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.saveImageToPhotosAlbum src fail 02' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.saveImageToPhotosAlbum src complete 02 ' + JSON.stringify(res));
                  }
                });
              })
              //filePath  String  网络图片路径
              Button("filePath 网络https jpg ").width(300).onClick(()=>{
                // @ts-ignore
                as.saveImageToPhotosAlbum({
                  filePath: 'https://www-file.huawei.com/-/media/corporate/images/home/video/fully_connecte_world_960.jpg',
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.saveImageToPhotosAlbum  src success 1' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.saveImageToPhotosAlbum src fail 1' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.saveImageToPhotosAlbum src complete 1 ' + JSON.stringify(res));
                  }
                });
              })
              //src 参数取值类型不同 Boolean
              Button("filePath Boolean ").width(300).onClick(()=>{
                // @ts-ignore
                as.saveImageToPhotosAlbum({
                  filePath: true,
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.saveImageToPhotosAlbum  src success 2' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.saveImageToPhotosAlbum src fail 2' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.saveImageToPhotosAlbum src complete 2 ' + JSON.stringify(res));
                  }
                });
              })
              //filePath 参数取值类型不同 Number
              Button("filePath Number ").width(300).onClick(()=>{
                // @ts-ignore
                as.saveImageToPhotosAlbum({
                  filePath: 999,
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.saveImageToPhotosAlbum  src success 3' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.saveImageToPhotosAlbum src fail 3' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.saveImageToPhotosAlbum src complete 3 ' + JSON.stringify(res));
                  }
                });
              })
              //filePath 参数取值类型不同 Object
              Button("filePath Object ").width(300).onClick(()=>{
                // @ts-ignore
                as.saveImageToPhotosAlbum({
                  filePath: { 'name':'test' },
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.saveImageToPhotosAlbum  src success 4' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.saveImageToPhotosAlbum src fail 4' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.saveImageToPhotosAlbum src complete 4 ' + JSON.stringify(res));
                  }
                });
              })
              //filePath 参数取值异常 null
              Button("filePath null ").width(300).onClick(()=>{
                // @ts-ignore
                as.saveImageToPhotosAlbum({
                  filePath: null,
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.saveImageToPhotosAlbum  src success 5' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.saveImageToPhotosAlbum src fail 5' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.saveImageToPhotosAlbum src complete 5 ' + JSON.stringify(res));
                  }
                });
              })
              //filePath 参数取值异常 空字符
              Button("filePath 空字符 ").width(300).onClick(()=>{
                // @ts-ignore
                as.saveImageToPhotosAlbum({
                  filePath: '',
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.saveImageToPhotosAlbum  src success 6' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.saveImageToPhotosAlbum src fail 6' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.saveImageToPhotosAlbum src complete 6 ' + JSON.stringify(res));
                  }
                });
              })
              //filePath 参数取值异常 undefined
              Button("filePath undefined ").width(300).onClick(()=>{
                // @ts-ignore
                as.saveImageToPhotosAlbum({
                  filePath: undefined,
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.saveImageToPhotosAlbum  src success 7' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.saveImageToPhotosAlbum src fail 7' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.saveImageToPhotosAlbum src complete 7 ' + JSON.stringify(res));
                  }
                });
              })

              //filePath 参数取值异常 undefined
              Button("filePath 无此参数 ").width(300).onClick(()=>{
                // @ts-ignore
                as.saveImageToPhotosAlbum({
                  // filePath: undefined,
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.saveImageToPhotosAlbum  src success 8' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.saveImageToPhotosAlbum src fail 8' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.saveImageToPhotosAlbum src complete 8 ' + JSON.stringify(res));
                  }
                });
              })
            }
          }

          ListItem(){
            Column({ space: 10 }) {
              Text("as. compressImage (Object)").fontSize(30)
              //src，图片的路径，可以是相对路径、临时文件路径、存储文件路径
              //src  String  相对路径
              Button("src 相对路径 ").width(300).onClick(()=>{
                // @ts-ignore
                as.compressImage({
                  src: $r('app.media.icon'),
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.compressImage  src success 0 ' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.compressImage src fail 0 ' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.compressImage src complete 0 ' + JSON.stringify(res));
                  }
                });
              })
              //src  String  绝对路径
              Button("src 网络http  png ").width(300).onClick(()=>{
                // @ts-ignore
                as.compressImage({
                  src: 'http://www.huawei.com/Assets/CBG/img/logo.png',
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.compressImage  src success 1' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.compressImage src fail 1' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.compressImage src complete  1' + JSON.stringify(res));
                  }
                });
              })
              //src  String  临时文件路径
              Button("src 临时文件路径 ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseImage({
                  count: 1,
                  sourceType: ['album'],
                  success: function (res) {
                    // @ts-ignore
                    as.compressImage({
                      src: res.tempFilePaths[0],
                      success: function (res) {
                        console.log('[AdvancedAPIDEMO] as.compressImage  src success 2' + JSON.stringify(res));
                      },
                      fail: (res) => {
                        console.error('[AdvancedAPIDEMO] as.compressImage src fail 2' + JSON.stringify(res));
                      },
                      complete: (res) => {
                        console.log('[AdvancedAPIDEMO] as.compressImage src complete  2' + JSON.stringify(res));
                      }
                    });
                  }
                })
              })
              //src  String  存储文件路径
              Button("src 存储文件路径 ").width(300).onClick(()=>{
                // @ts-ignore
                as.compressImage({
                  src: 'datashare:///media/image/2',
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.compressImage  src success 3' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.compressImage src fail 3' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.compressImage src complete 3 ' + JSON.stringify(res));
                  }
                });
              })
              //src  String  网络图片路径
              Button("src 网络https jpg ").width(300).onClick(()=>{
                // @ts-ignore
                as.compressImage({
                  src: 'https://www-file.huawei.com/-/media/corporate/images/home/video/fully_connecte_world_960.jpg',
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.compressImage  src success 4' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.compressImage src fail 4' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.compressImage src complete 4 ' + JSON.stringify(res));
                  }
                });
              })
              //src 参数取值类型不同 boolean
              Button("src boolean ").width(300).onClick(()=>{
                // @ts-ignore
                as.compressImage({
                  src: false,
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.compressImage  src success 5' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.compressImage src fail 5' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.compressImage src complete 5 ' + JSON.stringify(res));
                  }
                });
              })
              //src 参数取值类型不同 Number
              Button("src Number ").width(300).onClick(()=>{
                // @ts-ignore
                as.compressImage({
                  src: 555,
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.compressImage  src success 6' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.compressImage src fail 6' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.compressImage src complete  6' + JSON.stringify(res));
                  }
                });
              })
              //src 参数取值类型不同 Object
              Button("src Object ").width(300).onClick(()=>{
                // @ts-ignore
                as.compressImage({
                  src: { 'name':'test' },
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.compressImage  src success 7' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.compressImage src fail 7' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.compressImage src complete  7' + JSON.stringify(res));
                  }
                });
              })
              //src 参数取值异常 null
              Button("src null ").width(300).onClick(()=>{
                // @ts-ignore
                as.compressImage({
                  src: null,
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.compressImage  src success 8' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.compressImage src fail 8' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.compressImage src complete  8' + JSON.stringify(res));
                  }
                });
              })
              //src 参数取值异常 空字符
              Button("src 空字符 ").width(300).onClick(()=>{
                // @ts-ignore
                as.compressImage({
                  src: '',
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.compressImage  src success 9' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.compressImage src fail 9' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.compressImage src complete  9' + JSON.stringify(res));
                  }
                });
              })
              //src 参数取值异常 undefined
              Button("src undefined ").width(300).onClick(()=>{
                // @ts-ignore
                as.compressImage({
                  src: undefined,
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.compressImage  src success 10 ' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.compressImage src fail 10' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.compressImage src complete  10' + JSON.stringify(res));
                  }
                });
              })

              Button("src 无此参数 ").width(300).onClick(()=>{
                // @ts-ignore
                as.compressImage({
                  //src: undefined,
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.compressImage  src success 11 ' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.compressImage src fail 11' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.compressImage src complete  11' + JSON.stringify(res));
                  }
                });
              })


              //quality 压缩质量，范围0～100，数值越小，质量越低，压缩率越高（仅对jpg有效）
              //quality  Number  jpg   此参数无回调值
              Button("quality Number  jpg ").width(300).onClick(()=>{
                // @ts-ignoree
                as.chooseImage({
                  count: 1,
                  sourceType: ['album'],
                  success: function (res) {
                    // @ts-ignore
                    as.compressImage({
                      src: res.tempFilePaths[0],
                      quality:77,
                      success: function (res) {
                        console.log('[AdvancedAPIDEMO] as.compressImage  quality success 0' + JSON.stringify(res));
                      },
                      fail: (res) => {
                        console.error('[AdvancedAPIDEMO] as.compressImage quality fail 0' + JSON.stringify(res));
                      },
                      complete: (res) => {
                        console.log('[AdvancedAPIDEMO] as.compressImage quality complete  0' + JSON.stringify(res));
                      }
                    });
                  }
                })
              })
              //quality  Number  非jpg
              Button("quality Number 非jpg ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseImage({
                  count: 1,
                  sourceType: ['album'],
                  success: function (res) {
                    // @ts-ignore
                    as.compressImage({
                      src: res.tempFilePaths[0],
                      quality:77,
                      success: function (res) {
                        console.log('[AdvancedAPIDEMO] as.compressImage  quality success 1' + JSON.stringify(res));
                      },
                      fail: (res) => {
                        console.error('[AdvancedAPIDEMO] as.compressImage quality fail 1' + JSON.stringify(res));
                      },
                      complete: (res) => {
                        console.log('[AdvancedAPIDEMO] as.compressImage quality complete  1' + JSON.stringify(res));
                      }
                    });
                  }
                })
              })
              //quality  Number  小于取值范围
              Button("quality 小于取值范围 ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseImage({
                  count: 1,
                  sourceType: ['album'],
                  success: function (res) {
                    // @ts-ignore
                    as.compressImage({
                      src: res.tempFilePaths[0],
                      quality:-40,
                      success: function (res) {
                        console.log('[AdvancedAPIDEMO] as.compressImage  quality success 2' + JSON.stringify(res));
                      },
                      fail: (res) => {
                        console.error('[AdvancedAPIDEMO] as.compressImage quality fail 2' + JSON.stringify(res));
                      },
                      complete: (res) => {
                        console.log('[AdvancedAPIDEMO] as.compressImage quality complete  2' + JSON.stringify(res));
                      }
                    });
                  }
                })
              })
              //quality  Number  大于取值范围
              Button("quality 大于取值范围 ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseImage({
                  count: 1,
                  sourceType: ['album'],
                  success: function (res) {
                    // @ts-ignore
                    as.compressImage({
                      src: res.tempFilePaths[0],
                      quality:277,
                      success: function (res) {
                        console.log('[AdvancedAPIDEMO] as.compressImage  quality success 3' + JSON.stringify(res));
                      },
                      fail: (res) => {
                        console.error('[AdvancedAPIDEMO] as.compressImage quality fail 3' + JSON.stringify(res));
                      },
                      complete: (res) => {
                        console.log('[AdvancedAPIDEMO] as.compressImage quality complete  3' + JSON.stringify(res));
                      }
                    });
                  }
                })
              })
              //quality 参数取值类型不同 boolean
              Button("quality boolean").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseImage({
                  count: 1,
                  sourceType: ['album'],
                  success: function (res) {
                    // @ts-ignore
                    as.compressImage({
                      src: res.tempFilePaths[0],
                      quality:true,
                      success: function (res) {
                        console.log('[AdvancedAPIDEMO] as.compressImage  quality success 4' + JSON.stringify(res));
                      },
                      fail: (res) => {
                        console.error('[AdvancedAPIDEMO] as.compressImage quality fail 4' + JSON.stringify(res));
                      },
                      complete: (res) => {
                        console.log('[AdvancedAPIDEMO] as.compressImage quality complete  4' + JSON.stringify(res));
                      }
                    });
                  }
                })
              })
              //quality 参数取值类型不同 String
              Button("quality String").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseImage({
                  count: 1,
                  sourceType: ['album'],
                  success: function (res) {
                    // @ts-ignore
                    as.compressImage({
                      src: res.tempFilePaths[0],
                      quality:'test',
                      success: function (res) {
                        console.log('[AdvancedAPIDEMO] as.compressImage  quality success 5' + JSON.stringify(res));
                      },
                      fail: (res) => {
                        console.error('[AdvancedAPIDEMO] as.compressImage quality fail 5' + JSON.stringify(res));
                      },
                      complete: (res) => {
                        console.log('[AdvancedAPIDEMO] as.compressImage quality complete 5' + JSON.stringify(res));
                      }
                    });
                  }
                })
              })
              //quality 参数取值类型不同 Object
              Button("quality Object ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseImage({
                  count: 1,
                  sourceType: ['album'],
                  success: function (res) {
                    // @ts-ignore
                    as.compressImage({
                      src: res.tempFilePaths[0],
                      quality: { 'name':'test' },
                      success: function (res) {
                        console.log('[AdvancedAPIDEMO] as.compressImage  quality success 6' + JSON.stringify(res));
                      },
                      fail: (res) => {
                        console.error('[AdvancedAPIDEMO] as.compressImage quality fail 6' + JSON.stringify(res));
                      },
                      complete: (res) => {
                        console.log('[AdvancedAPIDEMO] as.compressImage quality complete  6' + JSON.stringify(res));
                      }
                    });
                  }
                })
              })
              //quality 参数取值异常 null
              Button("quality null ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseImage({
                  count: 1,
                  sourceType: ['album'],
                  success: function (res) {
                    // @ts-ignore
                    as.compressImage({
                      src: res.tempFilePaths[0],
                      quality:null,
                      success: function (res) {
                        console.log('[AdvancedAPIDEMO] as.compressImage  quality success 7' + JSON.stringify(res));
                      },
                      fail: (res) => {
                        console.error('[AdvancedAPIDEMO] as.compressImage quality fail 7' + JSON.stringify(res));
                      },
                      complete: (res) => {
                        console.log('[AdvancedAPIDEMO] as.compressImage quality complete  7' + JSON.stringify(res));
                      }
                    });
                  }
                })
              })
              //quality 参数取值异常 空字符
              Button("quality 空字符 ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseImage({
                  count: 1,
                  sourceType: ['album'],
                  success: function (res) {
                    // @ts-ignore
                    as.compressImage({
                      src: res.tempFilePaths[0],
                      quality:'',
                      success: function (res) {
                        console.log('[AdvancedAPIDEMO] as.compressImage  quality success 8' + JSON.stringify(res));
                      },
                      fail: (res) => {
                        console.error('[AdvancedAPIDEMO] as.compressImage quality fail 8' + JSON.stringify(res));
                      },
                      complete: (res) => {
                        console.log('[AdvancedAPIDEMO] as.compressImage quality complete  8' + JSON.stringify(res));
                      }
                    });
                  }
                })
              })
              //quality 参数取值异常 undefined
              Button("quality undefined ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseImage({
                  count: 1,
                  sourceType: ['album'],
                  success: function (res) {
                    // @ts-ignore
                    as.compressImage({
                      src: res.tempFilePaths[0],
                      quality:undefined,
                      success: function (res) {
                        console.log('[AdvancedAPIDEMO] as.compressImage  quality success 9' + JSON.stringify(res));
                      },
                      fail: (res) => {
                        console.error('[AdvancedAPIDEMO] as.compressImage quality fail 9' + JSON.stringify(res));
                      },
                      complete: (res) => {
                        console.log('[AdvancedAPIDEMO] as.compressImage quality complete  9' + JSON.stringify(res));
                      }
                    });
                  }
                })
              })

            }
          }

        }.divider({ strokeWidth: 2, color: 0xFFFFFF, startMargin: 20, endMargin: 20 }) // 每行之间的分界线
        .alignListItem(ListItemAlign.Center)

      }
    }
  }

}