@Entry
@Component
struct Network {
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
            Text("网络").fontSize(35)
          }

          ListItem(){
            Text("as.request").fontSize(20).fontWeight(FontWeight.Bold)
          }
          // TC1
          ListItem(){
            Button("发起请求").width(300).onClick(()=>{
              // @ts-ignore
              as.request({
                url: 'https://www.huawei.com',
                data: {
                  text: 'as.request'
                },
                header: {
                  'custom-header': 'hello'
                },
                success: (res) => {
                  console.log('[AdvancedAPI] 数据请求成功 ' + res.data); // 内容太长时无法打印
                  AlertDialog.show({ message: 'request success', offset: { dx: 0, dy: -50 } })
                },
                fail: () => {
                  console.error('[AdvancedAPI] 数据请求失败');
                },
                complete: () => {
                  console.log('[AdvancedAPI] 数据请求完成');
                  AlertDialog.show({ message: 'request complete', offset: { dx: 0, dy: 50 } })
                }
              })
            })
          }
          // TC2
          ListItem(){
            Button("参数全空").width(300).onClick(()=>{
              // @ts-ignore
              as.request({
              })
            }).backgroundColor(Color.Orange)
          }
          // TC3
          ListItem(){
            Button("参数缺少必填url").width(300).onClick(()=>{
              // @ts-ignore
              as.request({
                data: {
                  text: 'as.request'
                },
                fail: (err) => {
                  console.error('[AdvancedAPI] 数据请求失败 ' + JSON.stringify(err));
                  AlertDialog.show({ message: 'request fail', offset: { dx: 0, dy: -50 } })
                },
                complete: (res) => {
                  console.log('[AdvancedAPI] 数据请求完成' + JSON.stringify(res));
                  AlertDialog.show({ message: 'request complete', offset: { dx: 0, dy: 50 } })
                }
              })
            }).backgroundColor(Color.Orange)
          }
          // TC4
          ListItem(){
            Button("参数只有url").width(300).onClick(()=>{
              // @ts-ignore
              as.request({
                url: 'https://www.baidu.com',
              })
            }).backgroundColor(Color.Orange)
          }
          // TC5
          ListItem(){
            Button("错误的url").width(300).onClick(()=>{
              // @ts-ignore
              as.request({
                url: 'https://www.abcdef.com',
                timeout: 6000,
                fail: (err) => {
                  console.error('[AdvancedAPI] 数据请求失败 ' + JSON.stringify(err));
                  AlertDialog.show({ message: 'request fail' })
                }
              })
            }).backgroundColor(Color.Orange)
          }
          // TC6
          ListItem(){
            Button("url传入错误类型").width(300).onClick(()=>{
              // @ts-ignore
              as.request({
                url: 10086,
                fail: (err) => {
                  console.error('[AdvancedAPI] 数据请求失败 ' + JSON.stringify(err));
                  AlertDialog.show({ message: 'request fail' })
                }
              })
            }).backgroundColor(Color.Orange)
          }
          // TC7
          ListItem(){
            Button("非默认Method").width(300).onClick(()=>{
              // @ts-ignore
              as.request({
                url: 'https://www.huawei.com',
                data: {
                  text: 'as.request'
                },
                header: {
                  'custom-header': 'hello'
                },
                method: 'POST',
                success: (res) => {
                  console.log('[AdvancedAPI] 数据请求成功 ' + res.data);
                  AlertDialog.show({ message: 'request success' })
                },
                fail: () => {
                  console.error('[AdvancedAPI] 数据请求失败');
                  AlertDialog.show({ message: 'request fail' })
                }
              })
            }).backgroundColor(Color.Orange)
          }
          // TC8
          ListItem(){
            Button("超时1ms").width(300).onClick(()=>{
              // @ts-ignore
              as.request({
                url: 'https://www.google.com',
                data: {
                  text: 'as.request'
                },
                header: {
                  'custom-header': 'hello'
                },
                timeout: 1,
                success: (res) => {
                  console.log('[AdvancedAPI] 数据请求成功 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'request success' })
                },
                fail: (err) => {
                  console.error('[AdvancedAPI] 数据请求失败' + JSON.stringify(err));
                  AlertDialog.show({ message: 'request fail' })
                }
              })
            }).backgroundColor(Color.Orange)
          }
          // TC9
          ListItem(){
            Button("参数只有回调").width(300).onClick(()=>{
              // @ts-ignore
              as.request({
                fail: (err) => {
                  console.error('[AdvancedAPI] 数据请求失败 ' + JSON.stringify(err));
                  AlertDialog.show({ message: 'request fail', offset: { dx: 0, dy: -50 } })
                },
                complete: (res) => {
                  console.log('[AdvancedAPI] 数据请求完成' + JSON.stringify(res));
                  AlertDialog.show({ message: 'request complete', offset: { dx: 0, dy: 50 } })
                }
              })
            }).backgroundColor(Color.Orange)
          }

          ListItem(){
            Text("requestTask").fontSize(20).fontWeight(FontWeight.Bold)
          }
          // TC1
          ListItem(){
            Button("abort").width(300).onClick(()=>{
              // @ts-ignore
              this.requestTask = as.request({
                url: 'https://www.google.com',
                data: {
                  text: 'as.request'
                },
                header: {
                  'custom-header': 'hello'
                },
                success: (res) => {
                  console.log('[AdvancedAPI] 数据请求成功');
                  AlertDialog.show({ message: 'request success' })
                },
                fail: () => {
                  console.error('[AdvancedAPI] 数据请求失败');
                  AlertDialog.show({ message: 'request fail' })
                }
              })
              // @ts-ignore
              this.requestTask.abort()
            })
          }
          // TC2
          ListItem(){
            Button("onHeadersReceived").width(300).onClick(()=>{
              // @ts-ignore
              this.requestTask = as.request({
                url: 'https://www.baidu.com',
                data: {
                  text: 'as.request'
                },
                header: {
                  'custom-header': 'hello'
                },
                success: (res) => {
                  console.log('[AdvancedAPI] 数据请求成功');
                },
                fail: () => {
                  console.error('[AdvancedAPI] 数据请求失败');
                }
              })
              // @ts-ignore
              this.requestTask.onHeadersReceived(function (res) {
                console.log('[AdvancedAPI] requestTask onHeadersReceived ：' + JSON.stringify(res));
                AlertDialog.show({ message: 'Received Headers' })
              })
            })
          }
          // TC3
          ListItem(){
            Button("offHeadersReceived").width(300).onClick(()=>{
              // @ts-ignore
              this.requestTask = as.request({
                url: 'https://www.baidu.com',
                data: {
                  text: 'as.request'
                },
                header: {
                  'custom-header': 'hello'
                },
                success: (res) => {
                  console.log('[AdvancedAPI] 数据请求成功');
                },
                fail: () => {
                  console.error('[AdvancedAPI] 数据请求失败');
                }
              })
              // @ts-ignore
              this.requestTask.onHeadersReceived(function (res) {
                AlertDialog.show({ message: 'Received Headers' })
              })
              // @ts-ignore
              this.requestTask.offHeadersReceived()
            })
          }

          ListItem(){
            Text("as.downloadFile").fontSize(20).fontWeight(FontWeight.Bold)
          }
          // TC1
          ListItem(){
            Button("下载文件").width(300).onClick(()=>{
              // @ts-ignore
              as.downloadFile({
                url: 'https://www.huawei.com/Assets/CBG/img/logo.png',
                filePath: `${globalThis.abilityContext.cacheDir}/logo.png`,
                success: (res) => {
                  console.log('[AdvancedAPI] 文件下载成功 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'download success', offset: { dx: 0, dy: -50 } })
                },
                fail: (err) => {
                  console.error('[AdvancedAPI] 文件下载失败 ' + JSON.stringify(err));
                  AlertDialog.show({ message: 'download fail', offset: { dx: 0, dy: -50 } })
                },
                complete: (res) => {
                  console.log('[AdvancedAPI] 文件下载完成 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'download complete', offset: { dx: 0, dy: 50 } })
                }
              })
            })
          }
          // TC2
          ListItem(){
            Button("参数为空").width(300).onClick(()=>{
              // @ts-ignore
              as.downloadFile()
            }).backgroundColor(Color.Orange)
          }
          // TC3
          ListItem(){
            Button("无必填参数url").width(300).onClick(()=>{
              // @ts-ignore
              as.downloadFile({
                filePath: `${globalThis.abilityContext.cacheDir}/logo.png`,
                success: (res) => {
                  console.log('[AdvancedAPI] 文件下载成功 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'download success', offset: { dx: 0, dy: -50 } })
                },
                fail: (err) => {
                  console.error('[AdvancedAPI] 文件下载失败 ' + JSON.stringify(err));
                  AlertDialog.show({ message: 'download fail', offset: { dx: 0, dy: -50 } })
                },
                complete: (res) => {
                  console.log('[AdvancedAPI] 文件下载完成 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'download complete', offset: { dx: 0, dy: 50 } })
                }
              })
            }).backgroundColor(Color.Orange)
          }
          // TC4
          ListItem(){
            Button("url的网址不可访问").width(300).onClick(()=>{
              // @ts-ignore
              as.downloadFile({
                url: 'https://www.abcde.com/Assets/CBG/img/logo.png',
                filePath: `${globalThis.abilityContext.cacheDir}/test.png`,
                success: (res) => {
                  console.log('[AdvancedAPI] 文件下载成功 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'download success', offset: { dx: 0, dy: -50 } })
                },
                fail: (err) => {
                  console.error('[AdvancedAPI] 文件下载失败 ' + JSON.stringify(err));
                  AlertDialog.show({ message: 'download fail', offset: { dx: 0, dy: -50 } })
                },
                complete: (res) => {
                  console.log('[AdvancedAPI] 文件下载完成 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'download complete', offset: { dx: 0, dy: 50 } })
                }
              })
            }).backgroundColor(Color.Orange)
          }
          // TC5
          ListItem(){
            Button("url的文件不存在").width(300).onClick(()=>{
              // @ts-ignore
              as.downloadFile({
                url: 'https://www.huawei.com/Assets/CBG/img/null.png',
                filePath: `${globalThis.abilityContext.cacheDir}/null.png`,
                success: (res) => {
                  console.log('[AdvancedAPI] 文件下载成功 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'download success', offset: { dx: 0, dy: -50 } })
                },
                fail: (err) => {
                  console.error('[AdvancedAPI] 文件下载失败 ' + JSON.stringify(err));
                  AlertDialog.show({ message: 'download fail', offset: { dx: 0, dy: -50 } })
                },
                complete: (res) => {
                  console.log('[AdvancedAPI] 文件下载完成 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'download complete', offset: { dx: 0, dy: 50 } })
                }
              })
            }).backgroundColor(Color.Orange)
          }
          // TC6
          ListItem(){
            Button("url非网络地址").width(300).onClick(()=>{
              // @ts-ignore
              as.downloadFile({
                url: 'Assets/CBG/img/logo.png',
                filePath: `${globalThis.abilityContext.cacheDir}/logo.png`,
                success: (res) => {
                  console.log('[AdvancedAPI] 文件下载成功 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'download success', offset: { dx: 0, dy: -50 } })
                },
                fail: (err) => {
                  console.error('[AdvancedAPI] 文件下载失败 ' + JSON.stringify(err));
                  AlertDialog.show({ message: 'download fail', offset: { dx: 0, dy: -50 } })
                },
                complete: (res) => {
                  console.log('[AdvancedAPI] 文件下载完成 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'download complete', offset: { dx: 0, dy: 50 } })
                }
              })
            }).backgroundColor(Color.Orange)
          }
          // TC7
          ListItem(){
            Button("url非String").width(300).onClick(()=>{
              // @ts-ignore
              as.downloadFile({
                url: 10086,
                filePath: `${globalThis.abilityContext.cacheDir}/logo.png`,
                success: (res) => {
                  console.log('[AdvancedAPI] 文件下载成功 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'download success', offset: { dx: 0, dy: -50 } })
                },
                fail: (err) => {
                  console.error('[AdvancedAPI] 文件下载失败 ' + JSON.stringify(err));
                  AlertDialog.show({ message: 'download fail', offset: { dx: 0, dy: -50 } })
                },
                complete: (res) => {
                  console.log('[AdvancedAPI] 文件下载完成 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'download complete', offset: { dx: 0, dy: 50 } })
                }
              })
            }).backgroundColor(Color.Orange)
          }
          // TC8
          ListItem(){
            Button("不填filePath").width(300).onClick(()=>{
              // @ts-ignore
              as.downloadFile({
                url: 'https://www.huawei.com/Assets/CBG/img/logo.png',
                success: (res) => {
                  console.log('[AdvancedAPI] 文件下载成功 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'download success', offset: { dx: 0, dy: -50 } })
                },
                fail: (err) => {
                  console.error('[AdvancedAPI] 文件下载失败 ' + JSON.stringify(err));
                  AlertDialog.show({ message: 'download fail', offset: { dx: 0, dy: -50 } })
                },
                complete: (res) => {
                  console.log('[AdvancedAPI] 文件下载完成 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'download complete', offset: { dx: 0, dy: 50 } })
                }
              })
            }).backgroundColor(Color.Orange)
          }
          // TC9
          ListItem(){
            Button("filePath非沙盒路径").width(300).onClick(()=>{
              // @ts-ignore
              as.downloadFile({
                url: 'https://www.huawei.com/Assets/CBG/img/logo.png',
                filePath: `/data/app/el2/100/base/com.huawei.advancedDEMO/haps/advancedDEMO/cache/logo.png`,
                success: (res) => {
                  console.log('[AdvancedAPI] 文件下载成功 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'download success', offset: { dx: 0, dy: -50 } })
                },
                fail: (err) => {
                  console.error('[AdvancedAPI] 文件下载失败 ' + JSON.stringify(err));
                  AlertDialog.show({ message: 'download fail', offset: { dx: 0, dy: -50 } })
                },
                complete: (res) => {
                  console.log('[AdvancedAPI] 文件下载完成 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'download complete', offset: { dx: 0, dy: 50 } })
                }
              })
            }).backgroundColor(Color.Orange)
          }
          // TC10
          ListItem(){
            Button("filePath非路径").width(300).onClick(()=>{
              // @ts-ignore
              as.downloadFile({
                url: 'https://www.huawei.com/Assets/CBG/img/logo.png',
                filePath: `123456/logo.png`,
                success: (res) => {
                  console.log('[AdvancedAPI] 文件下载成功 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'download success', offset: { dx: 0, dy: -50 } })
                },
                fail: (err) => {
                  console.error('[AdvancedAPI] 文件下载失败 ' + JSON.stringify(err));
                  AlertDialog.show({ message: 'download fail', offset: { dx: 0, dy: -50 } })
                },
                complete: (res) => {
                  console.log('[AdvancedAPI] 文件下载完成 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'download complete', offset: { dx: 0, dy: 50 } })
                }
              })
            }).backgroundColor(Color.Orange)
          }

          ListItem(){
            Text("downloadTask").fontSize(20).fontWeight(FontWeight.Bold)
          }
          // TC1
          ListItem(){
            Button("abort").width(300).onClick(()=>{
              // @ts-ignore
              this.task = as.downloadFile({
                url: 'https://www.huawei.com/Assets/CBG/img/logo.png',
                filePath: `${globalThis.abilityContext.cacheDir}/1.png`,
                success: (res) => {
                  console.log('[AdvancedAPI] 文件下载成功 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'download success', offset: { dx: 0, dy: -50 } })
                },
                fail: (err) => {
                  console.error('[AdvancedAPI] 文件下载失败 ' + JSON.stringify(err));
                  AlertDialog.show({ message: 'download fail', offset: { dx: 0, dy: -50 } })
                },
                complete: (res) => {
                  console.log('[AdvancedAPI] 文件下载完成 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'download complete', offset: { dx: 0, dy: 50 } })
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
              this.task = as.downloadFile({
                url: 'https://www.huawei.com/Assets/CBG/img/logo.png',
                filePath: `${globalThis.abilityContext.cacheDir}/2.png`,
                success: (res) => {
                  console.log('[AdvancedAPI] 文件下载成功');
                },
                fail: (err) => {
                  console.error('[AdvancedAPI] 文件下载失败 ' + JSON.stringify(err));
                },
                complete: (res) => {
                  console.log('[AdvancedAPI] 文件下载完成');
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
              this.task = as.downloadFile({
                url: 'https://www.huawei.com/Assets/CBG/img/logo.png',
                filePath: `${globalThis.abilityContext.cacheDir}/3.png`,
                success: (res) => {
                  console.log('[AdvancedAPI] 文件下载成功');
                },
                fail: (err) => {
                  console.error('[AdvancedAPI] 文件下载失败 ' + JSON.stringify(err));
                },
                complete: (res) => {
                  console.log('[AdvancedAPI] 文件下载完成');
                }
              })
              // @ts-ignore
              this.task.onProgressUpdate(this.progressCallback1)
              // @ts-ignore
              this.task.onProgressUpdate(this.progressCallback2)
            }).backgroundColor(Color.Orange)
          }
          // TC4
          ListItem(){
            Button("onProgressUpdate 回调空").width(300).onClick(()=>{
              // @ts-ignore
              this.task = as.downloadFile({
                url: 'https://www.huawei.com/Assets/CBG/img/logo.png',
                filePath: `${globalThis.abilityContext.cacheDir}/4.png`,
                success: (res) => {
                  console.log('[AdvancedAPI] 文件下载成功');
                },
                fail: (err) => {
                  console.error('[AdvancedAPI] 文件下载失败 ' + JSON.stringify(err));
                },
                complete: (res) => {
                  console.log('[AdvancedAPI] 文件下载完成');
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
              this.task = as.downloadFile({
                url: 'https://www.huawei.com/Assets/CBG/img/logo.png',
                filePath: `${globalThis.abilityContext.cacheDir}/5.png`,
                success: (res) => {
                  console.log('[AdvancedAPI] 文件下载成功');
                },
                fail: (err) => {
                  console.error('[AdvancedAPI] 文件下载失败 ' + JSON.stringify(err));
                },
                complete: (res) => {
                  console.log('[AdvancedAPI] 文件下载完成');
                }
              })
              // @ts-ignore
              this.task.onProgressUpdate(this.progressCallback1)
              // @ts-ignore
              this.task.onProgressUpdate(this.progressCallback2)
              // @ts-ignore
              this.task.offProgressUpdate(this.progressCallback1)
            })
          }
          // TC6
          ListItem(){
            Button("offProgressUpdate 取消不存在").width(300).onClick(()=>{
              // @ts-ignore
              this.task = as.downloadFile({
                url: 'https://www.huawei.com/Assets/CBG/img/logo.png',
                filePath: `${globalThis.abilityContext.cacheDir}/6.png`,
                success: (res) => {
                  console.log('[AdvancedAPI] 文件下载成功');
                },
                fail: (err) => {
                  console.error('[AdvancedAPI] 文件下载失败 ' + JSON.stringify(err));
                },
                complete: (res) => {
                  console.log('[AdvancedAPI] 文件下载完成');
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
              this.task = as.downloadFile({
                url: 'https://www.huawei.com/Assets/CBG/img/logo.png',
                filePath: `${globalThis.abilityContext.cacheDir}/7.png`,
                success: (res) => {
                  console.log('[AdvancedAPI] 文件下载成功');
                },
                fail: (err) => {
                  console.error('[AdvancedAPI] 文件下载失败 ' + JSON.stringify(err));
                },
                complete: (res) => {
                  console.log('[AdvancedAPI] 文件下载完成');
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

          ListItem(){
            Text("as.uploadFile").fontSize(20).fontWeight(FontWeight.Bold)
          }
          // TC1
          ListItem(){
            Button("上传文件").width(300).onClick(()=>{
              // @ts-ignore
              as.uploadFile({
                url: 'http://192.168.43.120/upload',
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
                url: 'http://192.168.43.120/upload',
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
                url: 'http://192.168.43.120/upload',
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
                url: 'http://192.168.43.120/upload',
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
                url: 'http://192.168.43.120/upload',
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
                url: 'http://192.168.43.120/upload',
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
                url: 'http://192.168.43.120/upload',
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
                url: 'http://192.168.43.120/upload',
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
                url: 'http://192.168.43.120/upload',
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
                url: 'http://192.168.43.120/upload',
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
                url: 'http://192.168.43.120/upload',
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
                url: 'http://192.168.43.120/upload',
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
                url: 'http://192.168.43.120/upload',
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
                url: 'http://192.168.43.120/upload',
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
                url: 'http://192.168.43.120/upload',
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
                url: 'http://192.168.43.120/upload',
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

          ListItem(){
            Text("as.connectSocket").fontSize(20).fontWeight(FontWeight.Bold)
          }
          // TC1
          ListItem(){
            Button("创建连接").width(300).onClick(()=>{
              // @ts-ignore
              as.connectSocket({
                url: 'ws://websocket-echo.com',
                header: {
                  'content-type': 'application/json'
                },
                protocols: ['protocol1'],
                method: 'GET',
                success: (res) => {
                  console.log('[AdvancedAPI] Socket连接成功 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'connect success', offset: { dx: 0, dy: -50 } })
                },
                fail: (err) => {
                  console.error('[AdvancedAPI] Socket连接失败 ' + JSON.stringify(err));
                  AlertDialog.show({ message: 'connect fail', offset: { dx: 0, dy: -50 } })
                },
                complete: (res) => {
                  console.log('[AdvancedAPI] Socket连接完成 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'connect complete', offset: { dx: 0, dy: 50 } })
                }
              })
            })
          }
          // TC2
          ListItem(){
            Button("无参数").width(300).onClick(()=>{
              // @ts-ignore
              as.connectSocket()
            }).backgroundColor(Color.Orange)
          }
          // TC3
          ListItem(){
            Button("无必填参数url").width(300).onClick(()=>{
              // @ts-ignore
              as.connectSocket({
                success: (res) => {
                  console.log('[AdvancedAPI] Socket连接成功 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'connect success', offset: { dx: 0, dy: -50 } })
                },
                fail: (err) => {
                  console.error('[AdvancedAPI] Socket连接失败 ' + JSON.stringify(err));
                  AlertDialog.show({ message: 'connect fail', offset: { dx: 0, dy: -50 } })
                },
                complete: (res) => {
                  console.log('[AdvancedAPI] Socket连接完成 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'connect complete', offset: { dx: 0, dy: 50 } })
                }
              })
            }).backgroundColor(Color.Orange)
          }
          // TC4
          ListItem(){
            Button("无效的url").width(300).onClick(()=>{
              // @ts-ignore
              as.connectSocket({
                url: '',
                success: (res) => {
                  console.log('[AdvancedAPI] Socket连接成功 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'connect success', offset: { dx: 0, dy: -50 } })
                },
                fail: (err) => {
                  console.error('[AdvancedAPI] Socket连接失败 ' + JSON.stringify(err));
                  AlertDialog.show({ message: 'connect fail', offset: { dx: 0, dy: -50 } })
                },
                complete: (res) => {
                  console.log('[AdvancedAPI] Socket连接完成 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'connect complete', offset: { dx: 0, dy: 50 } })
                }
              })
            }).backgroundColor(Color.Orange)
          }
          // TC5
          ListItem(){
            Button("非String类型url").width(300).onClick(()=>{
              // @ts-ignore
              as.connectSocket({
                url: 10000,
                success: (res) => {
                  console.log('[AdvancedAPI] Socket连接成功 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'connect success', offset: { dx: 0, dy: -50 } })
                },
                fail: (err) => {
                  console.error('[AdvancedAPI] Socket连接失败 ' + JSON.stringify(err));
                  AlertDialog.show({ message: 'connect fail', offset: { dx: 0, dy: -50 } })
                },
                complete: (res) => {
                  console.log('[AdvancedAPI] Socket连接完成 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'connect complete', offset: { dx: 0, dy: 50 } })
                }
              })
            }).backgroundColor(Color.Orange)
          }
          // TC6
          ListItem(){
            Button("只有必填参数url").width(300).onClick(()=>{
              // @ts-ignore
              as.connectSocket({
                url: 'ws://websocket-echo.com'
              })
            }).backgroundColor(Color.Orange)
          }
          // TC7
          ListItem(){
            Button("multiple参数为true").width(300).onClick(()=>{
              // @ts-ignore
              as.connectSocket({
                url: 'ws://websocket-echo.com',
                multiple: true,
                success: (res) => {
                  console.log('[AdvancedAPI] Socket连接成功 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'connect success', offset: { dx: 0, dy: -50 } })
                },
                fail: (err) => {
                  console.error('[AdvancedAPI] Socket连接失败 ' + JSON.stringify(err));
                  AlertDialog.show({ message: 'connect fail', offset: { dx: 0, dy: -50 } })
                },
                complete: (res) => {
                  console.log('[AdvancedAPI] Socket连接完成 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'connect complete', offset: { dx: 0, dy: 50 } })
                }
              })
            }).backgroundColor(Color.Orange)
          }

          ListItem(){
            Text("as.sendSocketMessage").fontSize(20).fontWeight(FontWeight.Bold)
          }
          // TC1
          ListItem(){
            Button("发送String").width(300).onClick(()=>{
              // @ts-ignore
              as.sendSocketMessage({
                data: "I am message",
                success: (res) => {
                  console.log('[AdvancedAPI] Socket发送成功 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'send success', offset: { dx: 0, dy: -50 } })
                },
                fail: (err) => {
                  console.error('[AdvancedAPI] Socket发送失败 ' + JSON.stringify(err));
                  AlertDialog.show({ message: 'send fail', offset: { dx: 0, dy: -50 } })
                },
                complete: (res) => {
                  console.log('[AdvancedAPI] Socket发送完成 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'send complete', offset: { dx: 0, dy: 50 } })
                }
              })
            })
          }
          // TC2
          ListItem(){
            Button("发送无data").width(300).onClick(()=>{
              // @ts-ignore
              as.sendSocketMessage({
                success: (res) => {
                  console.log('[AdvancedAPI] Socket发送成功 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'send success', offset: { dx: 0, dy: -50 } })
                },
                fail: (err) => {
                  console.error('[AdvancedAPI] Socket发送失败 ' + JSON.stringify(err));
                  AlertDialog.show({ message: 'send fail', offset: { dx: 0, dy: -50 } })
                },
                complete: (res) => {
                  console.log('[AdvancedAPI] Socket发送完成 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'send complete', offset: { dx: 0, dy: 50 } })
                }
              })
            }).backgroundColor(Color.Orange)
          }
          // TC3
          ListItem(){
            Button("发送Number").width(300).onClick(()=>{
              // @ts-ignore
              as.sendSocketMessage({
                data: 10010,
                success: (res) => {
                  console.log('[AdvancedAPI] Socket发送成功 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'send success', offset: { dx: 0, dy: -50 } })
                },
                fail: (err) => {
                  console.error('[AdvancedAPI] Socket发送失败 ' + JSON.stringify(err));
                  AlertDialog.show({ message: 'send fail', offset: { dx: 0, dy: -50 } })
                },
                complete: (res) => {
                  console.log('[AdvancedAPI] Socket发送完成 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'send complete', offset: { dx: 0, dy: 50 } })
                }
              })
            }).backgroundColor(Color.Orange)
          }
          // TC4
          ListItem(){
            Button("发送ArrayBuffer").width(300).onClick(()=>{
              // @ts-ignore
              as.sendSocketMessage({
                data: new ArrayBuffer(10),
                success: (res) => {
                  console.log('[AdvancedAPI] Socket发送成功 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'send success', offset: { dx: 0, dy: -50 } })
                },
                fail: (err) => {
                  console.error('[AdvancedAPI] Socket发送失败 ' + JSON.stringify(err));
                  AlertDialog.show({ message: 'send fail', offset: { dx: 0, dy: -50 } })
                },
                complete: (res) => {
                  console.log('[AdvancedAPI] Socket发送完成 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'send complete', offset: { dx: 0, dy: 50 } })
                }
              })
            }).backgroundColor(Color.Orange)
          }

          ListItem(){
            Text("as.closeSocket").fontSize(20).fontWeight(FontWeight.Bold)
          }
          // TC1
          ListItem(){
            Button("关闭连接").width(300).onClick(()=>{
              // @ts-ignore
              as.closeSocket({
                code: 1000,
                reason: 'aaa',
                success: (res) => {
                  console.log('[AdvancedAPI] Socket关闭成功 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'close success', offset: { dx: 0, dy: -50 } })
                },
                fail: (err) => {
                  console.error('[AdvancedAPI] Socket关闭失败 ' + JSON.stringify(err));
                  AlertDialog.show({ message: 'close fail', offset: { dx: 0, dy: -50 } })
                },
                complete: (res) => {
                  console.log('[AdvancedAPI] Socket关闭完成 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'close complete', offset: { dx: 0, dy: 50 } })
                }
              })
            })
          }
          // TC2
          ListItem(){
            Button("非默认code").width(300).onClick(()=>{
              // @ts-ignore
              as.closeSocket({
                code: 9999,
                success: (res) => {
                  console.log('[AdvancedAPI] Socket关闭成功 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'close success', offset: { dx: 0, dy: -50 } })
                },
                fail: (err) => {
                  console.error('[AdvancedAPI] Socket关闭失败 ' + JSON.stringify(err));
                  AlertDialog.show({ message: 'close fail', offset: { dx: 0, dy: -50 } })
                },
                complete: (res) => {
                  console.log('[AdvancedAPI] Socket关闭完成 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'close complete', offset: { dx: 0, dy: 50 } })
                }
              })
            }).backgroundColor(Color.Orange)
          }
          // TC3
          ListItem(){
            Button("非Number类型code").width(300).onClick(()=>{
              // @ts-ignore
              as.closeSocket({
                code: 'abc',
                success: (res) => {
                  console.log('[AdvancedAPI] Socket关闭成功 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'close success', offset: { dx: 0, dy: -50 } })
                },
                fail: (err) => {
                  console.error('[AdvancedAPI] Socket关闭失败 ' + JSON.stringify(err));
                  AlertDialog.show({ message: 'close fail', offset: { dx: 0, dy: -50 } })
                },
                complete: (res) => {
                  console.log('[AdvancedAPI] Socket关闭完成 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'close complete', offset: { dx: 0, dy: 50 } })
                }
              })
            }).backgroundColor(Color.Orange)
          }
          // TC4
          ListItem(){
            Button("参数带reason").width(300).onClick(()=>{
              // @ts-ignore
              as.closeSocket({
                reason: 'aaa',
                success: (res) => {
                  console.log('[AdvancedAPI] Socket关闭成功 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'close success', offset: { dx: 0, dy: -50 } })
                },
                fail: (err) => {
                  console.error('[AdvancedAPI] Socket关闭失败 ' + JSON.stringify(err));
                  AlertDialog.show({ message: 'close fail', offset: { dx: 0, dy: -50 } })
                },
                complete: (res) => {
                  console.log('[AdvancedAPI] Socket关闭完成 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'close complete', offset: { dx: 0, dy: 50 } })
                }
              })
            }).backgroundColor(Color.Orange)
          }
          // TC5
          ListItem(){
            Button("非String类型reason").width(300).onClick(()=>{
              // @ts-ignore
              as.closeSocket({
                reason: 10086,
                success: (res) => {
                  console.log('[AdvancedAPI] Socket关闭成功 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'close success', offset: { dx: 0, dy: -50 } })
                },
                fail: (err) => {
                  console.error('[AdvancedAPI] Socket关闭失败 ' + JSON.stringify(err));
                  AlertDialog.show({ message: 'close fail', offset: { dx: 0, dy: -50 } })
                },
                complete: (res) => {
                  console.log('[AdvancedAPI] Socket关闭完成 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'close complete', offset: { dx: 0, dy: 50 } })
                }
              })
            }).backgroundColor(Color.Orange)
          }
          // TC6
          ListItem(){
            Button("reason超123字符").width(300).onClick(()=>{
              // @ts-ignore
              as.closeSocket({
                code: 1000,
                reason: '0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789',
                success: (res) => {
                  console.log('[AdvancedAPI] Socket关闭成功 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'close success', offset: { dx: 0, dy: -50 } })
                },
                fail: (err) => {
                  console.error('[AdvancedAPI] Socket关闭失败 ' + JSON.stringify(err));
                  AlertDialog.show({ message: 'close fail', offset: { dx: 0, dy: -50 } })
                },
                complete: (res) => {
                  console.log('[AdvancedAPI] Socket关闭完成 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'close complete', offset: { dx: 0, dy: 50 } })
                }
              })
            }).backgroundColor(Color.Orange)
          }

          ListItem(){
            Text("as.onSocketOpen").fontSize(20).fontWeight(FontWeight.Bold)
          }
          // TC1
          ListItem(){
            Button("回调带参数").width(300).onClick(()=>{
              // @ts-ignore
              as.onSocketOpen(function (res) {
                console.log('[AdvancedAPI] 监听到Socket连接已打开！ ' + JSON.stringify(res));
                AlertDialog.show({ message: 'Socket Open Params', offset: { dx: 0, dy: 200 } })
              })
            })
          }
          // TC2
          ListItem(){
            Button("回调不带参数").width(300).onClick(()=>{
              // @ts-ignore
              as.onSocketOpen(function () {
                console.log('[AdvancedAPI] 监听到Socket连接已打开！');
                AlertDialog.show({ message: 'Socket Open No Params', offset: { dx: 0, dy: 200 } })
              })
            }).backgroundColor(Color.Orange)
          }
          // TC3
          ListItem(){
            Button("回调空").width(300).onClick(()=>{
              // @ts-ignore
              as.onSocketOpen()
            }).backgroundColor(Color.Orange)
          }

          ListItem(){
            Text("as.onSocketError").fontSize(20).fontWeight(FontWeight.Bold)
          }
          // TC1
          ListItem(){
            Button("回调带参数").width(300).onClick(()=>{
              // @ts-ignore
              as.onSocketError(function (res) {
                console.log('[AdvancedAPI] 监听到Socket报错！' + JSON.stringify(res));
                AlertDialog.show({ message: 'Socket Error Params', offset: { dx: 0, dy: 200 } })
              })
            })
          }
          // TC2
          ListItem(){
            Button("回调不带参数").width(300).onClick(()=>{
              // @ts-ignore
              as.onSocketError(function () {
                console.log('[AdvancedAPI] 监听到Socket报错!');
                AlertDialog.show({ message: 'Socket Error No Params', offset: { dx: 0, dy: 200 } })
              })
            }).backgroundColor(Color.Orange)
          }
          // TC3
          ListItem(){
            Button("回调空").width(300).onClick(()=>{
              // @ts-ignore
              as.onSocketError()
            }).backgroundColor(Color.Orange)
          }

          ListItem(){
            Text("as.onSocketMessage").fontSize(20).fontWeight(FontWeight.Bold)
          }
          // TC1
          ListItem(){
            Button("回调带参数").width(300).onClick(()=>{
              // @ts-ignore
              as.onSocketMessage(function (res) {
                console.log('[AdvancedAPI] 监听到Socket收到消息：' + res.data);
                AlertDialog.show({ message: 'Socket Message Params', offset: { dx: 0, dy: 200 } })
              })
            })
          }
          // TC2
          ListItem(){
            Button("回调不带参数").width(300).onClick(()=>{
              // @ts-ignore
              as.onSocketMessage(function () {
                console.log('[AdvancedAPI] 监听到Socket收到消息');
                AlertDialog.show({ message: 'Socket Message No Params', offset: { dx: 0, dy: 200 } })
              })
            }).backgroundColor(Color.Orange)
          }
          // TC3
          ListItem(){
            Button("回调空").width(300).onClick(()=>{
              // @ts-ignore
              as.onSocketMessage()
            }).backgroundColor(Color.Orange)
          }

          ListItem(){
            Text("as.onSocketClose").fontSize(20).fontWeight(FontWeight.Bold)
          }
          // TC1
          ListItem(){
            Button("回调带参数").width(300).onClick(()=>{
              // @ts-ignore
              as.onSocketClose(function (res) {
                console.log('[AdvancedAPI] 监听到Socket已关闭！ ' + JSON.stringify(res));
                AlertDialog.show({ message: 'Socket Close Params', offset: { dx: 0, dy: 200 } })
              })
            })
          }
          // TC2
          ListItem(){
            Button("回调不带参数").width(300).onClick(()=>{
              // @ts-ignore
              as.onSocketClose(function () {
                console.log('[AdvancedAPI] 监听到Socket已关闭！');
                AlertDialog.show({ message: 'Socket Close No Params', offset: { dx: 0, dy: 200 } })
              })
            }).backgroundColor(Color.Orange)
          }
          // TC3
          ListItem(){
            Button("回调空").width(300).onClick(()=>{
              // @ts-ignore
              as.onSocketClose()
            }).backgroundColor(Color.Orange)
          }

          ListItem(){
            Text("SocketTask").fontSize(20).fontWeight(FontWeight.Bold)
          }
          // TC1
          ListItem(){
            Button("create").width(300).onClick(()=>{
              // @ts-ignore
              this.task = as.connectSocket({
                url: 'ws://websocket-echo.com',
                success: function () {
                  console.log('[AdvancedAPI] SockTask OK');
                  AlertDialog.show({ message: 'Socket Task Create Success'})
                },
                fail: function () {
                  console.error('[AdvancedAPI] SockTask Fail');
                  AlertDialog.show({ message: 'Socket Task Create Fail'})
                }
              })
            })
          }
          // TC2
          ListItem(){
            Button("send").width(300).onClick(()=>{
              // @ts-ignore
              this.task.send({
                data: "I am message",
                success: (res) => {
                  console.log('[AdvancedAPI] Socket发送成功');
                  AlertDialog.show({ message: 'Socket Task Send Success'})
                },
                fail: () => {
                  console.error('[AdvancedAPI] Socket发送失败');
                  AlertDialog.show({ message: 'Socket Task Send Fail'})
                }
              })
            })
          }
          // TC3
          ListItem(){
            Button("close").width(300).onClick(()=>{
              // @ts-ignore
              this.task.close({
                success: (res) => {
                  console.log('[AdvancedAPI] Socket关闭成功');
                  AlertDialog.show({ message: 'Socket Task Close Success'})
                },
                fail: () => {
                  console.error('[AdvancedAPI] Socket关闭失败');
                  AlertDialog.show({ message: 'Socket Task Close Fail'})
                }
              })
            })
          }
          // TC4
          ListItem(){
            Button("onOpen").width(300).onClick(()=>{
              // @ts-ignore
              this.task.onOpen(function (res) {
                console.log('[AdvancedAPI] 监听到Socket打开');
                AlertDialog.show({ message: 'Socket Opened', offset: { dx: 0, dy: 200 } })
              })
            })
          }
          // TC5
          ListItem(){
            Button("onError").width(300).onClick(()=>{
              // @ts-ignore
              this.task.onError(function (res) {
                console.log('[AdvancedAPI] 监听到Socket报错');
                AlertDialog.show({ message: 'Socket Error', offset: { dx: 0, dy: 200 } })
              })
            })
          }
          // TC6
          ListItem(){
            Button("onMessage").width(300).onClick(()=>{
              // @ts-ignore
              this.task.onMessage(function (res) {
                console.log('[AdvancedAPI] 监听到Socket收到消息：' + res.data);
                AlertDialog.show({ message: 'Socket Message Received', offset: { dx: 0, dy: 200 } })
              })
            })
          }
          // TC7
          ListItem(){
            Button("onClose").width(300).onClick(()=>{
              // @ts-ignore
              this.task.onClose(function (res) {
                console.log('[AdvancedAPI] 监听到Socket关闭');
                AlertDialog.show({ message: 'Socket Closed', offset: { dx: 0, dy: 200 } })
              })
            })
          }
        }.alignListItem(ListItemAlign.Center)
      }
    }
  }
}