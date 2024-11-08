@Entry
@Component
struct downloadFile {
  scroller: Scroller = new Scroller()

  aboutToAppear() {

  }
  build() {
    Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center })  {
      Column({ space: 5 }) {
        List({ space: 20, }){
          ListItem(){
            Text("downloadFile").fontSize(20).fontWeight(FontWeight.Bold)
          }

          ListItem(){
            Column ({ space: 10 }) {
              // downloadFile   url 正常传参 String类--有效网址（无其他参数）   sucess
              Button("url 正常传参").width(300).onClick(()=>{
                // @ts-ignore
                as.downloadFile({
                  url: 'https://www.huawei.com/Assets/CBG/img/logo.png',
                  success: (res) => {
                    console.log('[AdvancedAPI] downloadFile url success0 ' + res.tempFilePath) // 鸿蒙不返回tempFilePath，需要额外调用getTaskInfo获取存储文件的URI
                    console.log('[AdvancedAPI] downloadFile url success0 ' + res.statusCode) // 内容太长时无法打印
                    console.log('[AdvancedAPI] downloadFile url success0 ' + res.apFilePath) // 内容太长时无法打印
                    console.log('[AdvancedAPI] downloadFile url success0 ' + res.filePath) // 内容太长时无法打印
                    console.log('[AdvancedAPI] downloadFile url success0 ' + res.fileContent) // 内容太长时无法打印
                    console.log('[AdvancedAPI] downloadFile url success0 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]downloadFile url fail0 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] downloadFile url complete0 ' + JSON.stringify(res))
                  }
                })
              })

              // downloadFile   url 正常传参 String类--无效网址（无其他参数）  fail   {"errMsg":"Timeout was reached"}
              Button("url 正常传参 无效网址").width(300).onClick(()=>{
                // @ts-ignore
                as.downloadFile({
                  url: 'http://test',
                  success: (res) => {
                    console.log('[AdvancedAPI] downloadFile url success1 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]downloadFile url fail1 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] downloadFile url complete1 ' + JSON.stringify(res))
                  }
                })
              })

              // downloadFile   无此url参数（无其他参数）
              Button("无此url参数").width(300).onClick(()=>{
                // @ts-ignore
                as.downloadFile({
                  // url: 'https://www.huawei.com',
                  success: (res) => {
                    console.log('[AdvancedAPI] downloadFile url success2 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]downloadFile url fail2 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] downloadFile url complete2 ' + JSON.stringify(res))
                  }
                })
              })

              // downloadFile   url 类型不对 number（无其他参数）     类型不对，均是fail回调  {"errMsg":"URL using bad/illegal format or missing URL"}
              Button("number").width(300).onClick(()=>{
                // @ts-ignore
                as.downloadFile({
                  url: 7788,
                  success: (res) => {
                    console.log('[AdvancedAPI] downloadFile url success3 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]downloadFile url fail 3' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] downloadFile url complete3 ' + JSON.stringify(res))
                  }
                })
              })

              // downloadFile   url 类型不对 boolean（无其他参数）
              Button("boolean").width(300).onClick(()=>{
                // @ts-ignore
                as.downloadFile({
                  url: false,
                  success: (res) => {
                    console.log('[AdvancedAPI] downloadFile url success4 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]downloadFile url fail4 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] downloadFile url complete4 ' + JSON.stringify(res))
                  }
                })
              })

              // downloadFile   url 类型不对 object（无其他参数）
              Button("object").width(300).onClick(()=>{
                // @ts-ignore
                as.downloadFile({
                  url: { 'name':'test' },
                  success: (res) => {
                    console.log('[AdvancedAPI] downloadFile url success5 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]downloadFile url fail5 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] downloadFile url complete5 ' + JSON.stringify(res))
                  }
                })
              })

              // downloadFile   url 类型不对 null（无其他参数）
              Button("null").width(300).onClick(()=>{
                // @ts-ignore
                as.downloadFile({
                  url: null,
                  success: (res) => {
                    console.log('[AdvancedAPI] downloadFile url success6 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]downloadFile url fail6 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] downloadFile url complete6 ' + JSON.stringify(res))
                  }
                })
              })

              // downloadFile   url 类型不对 空字符（无其他参数）
              Button("空字符").width(300).onClick(()=>{
                // @ts-ignore
                as.downloadFile({
                  url: '',
                  success: (res) => {
                    console.log('[AdvancedAPI] downloadFile url success7 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]downloadFile url fail7 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] downloadFile url complete7 ' + JSON.stringify(res))
                  }
                })
              })

              // downloadFile   url 类型不对 undefined（无其他参数）
              Button("undefined").width(300).onClick(()=>{
                // @ts-ignore
                as.downloadFile({
                  url: undefined,
                  success: (res) => {
                    console.log('[AdvancedAPI] downloadFile url success8 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]downloadFile url fail8 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] downloadFile url complete8 ' + JSON.stringify(res))
                  }
                })
              })
            }
          }

          ListItem(){
            Column ({ space: 10 }) {
              // downloadFile   header 正常传参 header 中不能设置 Referer
              Button("header 正常传参").width(300).onClick(()=>{
                // @ts-ignore
                as.downloadFile({
                  url: 'https://www.huawei.com/Assets/CBG/img/logo.png',
                  header:{'content-type':'application/json'},
                  success: (res) => {
                    console.log('[AdvancedAPI] downloadFile header success 0 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]downloadFile header fail 0 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] downloadFile header complete 0 ' + JSON.stringify(res))
                  }
                })
              })

              // downloadFile   header 正常传参 header 中设置 Referer   --失败场景  success回调
              Button("header 设置 Referer1 ").width(300).onClick(()=>{
                // @ts-ignore
                as.downloadFile({
                  url: 'https://www.huawei.com/Assets/CBG/img/logo.png',
                  header:{'Referer':'https://www.huawei.com/Assets/CBG/img/logo.png'},
                  success: (res) => {
                    console.log('[AdvancedAPI] downloadFile header success 1 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]downloadFile header fail 1 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] downloadFile header complete 1 ' + JSON.stringify(res))
                  }
                })
              })

              Button("header 设置 Referer2 ").width(300).onClick(()=>{
                // @ts-ignore
                as.downloadFile({
                  url: 'http://photo.yupoo.com/vibius/GkRSowXr/medish.jpg',
                  header: { 'referer': 'http://photo.yupoo.com/' },
                  success: (res) => {
                    console.log('[AdvancedAPI] downloadFile header success 1 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]downloadFile header fail 1 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] downloadFile header complete 1 ' + JSON.stringify(res))
                  }
                })
              })

              Button("header 设置 Referer3 ").width(300).onClick(()=>{
                // @ts-ignore
                as.downloadFile({
                  url: 'http://photo.yupoo.com/vibius/GkRSowXr/medish.jpg',
                  header: {'referer': 'https://www.zhihu.com/' },
                  success: (res) => {
                    console.log('[AdvancedAPI] downloadFile header success 1 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]downloadFile header fail 1 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] downloadFile header complete 1 ' + JSON.stringify(res))
                  }
                })
              })

              // downloadFile   无此header参数（无其他参数）
              Button("无此header参数").width(300).onClick(()=>{
                // @ts-ignore
                as.downloadFile({
                  url: 'https://www.huawei.com/Assets/CBG/img/logo.png',
                  //                  header:{'content-type':'application/json'},
                  success: (res) => {
                    console.log('[AdvancedAPI] downloadFile header success 2 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]downloadFile header fail 2 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] downloadFile header complete 2 ' + JSON.stringify(res))
                  }
                })
              })

              // downloadFile   header 类型不对 number（无其他参数）
              Button("number").width(300).onClick(()=>{
                // @ts-ignore
                as.downloadFile({
                  url: 'https://www.huawei.com/Assets/CBG/img/logo.png',
                  header:8899,
                  success: (res) => {
                    console.log('[AdvancedAPI] downloadFile header success 3 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]downloadFile header fail 3 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] downloadFile header complete 3 ' + JSON.stringify(res))
                  }
                })
              })

              // downloadFile   header 类型不对 boolean（无其他参数）
              Button("boolean").width(300).onClick(()=>{
                // @ts-ignore
                as.downloadFile({
                  url: 'https://www.huawei.com/Assets/CBG/img/logo.png',
                  header:true,
                  success: (res) => {
                    console.log('[AdvancedAPI] downloadFile header success 4 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]downloadFile header fail 4 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] downloadFile header complete 4 ' + JSON.stringify(res))
                  }
                })
              })

              // downloadFile   header 类型不对 String（无其他参数）
              Button("String").width(300).onClick(()=>{
                // @ts-ignore
                as.downloadFile({
                  url: 'https://www.huawei.com/Assets/CBG/img/logo.png',
                  header:'content-type',
                  success: (res) => {
                    console.log('[AdvancedAPI] downloadFile header success 5 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]downloadFile header fail 5 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] downloadFile header complete 5 ' + JSON.stringify(res))
                  }
                })
              })

              // downloadFile   header 类型不对 null（无其他参数）
              Button("null").width(300).onClick(()=>{
                // @ts-ignore
                as.downloadFile({
                  url: 'https://www.huawei.com/Assets/CBG/img/logo.png',
                  header:null,
                  success: (res) => {
                    console.log('[AdvancedAPI] downloadFile header success 6 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]downloadFile header fail 6 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] downloadFile header complete 6 ' + JSON.stringify(res))
                  }
                })
              })

              // downloadFile   header 类型不对 空字符（无其他参数）
              Button("空字符").width(300).onClick(()=>{
                // @ts-ignore
                as.downloadFile({
                  url: 'https://www.huawei.com/Assets/CBG/img/logo.png',
                  header:'',
                  success: (res) => {
                    console.log('[AdvancedAPI] downloadFile header success 7 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]downloadFile header fail 7 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] downloadFile header complete 7 ' + JSON.stringify(res))
                  }
                })
              })

              // downloadFile   header 类型不对 undefined（无其他参数）
              Button("undefined").width(300).onClick(()=>{
                // @ts-ignore
                as.downloadFile({
                  url: 'https://www.huawei.com/Assets/CBG/img/logo.png',
                  header:undefined,
                  success: (res) => {
                    console.log('[AdvancedAPI] downloadFile header success 8 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]downloadFile header fail 8 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] downloadFile header complete 8 ' + JSON.stringify(res))
                  }
                })
              })
            }
          }

          // downloadFile-timeout的参数 鸿蒙不支持

          ListItem(){
            Column({ space: 10 }) {
              // downloadFile   filePath 正常传参 String类--
              Button("filePath 手机内存储文件路径").width(300).onClick(() => {
                // @ts-ignore
                as.downloadFile({
                  url: 'https://www.huawei.com/Assets/CBG/img/logo.png',
                  filePath: 'XXX',
                  success: (res) => {
                    console.log('[AdvancedAPI] downloadFile url success0 ' + res.tempFilePath) // 鸿蒙不返回tempFilePath，需要额外调用getTaskInfo获取存储文件的URI
                    console.log('[AdvancedAPI] downloadFile url success0 ' + res.statusCode) // 内容太长时无法打印
                    console.log('[AdvancedAPI] downloadFile url success0 ' + res.apFilePath) // 内容太长时无法打印
                    console.log('[AdvancedAPI] downloadFile url success0 ' + res.filePath) // 内容太长时无法打印
                    console.log('[AdvancedAPI] downloadFile url success0 ' + res.fileContent) // 内容太长时无法打印
                    console.log('[AdvancedAPI] downloadFile url success0 ' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]downloadFile filePath fail 6 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] downloadFile filePath complete 6 ' + JSON.stringify(res))
                  }
                })
              })

              Button("filePath 临时文件路径").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseImage({
                  count: 1,
                  sourceType: ['album'],
                  success: function (res) {
                    // @ts-ignore
                    as.downloadFile({
                      url: 'https://www.huawei.com/Assets/CBG/img/logo.png',
                      filePath: res.tempFilePaths[0],
                      success: (res) => {
                        console.log('[AdvancedAPI] downloadFile filePath success 7' + JSON.stringify(res))
                      },
                      fail: (res) => {
                        console.error('[AdvancedAPI]downloadFile filePath fail 7 ' + JSON.stringify(res))
                      },
                      complete: (res) => {
                        console.log('[AdvancedAPI] downloadFile filePath complete 7 ' + JSON.stringify(res))
                      }
                    });
                  }
                })
              })

              // downloadFile   无此filePath参数（默认get）
              Button("无此filePath参数").width(300).onClick(() => {
                // @ts-ignore
                as.downloadFile({
                  url: 'https://www.huawei.com/Assets/CBG/img/logo.png',
                  success: (res) => {
                    console.log('[AdvancedAPI] downloadFile filePath success 8' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]downloadFile filePath fail 8 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] downloadFile filePath complete 8 ' + JSON.stringify(res))
                  }
                })
              })

              // downloadFile   filePath 类型不对 number（无其他参数）
              Button("number").width(300).onClick(() => {
                // @ts-ignore
                as.downloadFile({
                  url: 'https://www.huawei.com/Assets/CBG/img/logo.png',
                  filePath: 666,
                  success: (res) => {
                    console.log('[AdvancedAPI] downloadFile filePath success 9' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]downloadFile filePath fail 9 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] downloadFile filePath complete 9 ' + JSON.stringify(res))
                  }
                })
              })

              // downloadFile   filePath 类型不对 boolean（无其他参数）
              Button("boolean").width(300).onClick(() => {
                // @ts-ignore
                as.downloadFile({
                  url: 'https://www.huawei.com/Assets/CBG/img/logo.png',
                  filePath: false,
                  success: (res) => {
                    console.log('[AdvancedAPI] downloadFile filePath success 01' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]downloadFile filePath fail 01 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] downloadFile filePath complete 01 ' + JSON.stringify(res))
                  }
                })
              })

              // downloadFile   filePath 类型不对 object（无其他参数）
              Button("object").width(300).onClick(() => {
                // @ts-ignore
                as.downloadFile({
                  url: 'https://www.huawei.com/Assets/CBG/img/logo.png',
                  filePath: { 'name': 'GET' },
                  success: (res) => {
                    console.log('[AdvancedAPI] downloadFile filePath success 02' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]downloadFile filePath fail 02 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] downloadFile filePath complete 02 ' + JSON.stringify(res))
                  }
                })
              })

              // downloadFile   filePath 类型不对 null（无其他参数）
              Button("null").width(300).onClick(() => {
                // @ts-ignore
                as.downloadFile({
                  url: 'https://www.huawei.com/Assets/CBG/img/logo.png',
                  filePath: null,
                  success: (res) => {
                    console.log('[AdvancedAPI] downloadFile filePath success 03' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]downloadFile filePath fail 03 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] downloadFile filePath complete 03 ' + JSON.stringify(res))
                  }
                })
              })

              // downloadFile   filePath 类型不对 空字符（无其他参数）
              Button("空字符").width(300).onClick(() => {
                // @ts-ignore
                as.downloadFile({
                  url: 'https://www.huawei.com/Assets/CBG/img/logo.png',
                  filePath: '',
                  success: (res) => {
                    console.log('[AdvancedAPI] downloadFile filePath success 04' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]downloadFile filePath fail 04 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] downloadFile filePath complete 04 ' + JSON.stringify(res))
                  }
                })
              })

              // downloadFile   filePath 类型不对 undefined（无其他参数）
              Button("undefined").width(300).onClick(() => {
                // @ts-ignore
                as.downloadFile({
                  url: 'https://www.huawei.com/Assets/CBG/img/logo.png',
                  filePath: undefined,
                  success: (res) => {
                    console.log('[AdvancedAPI] downloadFile filePath success 05' + JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPI]downloadFile filePath fail 05 ' + JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] downloadFile filePath complete 05 ' + JSON.stringify(res))
                  }
                })
              })
            }
          }

          ListItem(){
            Column({ space: 10 }) {
              Text("downloadTask").fontSize(20).fontWeight(FontWeight.Bold)

              Button("abort+onProgressUpdate").width(300).onClick(()=>{
                // @ts-ignore
                const downloadTask = as.downloadFile({
                  url: 'https://ss0.bdstatic.com/-0U0bnSm1A5BphGlnYG/cae-legoup-video-target/93be3d88-9fc2-4fbd-bd14-833bca731ca7.mp4', //仅为示例，并非真实的资源
                  success: (res) => {
                    if (res.statusCode === 200) {
                      console.log('downloadTask 下载成功');
                    }
                  }
                });

                downloadTask.onProgressUpdate((res) => {
                  console.log('downloadTask 下载进度' + res.progress);
                  console.log('downloadTask 已经下载的数据长度' + res.totalBytesWritten);
                  console.log('downloadTask 预期需要下载的数据总长度' + res.totalBytesExpectedToWrite);

                  // 满足测试条件，取消下载任务。
                  if (res.progress > 50) {
                    downloadTask.abort();
                  }
                });
              })
            }
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
        }.alignListItem(ListItemAlign.Center)
      }
    }
  }
}