// @ts-nocheck
import fs from '@ohos.file.fs'
import buffer from '@ohos.buffer'
import common from '@ohos.app.ability.common'
import promptAction from '@ohos.promptAction'

@Entry
@Component
struct FileSystemManager {
  context = getContext(this) as common.UIAbilityContext
  filePath = this.context.filesDir + '/test.txt'
  fileDestPath = this.context.filesDir + '/testSaveFile.txt'
  DestPath = this.context.filesDir + '/SaveFile'
  if_RecursiveDelete_Path=this.context.filesDir + '/RecursiveSaveFolder/RecursiveSaveText.txt'
  mkdirPathText1 = this.context.filesDir+'/files/mkdirtest1.txt' //用于接口mkdir的测试样例1 ，直接给出需要删除的文件
  mkdirPathText2 = this.context.filesDir+'/files/mkdirtest2' //用于接口mkdir的测试样例2 ，直接给出需要删除的文件,不带后缀
  mkdirPathFolder1 = this.context.filesDir+'/files'         //用于接口mkdir的测试样例3， 给出包含【多个文件】的文件夹，测试是否可以递归删除
  fsManager = {}
  fd = ''
  testArrayBuffer = new ArrayBuffer(4096)

  build() {
    Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
      Column({ space: 5 }) {

        List({ space: 20, initialIndex: 0 }){
          // fileSystemManager
          ListItem() {
            Column ({ space: 10 }) {
              Text('fileSystemManager').fontSize(25)
              Button('获取fileSystemManager').width(300).onClick(() => {
                this.fsManager = as.getFileSystemManager()
                console.log('[AdvancedAPI] fileSystemManager getFileSystemManager = '+this.fsManager )
                promptAction.showToast({
                  message: `获取fs对象成功！`
                })
              })
            }
          }

          //—————————————————分割线—————————————————————开发人员测试中——————————————————————————————————————————//
          // 用于检查接口的返回值
          ListItem() {
            Column({ space: 10 }) {
              Text('8月15日 测试鸿蒙statSync').fontSize(25)
              Button('先用鸿蒙接口创建文件test.txt，创建目录filesDir下，写入内容hello, world').width(600).onClick(() => {
                let file = fs.openSync(this.filePath, fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE)
                let num = fs.writeSync(file.fd, "hello, world")
                promptAction.showToast({
                  message: `文件内容写入成功，长度：${num},path:${this.filePath}`,
                })
                console.debug('[advanceDEMO] write data to file succeed and size is:' + num + this.filePath)
              })

              Button('statSync').width(600).onClick(() => {
                try {
                  let res=fs.statSync(this.filePath)
                  console.log('[advanceDEMO] the res of statSync: '+res)
                  promptAction.showToast({
                    message: `stat成功  res=${res}`
                  })
                } catch (error) {
                  console.error(`[advanceDEMO] 失败 the value of res : ${this.res}`)
                  console.error(`[advanceDEMO]statSync 失败 ${error}`)
                  promptAction.showToast({
                    message: `statSync 失败 ${error}`
                  })
                }
              })

              Button('buffer concat').width(600).onClick(() => {
                try {
                  const offsetOfArrayBuffer=10
                  // 使用new创建大小确定的ArrayBuffer
                  let wechatBuffer=new ArrayBuffer(1024)
                  let creatBuffer=new ArrayBuffer(1024)
                  console.log('[advanceDEMO] the byteLength of wechatBuffer: '+wechatBuffer.byteLength)
                  console.log('[advanceDEMO] the byteLength of creatBuffer: '+creatBuffer.byteLength)

                  // 使用鸿蒙的buffer创建buf1 buf2
                  let buf1=buffer.from(wechatBuffer,0,offsetOfArrayBuffer)
                  let len=1024-offsetOfArrayBuffer
                  let buf2=buffer.from(creatBuffer,0,1024) // 传入len=1024- offsetOfArrayBuffer 出错
                  console.log('[advanceDEMO] the byteLength of buf1: '+buf1.length)
                  console.log('[advanceDEMO] the byteLength of buf2: '+buf2.length)

                  // 写入内容
                  buf1.write('1234')
                  console.log('[advanceDEMO] write buf1 success :'+buf1.toString('utf-8'))
                  buf2.write('56789')
                  console.log('[advanceDEMO] write buf2 success, read by endcoing(dec):'+buf2.toString('dec'))
                  console.log('[advanceDEMO] write buf2 success, read by endcoing(utf-8)::'+buf2.toString('utf-8'))

                  // let buf1 = buffer.from("1234");
                  // let buf2 = buffer.from("abcd");
                  let buf = buffer.concat([buf1, buf2]);
                  console.log('[advanceDEMO]  read concat result by endcoing(dec):'+buf.toString('dec'))
                  console.log('[advanceDEMO]  read concat result by endcoing(utf-8)::'+buf.toString('utf-8'))

                  console.log('[advanceDEMO] the res of concat'+buf.toString('utf-8',0,100)); // 3132333461626364
                  promptAction.showToast({
                    message: `buffer concat 成功 `
                  })
                } catch (error) {
                  console.error(`[advanceDEMO]读取文件 失败 ${error}`)
                  promptAction.showToast({
                    message: `读取文件 失败 ${error}`
                  })
                }
              })

              Button('递归创建目录1').width(600).onClick(() => {
                this.fsManager.mkdir({
                  dirPath: this.context.filesDir + '/testMkdir1/testMkdirRecursive1',
                  recursive: true ,
                  success: (res) => {
                    promptAction.showToast({
                      message: `文件 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 创建目录 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `创建目录 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('递归创建目录2').width(600).onClick(() => {
                this.fsManager.mkdir({
                  dirPath: this.context.filesDir + '/testMkdir1/testMkdirRecursive2',
                  recursive: true ,
                  success: (res) => {
                    promptAction.showToast({
                      message: `文件 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 创建目录 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `创建目录 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('递归创建目录3').width(600).onClick(() => {
                this.fsManager.mkdir({
                  dirPath: this.context.filesDir + '/testMkdir1/testMkdirRecursive3',
                  recursive: true ,
                  success: (res) => {
                    promptAction.showToast({
                      message: `文件 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 创建目录 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `创建目录 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

            }
          }

          //—————————————————分割线—————————————————————开发人员测试中——————————————————————————————————————————//

          // fs.access
          ListItem() {
            Column ({ space: 10 }) {
              Text('fs.access').fontSize(25)
              Button('先用鸿蒙接口创建文件test.txt，创建目录filesDir下，写入内容hello, world').width(300).onClick(() => {
                let file = fs.openSync(this.filePath, fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE)
                let num = fs.writeSync(file.fd, "hello, world")
                promptAction.showToast({
                  message: `文件内容写入成功，长度：${num},path:${this.filePath}`,
                })
                console.debug('[advanceDEMO] write data to file succeed and size is:' + num + this.filePath)
              })

              Button('判断文件是否存在，path是一个文件').width(300).onClick(() => {
                this.fsManager.access({
                  path: this.filePath,
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager access  success = '+JSON.stringify(res) )
                    promptAction.showToast({
                      message: `文件存在 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    // 文件不存在或其他错误
                    console.error(`[advanceDEMO] 文件不存在 或其他错误 ${JSON.stringify(res)}`)
                    console.log('[AdvancedAPI] fileSystemManager access  fail = '+JSON.stringify(res) )
                    promptAction.showToast({
                      message: `文件不存在 或其他错误 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager access  complete = '+JSON.stringify(res) )
                  }
                })
              })

              Button('判断文件是否存在 没有path入参').width(300).onClick(() => {
                this.fsManager.access({
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager access  success = '+JSON.stringify(res) )
                    promptAction.showToast({
                      message: `文件存在 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    // 文件不存在或其他错误
                    console.error(`[advanceDEMO] 文件不存在 或其他错误 ${JSON.stringify(res)}`)
                    console.log('[AdvancedAPI] fileSystemManager access  fail = '+JSON.stringify(res) )
                    promptAction.showToast({
                      message: `文件不存在 或其他错误 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] access complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('判断文件是否存在 path是number').width(300).onClick(() => {
                this.fsManager.access({
                  path: 1,
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager access  success = '+JSON.stringify(res) )
                    promptAction.showToast({
                      message: `文件存在 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    // 文件不存在或其他错误
                    console.error(`[advanceDEMO] 文件不存在 或其他错误 ${JSON.stringify(res)}`)
                    console.log('[AdvancedAPI] fileSystemManager access  fail = '+JSON.stringify(res) )
                    promptAction.showToast({
                      message: `文件不存在 或其他错误 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] access complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('判断文件是否存在 path是null').width(300).onClick(() => {
                this.fsManager.access({
                  path: null,
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager access  success = '+JSON.stringify(res) )
                    promptAction.showToast({
                      message: `文件存在 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    // 文件不存在或其他错误
                    console.error(`[advanceDEMO] 文件不存在 或其他错误 ${JSON.stringify(res)}`)
                    console.log('[AdvancedAPI] fileSystemManager access  fail = '+JSON.stringify(res) )
                    promptAction.showToast({
                      message: `文件不存在 或其他错误 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] access complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('判断文件是否存在 path是文件夹(文件夹存在)').width(300).onClick(() => {
                this.fsManager.access({
                  path: this.context.filesDir+'/saveFiles',
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager access  success = '+JSON.stringify(res) )
                    promptAction.showToast({
                      message: `文件存在 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    // 文件不存在或其他错误
                    console.error(`[advanceDEMO] 不存在 或其他错误 ${JSON.stringify(res)}`)
                    console.log('[AdvancedAPI] fileSystemManager access  fail = '+JSON.stringify(res) )
                    promptAction.showToast({
                      message: `不存在 或其他错误 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] access complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('判断文件是否存在 path是文件夹(文件夹不存在)').width(300).onClick(() => {
                this.fsManager.access({
                  path: this.context.filesDir+'/111',
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager access  success = '+JSON.stringify(res) )
                    promptAction.showToast({
                      message: `文件存在 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    // 文件不存在或其他错误
                    console.error(`[advanceDEMO] 不存在 或其他错误 ${JSON.stringify(res)}`)
                    console.log('[AdvancedAPI] fileSystemManager access  fail = '+JSON.stringify(res) )
                    promptAction.showToast({
                      message: `不存在 或其他错误 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] access complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('path object ').width(300).onClick(() => {
                this.fsManager.access({
                  path: {name: 'test' },
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager access 1 success = '+JSON.stringify(res) )
                  },
                  fail: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager access 1 fail = '+JSON.stringify(res) )
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager access 1  complete = '+JSON.stringify(res) )
                  }
                })
              })

              Button('path boolean ').width(300).onClick(() => {
                this.fsManager.access({
                  path: false,
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager access 2 success = '+JSON.stringify(res) )
                  },
                  fail: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager access 2 fail = '+JSON.stringify(res) )
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] fileSystemManager access 2  complete = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('path undefined ').width(300).onClick(() => {
                this.fsManager.access({
                  path: undefined,
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager access 3 success = '+JSON.stringify(res) )
                  },
                  fail: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager access 3 fail = '+JSON.stringify(res) )
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] fileSystemManager access 3 complete = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('path 空字符 ').width(300).onClick(() => {
                this.fsManager.access({
                  path: '',
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager access 4 success = '+JSON.stringify(res) )
                  },
                  fail: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager access 4 fail = '+JSON.stringify(res) )
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] fileSystemManager access  4 complete = ${JSON.stringify(res)}`)
                  }
                })
              })
            }
          }

          // fs.accessSync
          ListItem() {
            Column({ space: 10 }) {
              Text('fs.accessSync').fontSize(25)
              Button('判断文件是否存在，path是一个文件').width(300).onClick(() => {
                try {
                  this.fsManager.accessSync(this.filePath)
                  console.log('[AdvancedAPI] fileSystemManager accessSync  success = '+this.filePath )
                  promptAction.showToast({
                    message: `文件存在`
                  })
                } catch (error) {
                  console.log('[AdvancedAPI] fileSystemManager accessSync  fail = '+error)
                  promptAction.showToast({
                    message: `文件不存在 或其他错误 ${error}`
                  })
                }
              })

              Button('判断文件是否存在 没有path入参').width(300).onClick(() => {
                try {
                  this.fsManager.accessSync()
                  promptAction.showToast({
                    message: `文件存在`
                  })
                } catch (error) {
                  console.log('[AdvancedAPI] fileSystemManager accessSync  fail = '+error)
                  promptAction.showToast({
                    message: `文件不存在 或其他错误 ${error}`
                  })
                }
              })

              Button('判断文件是否存在 path是number').width(300).onClick(() => {
                try {
                  this.fsManager.accessSync(1)
                  promptAction.showToast({
                    message: `文件存在`
                  })
                } catch (error) {
                  console.log('[AdvancedAPI] fileSystemManager accessSync  fail = '+error)
                  promptAction.showToast({
                    message: `文件不存在 或其他错误 ${error}`
                  })
                }
              })

              Button('判断文件是否存在 path是null').width(300).onClick(() => {
                try {
                  this.fsManager.accessSync(null)
                  promptAction.showToast({
                    message: `文件存在`
                  })
                } catch (error) {
                  console.log('[AdvancedAPI] fileSystemManager accessSync  fail = '+error)
                  promptAction.showToast({
                    message: `文件不存在 或其他错误 ${error}`
                  })
                }
              })

              Button('判断文件是否存在 path是文件夹(文件夹存在)').width(300).onClick(() => {
                try {
                  this.fsManager.accessSync(this.context.filesDir+'/saveFiles')
                  promptAction.showToast({
                    message: `文件存在`
                  })
                } catch (error) {
                  console.log('[AdvancedAPI] fileSystemManager accessSync  fail = '+error)
                  promptAction.showToast({
                    message: `文件不存在 或其他错误 ${error}`
                  })
                }
              })

              Button('判断文件是否存在 path是文件夹(文件夹不存在)').width(300).onClick(() => {
                try {
                  this.fsManager.accessSync(this.context.filesDir+'/111')
                  promptAction.showToast({
                    message: `文件存在`
                  })
                } catch (error) {
                  console.log('[AdvancedAPI] fileSystemManager accessSync  fail = '+error)
                  promptAction.showToast({
                    message: `文件不存在 或其他错误 ${error}`
                  })
                }
              })

              Button('path object ').width(300).onClick(() => {
                try {
                  this.fsManager.accessSync({name: 'test' })
                  console.log('[AdvancedAPI] fileSystemManager accessSync  ok = ' + 哈哈哈)
                } catch (error) {
                  console.log('[AdvancedAPI] fileSystemManager accessSync  exception = '+error)
                }
              })

              Button('path boolean ').width(300).onClick(() => {
                try {
                  this.fsManager.accessSync(true)
                  console.log('[AdvancedAPI] fileSystemManager accessSync  ok = ' + 哈哈哈)
                } catch (error) {
                  console.log('[AdvancedAPI] fileSystemManager accessSync  exception = '+error)
                }
              })

              Button('path undefined ').width(300).onClick(() => {
                try {
                  this.fsManager.accessSync(undefined)
                  console.log('[AdvancedAPI] fileSystemManager accessSync  ok = ' + 哈哈哈)
                } catch (error) {
                  console.log('[AdvancedAPI] fileSystemManager accessSync  exception = '+error)
                }
              })

              Button('path 空字符 ').width(300).onClick(() => {
                try {
                  this.fsManager.accessSync('')
                  console.log('[AdvancedAPI] fileSystemManager accessSync  ok = ' + 哈哈哈)
                } catch (error) {
                  console.log('[AdvancedAPI] fileSystemManager accessSync  exception = '+error)
                }
              })
            }
          }

          // fs.appendFile
          ListItem() {
            Column({ space: 10 }) {
              Text('fs.appendFile').fontSize(25)
              Button('鸿蒙接口读取文件test.txt内容').width(300).onClick(() => {
                let str = fs.readTextSync(this.filePath)
                console.log('[AdvancedAPI] fileSystemManager readTextSync  ok = ' + str)
                promptAction.showToast({
                  message: `文件内容：${JSON.stringify(str)}`
                })
              })

              Button('追加文件test.txt，写入内容：some text').width(300).onClick(() => {
                this.fsManager.appendFile({
                  filePath: this.filePath,
                  data: 'some text',
                  encoding: 'utf8',
                  success: (res) => {
                    promptAction.showToast({
                      message: `追加成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 追加文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `追加文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] appendFile complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('appendFile-path-无此参数').width(300).onClick(() => {
                this.fsManager.appendFile({
                  // filePath: this.filePath,
                  data: 'some text',
                  encoding: 'utf8',
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 1 success = '+JSON.stringify(res) )
                  },
                  fail: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 1 fail = '+JSON.stringify(res) )
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 1  complete = '+JSON.stringify(res) )
                  }
                })
              })

              Button('appendFile-path-Number').width(300).onClick(() => {
                this.fsManager.appendFile({
                  filePath: 778899,
                  data: 'some text',
                  encoding: 'utf8',
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 2 success = '+JSON.stringify(res) )
                  },
                  fail: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 2 fail = '+JSON.stringify(res) )
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 2  complete = '+JSON.stringify(res) )
                  }
                })
              })

              Button('appendFile-encoding\'ab\'').width(300).onClick(() => {
                this.fsManager.appendFile({
                  filePath: this.filePath,
                  data: 'some text',
                  encoding:12,
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 2 success = '+JSON.stringify(res) )
                  },
                  fail: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 2 fail = '+JSON.stringify(res) )
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 2  complete = '+JSON.stringify(res) )
                  }
                })
              })
            }
          }

          // fs.appendFile
          ListItem() {
            Column({ space: 10 }) {
              Text('fs.open').fontSize(25)
              Button('鸿蒙接口，删除hello.txt文件').width(300).onClick(() => {
                fs.unlinkSync(this.filePath)
                promptAction.showToast({
                  message: '删除成功'
                })
              })

              Button('appendFile-path-Object').width(300).onClick(() => {
                this.fsManager.appendFile({
                  filePath: {name:'test' },
                  data: 'some text',
                  encoding: 'utf8',
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 3 success = '+JSON.stringify(res) )
                  },
                  fail: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 3 fail = '+JSON.stringify(res) )
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 3  complete = '+JSON.stringify(res) )
                  }
                })
              })

              Button('appendFile-path-Boolean').width(300).onClick(() => {
                this.fsManager.appendFile({
                  filePath: false,
                  data: 'some text',
                  encoding: 'utf8',
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 4 success = '+JSON.stringify(res) )
                  },
                  fail: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 4 fail = '+JSON.stringify(res) )
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 4  complete = '+JSON.stringify(res) )
                  }
                })
              })

              Button('appendFile-path-null').width(300).onClick(() => {
                this.fsManager.appendFile({
                  filePath: null,
                  data: 'some text',
                  encoding: 'utf8',
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 5 success = '+JSON.stringify(res) )
                  },
                  fail: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 5 fail = '+JSON.stringify(res) )
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 5  complete = '+JSON.stringify(res) )
                  }
                })
              })

              Button('appendFile-path-undefined').width(300).onClick(() => {
                this.fsManager.appendFile({
                  filePath: undefined,
                  data: 'some text',
                  encoding: 'utf8',
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 6 success = '+JSON.stringify(res) )
                  },
                  fail: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 6 fail = '+JSON.stringify(res) )
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 6  complete = '+JSON.stringify(res) )
                  }
                })
              })

              Button('appendFile-path-空字符').width(300).onClick(() => {
                this.fsManager.appendFile({
                  filePath: '',
                  data: 'some text',
                  encoding: 'utf8',
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 7 success = '+JSON.stringify(res) )
                  },
                  fail: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 7 fail = '+JSON.stringify(res) )
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 7  complete = '+JSON.stringify(res) )
                  }
                })
              })

              Button('appendFile-data-String 超长字符').width(300).onClick(() => {
                this.fsManager.appendFile({
                  filePath: this.filePath,
                  data: 'muchStringDataMuchStringDataMuchStringDataMuchStringDataMuchStringDataMuchStringDataMuchStringData',
                  encoding: 'utf8',
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 0 success = '+JSON.stringify(res) )
                  },
                  fail: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 0 fail = '+JSON.stringify(res) )
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 0  complete = '+JSON.stringify(res) )
                  }
                })
              })

              Button('appendFile-data-ArrayBuffer').width(300).onClick(() => {
                const arrayBuffer = new Uint8Array([66, 66, 66])
                this.fsManager.appendFile({
                  filePath: this.filePath,
                  data: arrayBuffer,
                  encoding: 'utf8',
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 00 success = '+JSON.stringify(res) )
                  },
                  fail: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 00 fail = '+JSON.stringify(res) )
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 00  complete = '+JSON.stringify(res) )
                  }
                })
              })

              Button('appendFile-data-无此参数').width(300).onClick(() => {
                this.fsManager.appendFile({
                  filePath: this.filePath,
                  // data: 'some text',
                  encoding: 'utf8',
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 1 success = '+JSON.stringify(res) )
                  },
                  fail: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 1 fail = '+JSON.stringify(res) )
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 1  complete = '+JSON.stringify(res) )
                  }
                })
              })

              Button('appendFile-data-Number').width(300).onClick(() => {
                this.fsManager.appendFile({
                  filePath: this.filePath,
                  data: 778899,
                  encoding: 'utf8',
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 2 success = '+JSON.stringify(res) )
                  },
                  fail: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 2 fail = '+JSON.stringify(res) )
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 2 complete = '+JSON.stringify(res) )
                  }
                })
              })

              Button('appendFile-data-Object').width(300).onClick(() => {
                this.fsManager.appendFile({
                  filePath: this.filePath,
                  data: {name :'test' },
                  encoding: 'utf8',
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 3 success = '+JSON.stringify(res) )
                  },
                  fail: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 3 fail = '+JSON.stringify(res) )
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 3 complete = '+JSON.stringify(res) )
                  }
                })
              })

              Button('appendFile-data-Boolean').width(300).onClick(() => {
                this.fsManager.appendFile({
                  filePath: this.filePath,
                  data: false,
                  encoding: 'utf8',
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 4 success = '+JSON.stringify(res) )
                  },
                  fail: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 4 fail = '+JSON.stringify(res) )
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 4  complete = '+JSON.stringify(res) )
                  }
                })
              })

              Button('appendFile-data-null').width(300).onClick(() => {
                this.fsManager.appendFile({
                  filePath: this.filePath,
                  data: null,
                  encoding: 'utf8',
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 5 success = '+JSON.stringify(res) )
                  },
                  fail: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 5 fail = '+JSON.stringify(res) )
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 5  complete = '+JSON.stringify(res) )
                  }
                })
              })

              Button('appendFile-data-undefined').width(300).onClick(() => {
                this.fsManager.appendFile({
                  filePath: this.filePath,
                  data: undefined,
                  encoding: 'utf8',
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 6 success = '+JSON.stringify(res) )
                  },
                  fail: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 6 fail = '+JSON.stringify(res) )
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 6 complete = '+JSON.stringify(res) )
                  }
                })
              })

              Button('appendFile-data-空字符').width(300).onClick(() => {
                this.fsManager.appendFile({
                  filePath: this.filePath,
                  data: '',
                  encoding: 'utf8',
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 7 success = '+JSON.stringify(res) )
                  },
                  fail: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 7 fail = '+JSON.stringify(res) )
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 7 complete = '+JSON.stringify(res) )
                  }
                })
              })

              Button('appendFile-encoding-无此参数（效果默认utf-8）').width(300).onClick(() => {
                this.fsManager.appendFile({
                  filePath: this.filePath,
                  data: 'encoding wuCanShu',
                  // encoding: 'utf8',
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 0 success = '+JSON.stringify(res) )
                  },
                  fail: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 0 fail = '+JSON.stringify(res) )
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 0 complete = '+JSON.stringify(res) )
                  }
                })
              })

              Button('appendFile-encoding-合法类型（ascii）').width(300).onClick(() => {
                this.fsManager.appendFile({
                  filePath: this.filePath,
                  data: 'encoding ascii',
                  encoding: 'ascii',
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 1 success = '+JSON.stringify(res) )
                  },
                  fail: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 1 fail = '+JSON.stringify(res) )
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 1  complete = '+JSON.stringify(res) )
                  }
                })
              })

              Button('appendFile-encoding-合法类型（base64）').width(300).onClick(() => {
                this.fsManager.appendFile({
                  filePath: this.filePath,
                  data: 'encoding base64',
                  encoding: 'base64',
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 2 success = '+JSON.stringify(res) )
                  },
                  fail: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 2 fail = '+JSON.stringify(res) )
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 2 complete = '+JSON.stringify(res) )
                  }
                })
              })

              Button('appendFile-encoding-合法类型（binary）').width(300).onClick(() => {
                this.fsManager.appendFile({
                  filePath: this.filePath,
                  data: 'encoding binary',
                  encoding: 'binary',
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 3 success = '+JSON.stringify(res) )
                  },
                  fail: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 3 fail = '+JSON.stringify(res) )
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 3 complete = '+JSON.stringify(res) )
                  }
                })
              })

              Button('appendFile-encoding-合法类型（hex）').width(300).onClick(() => {
                this.fsManager.appendFile({
                  filePath: this.filePath,
                  data: 'encoding hex',
                  encoding: 'hex',
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 4 success = '+JSON.stringify(res) )
                  },
                  fail: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 4 fail = '+JSON.stringify(res) )
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 4  complete = '+JSON.stringify(res) )
                  }
                })
              })

              Button('appendFile-encoding-合法类型（ucs2）').width(300).onClick(() => {
                this.fsManager.appendFile({
                  filePath: this.filePath,
                  data: 'encoding ucs2',
                  encoding: 'ucs2',
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 5 success = '+JSON.stringify(res) )
                  },
                  fail: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 5 fail = '+JSON.stringify(res) )
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 5 complete = '+JSON.stringify(res) )
                  }
                })
              })

              Button('appendFile-encoding-合法类型（ucs-2）').width(300).onClick(() => {
                this.fsManager.appendFile({
                  filePath: this.filePath,
                  data: 'encoding ucs-2',
                  encoding: 'ucs-2',
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 6 success = '+JSON.stringify(res) )
                  },
                  fail: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 6 fail = '+JSON.stringify(res) )
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 6 complete = '+JSON.stringify(res) )
                  }
                })
              })

              Button('appendFile-encoding-合法类型（utf16le）').width(300).onClick(() => {
                this.fsManager.appendFile({
                  filePath: this.filePath,
                  data: 'encoding utf16le',
                  encoding: 'utf16le',
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 7 success = '+JSON.stringify(res) )
                  },
                  fail: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 7 fail = '+JSON.stringify(res) )
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 7 complete = '+JSON.stringify(res) )
                  }
                })
              })

              Button('appendFile-encoding-合法类型（utf-16le）').width(300).onClick(() => {
                this.fsManager.appendFile({
                  filePath: this.filePath,
                  data: 'encoding utf-16le',
                  encoding: 'utf-16le',
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 8 success = '+JSON.stringify(res) )
                  },
                  fail: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 8 fail = '+JSON.stringify(res) )
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 8 complete = '+JSON.stringify(res) )
                  }
                })
              })

              Button('appendFile-encoding-合法类型（utf-8）').width(300).onClick(() => {
                this.fsManager.appendFile({
                  filePath: this.filePath,
                  data: 'encoding utf-8',
                  encoding: 'utf-8',
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 9 success = '+JSON.stringify(res) )
                  },
                  fail: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 9 fail = '+JSON.stringify(res) )
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 9 complete = '+JSON.stringify(res) )
                  }
                })
              })

              Button('appendFile-encoding-合法类型（utf8）').width(300).onClick(() => {
                this.fsManager.appendFile({
                  filePath: this.filePath,
                  data: 'encoding utf8',
                  encoding: 'utf8',
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 10 success = '+JSON.stringify(res) )
                  },
                  fail: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 10 fail = '+JSON.stringify(res) )
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 10 complete = '+JSON.stringify(res) )
                  }
                })
              })

              Button('appendFile-encoding-合法类型（latin1）').width(300).onClick(() => {
                this.fsManager.appendFile({
                  filePath: this.filePath,
                  data: 'encoding latin1',
                  encoding: 'latin1',
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 11 success = '+JSON.stringify(res) )
                  },
                  fail: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 11 fail = '+JSON.stringify(res) )
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 11  complete = '+JSON.stringify(res) )
                  }
                })
              })

              Button('appendFile-encoding-Number').width(300).onClick(() => {
                this.fsManager.appendFile({
                  filePath: this.filePath,
                  data: 'encoding Number',
                  encoding: 445566,
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 12 success = '+JSON.stringify(res) )
                  },
                  fail: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 12 fail = '+JSON.stringify(res) )
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 12 complete = '+JSON.stringify(res) )
                  }
                })
              })

              Button('appendFile-encoding-Object').width(300).onClick(() => {
                this.fsManager.appendFile({
                  filePath: this.filePath,
                  data: 'encoding Object',
                  encoding: {name:'test' },
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 13 success = '+JSON.stringify(res) )
                  },
                  fail: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 13 fail = '+JSON.stringify(res) )
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 13  complete = '+JSON.stringify(res) )
                  }
                })
              })

              Button('appendFile-encoding-Boolean').width(300).onClick(() => {
                this.fsManager.appendFile({
                  filePath: this.filePath,
                  data: 'encoding Boolean',
                  encoding: false,
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 14 success = '+JSON.stringify(res) )
                  },
                  fail: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 14 fail = '+JSON.stringify(res) )
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 14 complete = '+JSON.stringify(res) )
                  }
                })
              })

              Button('appendFile-encoding-null').width(300).onClick(() => {
                this.fsManager.appendFile({
                  filePath: this.filePath,
                  data: 'encoding null',
                  encoding: null,
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 15 success = '+JSON.stringify(res) )
                  },
                  fail: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 15 fail = '+JSON.stringify(res) )
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 15  complete = '+JSON.stringify(res) )
                  }
                })
              })

              Button('appendFile-encoding-undefined').width(300).onClick(() => {
                this.fsManager.appendFile({
                  filePath: this.filePath,
                  data: 'encoding undefined',
                  encoding: undefined,
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 16 success = '+JSON.stringify(res) )
                  },
                  fail: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 16 fail = '+JSON.stringify(res) )
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 16  complete = '+JSON.stringify(res) )
                  }
                })
              })

              Button('appendFile-encoding-空字符').width(300).onClick(() => {
                this.fsManager.appendFile({
                  filePath: this.filePath,
                  data: 'encoding kongZiFu',
                  encoding: '',
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 17 success = '+JSON.stringify(res) )
                  },
                  fail: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 17 fail = '+JSON.stringify(res) )
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager appendFile 17  complete = '+JSON.stringify(res) )
                  }
                })
              })

              Button('同步追加文件test.txt，写入内容：some text').width(300).onClick(() => {
                this.fsManager.appendFileSync(this.filePath, 'some text', 'utf8')
              })

              Button('同步追加 path-Object').width(300).onClick(() => {
                try {
                  this.fsManager.appendFileSync({ name:'test' }, 'some text', 'utf8')
                  console.log('[AdvancedAPI] fileSystemManager appendFileSync  ok = ' + 哈哈哈)
                } catch (error) {
                  console.log('[AdvancedAPI] fileSystemManager appendFileSync  exception = '+error)
                }
              })

              Button('同步追加 path-null').width(300).onClick(() => {
                try {
                  this.fsManager.appendFileSync(null, 'some text', 'utf8')
                  console.log('[AdvancedAPI] fileSystemManager appendFileSync  ok = ' + 哈哈哈)
                } catch (error) {
                  console.log('[AdvancedAPI] fileSystemManager appendFileSync  exception = '+error)
                }
              })

              Button('同步追加 data-Number').width(300).onClick(() => {
                try {
                  this.fsManager.appendFileSync(this.filePath, 7788, 'utf8')
                  console.log('[AdvancedAPI] fileSystemManager appendFileSync  ok = ' + 哈哈哈)
                } catch (error) {
                  console.log('[AdvancedAPI] fileSystemManager appendFileSync  exception = '+error)
                }
              })

              Button('同步追加 data-null').width(300).onClick(() => {
                try {
                  this.fsManager.appendFileSync(this.filePath, null, 'utf8')
                  console.log('[AdvancedAPI] fileSystemManager appendFileSync  ok = ' + 哈哈哈)
                } catch (error) {
                  console.log('[AdvancedAPI] fileSystemManager appendFileSync  exception = '+error)
                }
              })

              Button('同步追加 encoding-Boolean').width(300).onClick(() => {
                try {
                  this.fsManager.appendFileSync(this.filePath, 'appendFileSyncEX', false)
                  console.log('[AdvancedAPI] fileSystemManager appendFileSync  ok = ' + 哈哈哈)
                } catch (error) {
                  console.log('[AdvancedAPI] fileSystemManager appendFileSync  exception = '+error)
                }
              })

              Button('同步追加 encoding-空字符').width(300).onClick(() => {
                try {
                  this.fsManager.appendFileSync(this.filePath, 'appendFileSyncEX', '')
                  console.log('[AdvancedAPI] fileSystemManager appendFileSync  ok = ' + 哈哈哈)
                } catch (error) {
                  console.log('[AdvancedAPI] fileSystemManager appendFileSync  exception = '+error)
                }
              })
            }
          }

          // fs.open
          ListItem() {
            Column({ space: 10 }) {
              Text('fs.open').fontSize(25)
              Button('鸿蒙接口，删除hello.txt文件').width(300).onClick(() => {
                fs.unlinkSync(this.filePath)
                promptAction.showToast({
                  message: '删除成功'
                })
              })

              Button('打开文件test.txt').width(300).onClick(() => {
                this.fsManager.open({
                  filePath: this.filePath,
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager open 0 success = '+JSON.stringify(res) )
                    console.log('[AdvancedAPI] fileSystemManager open res.fd = '+res.fd)
                    this.fd = res.fd,
                    promptAction.showToast({
                      message: `打开文件 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager open 0 fail = '+JSON.stringify(res) )
                    console.error(`[advanceDEMO] 打开文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `打开文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager open 0 complete = '+JSON.stringify(res) )
                    console.log(`[advanceDEMO] open complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('打开文件test.txt flag:a').width(300).onClick(() => {
                this.fsManager.open({
                  filePath: this.filePath,
                  flag: 'a',
                  success: (res) => {
                    promptAction.showToast({
                      message: `打开文件 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 打开文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `打开文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] open complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('打开文件test.txt flag:ax').width(300).onClick(() => {
                this.fsManager.open({
                  filePath: this.filePath,
                  flag: 'ax',
                  success: (res) => {
                    promptAction.showToast({
                      message: `打开文件 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 打开文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `打开文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] open complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('打开文件test.txt flag:a+').width(300).onClick(() => {
                this.fsManager.open({
                  filePath: this.filePath,
                  flag: 'a+',
                  success: (res) => {
                    promptAction.showToast({
                      message: `打开文件 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 打开文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `打开文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] open complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('打开文件test.txt flag:ax+').width(300).onClick(() => {
                this.fsManager.open({
                  filePath: this.filePath,
                  flag: 'ax+',
                  success: (res) => {
                    promptAction.showToast({
                      message: `打开文件 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 打开文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `打开文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] open complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('打开文件test.txt flag:as').width(300).onClick(() => {
                this.fsManager.open({
                  filePath: this.filePath,
                  flag: 'as',
                  success: (res) => {
                    promptAction.showToast({
                      message: `打开文件 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 打开文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `打开文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] open complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('打开文件test.txt flag:as+').width(300).onClick(() => {
                this.fsManager.open({
                  filePath: this.filePath,
                  flag: 'as+',
                  success: (res) => {
                    promptAction.showToast({
                      message: `打开文件 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 打开文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `打开文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] open complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('打开文件test.txt flag:r').width(300).onClick(() => {
                this.fsManager.open({
                  filePath: this.filePath,
                  flag: 'r',
                  success: (res) => {
                    promptAction.showToast({
                      message: `打开文件 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 打开文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `打开文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] open complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('打开文件test.txt flag:r+').width(300).onClick(() => {
                this.fsManager.open({
                  filePath: this.filePath,
                  flag: 'r+',
                  success: (res) => {
                    promptAction.showToast({
                      message: `打开文件 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 打开文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `打开文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] open complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('打开文件test.txt flag:w').width(300).onClick(() => {
                this.fsManager.open({
                  filePath: this.filePath,
                  flag: 'w',
                  success: (res) => {
                    promptAction.showToast({
                      message: `打开文件 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 打开文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `打开文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] open complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('打开文件test.txt flag:wx').width(300).onClick(() => {
                this.fsManager.open({
                  filePath: this.filePath,
                  flag: 'wx',
                  success: (res) => {
                    promptAction.showToast({
                      message: `打开文件 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 打开文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `打开文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] open complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('打开文件test.txt flag:w+').width(300).onClick(() => {
                this.fsManager.open({
                  filePath: this.filePath,
                  flag: 'w+',
                  success: (res) => {
                    promptAction.showToast({
                      message: `打开文件 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 打开文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `打开文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] open complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('打开文件test.txt flag:wx+').width(300).onClick(() => {
                this.fsManager.open({
                  filePath: this.filePath,
                  flag: 'wx+',
                  success: (res) => {
                    this.fd = res.fd
                    promptAction.showToast({
                      message: `打开文件 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 打开文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `打开文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] open complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('filePath object ').width(300).onClick(() => {
                this.fsManager.open({
                  filePath: {name: 'test' },
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager open 1 success = '+JSON.stringify(res) )
                  },
                  fail: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager open 1 fail = '+JSON.stringify(res) )
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager open 1  complete = '+JSON.stringify(res) )
                  }
                })
              })

              Button('filePath boolean ').width(300).onClick(() => {
                this.fsManager.open({
                  filePath: false,
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager open 2 success = '+JSON.stringify(res) )
                  },
                  fail: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager open 2 fail = '+JSON.stringify(res) )
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] fileSystemManager open 2  complete = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('filePath Number ').width(300).onClick(() => {
                this.fsManager.open({
                  filePath: 7788,
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager open 3 success = '+JSON.stringify(res) )
                  },
                  fail: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager open 3 fail = '+JSON.stringify(res) )
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] fileSystemManager open 3 complete = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('filePath 无效String ').width(300).onClick(() => {
                this.fsManager.open({
                  filePath: 'aaa',
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager open 4 success = '+JSON.stringify(res) )
                  },
                  fail: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager open 4 fail = '+JSON.stringify(res) )
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] fileSystemManager open  4 complete = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('filePath null ').width(300).onClick(() => {
                this.fsManager.open({
                  filePath: null,
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager open 5 success = '+JSON.stringify(res) )
                  },
                  fail: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager open 5 fail = '+JSON.stringify(res) )
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] fileSystemManager open 5  complete = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('filePath undefined ').width(300).onClick(() => {
                this.fsManager.open({
                  filePath: undefined,
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager open 6 success = '+JSON.stringify(res) )
                  },
                  fail: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager open 6 fail = '+JSON.stringify(res) )
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] fileSystemManager open 6 complete = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('filePath 空字符 ').width(300).onClick(() => {
                this.fsManager.open({
                  filePath: '',
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager open 7 success = '+JSON.stringify(res) )
                  },
                  fail: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager open 7 fail = '+JSON.stringify(res) )
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] fileSystemManager open  7 complete = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('flag object ').width(300).onClick(() => {
                this.fsManager.open({
                  filepath: this.filePath,
                  flag: {name: 'test' },
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager open 1 success = '+JSON.stringify(res) )
                  },
                  fail: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager open 1 fail = '+JSON.stringify(res) )
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager open 1  complete = '+JSON.stringify(res) )
                  }
                })
              })

              Button('flag boolean ').width(300).onClick(() => {
                this.fsManager.open({
                  filepath: this.filePath,
                  flag: false,
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager open 2 success = '+JSON.stringify(res) )
                  },
                  fail: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager open 2 fail = '+JSON.stringify(res) )
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] fileSystemManager open 2  complete = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('flag Number ').width(300).onClick(() => {
                this.fsManager.open({
                  filepath: this.filePath,
                  flag: 7788,
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager open 3 success = '+JSON.stringify(res) )
                  },
                  fail: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager open 3 fail = '+JSON.stringify(res) )
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] fileSystemManager open 3 complete = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('flag 无效String ').width(300).onClick(() => {
                this.fsManager.open({
                  filepath: this.filePath,
                  flag: 'aaa',
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager open 4 success = '+JSON.stringify(res) )
                  },
                  fail: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager open 4 fail = '+JSON.stringify(res) )
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] fileSystemManager open  4 complete = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('flag null ').width(300).onClick(() => {
                this.fsManager.open({
                  filepath: this.filePath,
                  flag: null,
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager open 5 success = '+JSON.stringify(res) )
                  },
                  fail: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager open 5 fail = '+JSON.stringify(res) )
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] fileSystemManager open 5  complete = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('flag undefined ').width(300).onClick(() => {
                this.fsManager.open({
                  filepath: this.filePath,
                  flag: undefined,
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager open 6 success = '+JSON.stringify(res) )
                  },
                  fail: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager open 6 fail = '+JSON.stringify(res) )
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] fileSystemManager open 6 complete = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('flag 空字符 ').width(300).onClick(() => {
                this.fsManager.open({
                  filepath: this.filePath,
                  flag: '',
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager open 7 success = '+JSON.stringify(res) )
                  },
                  fail: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager open 7 fail = '+JSON.stringify(res) )
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] fileSystemManager open  7 complete = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('同步打开文件test.txt flag:r').width(300).onClick(() => {
                console.log('[AdvancedAPI] fileSystemManager openSync  filePath = '+this.filePath )
                console.log('[AdvancedAPI] fileSystemManager openSync  type = '+ typeof(this.filePath))
                const fd = this.fsManager.openSync({
                  filePath: this.filePath,
                  flag: 'r'
                })
                console.log('[advanceDEMO] fd = ', fd)
                promptAction.showToast({
                  message: `同步打开文件 成功${fd}`
                })
              })

              Button('同步打开 filePath object').width(300).onClick(() => {
                try {
                  this.fsManager.openSync({
                    filePath: {name: 'aaa' },
                    flag: 'r'
                  })
                  console.log('[AdvancedAPI] fileSystemManager openSync  ok = ' + 哈哈哈)
                } catch (error) {
                  console.log('[AdvancedAPI] fileSystemManager openSync  exception = '+error)
                }
              })

              Button('同步打开 filePath boolean').width(300).onClick(() => {
                try {
                  this.fsManager.closeSync({
                    filePath: false,
                    flag: 'r'
                  })
                  console.log('[AdvancedAPI] fileSystemManager openSync  ok = ' + 哈哈哈)
                } catch (error) {
                  console.log('[AdvancedAPI] fileSystemManager openSync  exception = '+error)
                }
              })

              Button('同步打开 flag null').width(300).onClick(() => {
                try {
                  this.fsManager.openSync({
                    filePath: this.filePath,
                    flag: null
                  })
                  console.log('[AdvancedAPI] fileSystemManager openSync  ok = ' + 哈哈哈)
                } catch (error) {
                  console.log('[AdvancedAPI] fileSystemManager openSync  exception = '+error)
                }
              })

              Button('同步打开 flag undefined').width(300).onClick(() => {
                try {
                  this.fsManager.closeSync({
                    filePath:this.filePath,
                    flag: undefined
                  })
                  console.log('[AdvancedAPI] fileSystemManager openSync  ok = ' + 哈哈哈)
                } catch (error) {
                  console.log('[AdvancedAPI] fileSystemManager openSync  exception = '+error)
                }
              })
            }
          }

          // fs.close
          ListItem() {
            Column({ space: 10 }) {
              Text('fs.close').fontSize(25)
              Button('关闭文件test.txt').width(300).onClick(() => {
                console.log('[AdvancedAPI] fileSystemManager close fd = '+this.fd )
                this.fsManager.close({
                  fd: this.fd,
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager close 1 success = '+JSON.stringify(res) )
                    promptAction.showToast({
                      message: `关闭文件 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 打开文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `关闭文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('fd object ').width(300).onClick(() => {
                this.fsManager.close({
                  fd: {name: 'test' },
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager close 1 success = '+JSON.stringify(res) )
                  },
                  fail: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager close 1 fail = '+JSON.stringify(res) )
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager close 1  complete = '+JSON.stringify(res) )
                  }
                })
              })

              Button('fd boolean ').width(300).onClick(() => {
                this.fsManager.close({
                  fd: false,
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager close 2 success = '+JSON.stringify(res) )
                  },
                  fail: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager close 2 fail = '+JSON.stringify(res) )
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] fileSystemManager close 2  complete = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('fd Number ').width(300).onClick(() => {
                this.fsManager.close({
                  fd: 7788,
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager close 3 success = '+JSON.stringify(res) )
                  },
                  fail: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager close 3 fail = '+JSON.stringify(res) )
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] fileSystemManager close 3 complete = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('fd 无效String ').width(300).onClick(() => {
                this.fsManager.close({
                  fd: 'aaa',
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager close 4 success = '+JSON.stringify(res) )
                  },
                  fail: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager close 4 fail = '+JSON.stringify(res) )
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] fileSystemManager close  4 complete = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('fd null ').width(300).onClick(() => {
                this.fsManager.close({
                  fd: null,
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager close 5 success = '+JSON.stringify(res) )
                  },
                  fail: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager close 5 fail = '+JSON.stringify(res) )
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] fileSystemManager close 5  complete = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('fd undefined ').width(300).onClick(() => {
                this.fsManager.close({
                  fd: undefined,
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager close 6 success = '+JSON.stringify(res) )
                  },
                  fail: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager close 6 fail = '+JSON.stringify(res) )
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] fileSystemManager close 6 complete = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('fd 空字符 ').width(300).onClick(() => {
                this.fsManager.close({
                  fd: '',
                  success: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager close 7 success = '+JSON.stringify(res) )
                  },
                  fail: (res) => {
                    console.log('[AdvancedAPI] fileSystemManager close 7 fail = '+JSON.stringify(res) )
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] fileSystemManager close  7 complete = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('同步关闭文件test.txt').width(300).onClick(() => {
                this.fsManager.closeSync({
                  fd: this.fd
                })
                promptAction.showToast({
                  message: `关闭文件 成功`
                })
              })

              Button('同步关闭 无效String').width(300).onClick(() => {
                try {
                  this.fsManager.closeSync({
                    fd: 'aaa'
                  })
                  console.log('[AdvancedAPI] fileSystemManager closeSync  ok')
                } catch (error) {
                  console.log('[AdvancedAPI] fileSystemManager closeSync  exception = '+error)
                }
              })

              Button('同步关闭 object').width(300).onClick(() => {
                try {
                  this.fsManager.closeSync({
                    fd: {name: 'aaa' }
                  })
                  console.log('[AdvancedAPI] fileSystemManager closeSync  ok')
                } catch (error) {
                  console.log('[AdvancedAPI] fileSystemManager closeSync  exception = '+error)
                }
              })

              Button('同步关闭 boolean').width(300).onClick(() => {
                try {
                  this.fsManager.closeSync({
                    fd: true
                  })
                  console.log('[AdvancedAPI] fileSystemManager closeSync  ok')
                } catch (error) {
                  console.log('[AdvancedAPI] fileSystemManager closeSync  exception = '+error)
                }
              })

              Button('同步关闭 Number').width(300).onClick(() => {
                try {
                  this.fsManager.closeSync({
                    fd: 1122
                  })
                  console.log('[AdvancedAPI] fileSystemManager closeSync  ok')
                } catch (error) {
                  console.log('[AdvancedAPI] fileSystemManager closeSync  exception = '+error)
                }
              })

              Button('同步关闭 null').width(300).onClick(() => {
                try {
                  this.fsManager.closeSync({
                    fd: null
                  })
                  console.log('[AdvancedAPI] fileSystemManager closeSync  ok')
                } catch (error) {
                  console.log('[AdvancedAPI] fileSystemManager closeSync  exception = '+error)
                }
              })

              Button('同步关闭 undefined').width(300).onClick(() => {
                try {
                  this.fsManager.closeSync({
                    fd: undefined
                  })
                  console.log('[AdvancedAPI] fileSystemManager closeSync  ok')
                } catch (error) {
                  console.log('[AdvancedAPI] fileSystemManager closeSync  exception = '+error)
                }
              })

              Button('同步关闭 空字符').width(300).onClick(() => {
                try {
                  this.fsManager.closeSync({
                    fd: ''
                  })
                  console.log('[AdvancedAPI] fileSystemManager closeSync  ok')
                } catch (error) {
                  console.log('[AdvancedAPI] fileSystemManager closeSync  exception = '+error)
                }
              })
            }
          }

          ListItem() {
            Column({ space: 10 }) {
              Text('fs.fstat').fontSize(25)
              Button('先用鸿蒙接口创建文件test.txt，创建目录filesDir下，写入内容hello, world').width(600).onClick(() => {
                let file = fs.openSync(this.filePath, fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE)
                let num = fs.writeSync(file.fd, "hello, world")
                promptAction.showToast({
                  message: `文件内容写入成功，长度：${num},path:${this.filePath}`,
                })
                console.debug('[advanceDEMO] write data to file succeed and size is:' + num + this.filePath)
              })

              Button('先打开文件test.txt，得到该文件的fd').width(300).onClick(() => {
                this.fsManager.open({
                  filePath: this.filePath,
                  success: (res) => {
                    this.fd = res.fd
                    promptAction.showToast({
                      message: `打开文件 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 打开文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `打开文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] open complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('再获取文件的状态信息 fd【有效】').width(300).onClick(() => {
                console.log('wsf: this.fd = '+this.fd)
                this.fsManager.fstat({
                  fd: this.fd,
                  success: (res) => {
                    const stat = res.stat
                    console.log('[advanceDEMO] fstat stat.size = '+stat.size)
                    console.log('[advanceDEMO] fstat stat.mode = '+stat.mode)
                    console.log('[advanceDEMO] fstat stat.lastModifiedTime = '+stat.lastModifiedTime)
                    console.log('[advanceDEMO] fstat stat.lastAccessedTime = '+stat.lastAccessedTime)
                    console.log('[advanceDEMO] fstat stat.isDirectory()'+ stat.isDirectory())
                    console.log('[advanceDEMO] fstat stat.isFile()'+ stat.isFile())
                    promptAction.showToast({
                      message: `获取文件状态信息 成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 获取文件状态信息 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `获取文件状态信息 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              // fd的值为null num等非string的情况 属于同一类错误
              Button('获取文件的状态信息 fd为null【无效】').width(300).onClick(() => {
                this.fsManager.fstat({
                  fd: null,
                  success: (res) => {
                    console.log('[advanceDEMO] fstat res = '+JSON.stringify(res))
                    promptAction.showToast({
                      message: `获取文件状态信息 成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 打开文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `获取文件状态信息 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })
            }
          }

          // fs.copyFile
          ListItem() {
            Column({ space: 10 }) {
              Text('fs.copyFile ').fontSize(25)
              Text(' 文件复制（From srcPath To destPath) ').fontSize(25)
              Button('创建文件test.txt，创建目录filesDir下，写入内容hello, world').width(600).onClick(() => {
                let file = fs.openSync(this.filePath, fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE)
                let num = fs.writeSync(file.fd, "hello, world")
                promptAction.showToast({
                  message: `文件内容写入成功，长度：${num},path:${this.filePath}`,
                })
                console.debug('[advanceDEMO] write data to file succeed and size is:' + num + this.filePath)
              })

              //  可以复制
              Button('srcPath存在为文件路径、destPath存在为文件路径 且相同 ').width(600).onClick(() => {
                this.fsManager.copyFile({
                  srcPath: this.filePath,
                  destPath: this.filePath ,
                  success: (res) => {
                    promptAction.showToast({
                      message: `文件 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 打开文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `复制文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('为下面的按钮 创建文件creatNewFileForTest.txt').width(600).onClick(() => {
                let file = fs.openSync(this.context.filesDir+'/creatNewFileForTest.txt', fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE)
                let num = fs.writeSync(file.fd, "hello, world")
                promptAction.showToast({
                  message: `文件内容写入成功，长度：${num},path:${this.filePath}`,
                })
                console.debug('[advanceDEMO] write data to file succeed and size is:' + num + this.filePath)
              })

              // 报错  copyFile fail
              Button('srcPath存在为文件路径、destPath存在为文件路径 但不同 ').width(600).onClick(() => {
                this.fsManager.copyFile({
                  srcPath: this.filePath ,
                  destPath: this.context.filesDir+'/creatNewFileForTest.txt' ,
                  success: (res) => {
                    promptAction.showToast({
                      message: `文件 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 打开文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `复制文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('为下面的button创建一个目录1').width(600).onClick(() => {
                try {
                  this.fsManager.mkdirSync(this.context.filesDir+'/testMkdir/test1',true)
                  promptAction.showToast({
                    message: `创建目录1成功`
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `创建目录1失败，目录已存在 或其他错误 ${error}`
                  })
                }
              })

              // 符合要求 可以复制
              Button('srcPath存在为文件路径、destPath存在为目录路径  ').width(600).onClick(() => {
                this.fsManager.copyFile({
                  srcPath: this.filePath ,
                  destPath: this.context.filesDir+'/testMkdir/test1',
                  success: (res) => {
                    promptAction.showToast({
                      message: `文件 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 复制文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `复制文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              // 报错 不允许访问
              Button('srcPath不合法 为\`\` ').width(600).onClick(() => {
                this.fsManager.copyFile({
                  srcPath:``,
                  destPath: this.filePath ,
                  success: (res) => {
                    promptAction.showToast({
                      message: `文件 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 打开文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `复制文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              // 报错 不允许访问
              Button('destPath不合法 为\`\` ').width(600).onClick(() => {
                this.fsManager.copyFile({
                  srcPath: this.filePath,
                  destPath: ``,
                  success: (res) => {
                    promptAction.showToast({
                      message: `文件 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 打开文件 在这里报的错 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `复制文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('destPath不合法 为\`ab\` ').width(600).onClick(() => {
                this.fsManager.copyFile({
                  srcPath:this.filePath,
                  destPath:`ab`,
                  success: (res) => {
                    promptAction.showToast({
                      message: `文件 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 打开文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `复制文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              // 报错 num null等非string类型的参数 为同一类错误
              Button('destPath不合法 num ').width(600).onClick(() => {
                this.fsManager.copyFile({
                  srcPath: this.filePath ,
                  destPath: 12 ,
                  success: (res) => {
                    promptAction.showToast({
                      message: `文件 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 打开文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `复制文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('srcPath不合法 num ').width(600).onClick(() => {
                this.fsManager.copyFile({
                  srcPath: 1 ,
                  destPath: this.filePath ,
                  success: (res) => {
                    promptAction.showToast({
                      message: `文件 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 打开文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `复制文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('srcPath不合法 null ').width(600).onClick(() => {
                this.fsManager.copyFile({
                  srcPath: null ,
                  destPath: this.filePath ,
                  success: (res) => {
                    promptAction.showToast({
                      message: `文件 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 打开文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `复制文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('destPath不合法 null ').width(600).onClick(() => {
                this.fsManager.copyFile({
                  srcPath: this.filePath,
                  destPath: null ,
                  success: (res) => {
                    promptAction.showToast({
                      message: `文件 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 打开文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `复制文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('srcPath不合法 boolean ').width(600).onClick(() => {
                this.fsManager.copyFile({
                  srcPath:true ,
                  destPath: this.filePath ,
                  success: (res) => {
                    promptAction.showToast({
                      message: `文件 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 打开文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `复制文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('destPath不合法 boolean ').width(600).onClick(() => {
                this.fsManager.copyFile({
                  srcPath: this.filePath,
                  destPath:true,
                  success: (res) => {
                    promptAction.showToast({
                      message: `文件 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 打开文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `复制文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('srcPath不合法 为object ').width(600).onClick(() => {
                this.fsManager.copyFile({
                  srcPath: { 'name':'test' } ,
                  destPath: this.filePath ,
                  success: (res) => {
                    promptAction.showToast({
                      message: `文件 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 打开文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `复制文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('destPath不合法 为object ').width(600).onClick(() => {
                this.fsManager.copyFile({
                  srcPath: this.filePath,
                  destPath: { 'name':'test' },
                  success: (res) => {
                    promptAction.showToast({
                      message: `文件 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 打开文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `复制文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('srcPath不合法 undefined ').width(600).onClick(() => {
                this.fsManager.copyFile({
                  srcPath: undefined,
                  destPath: this.filePath ,
                  success: (res) => {
                    promptAction.showToast({
                      message: `文件 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 打开文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `复制文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('destPath不合法 undefined ').width(600).onClick(() => {
                this.fsManager.copyFile({
                  srcPath: this.filePath,
                  destPath: undefined,
                  success: (res) => {
                    promptAction.showToast({
                      message: `文件 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 打开文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `复制文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('为下面的button创建一个目录2').width(600).onClick(() => {
                try {
                  this.fsManager.mkdirSync(this.context.filesDir+'/testMkdir/test2',true)
                  promptAction.showToast({
                    message: `创建目录2成功`
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `创建目录2失败，目录已存在 或其他错误 ${error}`
                  })
                }
              })

              // 报错 src为目录
              Button('srcPath存在，但为目录 ').width(600).onClick(() => {
                this.fsManager.copyFile({
                  srcPath: this.context.filesDir+'/testMkdir/test2',
                  destPath: this.fileDestPath ,
                  success: (res) => {
                    promptAction.showToast({
                      message: `文件 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 打开文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `复制文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              // 符合要求
              Button('srcPath存在为文件路径，destPath不存在，但其上级目录存在').width(600).onClick(() => {
                this.fsManager.copyFile({
                  srcPath: this.filePath ,
                  destPath: this.context.filesDir + '/testMkdir/test2/testTxt.txt',
                  success: (res) => {
                    promptAction.showToast({
                      message: `文件 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 复制文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `复制文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              // 检查复制是否成功 destPath指向的路径的文件的大小和内容
              Button('检查复制是否成功 destPath指向的路径的文件的大小和内容  ').width(600).onClick(() => {
                try {
                  let ifAccess=fs.accessSync(this.context.filesDir + '/testMkdir/test2/testTxt.txt')
                  if (ifAccess) {
                    console.info("[AdvancedDEMO] file exists")
                  }
                  let stat=fs.statSync(this.context.filesDir + '/testMkdir/test2/testTxt.txt')
                  console.info("[AdvancedDEMO] 文件状态: size: " + stat.size)
                  let readtxt=fs.readTextSync(this.context.filesDir + '/testMkdir/test2/testTxt.txt')
                  console.info("[AdvancedDEMO] 文件内容:  " + readtxt)
                  promptAction.showToast({
                    message: `成功 size: ${stat.size} content: ${readtxt}`
                  })
                } catch (error) {
                  console.log('[AdvancedDEMO] 检查复制是否成功 失败 fail = '+error)
                  promptAction.showToast({
                    message: `检查复制是否成功 或其他错误 ${error}`
                  })
                }
              })

              // 报错
              Button('srcPath存在为文件路径，destPath不存在，其上级目录也不存在').width(600).onClick(() => {
                this.fsManager.copyFile({
                  srcPath: this.filePath ,
                  destPath: this.context.filesDir + '/unexistFolder1/testFor1',
                  success: (res) => {
                    promptAction.showToast({
                      message: `文件 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 打开文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `复制文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

            }
          }

          // fs.copyFileSync
          ListItem() {
            Column({ space: 10 }) {
              Text('fs.copyFileSync ').fontSize(25)
              Text(' 文件复制（From srcPath To destPath) ').fontSize(25)
              Button('创建文件test.txt，创建目录filesDir下，写入内容hello, world').width(600).onClick(() => {
                let file = fs.openSync(this.filePath, fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE)
                let num = fs.writeSync(file.fd, "hello, world")
                promptAction.showToast({
                  message: `文件内容写入成功，长度：${num},path:${this.filePath}`,
                })
                console.debug('[advanceDEMO] write data to file succeed and size is:' + num + this.filePath)
              })

              // 可以复制
              Button('srcPath存在为文件路径、destPath存在为文件路径 且相同 ').width(600).onClick(() => {
                try {
                  this.fsManager.copyFileSync(this.filePath,this.filePath )
                  promptAction.showToast({
                    message: `复制成功`
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `复制文件 失败 或其他错误 ${error}`
                  })
                }
              })

              Button('为下面的按钮 创建文件creatNewFileForTest.txt').width(600).onClick(() => {
                let file = fs.openSync(this.context.filesDir+'/creatNewFileForTest.txt', fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE)
                let num = fs.writeSync(file.fd, "hello, world")
                promptAction.showToast({
                  message: `文件内容写入成功，长度：${num},path:${this.filePath}`,
                })
                console.debug('[advanceDEMO] write data to file succeed and size is:' + num + this.filePath)
              })

              // 报错  copyFile fail
              Button('srcPath存在为文件路径、destPath存在为文件路径 但不同 ').width(600).onClick(() => {
                try {
                  this.fsManager.copyFileSync(this.filePath,this.context.filesDir+'/creatNewFileForTest.txt')
                  promptAction.showToast({
                    message: `复制成功`
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `复制文件 失败 或其他错误 ${error}`
                  })
                }
              })

              Button('为下面的button创建一个目录1').width(600).onClick(() => {
                try {
                  this.fsManager.mkdirSync(this.context.filesDir+'/testMkdir/test1',true)
                  promptAction.showToast({
                    message: `创建目录1成功`
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `创建目录1失败，目录已存在 或其他错误 ${error}`
                  })
                }
              })

              // 符合要求 可以复制
              Button('srcPath存在为文件路径、destPath存在为目录路径  ').width(600).onClick(() => {
                try {
                  this.fsManager.copyFileSync(this.filePath,this.context.filesDir+'/testMkdir/test1')
                  promptAction.showToast({
                    message: `复制成功`
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `复制文件 失败 或其他错误 ${error}`
                  })
                }
              })

              // 报错 不允许访问
              Button('srcPath不合法 为\`\` ').width(600).onClick(() => {
                try {
                  this.fsManager.copyFileSync(``,this.filePath)
                  promptAction.showToast({
                    message: `复制成功`
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `复制文件 失败 或其他错误 ${error}`
                  })
                }
              })

              // 报错 不允许访问
              Button('destPath不合法 为\`\` ').width(600).onClick(() => {
                try {
                  this.fsManager.copyFileSync(this.filePath,``)
                  promptAction.showToast({
                    message: `复制成功`
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `复制文件 失败 或其他错误 ${error}`
                  })
                }
              })

              Button('destPath不合法 为\`ab\` ').width(600).onClick(() => {
                try {
                  this.fsManager.copyFileSync(this.filePath,`ab`)
                  promptAction.showToast({
                    message: `复制成功`
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `复制文件 失败 或其他错误 ${error}`
                  })
                }
              })

              // 报错 num null等非string类型的参数 为同一类错误
              Button('destPath不合法 num ').width(600).onClick(() => {
                try {
                  this.fsManager.copyFileSync(this.filePath,12)
                  promptAction.showToast({
                    message: `复制成功`
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `复制文件 失败 或其他错误 ${error}`
                  })
                }
              })

              Button('srcPath不合法 num ').width(600).onClick(() => {
                try {
                  this.fsManager.copyFileSync(12,this.filePath)
                  promptAction.showToast({
                    message: `复制成功`
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `复制文件 失败 或其他错误 ${error}`
                  })
                }
              })

              Button('srcPath不合法 null ').width(600).onClick(() => {
                try {
                  this.fsManager.copyFileSync(null,this.filePath)
                  promptAction.showToast({
                    message: `复制成功`
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `复制文件 失败 或其他错误 ${error}`
                  })
                }
              })

              Button('destPath不合法 null ').width(600).onClick(() => {
                try {
                  this.fsManager.copyFileSync(this.filePath,null)
                  promptAction.showToast({
                    message: `复制成功`
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `复制文件 失败 或其他错误 ${error}`
                  })
                }
              })

              Button('srcPath不合法 boolean ').width(600).onClick(() => {
                try {
                  this.fsManager.copyFileSync(true,this.filePath)
                  promptAction.showToast({
                    message: `复制成功`
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `复制文件 失败 或其他错误 ${error}`
                  })
                }
              })

              Button('destPath不合法 boolean ').width(600).onClick(() => {
                try {
                  this.fsManager.copyFileSync(this.filePath,true)
                  promptAction.showToast({
                    message: `复制成功`
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `复制文件 失败 或其他错误 ${error}`
                  })
                }
              })

              Button('srcPath不合法 object ').width(600).onClick(() => {
                try {
                  this.fsManager.copyFileSync({'name':'test'},this.filePath)
                  promptAction.showToast({
                    message: `复制成功`
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `复制文件 失败 或其他错误 ${error}`
                  })
                }
              })

              Button('destPath不合法 object ').width(600).onClick(() => {
                try {
                  this.fsManager.copyFileSync(this.filePath,{'name':'test'})
                  promptAction.showToast({
                    message: `复制成功`
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `复制文件 失败 或其他错误 ${error}`
                  })
                }
              })

              Button('srcPath不合法 undefined ').width(600).onClick(() => {
                try {
                  this.fsManager.copyFileSync(undefined,this.filePath)
                  promptAction.showToast({
                    message: `复制成功`
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `复制文件 失败 或其他错误 ${error}`
                  })
                }
              })

              Button('destPath不合法 undefined ').width(600).onClick(() => {
                try {
                  this.fsManager.copyFileSync(this.filePath,undefined)
                  promptAction.showToast({
                    message: `复制成功`
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `复制文件 失败 或其他错误 ${error}`
                  })
                }
              })

              Button('为下面的button创建一个目录2').width(600).onClick(() => {
                try {
                  this.fsManager.mkdirSync(this.context.filesDir+'/testMkdir/test2',true)
                  promptAction.showToast({
                    message: `创建目录2成功`
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `创建目录2失败，目录已存在 或其他错误 ${error}`
                  })
                }
              })

              // 报错 src为目录
              Button('srcPath存在，但为目录 ').width(600).onClick(() => {
                try {
                  this.fsManager.copyFileSync(this.context.filesDir+'/testMkdir/test2',this.filePath)
                  promptAction.showToast({
                    message: `复制成功`
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `复制文件 失败 或其他错误 ${error}`
                  })
                }
              })

              // 符合要求
              Button('srcPath存在为文件路径，destPath不存在，但其上级目录存在').width(600).onClick(() => {
                try {
                  this.fsManager.copyFileSync(this.filePath,this.context.filesDir + '/testMkdir/test2/testTxt.txt')
                  promptAction.showToast({
                    message: `复制成功`
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `复制文件 失败 或其他错误 ${error}`
                  })
                }
              })

              // 检查复制是否成功 destPath指向的路径的文件的大小和内容
              Button('检查复制是否成功 destPath指向的路径的文件的大小和内容  ').width(600).onClick(() => {
                try {
                  let ifAccess=fs.accessSync(this.context.filesDir + '/testMkdir/test2/testTxt.txt')
                  if (ifAccess) {
                    console.info("[AdvancedDEMO] file exists")
                  }
                  let stat=fs.statSync(this.context.filesDir + '/testMkdir/test2/testTxt.txt')
                  console.info("[AdvancedDEMO] 文件状态: size: " + stat.size)
                  let readtxt=fs.readTextSync(this.context.filesDir + '/testMkdir/test2/testTxt.txt')
                  console.info("[AdvancedDEMO] 文件内容:  " + readtxt)
                  promptAction.showToast({
                    message: `成功 size: ${stat.size} content: ${readtxt}`
                  })
                } catch (error) {
                  console.log('[AdvancedDEMO] 检查复制是否成功 失败 fail = '+error)
                  promptAction.showToast({
                    message: `检查复制是否成功 或其他错误 ${error}`
                  })
                }
              })

              // 报错
              Button('srcPath存在为文件路径，destPath不存在，其上级目录也不存在').width(600).onClick(() => {
                try {
                  this.fsManager.copyFileSync(this.filePath,this.context.filesDir + '/unexistFolder1/testFor1')
                  promptAction.showToast({
                    message: `复制成功`
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `复制文件 失败 或其他错误 ${error}`
                  })
                }
              })
            }
          }

          // fs.stat 8月7日
          ListItem() {
            Column({ space: 10 }) {
              Text('8月7日 fs.fstat').fontSize(25)
              Button('先用鸿蒙接口创建文件test.txt，创建目录filesDir下，写入内容hello, world').width(600).onClick(() => {
                let file = fs.openSync(this.filePath, fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE)
                let num = fs.writeSync(file.fd, "hello, world")
                promptAction.showToast({
                  message: `文件内容写入成功，长度：${num},path:${this.filePath}`,
                })
                console.debug('[advanceDEMO] write data to file succeed and size is:' + num + this.filePath)
              })

              Button('先打开文件test.txt，得到该文件的fd').width(300).onClick(() => {
                this.fsManager = as.getFileSystemManager()
                this.fsManager.open({
                  filePath: this.filePath,
                  success: (res) => {
                    this.fd = res.fd
                    console.log(`[advanceDEMO] 打开文件 成功 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `打开文件 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 打开文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `打开文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] open complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('打开目录filesDir，得到该目录的fd').width(300).onClick(() => {
                this.fsManager = as.getFileSystemManager()
                this.fsManager.open({
                  filePath: this.context.filesDir,
                  success: (res) => {
                    this.fd = res.fd
                    console.log(`[advanceDEMO] 打开目录 成功 ${JSON.stringify(res)}`)
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 打开目录 失败 ${JSON.stringify(res)}`)
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] open dir complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('再获取文件的状态信息 fd【有效】').width(300).onClick(() => {
                console.log('[advanceDEMO] this.fd = '+this.fd)
                this.fsManager.fstat({
                  fd: this.fd,
                  success: (res) => {
                    const stat = res.stat
                    console.log('[advanceDEMO] fstat stat.size = '+stat.size)
                    console.log('[advanceDEMO] fstat stat.mode = '+stat.mode)
                    console.log('[advanceDEMO] fstat stat.lastModifiedTime = '+stat.lastModifiedTime)
                    console.log('[advanceDEMO] fstat stat.lastAccessedTime = '+stat.lastAccessedTime)
                    console.log('[advanceDEMO] fstat stat.isDirectory() = '+ stat.isDirectory())
                    console.log('[advanceDEMO] fstat stat.isFile() = '+ stat.isFile())
                    promptAction.showToast({
                      message: `获取文件状态信息 成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 获取文件状态信息 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `获取文件状态信息 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              // fd的值为null num等非string的情况 属于同一类错误
              Button('获取文件的状态信息 fd为null【无效】').width(300).onClick(() => {
                this.fsManager.fstat({
                  fd: null,
                  success: (res) => {
                    console.log('[advanceDEMO] fstat success res = '+JSON.stringify(res))
                    promptAction.showToast({
                      message: `获取文件状态信息 成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 获取文件状态信息 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `获取文件状态信息 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] fstat complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('获取文件的状态信息 fd不传【无效】').width(300).onClick(() => {
                this.fsManager.fstat({
                  success: (res) => {
                    console.log('[advanceDEMO] fstat success : '+JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[advanceDEMO] fstat fail : '+JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[advanceDEMO] fstat complete : '+JSON.stringify(res))
                  }
                })
              })

              Button('获取文件的状态信息 fd为undefined【无效】').width(300).onClick(() => {
                this.fsManager.fstat({
                  fd: undefined,
                  success: (res) => {
                    console.log('[advanceDEMO] fstat success : '+JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[advanceDEMO] fstat fail : '+JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[advanceDEMO] fstat complete : '+JSON.stringify(res))
                  }
                })
              })

              Button('获取文件的状态信息 fd为boolean【无效】').width(300).onClick(() => {
                this.fsManager.fstat({
                  fd: true,
                  success: (res) => {
                    console.log('[advanceDEMO] fstat success : '+JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[advanceDEMO] fstat fail : '+JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[advanceDEMO] fstat complete : '+JSON.stringify(res))
                  }
                })
              })

              Button('获取文件的状态信息 fd为空字符串【无效】').width(300).onClick(() => {
                this.fsManager.fstat({
                  fd: '',
                  success: (res) => {
                    console.log('[advanceDEMO] fstat success : '+JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[advanceDEMO] fstat fail : '+JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[advanceDEMO] fstat complete : '+JSON.stringify(res))
                  }
                })
              })

              Button('获取文件的状态信息 fd为Number【无效】').width(300).onClick(() => {
                this.fsManager.fstat({
                  fd: 42,
                  success: (res) => {
                    console.log('[advanceDEMO] fstat success : '+JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[advanceDEMO] fstat fail : '+JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[advanceDEMO] fstat complete : '+JSON.stringify(res))
                  }
                })
              })

              Button('获取文件的状态信息 fd为Object【无效】').width(300).onClick(() => {
                this.fsManager.fstat({
                  fd: {fd: '42'},
                  success: (res) => {
                    console.log('[advanceDEMO] fstat success : '+JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[advanceDEMO] fstat fail : '+JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[advanceDEMO] fstat complete : '+JSON.stringify(res))
                  }
                })
              })

              Button('获取文件的状态信息 fd为无效String【无效】').width(300).onClick(() => {
                this.fsManager.fstat({
                  fd: '42',
                  success: (res) => {
                    console.log('[advanceDEMO] fstat success : '+JSON.stringify(res))
                  },
                  fail: (res) => {
                    console.error('[advanceDEMO] fstat fail : '+JSON.stringify(res))
                  },
                  complete: (res) => {
                    console.log('[advanceDEMO] fstat complete : '+JSON.stringify(res))
                  }
                })
              })

            }
          }

          // fs.fstatSync
          ListItem() {
            Column({ space: 10 }) {
              Text('fs.fstatSync').fontSize(25)
              Button('先用鸿蒙接口创建文件test.txt，创建目录filesDir下，写入内容hello, world').width(600).onClick(() => {
                let file = fs.openSync(this.filePath, fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE)
                let num = fs.writeSync(file.fd, "hello, world")
                promptAction.showToast({
                  message: `文件内容写入成功，长度：${num},path:${this.filePath}`,
                })
                console.debug('[advanceDEMO] write data to file succeed and size is:' + num + this.filePath)
              })

              Button('先打开文件test.txt，得到该文件的fd').width(600).onClick(() => {
                this.fsManager.open({
                  filePath: this.filePath,
                  success: (res) => {
                    this.fd = res.fd
                    promptAction.showToast({
                      message: `打开文件 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 打开文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `打开文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] open complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('再获取文件的状态信息 fd【有效】').width(600).onClick(() => {
                try {
                  let res=this.fsManager.fstatSync({fd:this.fd})
                  console.log('[advanceDEMO] fstatSync stat.size = '+res.stat.size)
                  console.log('[advanceDEMO] fstatSync stat.mode = '+res.stat.mode)
                  console.log('[advanceDEMO] fstatSync stat.lastModifiedTime = '+res.stat.lastModifiedTime)
                  console.log('[advanceDEMO] fstatSync stat.lastAccessedTime = '+res.stat.lastAccessedTime)
                  console.log('[advanceDEMO] fstatSync stat.isDirectory() = '+ res.stat.isDirectory())
                  console.log('[advanceDEMO] fstatSync stat.isFile() = '+ res.stat.isFile())
                  promptAction.showToast({
                    message: `获取文件状态信息 成功 res = ${JSON.stringify(res)}`
                  })
                } catch (error) {
                  console.debug('[advanceDEMO] fstatSync fail')
                  promptAction.showToast({
                    message: `获取文件的状态信息失败 或其他错误 ${error}`
                  })
                }
              })

              Button('为下面的button创建一个目录').width(600).onClick(() => {
                try {
                  this.fsManager.mkdirSync(this.context.filesDir+'/testMkdir/test1',true)
                  promptAction.showToast({
                    message: `创建目录1成功`
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `创建目录1失败，目录已存在 或其他错误 ${error}`
                  })
                }
              })

              Button('打开目录，得到该目录的fd').width(600).onClick(() => {
                this.fsManager.open({
                  filePath: this.context.filesDir+'/testMkdir/test1',
                  success: (res) => {
                    this.fd = res.fd
                    promptAction.showToast({
                      message: `打开文件 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 打开文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `打开文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] open complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('获取目录的状态信息 fd【有效】').width(600).onClick(() => {
                try {
                  let res=this.fsManager.fstatSync({fd:this.fd})
                  console.log('[advanceDEMO] fstatSync stat.size = '+res.stat.size)
                  console.log('[advanceDEMO] fstatSync stat.mode = '+res.stat.mode)
                  console.log('[advanceDEMO] fstatSync stat.lastModifiedTime = '+res.stat.lastModifiedTime)
                  console.log('[advanceDEMO] fstatSync stat.lastAccessedTime = '+res.stat.lastAccessedTime)
                  console.log('[advanceDEMO] fstatSync stat.isDirectory() = '+ res.stat.isDirectory())
                  console.log('[advanceDEMO] fstatSync stat.isFile() = '+ res.stat.isFile())
                  promptAction.showToast({
                    message: `获取文件状态信息 成功 res = ${JSON.stringify(res)}`
                  })
                } catch (error) {
                  console.debug('[advanceDEMO] fstatSync fail')
                  promptAction.showToast({
                    message: `获取文件的状态信息失败 或其他错误 ${error}`
                  })
                }
              })

              // fd的值为null num等非string的情况 属于同一类错误
              Button('获取文件的状态信息 fd为null【无效】').width(600).onClick(() => {
                try {
                  let res=this.fsManager.fstatSync({fd:null})
                  console.log('[advanceDEMO] fstatSync stat.size = '+res.stat.size)
                  console.log('[advanceDEMO] fstatSync stat.mode = '+res.stat.mode)
                  console.log('[advanceDEMO] fstatSync stat.lastModifiedTime = '+res.stat.lastModifiedTime)
                  console.log('[advanceDEMO] fstatSync stat.lastAccessedTime = '+res.stat.lastAccessedTime)
                  console.log('[advanceDEMO] fstatSync stat.isDirectory() = '+ res.stat.isDirectory())
                  console.log('[advanceDEMO] fstatSync stat.isFile() = '+ res.stat.isFile())
                  promptAction.showToast({
                    message: `获取文件的状态信息 成功`
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `获取文件的状态信息失败 或其他错误 ${error}`
                  })
                }
              })

              Button('获取文件的状态信息 fd为num【无效】').width(600).onClick(() => {
                try {
                  let res=this.fsManager.fstatSync({fd:12})
                  console.log('[advanceDEMO] fstatSync stat.size = '+res.stat.size)
                  console.log('[advanceDEMO] fstatSync stat.mode = '+res.stat.mode)
                  console.log('[advanceDEMO] fstatSync stat.lastModifiedTime = '+res.stat.lastModifiedTime)
                  console.log('[advanceDEMO] fstatSync stat.lastAccessedTime = '+res.stat.lastAccessedTime)
                  console.log('[advanceDEMO] fstatSync stat.isDirectory() = '+ res.stat.isDirectory())
                  console.log('[advanceDEMO] fstatSync stat.isFile() = '+ res.stat.isFile())
                  promptAction.showToast({
                    message: `获取文件的状态信息 成功`
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `获取文件的状态信息失败 或其他错误 ${error}`
                  })
                }
              })

              Button('获取文件的状态信息 fd为boolean【无效】').width(600).onClick(() => {
                try {
                  let res=this.fsManager.fstatSync({fd:true})
                  console.log('[advanceDEMO] fstatSync stat.size = '+res.stat.size)
                  console.log('[advanceDEMO] fstatSync stat.mode = '+res.stat.mode)
                  console.log('[advanceDEMO] fstatSync stat.lastModifiedTime = '+res.stat.lastModifiedTime)
                  console.log('[advanceDEMO] fstatSync stat.lastAccessedTime = '+res.stat.lastAccessedTime)
                  console.log('[advanceDEMO] fstatSync stat.isDirectory() = '+ res.stat.isDirectory())
                  console.log('[advanceDEMO] fstatSync stat.isFile() = '+ res.stat.isFile())
                  promptAction.showToast({
                    message: `获取文件的状态信息 成功`
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `获取文件的状态信息失败 或其他错误 ${error}`
                  })
                }
              })

              Button('获取文件的状态信息 fd为object【无效】').width(600).onClick(() => {
                try {
                  let res=this.fsManager.fstatSync({fd:{'name':'test'}})
                  console.log('[advanceDEMO] fstatSync stat.size = '+res.stat.size)
                  console.log('[advanceDEMO] fstatSync stat.mode = '+res.stat.mode)
                  console.log('[advanceDEMO] fstatSync stat.lastModifiedTime = '+res.stat.lastModifiedTime)
                  console.log('[advanceDEMO] fstatSync stat.lastAccessedTime = '+res.stat.lastAccessedTime)
                  console.log('[advanceDEMO] fstatSync stat.isDirectory() = '+ res.stat.isDirectory())
                  console.log('[advanceDEMO] fstatSync stat.isFile() = '+ res.stat.isFile())
                  promptAction.showToast({
                    message: `获取文件的状态信息 成功`
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `获取文件的状态信息失败 或其他错误 ${error}`
                  })
                }
              })

              Button('获取文件的状态信息 fd为\'\'【无效】').width(600).onClick(() => {
                try {
                  let res=this.fsManager.fstatSync({fd:''})
                  console.log('[advanceDEMO] fstatSync stat.size = '+res.stat.size)
                  console.log('[advanceDEMO] fstatSync stat.mode = '+res.stat.mode)
                  console.log('[advanceDEMO] fstatSync stat.lastModifiedTime = '+res.stat.lastModifiedTime)
                  console.log('[advanceDEMO] fstatSync stat.lastAccessedTime = '+res.stat.lastAccessedTime)
                  console.log('[advanceDEMO] fstatSync stat.isDirectory() = '+ res.stat.isDirectory())
                  console.log('[advanceDEMO] fstatSync stat.isFile() = '+ res.stat.isFile())
                  promptAction.showToast({
                    message: `获取文件的状态信息 成功`
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `获取文件的状态信息失败 或其他错误 ${error}`
                  })
                }
              })

              Button('获取文件的状态信息 fd为undefined【无效】').width(600).onClick(() => {
                try {
                  let res=this.fsManager.fstatSync({fd:undefined})
                  console.log('[advanceDEMO] fstatSync stat.size = '+res.stat.size)
                  console.log('[advanceDEMO] fstatSync stat.mode = '+res.stat.mode)
                  console.log('[advanceDEMO] fstatSync stat.lastModifiedTime = '+res.stat.lastModifiedTime)
                  console.log('[advanceDEMO] fstatSync stat.lastAccessedTime = '+res.stat.lastAccessedTime)
                  console.log('[advanceDEMO] fstatSync stat.isDirectory() = '+ res.stat.isDirectory())
                  console.log('[advanceDEMO] fstatSync stat.isFile() = '+ res.stat.isFile())
                  promptAction.showToast({
                    message: `获取文件的状态信息 成功`
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `获取文件的状态信息失败 或其他错误 ${error}`
                  })
                }
              })

            }
          }

          // fs.ftruncate
          ListItem() {
            Column({ space: 10 }) {
              Text('fs.truncate').fontSize(25)
              Button('先用鸿蒙接口创建文件test.txt，创建目录filesDir下，写入内容hello, world').width(600).onClick(() => {
                let file = fs.openSync(this.filePath, fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE)
                let num = fs.writeSync(file.fd, "hello, world")
                promptAction.showToast({
                  message: `文件内容写入成功，长度：${num},path:${this.filePath}`,
                })
                console.debug('[advanceDEMO] write data to file succeed and size is:' + num + this.filePath)
              })

              Button('使用open打开文件test.txt，得到该文件的fd (string类型)').width(600).onClick(() => {
                this.fsManager.open({
                  filePath: this.filePath,
                  flag: 'a+',
                  success: (res) => {
                    this.fd = res.fd
                    console.log('advanceDEMO 打开文件 成功 '+this.filePath)
                    promptAction.showToast({
                      message: `打开文件 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 打开文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `打开文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] open complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              //截取前的文件的大小和文件内容
              Button('【截取前】的文件的大小和文件内容 ').width(600).onClick(() => {
                try {
                  let stat = fs.statSync(Number(this.fd))
                  console.info("[advanceDEMO] 【截取前】 get file info succeed, the size of file is " + stat.size)
                  let str = fs.readTextSync(this.filePath);
                  console.info("[advanceDEMO] 【截取前】 readTextSync succeed:" + str);

                  promptAction.showToast({
                    message: `【截取前】文件的大小: ${stat.size} 文件的内容 ${str} `
                  })
                } catch (error) {
                  console.debug(`
                      [advanceDEMO] 获取【截取前】的文件的大小和文件内容 失败 { ${JSON.stringify(error)}}
                    `)
                  promptAction.showToast({
                    message: `获取【截取前】的文件的大小和文件内容 失败 或其他错误 ${error}`
                  })
                }
              })

              Button('再截取文件 fd【有效】').width(600).onClick(() => {
                this.fsManager.ftruncate({
                  fd:this.fd,
                  length:10,
                  success: (res) => {
                    promptAction.showToast({
                      message: `截取文件 成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 截取文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `截取文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              //截取后的文件的大小和文件内容
              Button('【截取后】的文件的大小和文件内容 ').width(600).onClick(() => {
                try {
                  let stat = fs.statSync(Number(this.fd))
                  console.info("[advanceDEMO] 【截取后】 get file info succeed, the size of file is " + stat.size)
                  let str = fs.readTextSync(this.filePath);
                  console.info("[advanceDEMO] 【截取后】readTextSync succeed:" + str);

                  promptAction.showToast({
                    message: `【截取后】文件的大小: ${stat.size} 文件的内容 ${str} `
                  })
                } catch (error) {
                  console.debug(`
                      [advanceDEMO] 获取【截取后】的文件的大小和文件内容 失败 { ${JSON.stringify(error)}}
                    `)
                  promptAction.showToast({
                    message: `获取【截取后】的文件的大小和文件内容 失败 或其他错误 ${error}`
                  })
                }
              })

              // fd的值为null num等非string的情况 属于同一类错误
              Button('截取文件 fd为null【无效】').width(600).onClick(() => {
                this.fsManager.ftruncate({
                  fd: null,
                  length:10,
                  success: (res) => {
                    promptAction.showToast({
                      message: `截取文件 成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 截取文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `截取文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('截取文件 fd为\'\'【无效】').width(600).onClick(() => {
                this.fsManager.ftruncate({
                  fd:``,
                  length:10,
                  success: (res) => {
                    promptAction.showToast({
                      message: `截取文件 成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 截取文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `截取文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('截取文件 fd为boolean【无效】').width(600).onClick(() => {
                this.fsManager.ftruncate({
                  fd: true,
                  length:10,
                  success: (res) => {
                    promptAction.showToast({
                      message: `截取文件 成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 截取文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `截取文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('截取文件 fd为object【无效】').width(600).onClick(() => {
                this.fsManager.ftruncate({
                  fd: {'name':'test'},
                  length:10,
                  success: (res) => {
                    promptAction.showToast({
                      message: `截取文件 成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 截取文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `截取文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('截取文件 fd为undefined【无效】').width(600).onClick(() => {
                this.fsManager.ftruncate({
                  fd: undefined,
                  length:10,
                  success: (res) => {
                    promptAction.showToast({
                      message: `截取文件 成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 截取文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `截取文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('截取文件 fd为\'ab\'【无效】').width(600).onClick(() => {
                this.fsManager.ftruncate({
                  fd: 'ab',
                  length:10,
                  success: (res) => {
                    promptAction.showToast({
                      message: `截取文件 成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 截取文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `截取文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              // length为负数 微信会把它看做0
              Button('截取文件 length<0').width(600).onClick(() => {
                this.fsManager.ftruncate({
                  fd: this.fd,
                  length:-10,
                  success: (res) => {
                    promptAction.showToast({
                      message: `截取文件 成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 截取文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `截取文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              // length大于原文本长度 会在结尾自动补\0
              Button('截取文件 length大于原文本长度').width(600).onClick(() => {
                this.fsManager.ftruncate({
                  fd: this.fd,
                  length:50,
                  success: (res) => {
                    promptAction.showToast({
                      message: `截取文件 成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 截取文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `截取文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('截取文件 length为boolean').width(600).onClick(() => {
                this.fsManager.ftruncate({
                  fd: this.fd,
                  length:true,
                  success: (res) => {
                    promptAction.showToast({
                      message: `截取文件 成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 截取文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `截取文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('截取文件 length为object').width(600).onClick(() => {
                this.fsManager.ftruncate({
                  fd: this.fd,
                  length:{'name':'test'},
                  success: (res) => {
                    promptAction.showToast({
                      message: `截取文件 成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 截取文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `截取文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('截取文件 length为null').width(600).onClick(() => {
                this.fsManager.ftruncate({
                  fd: this.fd,
                  length:null,
                  success: (res) => {
                    promptAction.showToast({
                      message: `截取文件 成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 截取文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `截取文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('截取文件 length为\'ab\'').width(600).onClick(() => {
                this.fsManager.ftruncate({
                  fd: this.fd,
                  length:'ab',
                  success: (res) => {
                    promptAction.showToast({
                      message: `截取文件 成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 截取文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `截取文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('截取文件 length为\'\'').width(600).onClick(() => {
                this.fsManager.ftruncate({
                  fd: this.fd,
                  length:'',
                  success: (res) => {
                    promptAction.showToast({
                      message: `截取文件 成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 截取文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `截取文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('截取文件 length为undefined').width(600).onClick(() => {
                this.fsManager.ftruncate({
                  fd: this.fd,
                  length:undefined,
                  success: (res) => {
                    promptAction.showToast({
                      message: `截取文件 成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 截取文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `截取文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })
            }
          }

          // fs.ftruncateSync
          ListItem() {
            Column({ space: 10 }) {
              Text('fs.truncateSync').fontSize(25)

              Button('先用鸿蒙接口创建文件test.txt，创建目录filesDir下，写入内容hello, world').width(600).onClick(() => {
                let file = fs.openSync(this.filePath, fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE)
                let num = fs.writeSync(file.fd, "hello, world")
                promptAction.showToast({
                  message: `文件内容写入成功，长度：${num},path:${this.filePath}`,
                })
                console.debug('[advanceDEMO] write data to file succeed and size is:' + num + this.filePath)
              })

              Button('先使用open打开文件test.txt，得到该文件的fd (string类型)').width(600).onClick(() => {
                this.fsManager.open({
                  filePath: this.filePath,
                  flag: 'a+',
                  success: (res) => {
                    this.fd = res.fd
                    console.log('advanceDEMO 打开文件 成功 '+this.filePath)
                    promptAction.showToast({
                      message: `打开文件 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 打开文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `打开文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] open complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              //截取前的文件的大小和文件内容
              Button('【截取前】的文件的大小和文件内容 ').width(600).onClick(() => {
                try {
                  let stat = fs.statSync(Number(this.fd))
                  console.info("[advanceDEMO] 【截取前】 get file info succeed, the size of file is " + stat.size)
                  let str = fs.readTextSync(this.filePath);
                  console.info("[advanceDEMO] 【截取前】 readTextSync succeed:" + str);

                  promptAction.showToast({
                    message: `【截取前】文件的大小: ${stat.size} 文件的内容 ${str} `
                  })
                } catch (error) {
                  console.debug(`
                      [advanceDEMO] 获取【截取前】的文件的大小和文件内容 失败 { ${JSON.stringify(error)}}
                    `)
                  promptAction.showToast({
                    message: `获取【截取前】的文件的大小和文件内容 失败 或其他错误 ${error}`
                  })
                }
              })

              Button('再使用鸿蒙截取文件 路径【有效】').width(600).onClick(() => {
                try {
                  let res=this.fsManager.ftruncateSync({fd:this.fd,length:10}) //
                  console.debug(`
                      [advanceDEMO] 鸿蒙截取文件 成功 ${JSON.stringify(res)} }
                    `)
                  promptAction.showToast({
                    message: `鸿蒙截取文件 成功 ${JSON.stringify(res)} `
                  })
                } catch (error) {
                  console.debug(`
                      [advanceDEMO] 鸿蒙截取文件 { ${JSON.stringify(error)}}
                    `)
                  promptAction.showToast({
                    message: `鸿蒙截取文件 或其他错误 ${error}`
                  })
                }
              })

              //截取后的文件的大小和文件内容
              Button('【截取后】的文件的大小和文件内容 ').width(600).onClick(() => {
                try {
                  let stat = fs.statSync(Number(this.fd))
                  console.info("[advanceDEMO] 【截取后】 get file info succeed, the size of file is " + stat.size)
                  let str = fs.readTextSync(this.filePath);
                  console.info("[advanceDEMO] 【截取后】readTextSync succeed:" + str);

                  promptAction.showToast({
                    message: `【截取后】文件的大小: ${stat.size} 文件的内容 ${str} `
                  })
                } catch (error) {
                  console.debug(`
                      [advanceDEMO] 获取【截取后】的文件的大小和文件内容 失败 { ${JSON.stringify(error)}}
                    `)
                  promptAction.showToast({
                    message: `获取【截取后】的文件的大小和文件内容 失败 或其他错误 ${error}`
                  })
                }
              })

              // length大于原文本长度 会在结尾自动补\0
              Button('截取文件 length大于原文本长度').width(600).onClick(() => {
                try {
                  let res=this.fsManager.ftruncateSync({fd:this.fd,length:20}) //
                  console.debug(`
                      [advanceDEMO] 鸿蒙截取文件 成功 ${JSON.stringify(res)} }
                    `)
                  promptAction.showToast({
                    message: `鸿蒙截取文件 成功 ${JSON.stringify(res)} `
                  })
                } catch (error) {
                  console.debug(`
                      [advanceDEMO] 鸿蒙截取文件 { ${JSON.stringify(error)}}
                    `)
                  promptAction.showToast({
                    message: `鸿蒙截取文件 或其他错误 ${error}`
                  })
                }
              })

              // fd的值为null num等非string的情况 属于同一类错误
              Button('截取文件 fd为null【无效】').width(600).onClick(() => {
                try {
                  let res=this.fsManager.ftruncateSync({fd:null,length:10}) //
                  console.debug(`
                      [advanceDEMO] 鸿蒙截取文件 成功 ${JSON.stringify(res)} }
                    `)
                  promptAction.showToast({
                    message: `鸿蒙截取文件 成功 ${JSON.stringify(res)} `
                  })
                } catch (error) {
                  console.debug(`
                      [advanceDEMO] 鸿蒙截取文件  ${error}
                    `)
                  promptAction.showToast({
                    message: `鸿蒙截取文件 或其他错误 ${error}`
                  })
                }
              })

              Button('截取文件 fd为\'\'【无效】').width(600).onClick(() => {
                try {
                  let res=this.fsManager.ftruncateSync({fd:``,length:10}) //
                  console.debug(`
                      [advanceDEMO] 鸿蒙截取文件 成功 ${JSON.stringify(res)} }
                    `)
                  promptAction.showToast({
                    message: `鸿蒙截取文件 成功 ${JSON.stringify(res)} `
                  })
                } catch (error) {
                  console.debug(`
                      [advanceDEMO] 鸿蒙截取文件 失败  ${error}
                    `)
                  promptAction.showToast({
                    message: `鸿蒙截取文件 或其他错误 ${error}`
                  })
                }
              })

              Button('截取文件 fd为boolean【无效】').width(600).onClick(() => {
                try {
                  let res=this.fsManager.ftruncateSync({fd:true,length:10}) //
                  console.debug(`
                      [advanceDEMO] 鸿蒙截取文件 成功 ${JSON.stringify(res)} }
                    `)
                  promptAction.showToast({
                    message: `鸿蒙截取文件 成功 ${JSON.stringify(res)} `
                  })
                } catch (error) {
                  console.debug(`
                      [advanceDEMO] 鸿蒙截取文件 失败  ${error}
                    `)
                  promptAction.showToast({
                    message: `鸿蒙截取文件 或其他错误 ${error}`
                  })
                }
              })

              Button('截取文件 fd为object【无效】').width(600).onClick(() => {
                try {
                  let res=this.fsManager.ftruncateSync({fd:{'name':'test'},length:10}) //
                  console.debug(`
                      [advanceDEMO] 鸿蒙截取文件 成功 ${JSON.stringify(res)} }
                    `)
                  promptAction.showToast({
                    message: `鸿蒙截取文件 成功 ${JSON.stringify(res)} `
                  })
                } catch (error) {
                  console.debug(`
                      [advanceDEMO] 鸿蒙截取文件 失败  ${error}
                    `)
                  promptAction.showToast({
                    message: `鸿蒙截取文件 或其他错误 ${error}`
                  })
                }
              })

              Button('截取文件 fd为undefined【无效】').width(600).onClick(() => {
                try {
                  let res=this.fsManager.ftruncateSync({fd:undefined,length:10}) //
                  console.debug(`
                      [advanceDEMO] 鸿蒙截取文件 成功 ${JSON.stringify(res)} }
                    `)
                  promptAction.showToast({
                    message: `鸿蒙截取文件 成功 ${JSON.stringify(res)} `
                  })
                } catch (error) {
                  console.debug(`
                      [advanceDEMO] 鸿蒙截取文件 失败  ${error}
                    `)
                  promptAction.showToast({
                    message: `鸿蒙截取文件 或其他错误 ${error}`
                  })
                }
              })

              Button('截取文件 fd为\'ab\'【无效】').width(600).onClick(() => {
                try {
                  let res=this.fsManager.ftruncateSync({fd:'ab',length:10}) //
                  console.debug(`
                      [advanceDEMO] 鸿蒙截取文件 成功 ${JSON.stringify(res)} }
                    `)
                  promptAction.showToast({
                    message: `鸿蒙截取文件 成功 ${JSON.stringify(res)} `
                  })
                } catch (error) {
                  console.debug(`
                      [advanceDEMO] 鸿蒙截取文件 失败  ${error}
                    `)
                  promptAction.showToast({
                    message: `鸿蒙截取文件 或其他错误 ${error}`
                  })
                }
              })

              Button('截取文件 length<0').width(600).onClick(() => {
                try {
                  let res=this.fsManager.ftruncateSync({fd:this.fd,length:-10}) //
                  console.debug(`
                      [advanceDEMO] 鸿蒙截取文件 成功 ${JSON.stringify(res)} }
                    `)
                  promptAction.showToast({
                    message: `鸿蒙截取文件 成功 ${JSON.stringify(res)} `
                  })
                } catch (error) {
                  console.debug(`
                      [advanceDEMO] 鸿蒙截取文件  ${error}
                    `)
                  promptAction.showToast({
                    message: `鸿蒙截取文件 或其他错误 ${error}`
                  })
                }
              })

              Button('截取文件 length大于原文本长度').width(600).onClick(() => {
                try {
                  let res=this.fsManager.ftruncateSync({fd:this.fd,length:50}) //
                  console.debug(`
                      [advanceDEMO] 鸿蒙截取文件 成功 ${JSON.stringify(res)} }
                    `)
                  promptAction.showToast({
                    message: `鸿蒙截取文件 成功 ${JSON.stringify(res)} `
                  })
                } catch (error) {
                  console.debug(`
                      [advanceDEMO] 鸿蒙截取文件 { ${JSON.stringify(error)}}
                    `)
                  promptAction.showToast({
                    message: `鸿蒙截取文件 或其他错误 ${error}`
                  })
                }
              })

              Button('截取文件 length为boolean').width(600).onClick(() => {
                try {
                  let res=this.fsManager.ftruncateSync({fd:this.fd,length:true}) //
                  console.debug(`
                      [advanceDEMO] 鸿蒙截取文件 成功 ${JSON.stringify(res)} }
                    `)
                  promptAction.showToast({
                    message: `鸿蒙截取文件 成功 ${JSON.stringify(res)} `
                  })
                } catch (error) {
                  console.debug(`
                      [advanceDEMO] 鸿蒙截取文件 { ${JSON.stringify(error)}}
                    `)
                  promptAction.showToast({
                    message: `鸿蒙截取文件 或其他错误 ${error}`
                  })
                }
              })

              Button('截取文件 length为object').width(600).onClick(() => {
                try {
                  let res=this.fsManager.ftruncateSync({fd:this.fd,length:{'name':'test'}}) //
                  console.debug(`
                      [advanceDEMO] 鸿蒙截取文件 成功 ${JSON.stringify(res)} }
                    `)
                  promptAction.showToast({
                    message: `鸿蒙截取文件 成功 ${JSON.stringify(res)} `
                  })
                } catch (error) {
                  console.debug(`
                      [advanceDEMO] 鸿蒙截取文件 { ${JSON.stringify(error)}}
                    `)
                  promptAction.showToast({
                    message: `鸿蒙截取文件 或其他错误 ${error}`
                  })
                }
              })

              Button('截取文件 length为null').width(600).onClick(() => {
                try {
                  let res=this.fsManager.ftruncateSync({fd:this.fd,length:null}) //
                  console.debug(`
                      [advanceDEMO] 鸿蒙截取文件 成功 ${JSON.stringify(res)} }
                    `)
                  promptAction.showToast({
                    message: `鸿蒙截取文件 成功 ${JSON.stringify(res)} `
                  })
                } catch (error) {
                  console.debug(`
                      [advanceDEMO] 鸿蒙截取文件 { ${JSON.stringify(error)}}
                    `)
                  promptAction.showToast({
                    message: `鸿蒙截取文件 或其他错误 ${error}`
                  })
                }
              })

              Button('截取文件 length为\'ab\'').width(600).onClick(() => {
                try {
                  let res=this.fsManager.ftruncateSync({fd:this.fd,length:'ab'}) //
                  console.debug(`
                      [advanceDEMO] 鸿蒙截取文件 成功 ${JSON.stringify(res)} }
                    `)
                  promptAction.showToast({
                    message: `鸿蒙截取文件 成功 ${JSON.stringify(res)} `
                  })
                } catch (error) {
                  console.debug(`
                      [advanceDEMO] 鸿蒙截取文件 { ${JSON.stringify(error)}}
                    `)
                  promptAction.showToast({
                    message: `鸿蒙截取文件 或其他错误 ${error}`
                  })
                }
              })

              Button('截取文件 length为\'\'').width(600).onClick(() => {
                try {
                  let res=this.fsManager.ftruncateSync({fd:this.fd,length:''}) //
                  console.debug(`
                      [advanceDEMO] 鸿蒙截取文件 成功 ${JSON.stringify(res)} }
                    `)
                  promptAction.showToast({
                    message: `鸿蒙截取文件 成功 ${JSON.stringify(res)} `
                  })
                } catch (error) {
                  console.debug(`
                      [advanceDEMO] 鸿蒙截取文件 { ${JSON.stringify(error)}}
                    `)
                  promptAction.showToast({
                    message: `鸿蒙截取文件 或其他错误 ${error}`
                  })
                }
              })

              Button('截取文件 length为undefined').width(600).onClick(() => {
                try {
                  let res=this.fsManager.ftruncateSync({fd:this.fd,length:undefined}) //
                  console.debug(`
                      [advanceDEMO] 鸿蒙截取文件 成功 ${JSON.stringify(res)} }
                    `)
                  promptAction.showToast({
                    message: `鸿蒙截取文件 成功 ${JSON.stringify(res)} `
                  })
                } catch (error) {
                  console.debug(`
                      [advanceDEMO] 鸿蒙截取文件 { ${JSON.stringify(error)}}
                    `)
                  promptAction.showToast({
                    message: `鸿蒙截取文件 或其他错误 ${error}`
                  })
                }
              })

            }
          }

          // fs.getFileInfo
          // 接口的要求：获取该小程序下的 本地临时文件 或 本地缓存文件 信息
          // 由于鸿蒙未提供该接口，开发者使用鸿蒙的fstat实现；且微信要求在真机上才能测试 ，模拟机上无法测试，可能会存在一些难以预料的情况
          ListItem() {
            Column({ space: 10 }) {
              Text('fs.getFileInfo').fontSize(25)
              Button('先用鸿蒙接口创建文件test.txt，创建目录filesDir下，写入内容hello, world').width(600).onClick(() => {
                let file = fs.openSync(this.filePath, fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE)
                let num = fs.writeSync(file.fd, "hello, world")
                promptAction.showToast({
                  message: `文件内容写入成功，长度：${num},path:${this.filePath}`,
                })
                console.debug('[advanceDEMO] write data to file succeed and size is:' + num + this.filePath)
              })

              Button('获取本地临时文件或本地缓存文件的信息 【路径存在】').width(600).onClick(() => {
                this.fsManager.getFileInfo({
                  filePath: this.filePath,
                  success: (res) => {
                    promptAction.showToast({
                      message: `获取文件信息 成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 获取文件信息 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `获取文件信息 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('获取本地临时文件或本地缓存文件的信息 【路径不存在】').width(600).onClick(() => {
                this.fsManager.getFileInfo({
                  filePath: this.context.filesDir+'/randomFile/test.txt',
                  success: (res) => {
                    promptAction.showToast({
                      message: `获取文件信息 成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 获取文件信息 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `获取文件信息 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              // fd的值为null num等非string的情况 属于同一类错误
              Button('获取本地临时文件或本地缓存文件的信息 【路径为空】').width(600).onClick(() => {
                this.fsManager.getFileInfo({
                  filePath: null,
                  success: (res) => {
                    promptAction.showToast({
                      message: `获取文件信息 成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 获取文件信息 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `获取文件信息 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

            }
          }

          // fs.mkdir
          ListItem() {
            Column({ space: 10 }) {
              Text('fs.mkdir ').fontSize(25)
              Button('dirPath的上级目录存在 递归创建：【否】').width(600).onClick(() => {
                this.fsManager.mkdir({
                  dirPath: this.context.filesDir+'/testMkdirSingleLayerFalse',
                  recursive:false,
                  success: (res) => {
                    promptAction.showToast({
                      message: `文件 res = ${JSON.stringify(res)}`
                    })
                  },

                  fail: (res) => {
                    console.error(`[advanceDEMO] 创建目录 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `创建目录 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })


              Button('dirPath的上级目录存在 递归创建：【是】').width(600).onClick(() => {
                this.fsManager.mkdir({
                  dirPath: this.context.filesDir+'/testMkdirSingleLayerTrue',
                  recursive:true,
                  success: (res) => {
                    promptAction.showToast({
                      message: `文件 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 创建目录 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `创建目录 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('dirPath的上级目录不存在 递归创建：【否】').width(600).onClick(() => {
                this.fsManager.mkdir({
                  dirPath: this.context.filesDir + '/testMkdir1/testMkdir',
                  recursive: false ,
                  success: (res) => {
                    promptAction.showToast({
                      message: `文件 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 创建目录 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `创建目录 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('dirPath的上级目录不存在 递归创建：【是】').width(600).onClick(() => {
                this.fsManager.mkdir({
                  dirPath: this.context.filesDir + '/testMkdir1/testMkdirRecursive',
                  recursive: true ,
                  success: (res) => {
                    promptAction.showToast({
                      message: `文件 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 创建目录 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `创建目录 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('dirPath已存在').width(600).onClick(() => {
                this.fsManager.mkdir({
                  dirPath: this.context.filesDir+'/testMkdirSingleLayerFalse',
                  recursive: false ,
                  success: (res) => {
                    promptAction.showToast({
                      message: `文件 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 创建目录 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `创建目录 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              // 路径为null num等非string的情况 属于同一类情况
              Button('dirPath为num').width(600).onClick(() => {
                this.fsManager.mkdir({
                  dirPath: 12,
                  recursive: false ,
                  success: (res) => {
                    promptAction.showToast({
                      message: `文件 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 创建目录 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `创建目录 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('dirPath为null').width(600).onClick(() => {
                this.fsManager.mkdir({
                  dirPath: null,
                  recursive: false ,
                  success: (res) => {
                    promptAction.showToast({
                      message: `文件 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 创建目录 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `创建目录 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('dirPath为boolean').width(600).onClick(() => {
                this.fsManager.mkdir({
                  dirPath: true,
                  recursive: false ,
                  success: (res) => {
                    promptAction.showToast({
                      message: `文件 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 创建目录 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `创建目录 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('dirPath为undefined').width(600).onClick(() => {
                this.fsManager.mkdir({
                  dirPath: undefined,
                  recursive: false ,
                  success: (res) => {
                    promptAction.showToast({
                      message: `文件 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 创建目录 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `创建目录 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('dirPath为object').width(600).onClick(() => {
                this.fsManager.mkdir({
                  dirPath: {'name':'test'},
                  recursive: false ,
                  success: (res) => {
                    promptAction.showToast({
                      message: `文件 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 创建目录 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `创建目录 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('dirPath为\'\'').width(600).onClick(() => {
                this.fsManager.mkdir({
                  dirPath: '',
                  recursive: false ,
                  success: (res) => {
                    promptAction.showToast({
                      message: `文件 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 创建目录 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `创建目录 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('dirPath为\'ab\'').width(600).onClick(() => {
                this.fsManager.mkdir({
                  dirPath:'ab',
                  recursive: false ,
                  success: (res) => {
                    promptAction.showToast({
                      message: `文件 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 创建目录 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `创建目录 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('recursive 为undefined').width(600).onClick(() => {
                this.fsManager.mkdir({
                  dirPath: this.context.filesDir+'/testMkdirForRec1' ,
                  recursive: undefined ,
                  success: (res) => {
                    promptAction.showToast({
                      message: `文件 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 创建目录 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `创建目录 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('recursive 为object').width(600).onClick(() => {
                this.fsManager.mkdir({
                  dirPath: this.context.filesDir+'/testMkdirForRec2' ,
                  recursive: {'name':'test'} ,
                  success: (res) => {
                    promptAction.showToast({
                      message: `文件 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 创建目录 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `创建目录 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('recursive 为\'\'').width(600).onClick(() => {
                this.fsManager.mkdir({
                  dirPath: this.context.filesDir+'/testMkdirForRec3' ,
                  recursive: '' ,
                  success: (res) => {
                    promptAction.showToast({
                      message: `文件 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 创建目录 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `创建目录 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('recursive 为\'ab\'').width(600).onClick(() => {
                this.fsManager.mkdir({
                  dirPath: this.context.filesDir+'/testMkdirForRec4' ,
                  recursive: 'ab' ,
                  success: (res) => {
                    promptAction.showToast({
                      message: `文件 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 创建目录 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `创建目录 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('recursive 为null').width(600).onClick(() => {
                this.fsManager.mkdir({
                  dirPath: this.context.filesDir+'/testMkdirForRec5' ,
                  recursive: null ,
                  success: (res) => {
                    promptAction.showToast({
                      message: `文件 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 创建目录 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `创建目录 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('recursive 为num').width(600).onClick(() => {
                this.fsManager.mkdir({
                  dirPath: this.context.filesDir+'/testMkdirForRec6' ,
                  recursive: 12 ,
                  success: (res) => {
                    promptAction.showToast({
                      message: `文件 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 创建目录 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `创建目录 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

            }
          }

          // fs.mkdirSync
          ListItem() {
            Column({ space: 10 }) {
              Text('fs.mkdirSync').fontSize(25)

              Button('dirPath的上级目录存在 递归创建：【否】').width(600).onClick(() => {
                try {
                  this.fsManager.mkdirSync(this.context.filesDir+'/testMkdir',false)
                  promptAction.showToast({
                    message: `创建目录成功`
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `创建目录失败，目录已存在 或其他错误 ${error}`
                  })
                }
              })

              Button('dirPath的上级目录存在 递归创建：【是】').width(600).onClick(() => {
                try {
                  this.fsManager.mkdirSync(this.context.filesDir+'/testMkdirRecursive',true)
                  promptAction.showToast({
                    message: `创建目录成功`
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `创建目录失败，目录已存在 或其他错误 ${error}`
                  })
                }
              })

              Button('dirPath的上级目录不存在 递归创建：【否】').width(600).onClick(() => {
                try {
                  this.fsManager.mkdirSync(this.context.filesDir + '/testMkdir2/testMkdir',false)
                  promptAction.showToast({
                    message: `创建目录成功`
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `创建目录失败，目录已存在 或其他错误 ${error}`
                  })
                }
              })

              Button('dirPath的上级目录不存在 递归创建：【是】').width(600).onClick(() => {
                try {
                  this.fsManager.mkdirSync(this.context.filesDir + '/testMkdir2/testMkdirRecursive',true)
                  promptAction.showToast({
                    message: `创建目录成功`
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `创建目录失败，目录已存在 或其他错误 ${error}`
                  })
                }
              })

              Button('dirPath已存在').width(600).onClick(() => {
                try {
                  this.fsManager.mkdirSync(this.context.filesDir+'/testMkdir',false)
                  promptAction.showToast({
                    message: `创建目录成功`
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `创建目录失败，目录已存在 或其他错误 ${error}`
                  })
                }
              })

              // 路径为null num等非string的情况 属于同一类情况
              Button('dirPath为num').width(600).onClick(() => {
                try {
                  this.fsManager.mkdirSync(12,false)
                  promptAction.showToast({
                    message: `创建目录成功`
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `创建目录失败，目录已存在 或其他错误 ${error}`
                  })
                }
              })

              Button('dirPath为null').width(600).onClick(() => {
                try {
                  this.fsManager.mkdirSync(null,false)
                  promptAction.showToast({
                    message: `创建目录成功`
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `创建目录失败，目录已存在 或其他错误 ${error}`
                  })
                }
              })

              Button('dirPath为boolean').width(600).onClick(() => {
                try {
                  this.fsManager.mkdirSync(true,false)
                  promptAction.showToast({
                    message: `创建目录成功`
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `创建目录失败，目录已存在 或其他错误 ${error}`
                  })
                }
              })

              Button('dirPath为undefined').width(600).onClick(() => {
                try {
                  this.fsManager.mkdirSync(undefined,false)
                  promptAction.showToast({
                    message: `创建目录成功`
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `创建目录失败，目录已存在 或其他错误 ${error}`
                  })
                }
              })

              Button('dirPath为object').width(600).onClick(() => {
                try {
                  this.fsManager.mkdirSync({'name':'test'},false)
                  promptAction.showToast({
                    message: `创建目录成功`
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `创建目录失败，目录已存在 或其他错误 ${error}`
                  })
                }
              })

              Button('dirPath为\'\'').width(600).onClick(() => {
                try {
                  this.fsManager.mkdirSync('',false)
                  promptAction.showToast({
                    message: `创建目录成功`
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `创建目录失败，目录已存在 或其他错误 ${error}`
                  })
                }
              })

              Button('dirPath为\'ab\'').width(600).onClick(() => {
                try {
                  this.fsManager.mkdirSync('ab',false)
                  promptAction.showToast({
                    message: `创建目录成功`
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `创建目录失败，目录已存在 或其他错误 ${error}`
                  })
                }
              })

              Button('recursive 为undefined').width(600).onClick(() => {
                try {
                  this.fsManager.mkdirSync(this.context.filesDir+'/testMkdirForRec1',undefined)
                  promptAction.showToast({
                    message: `创建目录成功`
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `创建目录失败，目录已存在 或其他错误 ${error}`
                  })
                }
              })

              Button('recursive 为object').width(600).onClick(() => {
                try {
                  this.fsManager.mkdirSync(this.context.filesDir+'/testMkdirForRec2',{'name':'test'})
                  promptAction.showToast({
                    message: `创建目录成功`
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `创建目录失败，目录已存在 或其他错误 ${error}`
                  })
                }
              })

              Button('recursive 为\'\'').width(600).onClick(() => {
                try {
                  this.fsManager.mkdirSync(this.context.filesDir+'/testMkdirForRec3','')
                  promptAction.showToast({
                    message: `创建目录成功`
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `创建目录失败，目录已存在 或其他错误 ${error}`
                  })
                }
              })

              Button('recursive 为\'ab\'').width(600).onClick(() => {
                try {
                  this.fsManager.mkdirSync(this.context.filesDir+'/testMkdirForRec4','ab')
                  promptAction.showToast({
                    message: `创建目录成功`
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `创建目录失败，目录已存在 或其他错误 ${error}`
                  })
                }
              })

              Button('recursive 为null').width(600).onClick(() => {
                try {
                  this.fsManager.mkdirSync(this.context.filesDir+'/testMkdirForRec5',null)
                  promptAction.showToast({
                    message: `创建目录成功`
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `创建目录失败，目录已存在 或其他错误 ${error}`
                  })
                }
              })

              Button('recursive 为num').width(600).onClick(() => {
                try {
                  this.fsManager.mkdirSync(this.context.filesDir+'/testMkdirForRec6',12)
                  promptAction.showToast({
                    message: `创建目录成功`
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `创建目录失败，目录已存在 或其他错误 ${error}`
                  })
                }
              })
            }
          }

          // fs.read
          ListItem() {
            Column({ space: 10 }) {
              Text('fs.read').fontSize(25)
              Button('先用鸿蒙接口创建文件test.txt，创建目录filesDir下，写入内容hello, world').width(600).onClick(() => {
                let file = fs.openSync(this.filePath, fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE)
                let num = fs.writeSync(file.fd, "hello, world")
                promptAction.showToast({
                  message: `文件内容写入成功，长度：${num},path:${this.filePath}`,
                })
                console.debug('[advanceDEMO] write data to file succeed and size is:' + num + this.filePath)
              })

              Button('先打开文件test.txt，得到该文件的fd').width(600).onClick(() => {
                this.fsManager.open({
                  filePath: this.filePath,
                  success: (res) => {
                    this.fd = res.fd
                    console.log(`[advanceDEMO] 打开文件 成功 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `打开文件 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 打开文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `打开文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] open complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              // 若不先打开文件 fd为获取getFileManager权限时得到的fd:''
              Button('再读取文件 fd【有效】').width(600).onClick(() => {
                this.fsManager.read({
                  fd: this.fd,
                  arrayBuffer: this.testArrayBuffer ,
                  success: (res) => {
                    console.log(`
                      [advanceDEMO] 读取文件 成功 { bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength}), errMsg: ${JSON.stringify(res.errMsg)} }
                    `)
                    // message中换行，在用户界面也会换行 所以一条代码虽然很长，但也不进行换行格式化
                    promptAction.showToast({
                      message: `读取文件 成功 res = {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength}), errMsg: ${JSON.stringify(res.errMsg)}} `
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('fd为\' \' arrayBuffer【有效】 其余参数不填').width(600).onClick(() => {
                this.fsManager.read({
                  fd: '',
                  arrayBuffer: this.testArrayBuffer,
                  success: (res) => {
                    let contextOfArrayBuffer=String.fromCharCode.apply(null, new Uint8Array(res.arrayBuffer.slice(0, res.bytesRead)))       //读取arrayBuffer中的字符信息
                    console.log(`[advanceDEMO] 读取文件 成功 {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}}`)
                    promptAction.showToast({
                      message: `读取文件 成功 res = {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}} `
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `获取文件状态信息 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('fd为\'ab\' arrayBuffer【有效】 其余参数不填').width(600).onClick(() => {
                this.fsManager.read({
                  fd: 'ab',
                  arrayBuffer: this.testArrayBuffer,
                  success: (res) => {
                    let contextOfArrayBuffer=String.fromCharCode.apply(null, new Uint8Array(res.arrayBuffer.slice(0, res.bytesRead)))       //读取arrayBuffer中的字符信息
                    console.log(`[advanceDEMO] 读取文件 成功 {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}}`)
                    promptAction.showToast({
                      message: `读取文件 成功 res = {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}} `
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `获取文件状态信息 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('fd为num arrayBuffer【有效】 其余参数不填').width(600).onClick(() => {
                this.fsManager.read({
                  fd: 12,
                  arrayBuffer: this.testArrayBuffer,
                  success: (res) => {
                    let contextOfArrayBuffer=String.fromCharCode.apply(null, new Uint8Array(res.arrayBuffer.slice(0, res.bytesRead)))       //读取arrayBuffer中的字符信息
                    console.log(`[advanceDEMO] 读取文件 成功 {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}}`)
                    promptAction.showToast({
                      message: `读取文件 成功 res = {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}} `
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `获取文件状态信息 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('fd为object arrayBuffer【有效】其余参数不填').width(600).onClick(() => {
                this.fsManager.read({
                  fd: {'name':'test'},
                  arrayBuffer: this.testArrayBuffer,
                  success: (res) => {
                    let contextOfArrayBuffer=String.fromCharCode.apply(null, new Uint8Array(res.arrayBuffer.slice(0, res.bytesRead)))       //读取arrayBuffer中的字符信息
                    console.log(`[advanceDEMO] 读取文件 成功 {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}}`)
                    promptAction.showToast({
                      message: `读取文件 成功 res = {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}} `
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `获取文件状态信息 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button(' fd为null arrayBuffer【有效】其余参数不填').width(600).onClick(() => {
                this.fsManager.read({
                  fd: null,
                  arrayBuffer: this.testArrayBuffer,
                  success: (res) => {
                    let contextOfArrayBuffer=String.fromCharCode.apply(null, new Uint8Array(res.arrayBuffer.slice(0, res.bytesRead)))       //读取arrayBuffer中的字符信息
                    console.log(`[advanceDEMO] 读取文件 成功 {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}}`)
                    promptAction.showToast({
                      message: `读取文件 成功 res = {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}} `
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `获取文件状态信息 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button(' fd为boolean arrayBuffer【有效】其余参数不填').width(600).onClick(() => {
                this.fsManager.read({
                  fd: true,
                  arrayBuffer: this.testArrayBuffer,
                  success: (res) => {
                    let contextOfArrayBuffer=String.fromCharCode.apply(null, new Uint8Array(res.arrayBuffer.slice(0, res.bytesRead)))       //读取arrayBuffer中的字符信息
                    console.log(`[advanceDEMO] 读取文件 成功 {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}}`)
                    promptAction.showToast({
                      message: `读取文件 成功 res = {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}} `
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `获取文件状态信息 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button(' fd为undefined arrayBuffer【有效】其余参数不填').width(600).onClick(() => {
                this.fsManager.read({
                  fd: undefined,
                  arrayBuffer: this.testArrayBuffer,
                  success: (res) => {
                    let contextOfArrayBuffer=String.fromCharCode.apply(null, new Uint8Array(res.arrayBuffer.slice(0, res.bytesRead)))       //读取arrayBuffer中的字符信息
                    console.log(`[advanceDEMO] 读取文件 成功 {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}}`)
                    promptAction.showToast({
                      message: `读取文件 成功 res = {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}} `
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `获取文件状态信息 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('fd【有效】 arrayBuffer为\'\'').width(600).onClick(() => {
                this.fsManager.read({
                  fd: this.fd,
                  arrayBuffer:'' ,
                  success: (res) => {
                    let contextOfArrayBuffer=String.fromCharCode.apply(null, new Uint8Array(res.arrayBuffer.slice(0, res.bytesRead)))       //读取arrayBuffer中的字符信息
                    console.log(`[advanceDEMO] 读取文件 成功 {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}}`)
                    promptAction.showToast({
                      message: `读取文件 成功 res = {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}} `
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('fd【有效】 arrayBuffer为\'ab\'').width(600).onClick(() => {
                this.fsManager.read({
                  fd: this.fd,
                  arrayBuffer:'ab' ,
                  success: (res) => {
                    let contextOfArrayBuffer=String.fromCharCode.apply(null, new Uint8Array(res.arrayBuffer.slice(0, res.bytesRead)))       //读取arrayBuffer中的字符信息
                    console.log(`[advanceDEMO] 读取文件 成功 {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}}`)
                    promptAction.showToast({
                      message: `读取文件 成功 res = {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}} `
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('fd【有效】 arrayBuffer为num').width(600).onClick(() => {
                this.fsManager.read({
                  fd: this.fd,
                  arrayBuffer:12 ,
                  success: (res) => {
                    let contextOfArrayBuffer=String.fromCharCode.apply(null, new Uint8Array(res.arrayBuffer.slice(0, res.bytesRead)))       //读取arrayBuffer中的字符信息
                    console.log(`[advanceDEMO] 读取文件 成功 {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}}`)
                    promptAction.showToast({
                      message: `读取文件 成功 res = {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}} `
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('fd【有效】 arrayBuffer为object').width(600).onClick(() => {
                this.fsManager.read({
                  fd: this.fd,
                  arrayBuffer:{'name':'test'} ,
                  success: (res) => {
                    let contextOfArrayBuffer=String.fromCharCode.apply(null, new Uint8Array(res.arrayBuffer.slice(0, res.bytesRead)))       //读取arrayBuffer中的字符信息
                    console.log(`[advanceDEMO] 读取文件 成功 {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}}`)
                    promptAction.showToast({
                      message: `读取文件 成功 res = {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}} `
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('fd【有效】 arrayBuffer为null').width(600).onClick(() => {
                this.fsManager.read({
                  fd: this.fd,
                  arrayBuffer:null ,
                  success: (res) => {
                    let contextOfArrayBuffer=String.fromCharCode.apply(null, new Uint8Array(res.arrayBuffer.slice(0, res.bytesRead)))       //读取arrayBuffer中的字符信息
                    console.log(`[advanceDEMO] 读取文件 成功 {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}}`)
                    promptAction.showToast({
                      message: `读取文件 成功 res = {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}} `
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('fd【有效】 arrayBuffer为boolean').width(600).onClick(() => {
                this.fsManager.read({
                  fd: this.fd,
                  arrayBuffer:true ,
                  success: (res) => {
                    let contextOfArrayBuffer=String.fromCharCode.apply(null, new Uint8Array(res.arrayBuffer.slice(0, res.bytesRead)))       //读取arrayBuffer中的字符信息
                    console.log(`[advanceDEMO] 读取文件 成功 {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}}`)
                    promptAction.showToast({
                      message: `读取文件 成功 res = {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}} `
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('fd【有效】 arrayBuffer为undefined').width(600).onClick(() => {
                this.fsManager.read({
                  fd: this.fd,
                  arrayBuffer:undefined,
                  success: (res) => {
                    let contextOfArrayBuffer=String.fromCharCode.apply(null, new Uint8Array(res.arrayBuffer.slice(0, res.bytesRead)))       //读取arrayBuffer中的字符信息
                    console.log(`[advanceDEMO] 读取文件 成功 {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}}`)
                    promptAction.showToast({
                      message: `读取文件 成功 res = {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}} `
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('其余参数【有效】 offset+length <= arrayBuffer.size').width(600).onClick(() => {
                this.fsManager.read({
                  fd: this.fd,
                  arrayBuffer:this.testArrayBuffer,
                  offset:0,
                  length:10,
                  position:0,
                  success: (res) => {
                    let contextOfArrayBuffer=String.fromCharCode.apply(null, new Uint8Array(res.arrayBuffer.slice(0, res.bytesRead)))       //读取arrayBuffer中的字符信息
                    console.log(`[advanceDEMO] 读取文件 成功 {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}}`)
                    promptAction.showToast({
                      message: `读取文件 成功 res = {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}} `
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('其余参数【有效】 offset+length > arrayBuffer.size').width(600).onClick(() => {

                this.fsManager.read({
                  fd: this.fd,
                  arrayBuffer:this.testArrayBuffer,
                  offset:4090, // testArrayBuffer的容量设置为4096
                  length:10,  // offset+length > arrayBuffer.size=4096
                  position:0,
                  success: (res) => {
                    let contextOfArrayBuffer=String.fromCharCode.apply(null, new Uint8Array(res.arrayBuffer.slice(0, res.bytesRead)))       //读取arrayBuffer中的字符信息
                    console.log(`[advanceDEMO] 读取文件 成功 {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}}`)
                    promptAction.showToast({
                      message: `读取文件 成功 res = {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}} `
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('其余参数【有效】 offset为\'\'').width(600).onClick(() => {
                this.fsManager.read({
                  fd: this.fd,
                  arrayBuffer:this.testArrayBuffer,
                  offset:'',
                  length:10,
                  position:0,
                  success: (res) => {
                    let contextOfArrayBuffer=String.fromCharCode.apply(null, new Uint8Array(res.arrayBuffer.slice(0, res.bytesRead)))       //读取arrayBuffer中的字符信息
                    console.log(`[advanceDEMO] 读取文件 成功 {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}}`)
                    promptAction.showToast({
                      message: `读取文件 成功 res = {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}} `
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('其余参数【有效】 offset为\'ab\'').width(600).onClick(() => {
                this.fsManager.read({
                  fd: this.fd,
                  arrayBuffer:this.testArrayBuffer,
                  offset:'ab',
                  length:10,
                  position:0,
                  success: (res) => {
                    let contextOfArrayBuffer=String.fromCharCode.apply(null, new Uint8Array(res.arrayBuffer.slice(0, res.bytesRead)))       //读取arrayBuffer中的字符信息
                    console.log(`[advanceDEMO] 读取文件 成功 {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}}`)
                    promptAction.showToast({
                      message: `读取文件 成功 res = {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}} `
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('其余参数【有效】 offset为object').width(600).onClick(() => {
                this.fsManager.read({
                  fd: this.fd,
                  arrayBuffer:this.testArrayBuffer,
                  offset:{'name':'test'},
                  length:10,
                  position:0,
                  success: (res) => {
                    let contextOfArrayBuffer=String.fromCharCode.apply(null, new Uint8Array(res.arrayBuffer.slice(0, res.bytesRead)))       //读取arrayBuffer中的字符信息
                    console.log(`[advanceDEMO] 读取文件 成功 {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}}`)
                    promptAction.showToast({
                      message: `读取文件 成功 res = {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}} `
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('其余参数【有效】 offset为null').width(600).onClick(() => {
                this.fsManager.read({
                  fd: this.fd,
                  arrayBuffer:this.testArrayBuffer,
                  offset:null,
                  length:10,
                  position:0,
                  success: (res) => {
                    let contextOfArrayBuffer=String.fromCharCode.apply(null, new Uint8Array(res.arrayBuffer.slice(0, res.bytesRead)))       //读取arrayBuffer中的字符信息
                    console.log(`[advanceDEMO] 读取文件 成功 {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}}`)
                    promptAction.showToast({
                      message: `读取文件 成功 res = {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}} `
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('其余参数【有效】 offset为boolean').width(600).onClick(() => {
                this.fsManager.read({
                  fd: this.fd,
                  arrayBuffer:this.testArrayBuffer,
                  offset:true,
                  length:10,
                  position:0,
                  success: (res) => {
                    let contextOfArrayBuffer=String.fromCharCode.apply(null, new Uint8Array(res.arrayBuffer.slice(0, res.bytesRead)))       //读取arrayBuffer中的字符信息
                    console.log(`[advanceDEMO] 读取文件 成功 {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}}`)
                    promptAction.showToast({
                      message: `读取文件 成功 res = {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}} `
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('其余参数【有效】 offset为undefined').width(600).onClick(() => {
                this.fsManager.read({
                  fd: this.fd,
                  arrayBuffer:this.testArrayBuffer,
                  offset:undefined,
                  length:10,
                  position:0,
                  success: (res) => {
                    let contextOfArrayBuffer=String.fromCharCode.apply(null, new Uint8Array(res.arrayBuffer.slice(0, res.bytesRead)))       //读取arrayBuffer中的字符信息
                    console.log(`[advanceDEMO] 读取文件 成功 {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}}`)
                    promptAction.showToast({
                      message: `读取文件 成功 res = {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}} `
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('其余参数【有效】 offset<0').width(600).onClick(() => {
                this.fsManager.read({
                  fd: this.fd,
                  arrayBuffer:this.testArrayBuffer,
                  offset:-5,
                  length:10,
                  position:0,
                  success: (res) => {
                    let contextOfArrayBuffer=String.fromCharCode.apply(null, new Uint8Array(res.arrayBuffer.slice(0, res.bytesRead)))       //读取arrayBuffer中的字符信息
                    console.log(`[advanceDEMO] 读取文件 成功 {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}}`)
                    promptAction.showToast({
                      message: `读取文件 成功 res = {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}} `
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('其余参数【有效】 length大于文本内容的长度').width(600).onClick(() => {
                this.fsManager.read({
                  fd: this.fd,
                  arrayBuffer:this.testArrayBuffer,
                  offset:0,
                  length:20,
                  position:0,
                  success: (res) => {
                    let contextOfArrayBuffer=String.fromCharCode.apply(null, new Uint8Array(res.arrayBuffer.slice(0, res.bytesRead)))       //读取arrayBuffer中的字符信息
                    console.log(`[advanceDEMO] 读取文件 成功 {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}}`)
                    promptAction.showToast({
                      message: `读取文件 成功 res = {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}} `
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('其余参数【有效】 length为\'\'').width(600).onClick(() => {
                this.fsManager.read({
                  fd: this.fd,
                  arrayBuffer:this.testArrayBuffer,
                  offset:0,
                  length:'',
                  position:0,
                  success: (res) => {
                    let contextOfArrayBuffer=String.fromCharCode.apply(null, new Uint8Array(res.arrayBuffer.slice(0, res.bytesRead)))       //读取arrayBuffer中的字符信息
                    console.log(`[advanceDEMO] 读取文件 成功 {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}}`)
                    promptAction.showToast({
                      message: `读取文件 成功 res = {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}} `
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('其余参数【有效】 length为\'ab\'').width(600).onClick(() => {
                this.fsManager.read({
                  fd: this.fd,
                  arrayBuffer:this.testArrayBuffer,
                  offset:0,
                  length:'ab',
                  position:0,
                  success: (res) => {
                    let contextOfArrayBuffer=String.fromCharCode.apply(null, new Uint8Array(res.arrayBuffer.slice(0, res.bytesRead)))       //读取arrayBuffer中的字符信息
                    console.log(`[advanceDEMO] 读取文件 成功 {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}}`)
                    promptAction.showToast({
                      message: `读取文件 成功 res = {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}} `
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('其余参数【有效】 length为\'12\'').width(600).onClick(() => {
                this.fsManager.read({
                  fd: this.fd,
                  arrayBuffer:this.testArrayBuffer,
                  offset:0,
                  length:'12',
                  position:0,
                  success: (res) => {
                    let contextOfArrayBuffer=String.fromCharCode.apply(null, new Uint8Array(res.arrayBuffer.slice(0, res.bytesRead)))       //读取arrayBuffer中的字符信息
                    console.log(`[advanceDEMO] 读取文件 成功 {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}}`)
                    promptAction.showToast({
                      message: `读取文件 成功 res = {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}} `
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('其余参数【有效】 length为object').width(600).onClick(() => {
                this.fsManager.read({
                  fd: this.fd,
                  arrayBuffer:this.testArrayBuffer,
                  offset:0,
                  length:{'name':'test'},
                  position:0,
                  success: (res) => {
                    let contextOfArrayBuffer=String.fromCharCode.apply(null, new Uint8Array(res.arrayBuffer.slice(0, res.bytesRead)))       //读取arrayBuffer中的字符信息
                    console.log(`[advanceDEMO] 读取文件 成功 {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}}`)
                    promptAction.showToast({
                      message: `读取文件 成功 res = {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}} `
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('其余参数【有效】 length为null').width(600).onClick(() => {
                this.fsManager.read({
                  fd: this.fd,
                  arrayBuffer:this.testArrayBuffer,
                  offset:0,
                  length:null,
                  position:0,
                  success: (res) => {
                    let contextOfArrayBuffer=String.fromCharCode.apply(null, new Uint8Array(res.arrayBuffer.slice(0, res.bytesRead)))       //读取arrayBuffer中的字符信息
                    console.log(`[advanceDEMO] 读取文件 成功 {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}}`)
                    promptAction.showToast({
                      message: `读取文件 成功 res = {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}} `
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('其余参数【有效】 length为true').width(600).onClick(() => {
                this.fsManager.read({
                  fd: this.fd,
                  arrayBuffer:this.testArrayBuffer,
                  offset:0,
                  length:true,
                  position:0,
                  success: (res) => {
                    let contextOfArrayBuffer=String.fromCharCode.apply(null, new Uint8Array(res.arrayBuffer.slice(0, res.bytesRead)))       //读取arrayBuffer中的字符信息
                    console.log(`[advanceDEMO] 读取文件 成功 {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}}`)
                    promptAction.showToast({
                      message: `读取文件 成功 res = {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}} `
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('其余参数【有效】 length为false').width(600).onClick(() => {
                this.fsManager.read({
                  fd: this.fd,
                  arrayBuffer:this.testArrayBuffer,
                  offset:0,
                  length:false,
                  position:0,
                  success: (res) => {
                    let contextOfArrayBuffer=String.fromCharCode.apply(null, new Uint8Array(res.arrayBuffer.slice(0, res.bytesRead)))       //读取arrayBuffer中的字符信息
                    console.log(`[advanceDEMO] 读取文件 成功 {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}}`)
                    promptAction.showToast({
                      message: `读取文件 成功 res = {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}} `
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('其余参数【有效】 length为undefined').width(600).onClick(() => {
                this.fsManager.read({
                  fd: this.fd,
                  arrayBuffer:this.testArrayBuffer,
                  offset:0,
                  length:undefined,
                  position:0,
                  success: (res) => {
                    let contextOfArrayBuffer=String.fromCharCode.apply(null, new Uint8Array(res.arrayBuffer.slice(0, res.bytesRead)))       //读取arrayBuffer中的字符信息
                    console.log(`[advanceDEMO] 读取文件 成功 {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}}`)
                    promptAction.showToast({
                      message: `读取文件 成功 res = {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}} `
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('其余参数【有效】 length<0').width(600).onClick(() => {
                this.fsManager.read({
                  fd: this.fd,
                  arrayBuffer:this.testArrayBuffer,
                  offset:0,
                  length:-5,
                  position:0,
                  success: (res) => {
                    let contextOfArrayBuffer=String.fromCharCode.apply(null, new Uint8Array(res.arrayBuffer.slice(0, res.bytesRead)))       //读取arrayBuffer中的字符信息
                    console.log(`[advanceDEMO] 读取文件 成功 {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}}`)
                    promptAction.showToast({
                      message: `读取文件 成功 res = {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}} `
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('其余参数【有效】 position+length <= 文件内容长度').width(600).onClick(() => {
                this.fsManager.read({
                  fd: this.fd,
                  arrayBuffer:this.testArrayBuffer,
                  offset:0,
                  length:10,
                  position:0, // hello.txt内的内容长度为12
                  success: (res) => {
                    let contextOfArrayBuffer=String.fromCharCode.apply(null, new Uint8Array(res.arrayBuffer.slice(0, res.bytesRead)))       //读取arrayBuffer中的字符信息
                    console.log(`[advanceDEMO] 读取文件 成功 {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}}`)
                    promptAction.showToast({
                      message: `读取文件 成功 res = {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}} `
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('其余参数【有效】 position+length > 文件内容长度').width(600).onClick(() => {
                this.fsManager.read({
                  fd: this.fd,
                  arrayBuffer:this.testArrayBuffer,
                  offset:0,
                  length:10,
                  position:10, // hello.txt内的内容长度为12
                  success: (res) => {
                    let contextOfArrayBuffer=String.fromCharCode.apply(null, new Uint8Array(res.arrayBuffer.slice(0, res.bytesRead)))       //读取arrayBuffer中的字符信息
                    console.log(`[advanceDEMO] 读取文件 成功 {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}}`)
                    promptAction.showToast({
                      message: `读取文件 成功 res = {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}} `
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('其余参数【有效】 position > 文件内容长度').width(600).onClick(() => {
                this.fsManager.read({
                  fd: this.fd,
                  arrayBuffer:this.testArrayBuffer,
                  offset:0,
                  length:10,
                  position:15, // hello.txt内的内容长度为12
                  success: (res) => {
                    let contextOfArrayBuffer=String.fromCharCode.apply(null, new Uint8Array(res.arrayBuffer.slice(0, res.bytesRead)))       //读取arrayBuffer中的字符信息
                    console.log(`[advanceDEMO] 读取文件 成功 {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}}`)
                    promptAction.showToast({
                      message: `读取文件 成功 res = {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}} `
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('其余参数【有效】 position为\'\'').width(600).onClick(() => {
                this.fsManager.read({
                  fd: this.fd,
                  arrayBuffer:this.testArrayBuffer,
                  offset:0,
                  length:10,
                  position:'',
                  success: (res) => {
                    let contextOfArrayBuffer=String.fromCharCode.apply(null, new Uint8Array(res.arrayBuffer.slice(0, res.bytesRead)))       //读取arrayBuffer中的字符信息
                    console.log(`[advanceDEMO] 读取文件 成功 {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}}`)
                    promptAction.showToast({
                      message: `读取文件 成功 res = {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}} `
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('其余参数【有效】 position为\'ab\'').width(600).onClick(() => {
                this.fsManager.read({
                  fd: this.fd,
                  arrayBuffer:this.testArrayBuffer,
                  offset:0,
                  length:10,
                  position:'ab',
                  success: (res) => {
                    let contextOfArrayBuffer=String.fromCharCode.apply(null, new Uint8Array(res.arrayBuffer.slice(0, res.bytesRead)))       //读取arrayBuffer中的字符信息
                    console.log(`[advanceDEMO] 读取文件 成功 {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}}`)
                    promptAction.showToast({
                      message: `读取文件 成功 res = {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}} `
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('其余参数【有效】 position为\'12\'').width(600).onClick(() => {
                this.fsManager.read({
                  fd: this.fd,
                  arrayBuffer:this.testArrayBuffer,
                  offset:0,
                  length:10,
                  position:'12',
                  success: (res) => {
                    let contextOfArrayBuffer=String.fromCharCode.apply(null, new Uint8Array(res.arrayBuffer.slice(0, res.bytesRead)))       //读取arrayBuffer中的字符信息
                    console.log(`[advanceDEMO] 读取文件 成功 {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}}`)
                    promptAction.showToast({
                      message: `读取文件 成功 res = {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}} `
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('其余参数【有效】 position为object').width(600).onClick(() => {
                this.fsManager.read({
                  fd: this.fd,
                  arrayBuffer:this.testArrayBuffer,
                  offset:0,
                  length:10,
                  position:{'name':'test'},
                  success: (res) => {
                    let contextOfArrayBuffer=String.fromCharCode.apply(null, new Uint8Array(res.arrayBuffer.slice(0, res.bytesRead)))       //读取arrayBuffer中的字符信息
                    console.log(`[advanceDEMO] 读取文件 成功 {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}}`)
                    promptAction.showToast({
                      message: `读取文件 成功 res = {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}} `
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('其余参数【有效】 position为null').width(600).onClick(() => {
                this.fsManager.read({
                  fd: this.fd,
                  arrayBuffer:this.testArrayBuffer,
                  offset:0,
                  length:10,
                  position:null,
                  success: (res) => {
                    let contextOfArrayBuffer=String.fromCharCode.apply(null, new Uint8Array(res.arrayBuffer.slice(0, res.bytesRead)))       //读取arrayBuffer中的字符信息
                    console.log(`[advanceDEMO] 读取文件 成功 {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}}`)
                    promptAction.showToast({
                      message: `读取文件 成功 res = {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}} `
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('其余参数【有效】 position为true').width(600).onClick(() => {
                this.fsManager.read({
                  fd: this.fd,
                  arrayBuffer:this.testArrayBuffer,
                  offset:0,
                  length:10,
                  position:true,
                  success: (res) => {
                    let contextOfArrayBuffer=String.fromCharCode.apply(null, new Uint8Array(res.arrayBuffer.slice(0, res.bytesRead)))       //读取arrayBuffer中的字符信息
                    console.log(`[advanceDEMO] 读取文件 成功 {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}}`)
                    promptAction.showToast({
                      message: `读取文件 成功 res = {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}} `
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('其余参数【有效】 position为false').width(600).onClick(() => {
                this.fsManager.read({
                  fd: this.fd,
                  arrayBuffer:this.testArrayBuffer,
                  offset:0,
                  length:10,
                  position:false,
                  success: (res) => {
                    let contextOfArrayBuffer=String.fromCharCode.apply(null, new Uint8Array(res.arrayBuffer.slice(0, res.bytesRead)))       //读取arrayBuffer中的字符信息
                    console.log(`[advanceDEMO] 读取文件 成功 {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}}`)
                    promptAction.showToast({
                      message: `读取文件 成功 res = {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}} `
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('其余参数【有效】 position为undefined').width(600).onClick(() => {
                this.fsManager.read({
                  fd: this.fd,
                  arrayBuffer:this.testArrayBuffer,
                  offset:0,
                  length:10,
                  position:undefined,
                  success: (res) => {
                    let contextOfArrayBuffer=String.fromCharCode.apply(null, new Uint8Array(res.arrayBuffer.slice(0, res.bytesRead)))       //读取arrayBuffer中的字符信息
                    console.log(`[advanceDEMO] 读取文件 成功 {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}}`)
                    promptAction.showToast({
                      message: `读取文件 成功 res = {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}} `
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('其余参数【有效】 position<0').width(600).onClick(() => {
                this.fsManager.read({
                  fd: this.fd,
                  arrayBuffer:this.testArrayBuffer,
                  offset:0,
                  length:10,
                  position:-5,
                  success: (res) => {
                    let contextOfArrayBuffer=String.fromCharCode.apply(null, new Uint8Array(res.arrayBuffer.slice(0, res.bytesRead)))       //读取arrayBuffer中的字符信息
                    console.log(`[advanceDEMO] 读取文件 成功 {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}}`)
                    promptAction.showToast({
                      message: `读取文件 成功 res = {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${JSON.stringify(contextOfArrayBuffer)} , errMsg: ${JSON.stringify(res.errMsg)}} `
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })
            }
          }

          // fs.readSync
          ListItem() {
            Column({ space: 10 }) {
              Text('fs.readSync').fontSize(25)
              Button('先用鸿蒙接口创建文件test.txt，创建目录filesDir下，写入内容hello, world').width(600).onClick(() => {
                let file = fs.openSync(this.filePath, fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE)
                let num = fs.writeSync(file.fd, "hello, world")
                promptAction.showToast({
                  message: `文件内容写入成功，长度：${num},path:${this.filePath}`,
                })
                console.debug('[advanceDEMO] write data to file succeed and size is:' + num + this.filePath)
              })

              Button('先打开文件test.txt，得到该文件的fd').width(600).onClick(() => {
                this.fsManager.open({
                  filePath: this.filePath,
                  success: (res) => {
                    this.fd = res.fd
                    promptAction.showToast({
                      message: `打开文件 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 打开文件 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `打开文件 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] open complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('再读取文件 fd【有效】').width(600).onClick(() => {
                try {
                  let res=this.fsManager.readSync({fd:this.fd,arrayBuffer:this.testArrayBuffer}) //
                  console.debug(`
                      [advanceDEMO] 读取文件 成功 { bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})}
                    `)
                  promptAction.showToast({
                    message: `读取文件 成功  {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})} `
                  })
                } catch (error) {
                  console.debug(`
                      [advanceDEMO] 读取失败 { ${JSON.stringify(error)}}
                    `)
                  promptAction.showToast({
                    message: `读取失败 或其他错误 ${error}`
                  })
                }
              })

              // fd的值为null num等非string的情况 属于同一类错误
              Button('fd为\'\'【无效】').width(600).onClick(() => {
                try {
                  let res=this.fsManager.readSync({ fd:'', arrayBuffer: this.testArrayBuffer }) //
                  console.debug(`
                      [advanceDEMO] 读取文件 成功 { bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})}
                    `)
                  promptAction.showToast({
                    message: `读取文件 成功  {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})} `
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `读取失败 或其他错误 ${error}`
                  })
                }
              })

              Button('其余参数【有效】 fd为num').width(600).onClick(() => {
                try {
                  let res=this.fsManager.readSync({ fd:12, arrayBuffer: this.testArrayBuffer }) //
                  console.debug(`
                      [advanceDEMO] 读取文件 成功 { bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})}
                    `)
                  promptAction.showToast({
                    message: `读取文件 成功  {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})} `
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `读取失败 或其他错误 ${error}`
                  })
                }
              })

              Button('其余参数【有效】 fd为object').width(600).onClick(() => {
                try {
                  let res=this.fsManager.readSync({ fd:{'name':'test'}, arrayBuffer: this.testArrayBuffer }) //
                  console.debug(`
                      [advanceDEMO] 读取文件 成功 { bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})}
                    `)
                  promptAction.showToast({
                    message: `读取文件 成功  {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})} `
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `读取失败 或其他错误 ${error}`
                  })
                }
              })

              Button('其余参数【有效】  fd为null').width(600).onClick(() => {
                try {
                  let res=this.fsManager.readSync({ fd:null, arrayBuffer: this.testArrayBuffer }) //
                  console.debug(`
                      [advanceDEMO] 读取文件 成功 { bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})}
                    `)
                  promptAction.showToast({
                    message: `读取文件 成功  {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})} `
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `读取失败 或其他错误 ${error}`
                  })
                }
              })

              Button('其余参数【有效】 fd为boolean').width(600).onClick(() => {
                try {
                  let res=this.fsManager.readSync({ fd:true, arrayBuffer: this.testArrayBuffer }) //
                  console.debug(`
                      [advanceDEMO] 读取文件 成功 { bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})}
                    `)
                  promptAction.showToast({
                    message: `读取文件 成功  {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})} `
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `读取失败 或其他错误 ${error}`
                  })
                }
              })

              Button('其余参数【有效】 fd为undefined').width(600).onClick(() => {
                try {
                  let res=this.fsManager.readSync({ fd:undefined, arrayBuffer: this.testArrayBuffer }) //
                  console.debug(`
                      [advanceDEMO] 读取文件 成功 { bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})}
                    `)
                  promptAction.showToast({
                    message: `读取文件 成功  {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})} `
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `读取失败 或其他错误 ${error}`
                  })
                }
              })

              Button('其余参数【有效】 arrayBuffer为\'\'').width(600).onClick(() => {
                try {
                  let res=this.fsManager.readSync({ fd:this.fd, arrayBuffer:'' }) //
                  console.debug(`
                      [advanceDEMO] 读取文件 成功 { bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})}
                    `)
                  promptAction.showToast({
                    message: `读取文件 成功  {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})} `
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `读取失败 或其他错误 ${error}`
                  })
                }
              })

              Button('其余参数【有效】arrayBuffer为\'ab\'').width(600).onClick(() => {
                try {
                  let res=this.fsManager.readSync({ fd:this.fd, arrayBuffer:'ab' }) //
                  console.debug(`
                      [advanceDEMO] 读取文件 成功 { bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})}
                    `)
                  promptAction.showToast({
                    message: `读取文件 成功  {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})} `
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `读取失败 或其他错误 ${error}`
                  })
                }
              })

              Button('其余参数【有效】 arrayBuffer为num').width(600).onClick(() => {
                try {
                  let res=this.fsManager.readSync({ fd:this.fd, arrayBuffer:12 }) //
                  console.debug(`
                      [advanceDEMO] 读取文件 成功 { bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})}
                    `)
                  promptAction.showToast({
                    message: `读取文件 成功  {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})} `
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `读取失败 或其他错误 ${error}`
                  })
                }
              })

              Button('其余参数【有效】 arrayBuffer为object').width(600).onClick(() => {
                try {
                  let res=this.fsManager.readSync({ fd:this.fd, arrayBuffer:{'name':'test'} }) //
                  console.debug(`
                      [advanceDEMO] 读取文件 成功 { bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})}
                    `)
                  promptAction.showToast({
                    message: `读取文件 成功  {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})} `
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `读取失败 或其他错误 ${error}`
                  })
                }
              })

              Button('其余参数【有效】 arrayBuffer为null').width(600).onClick(() => {
                try {
                  let res=this.fsManager.readSync({ fd:this.fd, arrayBuffer:null }) //
                  console.debug(`
                      [advanceDEMO] 读取文件 成功 { bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})}
                    `)
                  promptAction.showToast({
                    message: `读取文件 成功  {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})} `
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `读取失败 或其他错误 ${error}`
                  })
                }
              })

              Button('其余参数【有效】 arrayBuffer为boolean').width(600).onClick(() => {
                try {
                  let res=this.fsManager.readSync({ fd:this.fd, arrayBuffer:true }) //
                  console.debug(`
                      [advanceDEMO] 读取文件 成功 { bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})}
                    `)
                  promptAction.showToast({
                    message: `读取文件 成功  {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})} `
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `读取失败 或其他错误 ${error}`
                  })
                }
              })

              Button('其余参数【有效】 arrayBuffer为undefined').width(600).onClick(() => {
                try {
                  let res=this.fsManager.readSync({ fd:this.fd, arrayBuffer:undefined }) //
                  console.debug(`
                      [advanceDEMO] 读取文件 成功 { bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})}
                    `)
                  promptAction.showToast({
                    message: `读取文件 成功  {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})} `
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `读取失败 或其他错误 ${error}`
                  })
                }
              })

              Button('其余参数【有效】 offset+length <= arrayBuffer.size').width(600).onClick(() => {
                try {
                  let res=this.fsManager.readSync({
                    fd:this.fd,
                    arrayBuffer:this.testArrayBuffer,
                    offset:0,
                    length:10,
                    position:0, })
                  console.debug(`
                      [advanceDEMO] 读取文件 成功 { bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})}
                    `)
                  promptAction.showToast({
                    message: `读取文件 成功  {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})} `
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `读取失败 或其他错误 ${error}`
                  })
                }
              })

              Button('其余参数【有效】 offset+length > arrayBuffer.size').width(600).onClick(() => {
                try {
                  let res=this.fsManager.readSync({
                    fd:this.fd,
                    arrayBuffer:this.testArrayBuffer,
                    offset:4090, // testArrayBuffer的容量设置为4096
                    length:10,  // offset+length > arrayBuffer.size=4096
                    position:0,
                  })
                  console.debug(`
                      [advanceDEMO] 读取文件 成功 { bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})}
                    `)
                  promptAction.showToast({
                    message: `读取文件 成功  {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})} `
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `读取失败 或其他错误 ${error}`
                  })
                }
              })

              Button('其余参数【有效】 offset为\'\'').width(600).onClick(() => {
                try {
                  let res=this.fsManager.readSync({
                    fd:this.fd,
                    arrayBuffer:this.testArrayBuffer,
                    offset:'',
                    length:10,
                    position:0
                  })
                  console.debug(`
                      [advanceDEMO] 读取文件 成功 { bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})}
                    `)
                  promptAction.showToast({
                    message: `读取文件 成功  {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})} `
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `读取失败 或其他错误 ${error}`
                  })
                }
              })

              Button('其余参数【有效】 offset为\'ab\'').width(600).onClick(() => {
                try {
                  let res=this.fsManager.readSync({
                    fd:this.fd,
                    arrayBuffer:this.testArrayBuffer,
                    offset:'ab',
                    length:10,
                    position:0
                  })
                  console.debug(`
                      [advanceDEMO] 读取文件 成功 { bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})}
                    `)
                  promptAction.showToast({
                    message: `读取文件 成功  {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})} `
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `读取失败 或其他错误 ${error}`
                  })
                }
              })

              Button('其余参数【有效】 offset为object').width(600).onClick(() => {
                try {
                  let res=this.fsManager.readSync({
                    fd:this.fd,
                    arrayBuffer:this.testArrayBuffer,
                    offset:{'name':'test'},
                    length:10,
                    position:0
                  })
                  console.debug(`
                      [advanceDEMO] 读取文件 成功 { bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})}
                    `)
                  promptAction.showToast({
                    message: `读取文件 成功  {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})} `
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `读取失败 或其他错误 ${error}`
                  })
                }
              })

              Button('其余参数【有效】 offset为null').width(600).onClick(() => {
                try {
                  let res=this.fsManager.readSync({
                    fd:this.fd,
                    arrayBuffer:this.testArrayBuffer,
                    offset:null,
                    length:10,
                    position:0
                  })
                  console.debug(`
                      [advanceDEMO] 读取文件 成功 { bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})}
                    `)
                  promptAction.showToast({
                    message: `读取文件 成功  {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})} `
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `读取失败 或其他错误 ${error}`
                  })
                }
              })

              Button('其余参数【有效】 offset为boolean').width(600).onClick(() => {
                try {
                  let res=this.fsManager.readSync({
                    fd:this.fd,
                    arrayBuffer:this.testArrayBuffer,
                    offset:true,
                    length:10,
                    position:0
                  })
                  console.debug(`
                      [advanceDEMO] 读取文件 成功 { bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})}
                    `)
                  promptAction.showToast({
                    message: `读取文件 成功  {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})} `
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `读取失败 或其他错误 ${error}`
                  })
                }
              })

              Button('其余参数【有效】 offset为undefined').width(600).onClick(() => {
                try {
                  let res=this.fsManager.readSync({
                    fd:this.fd,
                    arrayBuffer:this.testArrayBuffer,
                    offset:undefined,
                    length:10,
                    position:0
                  })
                  console.debug(`
                      [advanceDEMO] 读取文件 成功 { bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})}
                    `)
                  promptAction.showToast({
                    message: `读取文件 成功  {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})} `
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `读取失败 或其他错误 ${error}`
                  })
                }
              })

              Button('其余参数【有效】 offset<0').width(600).onClick(() => {
                try {
                  let res=this.fsManager.readSync({
                    fd:this.fd,
                    arrayBuffer:this.testArrayBuffer,
                    offset:-5,
                    length:10,
                    position:0
                  })
                  console.debug(`
                      [advanceDEMO] 读取文件 成功 { bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})}
                    `)
                  promptAction.showToast({
                    message: `读取文件 成功  {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})} `
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `读取失败 或其他错误 ${error}`
                  })
                }
              })

              Button('其余参数【有效】 length大于文本内容的长度').width(600).onClick(() => {
                try {
                  let res=this.fsManager.readSync({
                    fd:this.fd,
                    arrayBuffer:this.testArrayBuffer,
                    offset:0,
                    length:20,
                    position:0
                  })
                  console.debug(`
                      [advanceDEMO] 读取文件 成功 { bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})}
                    `)
                  promptAction.showToast({
                    message: `读取文件 成功  {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})} `
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `读取失败 或其他错误 ${error}`
                  })
                }
              })

              Button('其余参数【有效】 length为\'\'').width(600).onClick(() => {
                try {
                  let res=this.fsManager.readSync({
                    fd:this.fd,
                    arrayBuffer:this.testArrayBuffer,
                    offset:0,
                    length:'',
                    position:0
                  })
                  console.debug(`
                      [advanceDEMO] 读取文件 成功 { bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})}
                    `)
                  promptAction.showToast({
                    message: `读取文件 成功  {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})} `
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `读取失败 或其他错误 ${error}`
                  })
                }
              })

              Button('其余参数【有效】 length为\'ab\'').width(600).onClick(() => {
                try {
                  let res=this.fsManager.readSync({
                    fd:this.fd,
                    arrayBuffer:this.testArrayBuffer,
                    offset:0,
                    length:'ab',
                    position:0
                  })
                  console.debug(`
                      [advanceDEMO] 读取文件 成功 { bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})}
                    `)
                  promptAction.showToast({
                    message: `读取文件 成功  {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})} `
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `读取失败 或其他错误 ${error}`
                  })
                }
              })

              Button('其余参数【有效】 length为\'12\'').width(600).onClick(() => {
                try {
                  let res=this.fsManager.readSync({
                    fd:this.fd,
                    arrayBuffer:this.testArrayBuffer,
                    offset:0,
                    length:'12',
                    position:0
                  })
                  console.debug(`
                      [advanceDEMO] 读取文件 成功 { bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})}
                    `)
                  promptAction.showToast({
                    message: `读取文件 成功  {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})} `
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `读取失败 或其他错误 ${error}`
                  })
                }
              })

              Button('其余参数【有效】 length为object').width(600).onClick(() => {
                try {
                  let res=this.fsManager.readSync({
                    fd:this.fd,
                    arrayBuffer:this.testArrayBuffer,
                    offset:0,
                    length:{'name':'test'},
                    position:0
                  })
                  console.debug(`
                      [advanceDEMO] 读取文件 成功 { bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})}
                    `)
                  promptAction.showToast({
                    message: `读取文件 成功  {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})} `
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `读取失败 或其他错误 ${error}`
                  })
                }
              })

              Button('其余参数【有效】 length为null').width(600).onClick(() => {
                try {
                  let res=this.fsManager.readSync({
                    fd:this.fd,
                    arrayBuffer:this.testArrayBuffer,
                    offset:0,
                    length:null,
                    position:0
                  })
                  console.debug(`
                      [advanceDEMO] 读取文件 成功 { bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})}
                    `)
                  promptAction.showToast({
                    message: `读取文件 成功  {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})} `
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `读取失败 或其他错误 ${error}`
                  })
                }
              })

              Button('其余参数【有效】 length为true').width(600).onClick(() => {
                try {
                  let res=this.fsManager.readSync({
                    fd:this.fd,
                    arrayBuffer:this.testArrayBuffer,
                    offset:0,
                    length:true,
                    position:0
                  })
                  console.debug(`
                      [advanceDEMO] 读取文件 成功 { bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})}
                    `)
                  promptAction.showToast({
                    message: `读取文件 成功  {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})} `
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `读取失败 或其他错误 ${error}`
                  })
                }
              })

              Button('其余参数【有效】 length为false').width(600).onClick(() => {
                try {
                  let res=this.fsManager.readSync({
                    fd:this.fd,
                    arrayBuffer:this.testArrayBuffer,
                    offset:0,
                    length:false,
                    position:0
                  })
                  console.debug(`
                      [advanceDEMO] 读取文件 成功 { bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})}
                    `)
                  promptAction.showToast({
                    message: `读取文件 成功  {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})} `
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `读取失败 或其他错误 ${error}`
                  })
                }
              })

              Button('其余参数【有效】 length为undefined').width(600).onClick(() => {
                try {
                  let res=this.fsManager.readSync({
                    fd:this.fd,
                    arrayBuffer:this.testArrayBuffer,
                    offset:0,
                    length:undefined,
                    position:0
                  })
                  console.debug(`
                      [advanceDEMO] 读取文件 成功 { bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})}
                    `)
                  promptAction.showToast({
                    message: `读取文件 成功  {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})} `
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `读取失败 或其他错误 ${error}`
                  })
                }
              })

              Button('其余参数【有效】 length<0').width(600).onClick(() => {
                try {
                  let res=this.fsManager.readSync({
                    fd:this.fd,
                    arrayBuffer:this.testArrayBuffer,
                    offset:0,
                    length:-5,
                    position:0
                  })
                  console.debug(`
                      [advanceDEMO] 读取文件 成功 { bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})}
                    `)
                  promptAction.showToast({
                    message: `读取文件 成功  {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})} `
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `读取失败 或其他错误 ${error}`
                  })
                }
              })

              Button('其余参数【有效】 position+length <= 文件内容长度').width(600).onClick(() => {
                try {
                  let res=this.fsManager.readSync({
                    fd:this.fd,
                    arrayBuffer:this.testArrayBuffer,
                    offset:0,
                    length:10,
                    position:0 // hello.txt内的内容长度为12
                  })
                  console.debug(`
                      [advanceDEMO] 读取文件 成功 { bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})}
                    `)
                  promptAction.showToast({
                    message: `读取文件 成功  {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})} `
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `读取失败 或其他错误 ${error}`
                  })
                }
              })

              Button('其余参数【有效】 position+length > 文件内容长度').width(600).onClick(() =>{
                try {
                  let res=this.fsManager.readSync({
                    fd:this.fd,
                    arrayBuffer:this.testArrayBuffer,
                    offset:0,
                    length:10,
                    position:10 // hello.txt内的内容长度为12
                  })
                  console.debug(`
                      [advanceDEMO] 读取文件 成功 { bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})}
                    `)
                  promptAction.showToast({
                    message: `读取文件 成功  {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})} `
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `读取失败 或其他错误 ${error}`
                  })
                }
              })

              Button('其余参数【有效】 position > 文件内容长度').width(600).onClick(() => {
                try {
                  let res=this.fsManager.readSync({
                    fd:this.fd,
                    arrayBuffer:this.testArrayBuffer,
                    offset:0,
                    length:10,
                    position:15 // hello.txt内的内容长度为12
                  })
                  console.debug(`
                      [advanceDEMO] 读取文件 成功 { bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})}
                    `)
                  promptAction.showToast({
                    message: `读取文件 成功  {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})} `
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `读取失败 或其他错误 ${error}`
                  })
                }
              })

              Button('其余参数【有效】 position为\'\'').width(600).onClick(() => {
                try {
                  let res=this.fsManager.readSync({
                    fd:this.fd,
                    arrayBuffer:this.testArrayBuffer,
                    offset:0,
                    length:10,
                    position:''
                  })
                  console.debug(`
                      [advanceDEMO] 读取文件 成功 { bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})}
                    `)
                  promptAction.showToast({
                    message: `读取文件 成功  {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})} `
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `读取失败 或其他错误 ${error}`
                  })
                }
              })

              Button('其余参数【有效】 position为\'ab\'').width(600).onClick(() => {
                try {
                  let res=this.fsManager.readSync({
                    fd:this.fd,
                    arrayBuffer:this.testArrayBuffer,
                    offset:0,
                    length:10,
                    position:'ab'
                  })
                  console.debug(`
                      [advanceDEMO] 读取文件 成功 { bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})}
                    `)
                  promptAction.showToast({
                    message: `读取文件 成功  {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})} `
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `读取失败 或其他错误 ${error}`
                  })
                }
              })

              Button('其余参数【有效】 position为\'12\'').width(600).onClick(() => {
                try {
                  let res=this.fsManager.readSync({
                    fd:this.fd,
                    arrayBuffer:this.testArrayBuffer,
                    offset:0,
                    length:10,
                    position:'12'
                  })
                  console.debug(`
                      [advanceDEMO] 读取文件 成功 { bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})}
                    `)
                  promptAction.showToast({
                    message: `读取文件 成功  {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})} `
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `读取失败 或其他错误 ${error}`
                  })
                }
              })

              Button('其余参数【有效】 position为object').width(600).onClick(() => {
                try {
                  let res=this.fsManager.readSync({
                    fd:this.fd,
                    arrayBuffer:this.testArrayBuffer,
                    offset:0,
                    length:10,
                    position:{'n':'t'}
                  })
                  console.debug(`
                      [advanceDEMO] 读取文件 成功 { bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})}
                    `)
                  promptAction.showToast({
                    message: `读取文件 成功  {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})} `
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `读取失败 或其他错误 ${error}`
                  })
                }
              })

              Button('其余参数【有效】 position为null').width(600).onClick(() => {
                try {
                  let res=this.fsManager.readSync({
                    fd:this.fd,
                    arrayBuffer:this.testArrayBuffer,
                    offset:0,
                    length:10,
                    position:null
                  })
                  console.debug(`
                      [advanceDEMO] 读取文件 成功 { bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})}
                    `)
                  promptAction.showToast({
                    message: `读取文件 成功  {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})} `
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `读取失败 或其他错误 ${error}`
                  })
                }
              })

              Button('其余参数【有效】 position为true').width(600).onClick(() => {
                try {
                  let res=this.fsManager.readSync({
                    fd:this.fd,
                    arrayBuffer:this.testArrayBuffer,
                    offset:0,
                    length:10,
                    position:true
                  })
                  console.debug(`
                      [advanceDEMO] 读取文件 成功 { bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})}
                    `)
                  promptAction.showToast({
                    message: `读取文件 成功  {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})} `
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `读取失败 或其他错误 ${error}`
                  })
                }
              })

              Button('其余参数【有效】 position为false').width(600).onClick(() => {
                try {
                  let res=this.fsManager.readSync({
                    fd:this.fd,
                    arrayBuffer:this.testArrayBuffer,
                    offset:0,
                    length:10,
                    position:false
                  })
                  console.debug(`
                      [advanceDEMO] 读取文件 成功 { bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})}
                    `)
                  promptAction.showToast({
                    message: `读取文件 成功  {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})} `
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `读取失败 或其他错误 ${error}`
                  })
                }
              })

              Button('其余参数【有效】 position为undefined').width(600).onClick(() => {
                try {
                  let res=this.fsManager.readSync({
                    fd:this.fd,
                    arrayBuffer:this.testArrayBuffer,
                    offset:0,
                    length:10,
                    position:undefined
                  })
                  console.debug(`
                      [advanceDEMO] 读取文件 成功 { bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})}
                    `)
                  promptAction.showToast({
                    message: `读取文件 成功  {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})} `
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `读取失败 或其他错误 ${error}`
                  })
                }
              })

              Button('其余参数【有效】 position<0').width(600).onClick(() => {
                try {
                  let res=this.fsManager.readSync({
                    fd:this.fd,
                    arrayBuffer:this.testArrayBuffer,
                    offset:0,
                    length:10,
                    position:-5
                  })
                  console.debug(`
                      [advanceDEMO] 读取文件 成功 { bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})}
                    `)
                  promptAction.showToast({
                    message: `读取文件 成功  {bytesRead: ${JSON.stringify(res.bytesRead)}, arrayBuffer:${res.arrayBuffer.constructor.name}(${res.arrayBuffer.byteLength})} `
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `读取失败 或其他错误 ${error}`
                  })
                }
              })
            }
          }

          // fs.readCompressedFile

        }.alignListItem(ListItemAlign.Center) // 每行之间的分界线
      }
    }
  }
}