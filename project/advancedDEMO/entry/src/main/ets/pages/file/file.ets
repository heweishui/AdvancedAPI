import fileio from '@ohos.fileio'
import common from '@ohos.app.ability.common'

@Entry
@Component
struct File {
  context = getContext(this) as common.UIAbilityContext
  filePath = this.context.filesDir + '/test.txt'
  pdfPath = ''
  saveFilePath = ''

  build() {
    Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
      Column({ space: 5 }) {

        List({ space: 20, initialIndex: 0 }){
          ListItem() {
            Column ({ space: 10 }) {
              Text('文件').fontSize(35)
              Button('先鸿蒙接口创建文件A，创建目录filesDir下').width(300).onClick(() => {
                let fd = fileio.openSync(this.filePath, 0o100 | 0o2, 0o666)
                let num = fileio.writeSync(fd, "hello, world")
                console.log('[AdvancedAPI] write data to file succeed and size is:' + num)
              })

              Button('再保存文件A as.saveFile').width(300).onClick(() => {
                // @ts-ignore
                as.saveFile({
                  tempFilePath: this.filePath,
                  success: (res) => {
                    console.log('[AdvancedAPI]  saveFile--tempFilePath success'+ JSON.stringify(res))
                    console.log('[AdvancedAPI]  saveFile savedFilePath = '+res.savedFilePath)
                    this.saveFilePath = res.savedFilePath
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI]  saveFile--tempFilePath fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI]  saveFile--tempFilePath complete' + JSON.stringify(res))
                  }
                });
              })

              Button('先鸿蒙接口创建文件B，创建目录cacheDir下').width(300).onClick(() => {
                this.filePath = this.context.cacheDir + '/test.txt'
                let filePath = this.filePath
                let fd = fileio.openSync(filePath, 0o100 | 0o2, 0o666);
                let num = fileio.writeSync(fd, "hello, world");
                console.log("[AdvancedAPI] write data to file succeed and size is:" + num);
              })

              Button('再保存文件B as.saveFile，采用internal格式路径').width(300).onClick(() => {
                // @ts-ignore
                as.saveFile({
                  tempFilePath: 'internal://cache/test.txt',
                  success: function (res) {
                    console.log('[AdvancedAPI] saveFile savedFilePath = '+res.savedFilePath)
                    console.log('[AdvancedAPI] saveFile savedFilePath = '+JSON.stringify(res))
                  },
                  fail: function () {
                    console.log('[AdvancedAPI] saveFile fail')
                  }
                });
              })

              Button('as.getSavedFileList').width(300).onClick(() => {
                // @ts-ignore
                as.getSavedFileList({
                  success: function (res) {
                    console.log('[AdvancedAPI] getSavedFileList fileList = '+JSON.stringify(res.fileList));
                  },
                  fail: function () {
                    console.log('[AdvancedAPI] getSavedFileList fail');
                  }
                });
              })

              Button('as.getSavedFileInfo').width(300).onClick(() => {
                // @ts-ignore
                as.getSavedFileInfo({
                  filePath: this.saveFilePath,
                  success: function (res) {
                    console.log('[AdvancedAPI] getSavedFileInfo res = '+JSON.stringify(res));
                  },
                  fail: function () {
                    console.log('[AdvancedAPI] getSavedFileInfo fail');
                  }
                });
              })

              Button('as.removeSavedFile').width(300).onClick(() => {
                // @ts-ignore
                as.removeSavedFile({
                  filePath: this.saveFilePath,
                  success: function (res) {
                    console.log('[AdvancedAPI] removeSavedFile res = '+JSON.stringify(res));
                  },
                  fail: function () {
                    console.log('[AdvancedAPI] removeSavedFile fail');
                  }
                });
              })

              Button('as.getFileInfo').width(300).onClick(() => {
                // @ts-ignore
                as.getFileInfo({
                  filePath: this.saveFilePath,
                  digestAlgorithm: 'md5',
                  success: function (res) {
                    console.log('[AdvancedAPI] getFileInfo res = '+JSON.stringify(res));
                  },
                  fail: function () {
                    console.log('[AdvancedAPI] getFileInfo fail');
                  }
                });
              })

            }
          }

          //saveFile
          ListItem(){
            Column ({ space: 10 }) {
              Text('saveFile -必填参数 tempFilePath ').fontSize(35)
              Button("tempFilePath 正常入参String").width(300).onClick(() => {
                // @ts-ignore
                as.saveFile({
                  tempFilePath: this.saveFilePath,
                  success: function (res) {
                    console.log('[AdvancedAPI]  saveFile--tempFilePath success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI]  saveFile--tempFilePath fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI]  saveFile--tempFilePath complete' + JSON.stringify(res))
                  }
                })
              })

              // 文件 .saveFile--tempFilePath-无此参数验证  fail
              Button("无此参数").width(300).onClick(() => {
                // @ts-ignore
                as.saveFile({
                  //             tempFilePath: 'hello',
                  success: function (res) {
                    console.log('[AdvancedAPI]  saveFile--tempFilePath1 success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI]  saveFile--tempFilePath1 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI]  saveFile--tempFilePath1 complete' + JSON.stringify(res))
                  }
                })
              })

              // 文件 .saveFile--tempFilePath-int参数验证   fail
              Button("Number").width(300).onClick(() => {
                // @ts-ignore
                as.saveFile({
                  tempFilePath: 1111,
                  success: function (res) {
                    console.log('[AdvancedAPI]  saveFile--tempFilePath2 success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI]  saveFile--tempFilePath2 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI]  saveFile--tempFilePath2 complete' + JSON.stringify(res))
                  }
                })
              })

              // 文件 .saveFile--tempFilePath-object参数验证 fail
              Button("Object").width(300).onClick(() => {
                // @ts-ignore
                as.saveFile({
                  tempFilePath: { "name":"aaa" },
                  success: function (res) {
                    console.log('[AdvancedAPI]  saveFile--tempFilePath3 success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI]  saveFile--tempFilePath3 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI]  saveFile--tempFilePath3 complete'+ JSON.stringify(res))
                  }
                })
              })

              // 文件 .saveFile--tempFilePath-boolean参数验证 fail
              Button("Boolean").width(300).onClick(() => {
                // @ts-ignore
                as.saveFile({
                  tempFilePath: false,
                  success: function (res) {
                    console.log('[AdvancedAPI]  saveFile--tempFilePath4 success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI]  saveFile--tempFilePath4 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI]  saveFile--tempFilePath4 complete' + JSON.stringify(res))
                  }
                })
              })

              // 文件 .saveFile--tempFilePath--空字符参数验证   success 回调
              Button("空字符").width(300).onClick(() => {
                // @ts-ignore
                as.saveFile({
                  tempFilePath: "",
                  success: function (res) {
                    console.log('[AdvancedAPI]  saveFile--tempFilePath5 success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI]  saveFile--tempFilePath5 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI]  saveFile--tempFilePath5 complete' +  JSON.stringify(res))
                  }
                })
              })

              // 文件 .saveFile--tempFilePath--null参数验证 fail
              Button("null").width(300).onClick(() => {
                // @ts-ignore
                as.saveFile({
                  tempFilePath: null,
                  success: function (res) {
                    console.log('[AdvancedAPI]  saveFile--tempFilePath6 success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI]  saveFile--tempFilePath6 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI]  saveFile--tempFilePath6 complete' + JSON.stringify(res))
                  }
                })
              })

              // 文件 .saveFile--tempFilePath--undefined参数验证  fail
              Button("undefined").width(300).onClick(() => {
                // @ts-ignore
                as.saveFile({
                  tempFilePath: undefined,
                  success: function (res) {
                    console.log('[AdvancedAPI]  saveFile--tempFilePath7 success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI]  saveFile--tempFilePath7 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI]  saveFile--tempFilePath7 complete' + JSON.stringify(res))
                  }
                })
              })
            }
          }

          //getSavedFileList
          ListItem() {
            Column ({ space: 10 }) {
              Text('getSavedFileList ').fontSize(35)
              Button("接口回调查看").width(300).onClick(() => {
                // @ts-ignore
                as.getSavedFileList({
                  success: function (res) {
                    console.log('[AdvancedAPI]  getSavedFileList success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI]  getSavedFileList fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI]  getSavedFileList complete' + JSON.stringify(res))
                  }
                })
              })
            }
          }

          //getSavedFileInfo
          ListItem(){
            Column ({ space: 10 }) {
              Text('getSavedFileInfo -必填参数 filePath ').fontSize(35)
              Button("filePath 正常入参String").width(300).onClick(() => {
                // @ts-ignore
                as.getSavedFileInfo({
                  filePath: this.saveFilePath,
                  success: function (res) {
                    console.log('[AdvancedAPI]  getSavedFileInfo--filePath success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI]  getSavedFileInfo--filePath fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI]  getSavedFileInfo--filePath complete' + JSON.stringify(res))
                  }
                })
              })

              // 文件 .getSavedFileInfo--filePath-无此参数验证  fail
              Button("无此参数").width(300).onClick(() => {
                // @ts-ignore
                as.getSavedFileInfo({
                  //             filePath: 'hello',
                  success: function (res) {
                    console.log('[AdvancedAPI]  getSavedFileInfo--filePath1 success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI]  getSavedFileInfo--filePath1 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI]  getSavedFileInfo--filePath1 complete' + JSON.stringify(res))
                  }
                })
              })

              // 文件 .getSavedFileInfo--filePath-int参数验证   fail
              Button("Number").width(300).onClick(() => {
                // @ts-ignore
                as.getSavedFileInfo({
                  filePath: 1111,
                  success: function (res) {
                    console.log('[AdvancedAPI]  getSavedFileInfo--filePath2 success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI]  getSavedFileInfo--filePath2 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI]  getSavedFileInfo--filePath2 complete' + JSON.stringify(res))
                  }
                })
              })

              // 文件 .getSavedFileInfo--filePath-object参数验证 fail
              Button("Object").width(300).onClick(() => {
                // @ts-ignore
                as.getSavedFileInfo({
                  filePath: { "name":"aaa" },
                  success: function (res) {
                    console.log('[AdvancedAPI]  getSavedFileInfo--filePath3 success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI]  getSavedFileInfo--filePath3 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI]  getSavedFileInfo--filePath3 complete'+ JSON.stringify(res))
                  }
                })
              })

              // 文件 .getSavedFileInfo--filePath-boolean参数验证 fail
              Button("Boolean").width(300).onClick(() => {
                // @ts-ignore
                as.getSavedFileInfo({
                  filePath: false,
                  success: function (res) {
                    console.log('[AdvancedAPI]  getSavedFileInfo--filePath4 success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI]  getSavedFileInfo--filePath4 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI]  getSavedFileInfo--filePath4 complete' + JSON.stringify(res))
                  }
                })
              })

              // 文件 .getSavedFileInfo--filePath--空字符参数验证   success 回调
              Button("空字符").width(300).onClick(() => {
                // @ts-ignore
                as.getSavedFileInfo({
                  filePath: "",
                  success: function (res) {
                    console.log('[AdvancedAPI]  getSavedFileInfo--filePath5 success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI]  getSavedFileInfo--filePath5 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI]  getSavedFileInfo--filePath5 complete' +  JSON.stringify(res))
                  }
                })
              })

              // 文件 .getSavedFileInfo--filePath--null参数验证 fail
              Button("null").width(300).onClick(() => {
                // @ts-ignore
                as.getSavedFileInfo({
                  filePath: null,
                  success: function (res) {
                    console.log('[AdvancedAPI]  getSavedFileInfo--filePath6 success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI]  getSavedFileInfo--filePath6 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI]  getSavedFileInfo--filePath6 complete' + JSON.stringify(res))
                  }
                })
              })

              // 文件 .getSavedFileInfo--filePath--undefined参数验证  fail
              Button("undefined").width(300).onClick(() => {
                // @ts-ignore
                as.getSavedFileInfo({
                  filePath: undefined,
                  success: function (res) {
                    console.log('[AdvancedAPI]  getSavedFileInfo--filePath7 success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI]  getSavedFileInfo--filePath7 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI]  getSavedFileInfo--filePath7 complete' + JSON.stringify(res))
                  }
                })
              })
            }
          }

          //removeSavedFile
          ListItem(){
            Column ({ space: 10 }) {
              Text('removeSavedFile -必填参数 filePath ').fontSize(35)
              Button("filePath 正常入参String").width(300).onClick(() => {
                // @ts-ignore
                as.removeSavedFile({
                  filePath: this.saveFilePath,
                  success: function (res) {
                    console.log('[AdvancedAPI]  removeSavedFile--filePath success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI]  removeSavedFile--filePath fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI]  removeSavedFile--filePath complete' + JSON.stringify(res))
                  }
                })
              })

              // 文件 .removeSavedFile--filePath-无此参数验证  fail
              Button("无此参数").width(300).onClick(() => {
                // @ts-ignore
                as.removeSavedFile({
                  //             filePath: 'hello',
                  success: function (res) {
                    console.log('[AdvancedAPI]  removeSavedFile--filePath1 success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI]  removeSavedFile--filePath1 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI]  removeSavedFile--filePath1 complete' + JSON.stringify(res))
                  }
                })
              })

              // 文件 .removeSavedFile--filePath-int参数验证   fail
              Button("Number").width(300).onClick(() => {
                // @ts-ignore
                as.removeSavedFile({
                  filePath: 1111,
                  success: function (res) {
                    console.log('[AdvancedAPI]  removeSavedFile--filePath2 success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI]  removeSavedFile--filePath2 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI]  removeSavedFile--filePath2 complete' + JSON.stringify(res))
                  }
                })
              })

              // 文件 .removeSavedFile--filePath-object参数验证 fail
              Button("Object").width(300).onClick(() => {
                // @ts-ignore
                as.removeSavedFile({
                  filePath: { "name":"aaa" },
                  success: function (res) {
                    console.log('[AdvancedAPI]  removeSavedFile--filePath3 success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI]  removeSavedFile--filePath3 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI]  removeSavedFile--filePath3 complete'+ JSON.stringify(res))
                  }
                })
              })

              // 文件 .removeSavedFile--filePath-boolean参数验证 fail
              Button("Boolean").width(300).onClick(() => {
                // @ts-ignore
                as.removeSavedFile({
                  filePath: false,
                  success: function (res) {
                    console.log('[AdvancedAPI]  removeSavedFile--filePath4 success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI]  removeSavedFile--filePath4 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI]  removeSavedFile--filePath4 complete' + JSON.stringify(res))
                  }
                })
              })

              // 文件 .removeSavedFile--filePath--空字符参数验证   success 回调
              Button("空字符").width(300).onClick(() => {
                // @ts-ignore
                as.removeSavedFile({
                  filePath: "",
                  success: function (res) {
                    console.log('[AdvancedAPI]  removeSavedFile--filePath5 success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI]  removeSavedFile--filePath5 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI]  removeSavedFile--filePath5 complete' +  JSON.stringify(res))
                  }
                })
              })

              // 文件 .removeSavedFile--filePath--null参数验证 fail
              Button("null").width(300).onClick(() => {
                // @ts-ignore
                as.removeSavedFile({
                  filePath: null,
                  success: function (res) {
                    console.log('[AdvancedAPI]  removeSavedFile--filePath6 success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI]  removeSavedFile--filePath6 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI]  removeSavedFile--filePath6 complete' + JSON.stringify(res))
                  }
                })
              })

              // 文件 .removeSavedFile--filePath--undefined参数验证  fail
              Button("undefined").width(300).onClick(() => {
                // @ts-ignore
                as.removeSavedFile({
                  filePath: undefined,
                  success: function (res) {
                    console.log('[AdvancedAPI]  removeSavedFile--filePath7 success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI]  removeSavedFile--filePath7 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI]  removeSavedFile--filePath7 complete' + JSON.stringify(res))
                  }
                })
              })
            }
          }

          //getFileInfo -必填参数 filePath
          ListItem(){
            Column ({ space: 10 }) {
              Text('getFileInfo -必填参数 filePath ').fontSize(35)
              Button("filePath 正常入参String").width(300).onClick(() => {
                // @ts-ignore
                as.getFileInfo({
                  filePath: this.saveFilePath,
                  success: function (res) {
                    console.log('[AdvancedAPI]  getFileInfo--filePath success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI]  getFileInfo--filePath fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI]  getFileInfo--filePath complete' + JSON.stringify(res))
                  }
                })
              })

              // 文件 .getFileInfo--filePath-无此参数验证  fail
              Button("无此参数").width(300).onClick(() => {
                // @ts-ignore
                as.getFileInfo({
                  //             filePath: 'hello',
                  success: function (res) {
                    console.log('[AdvancedAPI]  getFileInfo--filePath1 success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI]  getFileInfo--filePath1 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI]  getFileInfo--filePath1 complete' + JSON.stringify(res))
                  }
                })
              })

              // 文件 .getFileInfo--filePath-int参数验证   fail
              Button("Number").width(300).onClick(() => {
                // @ts-ignore
                as.getFileInfo({
                  filePath: 1111,
                  success: function (res) {
                    console.log('[AdvancedAPI]  getFileInfo--filePath2 success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI]  getFileInfo--filePath2 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI]  getFileInfo--filePath2 complete' + JSON.stringify(res))
                  }
                })
              })

              // 文件 .getFileInfo--filePath-object参数验证 fail
              Button("Object").width(300).onClick(() => {
                // @ts-ignore
                as.getFileInfo({
                  filePath: { "name":"aaa" },
                  success: function (res) {
                    console.log('[AdvancedAPI]  getFileInfo--filePath3 success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI]  getFileInfo--filePath3 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI]  getFileInfo--filePath3 complete'+ JSON.stringify(res))
                  }
                })
              })

              // 文件 .getFileInfo--filePath-boolean参数验证 fail
              Button("Boolean").width(300).onClick(() => {
                // @ts-ignore
                as.getFileInfo({
                  filePath: false,
                  success: function (res) {
                    console.log('[AdvancedAPI]  getFileInfo--filePath4 success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI]  getFileInfo--filePath4 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI]  getFileInfo--filePath4 complete' + JSON.stringify(res))
                  }
                })
              })

              // 文件 .getFileInfo--filePath--空字符参数验证   success 回调
              Button("空字符").width(300).onClick(() => {
                // @ts-ignore
                as.getFileInfo({
                  filePath: "",
                  success: function (res) {
                    console.log('[AdvancedAPI]  getFileInfo--filePath5 success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI]  getFileInfo--filePath5 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI]  getFileInfo--filePath5 complete' +  JSON.stringify(res))
                  }
                })
              })

              // 文件 .getFileInfo--filePath--null参数验证 fail
              Button("null").width(300).onClick(() => {
                // @ts-ignore
                as.getFileInfo({
                  filePath: null,
                  success: function (res) {
                    console.log('[AdvancedAPI]  getFileInfo--filePath6 success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI]  getFileInfo--filePath6 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI]  getFileInfo--filePath6 complete' + JSON.stringify(res))
                  }
                })
              })

              // 文件 .getFileInfo--filePath--undefined参数验证  fail
              Button("undefined").width(300).onClick(() => {
                // @ts-ignore
                as.getFileInfo({
                  filePath: undefined,
                  success: function (res) {
                    console.log('[AdvancedAPI]  getFileInfo--filePath7 success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI]  getFileInfo--filePath7 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI]  getFileInfo--filePath7 complete' + JSON.stringify(res))
                  }
                })
              })
            }
          }

          //getFileInfo -非必填参数 digestAlgorithm
          ListItem(){
            Column ({ space: 10 }) {
              Text('getFileInfo -非必填参数 digestAlgorithm ').fontSize(35)
              Button("digestAlgorithm 正常入参String").width(300).onClick(() => {
                // @ts-ignore
                as.getFileInfo({
                  filePath: this.saveFilePath,
                  digestAlgorithm: 'md5',
                  success: function (res) {
                    console.log('[AdvancedAPI]  getFileInfo--digestAlgorithm success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI]  getFileInfo--digestAlgorithm fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI]  getFileInfo--digestAlgorithm complete' + JSON.stringify(res))
                  }
                })
              })

              // 文件 .getFileInfo--digestAlgorithm-无此参数验证  fail
              Button("无此参数").width(300).onClick(() => {
                // @ts-ignore
                as.getFileInfo({
                  filePath: this.saveFilePath,
                  //             digestAlgorithm: 'hello',
                  success: function (res) {
                    console.log('[AdvancedAPI]  getFileInfo--digestAlgorithm1 success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI]  getFileInfo--digestAlgorithm1 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI]  getFileInfo--digestAlgorithm1 complete' + JSON.stringify(res))
                  }
                })
              })

              // 文件 .getFileInfo--digestAlgorithm-int参数验证   fail
              Button("Number").width(300).onClick(() => {
                // @ts-ignore
                as.getFileInfo({
                  filePath: this.saveFilePath,
                  digestAlgorithm: 1111,
                  success: function (res) {
                    console.log('[AdvancedAPI]  getFileInfo--digestAlgorithm2 success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI]  getFileInfo--digestAlgorithm2 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI]  getFileInfo--digestAlgorithm2 complete' + JSON.stringify(res))
                  }
                })
              })

              // 文件 .getFileInfo--digestAlgorithm-object参数验证 fail
              Button("Object").width(300).onClick(() => {
                // @ts-ignore
                as.getFileInfo({
                  filePath: this.saveFilePath,
                  digestAlgorithm: { "name":"aaa" },
                  success: function (res) {
                    console.log('[AdvancedAPI]  getFileInfo--digestAlgorithm3 success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI]  getFileInfo--digestAlgorithm3 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI]  getFileInfo--digestAlgorithm3 complete'+ JSON.stringify(res))
                  }
                })
              })

              // 文件 .getFileInfo--digestAlgorithm-boolean参数验证 fail
              Button("Boolean").width(300).onClick(() => {
                // @ts-ignore
                as.getFileInfo({
                  filePath: this.saveFilePath,
                  digestAlgorithm: false,
                  success: function (res) {
                    console.log('[AdvancedAPI]  getFileInfo--digestAlgorithm4 success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI]  getFileInfo--digestAlgorithm4 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI]  getFileInfo--digestAlgorithm4 complete' + JSON.stringify(res))
                  }
                })
              })

              // 文件 .getFileInfo--digestAlgorithm--空字符参数验证   success 回调
              Button("空字符").width(300).onClick(() => {
                // @ts-ignore
                as.getFileInfo({
                  filePath: this.saveFilePath,
                  digestAlgorithm: "",
                  success: function (res) {
                    console.log('[AdvancedAPI]  getFileInfo--digestAlgorithm5 success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI]  getFileInfo--digestAlgorithm5 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI]  getFileInfo--digestAlgorithm5 complete' +  JSON.stringify(res))
                  }
                })
              })

              // 文件 .getFileInfo--digestAlgorithm--null参数验证 fail
              Button("null").width(300).onClick(() => {
                // @ts-ignore
                as.getFileInfo({
                  filePath: this.saveFilePath,
                  digestAlgorithm: null,
                  success: function (res) {
                    console.log('[AdvancedAPI]  getFileInfo--digestAlgorithm6 success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI]  getFileInfo--digestAlgorithm6 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI]  getFileInfo--digestAlgorithm6 complete' + JSON.stringify(res))
                  }
                })
              })

              // 文件 .getFileInfo--digestAlgorithm--undefined参数验证  fail
              Button("undefined").width(300).onClick(() => {
                // @ts-ignore
                as.getFileInfo({
                  filePath: this.saveFilePath,
                  digestAlgorithm: undefined,
                  success: function (res) {
                    console.log('[AdvancedAPI]  getFileInfo--digestAlgorithm7 success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI]  getFileInfo--digestAlgorithm7 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI]  getFileInfo--digestAlgorithm7 complete' + JSON.stringify(res))
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