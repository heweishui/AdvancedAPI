// @ts-nocheck
import fs from '@ohos.file.fs'
import buffer from '@ohos.buffer'
import common from '@ohos.app.ability.common'
import promptAction from '@ohos.promptAction'

@Entry
@Component
struct File {
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

              Button('为下面的按钮 创建文件creatNewFileForTest.txt').width(600).onClick(() => {
                let file = fs.openSync(this.context.filesDir+'/creatNewFileForTest.txt', fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE)
                let num = fs.writeSync(file.fd, "hello, world")
                promptAction.showToast({
                  message: `文件内容写入成功，长度：${num},path:${this.filePath}`,
                })
                console.debug('[advanceDEMO] write data to file succeed and size is:' + num + this.filePath)
              })

              Button('copyFileSync').width(600).onClick(() => {
                try {
                  let res=fs.copyFileSync(this.filePath,this.context.filesDir+'/creatNewFileForTest.txt')
                  console.log('[advanceDEMO] the res of copyFileSync: '+res)
                  promptAction.showToast({
                    message: `copyFileSync成功  res=${res}`
                  })
                } catch (error) {
                  console.error(`[advanceDEMO] 失败 the value of res : ${this.res}`)
                  console.error(`[advanceDEMO] copyFileSync 失败 ${error}`)
                  promptAction.showToast({
                    message: `copyFileSync 失败 ${error}`
                  })
                }
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
                  console.log('[advanceDEMO] write buf2 success, read by endcoing(utf-8)::'+buf2.toString('utf-8'))

                  // let buf1 = buffer.from("1234");
                  // let buf2 = buffer.from("abcd");
                  let buf = buffer.concat([buf1, buf2]);
                  console.log('[advanceDEMO]  read concat result by endcoing(utf-8): '+buf.toString('utf-8'))

                  console.log('[advanceDEMO] the res of concat: '+buf.toString('utf-8',0,100));
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

          // fs.readdir
          ListItem() {
            Column({ space: 10 }) {
              Text('fs.readdir').fontSize(25)

              Button('readdir 目录不存在 ').width(600).onClick(() => {
                this.fsManager.readdir({
                  dirPath:this.context.filesDir+'/testMkdirUnexist',
                  success: (res) => {
                    promptAction.showToast({
                      message: `读取目录  成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取目录 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取目录 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('创建目录1').width(600).onClick(() => {
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

              Button('创建目录2').width(600).onClick(() => {
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

              Button('创建目录3').width(600).onClick(() => {
                try {
                  this.fsManager.mkdirSync(this.context.filesDir+'/testMkdir/test3',true)
                  promptAction.showToast({
                    message: `创建目录3成功`
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `创建目录3失败，目录已存在 或其他错误 ${error}`
                  })
                }
              })

              Button('readdir 目录存在且其下有文件 ').width(600).onClick(() => {
                this.fsManager.readdir({
                  dirPath:this.context.filesDir+'/testMkdir',
                  success: (res) => {
                    promptAction.showToast({
                      message: `读取目录  成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取目录 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取目录 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('为下面的button创建一个文件 ').width(600).onClick(() => {
                let file = fs.openSync(this.filePath, fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE)
                let num = fs.writeSync(file.fd, "hello, world")
                promptAction.showToast({
                  message: `文件内容写入成功，长度：${num},path:${this.filePath}`,
                })
                console.debug('[advanceDEMO] write data to file succeed and size is:' + num + this.filePath)
              })

              Button('readdir 传入文件路径 ').width(600).onClick(() => {
                this.fsManager.readdir({
                  dirPath:this.filePath,
                  success: (res) => {
                    promptAction.showToast({
                      message: `读取目录  成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取目录 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取目录 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('readdir 路径为\'\' ').width(600).onClick(() => {
                this.fsManager.readdir({
                  dirPath:'',
                  success: (res) => {
                    promptAction.showToast({
                      message: `读取目录  成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取目录 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取目录 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('readdir 路径为\'ab\' ').width(600).onClick(() => {
                this.fsManager.readdir({
                  dirPath:'ab',
                  success: (res) => {
                    promptAction.showToast({
                      message: `读取目录  成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取目录 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取目录 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('readdir 路径为null ').width(600).onClick(() => {
                this.fsManager.readdir({
                  dirPath:null,
                  success: (res) => {
                    promptAction.showToast({
                      message: `读取目录  成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取目录 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取目录 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('readdir 路径为num ').width(600).onClick(() => {
                this.fsManager.readdir({
                  dirPath:12,
                  success: (res) => {
                    promptAction.showToast({
                      message: `读取目录  成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取目录 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取目录 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('readdir 路径为boolean ').width(600).onClick(() => {
                this.fsManager.readdir({
                  dirPath:true,
                  success: (res) => {
                    promptAction.showToast({
                      message: `读取目录  成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取目录 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取目录 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('readdir 路径为object ').width(600).onClick(() => {
                this.fsManager.readdir({
                  dirPath:{'name':'test'},
                  success: (res) => {
                    promptAction.showToast({
                      message: `读取目录  成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取目录 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取目录 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('readdir 路径为undefined ').width(600).onClick(() => {
                this.fsManager.readdir({
                  dirPath:undefined,
                  success: (res) => {
                    promptAction.showToast({
                      message: `读取目录  成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取目录 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取目录 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

            }
          }

          // fs.readdirSync
          ListItem() {
            Column({ space: 10 }) {
              Text('fs.readdirSync').fontSize(25)

              Button('readdir 目录不存在 ').width(600).onClick(() => {
                try {
                  this.fsManager.readdirSync(this.filePath)
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

              Button('创建目录1').width(600).onClick(() => {
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

              Button('创建目录2').width(600).onClick(() => {
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

              Button('创建目录3').width(600).onClick(() => {
                try {
                  this.fsManager.mkdirSync(this.context.filesDir+'/testMkdir/test3',true)
                  promptAction.showToast({
                    message: `创建目录3成功`
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `创建目录3失败，目录已存在 或其他错误 ${error}`
                  })
                }
              })

              Button('readdir 目录存在且其下有文件 ').width(600).onClick(() => {
                try {
                  let res=this.fsManager.readdirSync(this.context.filesDir+'/testMkdir')
                  console.log('[AdvancedAPI] fileSystemManager accessSync  success = '+this.filePath )
                  promptAction.showToast({
                    message: `目录下存在文件： filenames :${JSON.stringify(res)}`
                  })
                } catch (error) {
                  console.log('[AdvancedAPI] fileSystemManager accessSync  fail = '+error)
                  promptAction.showToast({
                    message: `文件不存在 或其他错误 ${error}`
                  })
                }
              })

              Button('为下面的button创建一个文件 ').width(600).onClick(() => {
                let file = fs.openSync(this.filePath, fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE)
                let num = fs.writeSync(file.fd, "hello, world")
                promptAction.showToast({
                  message: `文件内容写入成功，长度：${num},path:${this.filePath}`,
                })
                console.debug('[advanceDEMO] write data to file succeed and size is:' + num + this.filePath)
              })

              Button('readdir 传入文件路径 ').width(600).onClick(() => {
                try {
                  let res=this.fsManager.readdirSync(this.filePath)
                  console.log('[AdvancedAPI] fileSystemManager accessSync  success = '+this.filePath )
                  promptAction.showToast({
                    message: `目录下存在文件： filenames :${JSON.stringify(res)}`
                  })
                } catch (error) {
                  console.log('[AdvancedAPI] fileSystemManager accessSync  fail = '+error)
                  promptAction.showToast({
                    message: `文件不存在 或其他错误 ${error}`
                  })
                }
              })

              Button('readdir 路径为\'\' ').width(600).onClick(() => {
                try {
                  this.fsManager.readdirSync('')
                  console.log('[AdvancedAPI] fileSystemManager accessSync  success = '+this.filePath )
                  promptAction.showToast({
                    message: `文件存在 `
                  })
                } catch (error) {
                  console.log('[AdvancedAPI] fileSystemManager accessSync  fail = '+error)
                  promptAction.showToast({
                    message: `文件不存在 或其他错误 ${error}`
                  })
                }
              })

              Button('readdir 路径为\'ab\' ').width(600).onClick(() => {
                try {
                  this.fsManager.readdirSync('ab')
                  console.log('[AdvancedAPI] fileSystemManager accessSync  success = '+this.filePath )
                  promptAction.showToast({
                    message: `文件存在 `
                  })
                } catch (error) {
                  console.log('[AdvancedAPI] fileSystemManager accessSync  fail = '+error)
                  promptAction.showToast({
                    message: `文件不存在 或其他错误 ${error}`
                  })
                }
              })

              // null num 等非string类型的错误为同一类
              Button('readdir 路径为null ').width(600).onClick(() => {
                try {
                  this.fsManager.readdirSync(null)
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

              Button('readdir 路径为num ').width(600).onClick(() => {
                try {
                  this.fsManager.readdirSync(12)
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

              Button('readdir 路径为boolean ').width(600).onClick(() => {
                try {
                  this.fsManager.readdirSync(true)
                  console.log('[AdvancedAPI] fileSystemManager accessSync  success = '+this.filePath )
                  promptAction.showToast({
                    message: `文件存在 `
                  })
                } catch (error) {
                  console.log('[AdvancedAPI] fileSystemManager accessSync  fail = '+error)
                  promptAction.showToast({
                    message: `文件不存在 或其他错误 ${error}`
                  })
                }
              })

              Button('readdir 路径为object ').width(600).onClick(() => {
                try {
                  this.fsManager.readdirSync({'name':'test'})
                  console.log('[AdvancedAPI] fileSystemManager accessSync  success = '+this.filePath )
                  promptAction.showToast({
                    message: `文件存在 `
                  })
                } catch (error) {
                  console.log('[AdvancedAPI] fileSystemManager accessSync  fail = '+error)
                  promptAction.showToast({
                    message: `文件不存在 或其他错误 ${error}`
                  })
                }
              })

              Button('readdir 路径为undefined ').width(600).onClick(() => {
                try {
                  this.fsManager.readdirSync(undefined)
                  console.log('[AdvancedAPI] fileSystemManager accessSync  success = '+this.filePath )
                  promptAction.showToast({
                    message: `文件存在 `
                  })
                } catch (error) {
                  console.log('[AdvancedAPI] fileSystemManager accessSync  fail = '+error)
                  promptAction.showToast({
                    message: `文件不存在 或其他错误 ${error}`
                  })
                }
              })

            }
          }

          // fs.readFile
          ListItem() {
            Column({ space: 10 }) {
              Text('fs.readFile').fontSize(25)

              Button('先用鸿蒙接口创建文件test.txt，创建目录filesDir下，写入内容hello, world').width(600).onClick(() => {
                let file = fs.openSync(this.filePath, fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE)
                let num = fs.writeSync(file.fd, "hello, world")
                promptAction.showToast({
                  message: `文件内容写入成功，长度：${num},path:${this.filePath}`,
                })
                console.debug('[advanceDEMO] write data to file succeed and size is:' + num + this.filePath)
              })

              Button('读取文件内容 filePath【有效】 ').width(600).onClick(() => {
                this.fsManager.readFile({
                  filePath:this.filePath,
                  //encoding:'utf-8',
                  //position:10,
                  //length:10,
                  success: (res) => {
                    promptAction.showToast({
                      message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件内容 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件内容 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] readFile complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('filePath【有效】,含encoding、position、length ').width(600).onClick(() => {
                this.fsManager.readFile({
                  filePath:this.filePath,
                  encoding:'utf-8',
                  position:3,
                  length:3,
                  success: (res) => {
                    promptAction.showToast({
                      message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件内容 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件内容 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('读取文件内容 filePath【无效】 ').width(600).onClick(() => {
                this.fsManager.readFile({
                  filePath:this.context.filesDir+`/hello1.txt`,
                  //encoding:'utf-8',
                  //position:10,
                  //length:10,
                  success: (res) => {
                    promptAction.showToast({
                      message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件内容 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件内容 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('读取文件内容 传入一个存在的目录 ').width(600).onClick(() => {
                this.fsManager.readFile({
                  filePath:this.context.filesDir,
                  //encoding:'utf-8',
                  //position:10,
                  //length:10,
                  success: (res) => {
                    promptAction.showToast({
                      message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件内容 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件内容 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('读取文件内容 filePath为null【无效】 ').width(600).onClick(() => {
                this.fsManager.readFile({
                  filePath:null,
                  //encoding:'utf-8',
                  //position:10,
                  //length:10,
                  success: (res) => {
                    promptAction.showToast({
                      message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件内容 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件内容 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('读取文件内容 filePath为num【无效】 ').width(600).onClick(() => {
                this.fsManager.readFile({
                  filePath:12,
                  //encoding:'utf-8',
                  //position:10,
                  //length:10,
                  success: (res) => {
                    promptAction.showToast({
                      message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件内容 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件内容 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              // 微信对''的访问返回为 permission denied
              Button('读取文件内容 filePath为\'\'【无效】 ').width(600).onClick(() => {
                this.fsManager.readFile({
                  filePath:``,
                  //encoding:'utf-8',
                  //position:10,
                  //length:10,
                  success: (res) => {
                    promptAction.showToast({
                      message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件内容 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件内容 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              // 8月8日 新增position 、length 越界以及为null的情况
              Button('position <0  ').width(600).onClick(() => {
                this.fsManager.readFile({
                  filePath:this.filePath,
                  encoding:'utf-8',
                  position:-2,
                  length:10,
                  success: (res) => {
                    promptAction.showToast({
                      message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件内容 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件内容 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              // 预期结果：能够读取成功的 全为空串 且长度为length的长度
              Button('position > 文件长度 ').width(600).onClick(() => {
                this.fsManager.readFile({
                  filePath:this.filePath,
                  encoding:'utf-8',
                  position:1000,
                  length:10,
                  success: (res) => {
                    promptAction.showToast({
                      message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                    })
                    console.log('[advanceDEMO] the type of res is : '+typeof(res.str) )
                    console.log('[advanceDEMO] the size of res is : '+res.str.length)
                    console.log('[advanceDEMO] the content of the res is : '+res.str)
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件内容 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件内容 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('position 为null ').width(600).onClick(() => {
                this.fsManager.readFile({
                  filePath:this.filePath,
                  encoding:'utf-8',
                  position:null,
                  length:10,
                  success: (res) => {
                    promptAction.showToast({
                      message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件内容 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件内容 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('length <0  ').width(600).onClick(() => {
                this.fsManager.readFile({
                  filePath:this.filePath,
                  encoding:'utf-8',
                  position:-20,
                  length:10,
                  success: (res) => {
                    promptAction.showToast({
                      message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件内容 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件内容 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('length > 文件长度 ').width(600).onClick(() => {
                this.fsManager.readFile({
                  filePath:this.filePath,
                  encoding:'utf-8',
                  position:0,
                  length:99,
                  success: (res) => {
                    promptAction.showToast({
                      message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                    })
                    console.log('[advanceDEMO] the type of res is : '+typeof(res.str) )
                    console.log('[advanceDEMO] the size of res is : '+res.str.length)
                    console.log('[advanceDEMO] the content of the res is : '+res.str)
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件内容 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件内容 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('length 为null ').width(600).onClick(() => {
                this.fsManager.readFile({
                  filePath:this.filePath,
                  encoding:'utf-8',
                  position:0,
                  length:null,
                  success: (res) => {
                    promptAction.showToast({
                      message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件内容 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件内容 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              // 8月9日 新增
              Button('position 为boolean ').width(600).onClick(() => {
                this.fsManager.readFile({
                  filePath:this.filePath,
                  encoding:'utf-8',
                  position:true,
                  length:10,
                  success: (res) => {
                    promptAction.showToast({
                      message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件内容 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件内容 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('position 为undefined ').width(600).onClick(() => {
                this.fsManager.readFile({
                  filePath:this.filePath,
                  encoding:'utf-8',
                  position:undefined,
                  length:10,
                  success: (res) => {
                    promptAction.showToast({
                      message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件内容 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件内容 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('position 为\'\' ').width(600).onClick(() => {
                this.fsManager.readFile({
                  filePath:this.filePath,
                  encoding:'utf-8',
                  position:'',
                  length:10,
                  success: (res) => {
                    promptAction.showToast({
                      message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件内容 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件内容 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('position 为\'ab\' ').width(600).onClick(() => {
                this.fsManager.readFile({
                  filePath:this.filePath,
                  encoding:'utf-8',
                  position:'ab',
                  length:10,
                  success: (res) => {
                    promptAction.showToast({
                      message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件内容 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件内容 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('position 为object ').width(600).onClick(() => {
                this.fsManager.readFile({
                  filePath:this.filePath,
                  encoding:'utf-8',
                  position:{'name':'test'},
                  length:10,
                  success: (res) => {
                    promptAction.showToast({
                      message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件内容 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件内容 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('length 为boolean ').width(600).onClick(() => {
                this.fsManager.readFile({
                  filePath:this.filePath,
                  encoding:'utf-8',
                  position:0,
                  length:true,
                  success: (res) => {
                    promptAction.showToast({
                      message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件内容 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件内容 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('length 为undefined ').width(600).onClick(() => {
                this.fsManager.readFile({
                  filePath:this.filePath,
                  encoding:'utf-8',
                  position:0,
                  length:undefined,
                  success: (res) => {
                    promptAction.showToast({
                      message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件内容 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件内容 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('length 为\'\' ').width(600).onClick(() => {
                this.fsManager.readFile({
                  filePath:this.filePath,
                  encoding:'utf-8',
                  position:0,
                  length:'',
                  success: (res) => {
                    promptAction.showToast({
                      message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件内容 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件内容 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('length 为\'ab\' ').width(600).onClick(() => {
                this.fsManager.readFile({
                  filePath:this.filePath,
                  encoding:'utf-8',
                  position:0,
                  length:'ab',
                  success: (res) => {
                    promptAction.showToast({
                      message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件内容 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件内容 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('length 为object').width(600).onClick(() => {
                this.fsManager.readFile({
                  filePath:this.filePath,
                  encoding:'utf-8',
                  position:0,
                  length:{'name':'test'},
                  success: (res) => {
                    promptAction.showToast({
                      message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件内容 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件内容 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('encoding 为支持的utf-8').width(600).onClick(() => {
                this.fsManager.readFile({
                  filePath:this.filePath,
                  encoding:'utf-8',
                  position:0,
                  length:10,
                  success: (res) => {
                    promptAction.showToast({
                      message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件内容 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件内容 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('encoding 为支持的utf8').width(600).onClick(() => {
                this.fsManager.readFile({
                  filePath:this.filePath,
                  encoding:'utf8',
                  position:0,
                  length:10,
                  success: (res) => {
                    promptAction.showToast({
                      message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件内容 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件内容 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('encoding 为合法但暂不支持的binary').width(600).onClick(() => {
                this.fsManager.readFile({
                  filePath:this.filePath,
                  encoding:'binary',
                  position:0,
                  length:10,
                  success: (res) => {
                    promptAction.showToast({
                      message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件内容 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件内容 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('encoding 为num').width(600).onClick(() => {
                this.fsManager.readFile({
                  filePath:this.filePath,
                  encoding:12,
                  position:0,
                  length:10,
                  success: (res) => {
                    promptAction.showToast({
                      message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件内容 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件内容 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('encoding 为null').width(600).onClick(() => {
                this.fsManager.readFile({
                  filePath:this.filePath,
                  encoding:null,
                  position:0,
                  length:10,
                  success: (res) => {
                    promptAction.showToast({
                      message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件内容 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件内容 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('encoding 为boolean').width(600).onClick(() => {
                this.fsManager.readFile({
                  filePath:this.filePath,
                  encoding:true,
                  position:0,
                  length:10,
                  success: (res) => {
                    promptAction.showToast({
                      message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件内容 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件内容 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('encoding 为\'ab\'').width(600).onClick(() => {
                this.fsManager.readFile({
                  filePath:this.filePath,
                  encoding:'ab',
                  position:0,
                  length:10,
                  success: (res) => {
                    promptAction.showToast({
                      message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件内容 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件内容 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('encoding 为object').width(600).onClick(() => {
                this.fsManager.readFile({
                  filePath:this.filePath,
                  encoding:{'name':'test'},
                  position:0,
                  length:10,
                  success: (res) => {
                    promptAction.showToast({
                      message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件内容 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件内容 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('encoding 为\'\'').width(600).onClick(() => {
                this.fsManager.readFile({
                  filePath:this.filePath,
                  encoding:'',
                  position:0,
                  length:10,
                  success: (res) => {
                    console.log("[advanceDEMO] the content is : " + String.fromCharCode.apply(null, new Uint8Array(res.buf.slice(0,10))))
                    console.log(`[advanceDEMO]  读取文件内容 成功 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 读取文件内容 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `读取文件内容 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] readFile complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('encoding 为undefined').width(600).onClick(() => {
                this.fsManager.readFile({
                  filePath:this.filePath,
                  encoding:undefined,
                  position:0,
                  length:10,
                  success: (res) => {
                    console.log("[advanceDEMO] the content is : " + String.fromCharCode.apply(null, new Uint8Array(res.buf.slice(0,10))))
                    promptAction.showToast({
                      message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    promptAction.showToast({
                      message: `读取文件内容 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] readFile complete res = ${JSON.stringify(res)}`)
                  }
                })
              })
            }
          }

          //fs.readFileSync
          ListItem() {
            Column({ space: 10 }) {
              Text('fs.readFileSync').fontSize(25)

              Button('先用鸿蒙接口创建文件test.txt，创建目录filesDir下，写入内容hello, world').width(600).onClick(() => {
                let file = fs.openSync(this.filePath, fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE)
                let num = fs.writeSync(file.fd, "hello, world")
                promptAction.showToast({
                  message: `文件内容写入成功，长度：${num},path:${this.filePath}`,
                })
                console.debug('[advanceDEMO] write data to file succeed and size is:' + num + this.filePath)
              })

              Button('读取文件内容 filePath【有效】 ').width(600).onClick(() => {
                try {
                  let res = this.fsManager.readFileSync(this.filePath)
                  console.log('[AdvancedAPI] fileSystemManager readFileSync  success ')
                  promptAction.showToast({
                    message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                  })
                } catch (error) {
                  console.error(`[advanceDEMO] 读取文件内容 失败 ${JSON.stringify(error)}`)
                  promptAction.showToast({
                    message: `读取文件内容 失败 ${JSON.stringify(error)}`
                  })
                }
              })

              Button('filePath【有效】,含encoding、position、length ').width(600).onClick(() => {
                try {
                  let res = this.fsManager.readFileSync(this.filePath, 'utf-8', 3, 3,)
                  console.log('[AdvancedAPI] fileSystemManager readFileSync  success ')
                  promptAction.showToast({
                    message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                  })
                } catch (error) {
                  console.error(`[advanceDEMO] 读取文件内容 失败 ` + error)
                  promptAction.showToast({
                    message: `读取文件内容 失败 ${JSON.stringify(error)}`
                  })
                }
              })

              Button('读取文件内容 filePath【无效】 ').width(600).onClick(() => {
                try {
                  let res = this.fsManager.readFileSync(this.context.filesDir + `/hello1.txt`)
                  console.log('[AdvancedAPI] fileSystemManager readFileSync  success ')
                  promptAction.showToast({
                    message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                  })
                } catch (error) {
                  console.error(`[advanceDEMO] 读取文件内容 失败 ` + error)
                  promptAction.showToast({
                    message: `读取文件内容 失败  ${error}`
                  })
                }
              })

              Button('读取文件内容 传入一个存在的目录 ').width(600).onClick(() => {
                try {
                  let res = this.fsManager.readFileSync(this.context.filesDir)
                  console.log('[AdvancedAPI] fileSystemManager readFileSync  success ')
                  promptAction.showToast({
                    message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                  })
                } catch (error) {
                  console.error(`[advanceDEMO] 读取文件内容 失败 ` + error)
                  promptAction.showToast({
                    message: `读取文件内容 失败  ${error}`
                  })
                }
              })

              Button('读取文件内容 filePath为null【无效】 ').width(600).onClick(() => {
                try {
                  let res = this.fsManager.readFileSync(null)
                  console.log('[AdvancedAPI] fileSystemManager readFileSync  success ')
                  promptAction.showToast({
                    message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                  })
                } catch (error) {
                  console.error(`[advanceDEMO] 读取文件内容 失败 ` + error)
                  promptAction.showToast({
                    message: `读取文件内容 失败  ${error}`
                  })
                }
              })

              Button('读取文件内容 filePath为num【无效】 ').width(600).onClick(() => {
                try {
                  let res = this.fsManager.readFileSync(12)
                  console.log('[AdvancedAPI] fileSystemManager readFileSync  success ')
                  promptAction.showToast({
                    message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                  })
                } catch (error) {
                  console.error(`[advanceDEMO] 读取文件内容 失败 ` + error)
                  promptAction.showToast({
                    message: `读取文件内容 失败  ${error}`
                  })
                }
              })

              Button('读取文件内容 filePath为\'\'【无效】 ').width(600).onClick(() => {
                try {
                  let res = this.fsManager.readFileSync(``)
                  console.log('[AdvancedAPI] fileSystemManager readFileSync  success ')
                  promptAction.showToast({
                    message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                  })
                } catch (error) {
                  console.error(`[advanceDEMO] 读取文件内容 失败 ` + error)
                  promptAction.showToast({
                    message: `读取文件内容 失败  ${error}`
                  })
                }
              })

              // 8月8日新增
              Button('position <0  ').width(600).onClick(() => {
                try {
                  let res = this.fsManager.readFileSync(this.filePath, 'utf-8', -2, 10)
                  console.log('[AdvancedAPI] fileSystemManager readFileSync  success ')
                  promptAction.showToast({
                    message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                  })
                } catch (error) {
                  console.error(`[advanceDEMO] 读取文件内容 失败 ` + error)
                  promptAction.showToast({
                    message: `读取文件内容 失败  ${error}`
                  })
                }
              })

              // 预期结果：能够读取成功的 全为空串 且长度为length的长度
              Button('position > 文件长度 ').width(600).onClick(() => {
                try {
                  let res = this.fsManager.readFileSync(this.filePath, 'utf-8', 1000, 10)
                  console.log('[AdvancedAPI] fileSystemManager readFileSync  success ')
                  promptAction.showToast({
                    message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                  })
                } catch (error) {
                  console.error(`[advanceDEMO] 读取文件内容 失败 ` + error)
                  promptAction.showToast({
                    message: `读取文件内容 失败  ${error}`
                  })
                }
              })

              Button('position 为null ').width(600).onClick(() => {
                try {
                  let res = this.fsManager.readFileSync(this.filePath, 'utf-8', null, 10)
                  console.log('[AdvancedAPI] fileSystemManager readFileSync  success ')
                  promptAction.showToast({
                    message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                  })
                } catch (error) {
                  console.error(`[advanceDEMO] 读取文件内容 失败 ` + error)
                  promptAction.showToast({
                    message: `读取文件内容 失败  ${error}`
                  })
                }
              })

              Button('length <0  ').width(600).onClick(() => {
                try {
                  let res = this.fsManager.readFileSync(this.filePath, 'utf-8', 0, -10)
                  console.log('[AdvancedAPI] fileSystemManager readFileSync  success ')
                  promptAction.showToast({
                    message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                  })
                } catch (error) {
                  console.error(`[advanceDEMO] 读取文件内容 失败 ` + error)
                  promptAction.showToast({
                    message: `读取文件内容 失败  ${error}`
                  })
                }
              })

              Button('length > 文件长度 ').width(600).onClick(() => {
                try {
                  let res = this.fsManager.readFileSync(this.filePath, 'utf-8', 0, 1000)
                  console.log('[AdvancedAPI] fileSystemManager readFileSync  success ')
                  promptAction.showToast({
                    message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                  })
                } catch (error) {
                  console.error(`[advanceDEMO] 读取文件内容 失败 ` + error)
                  promptAction.showToast({
                    message: `读取文件内容 失败  ${error}`
                  })
                }
              })

              Button('length 为null ').width(600).onClick(() => {
                try {
                  let res = this.fsManager.readFileSync(this.filePath, 'utf-8', 0, null)
                  console.log('[AdvancedAPI] fileSystemManager readFileSync  success ')
                  promptAction.showToast({
                    message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                  })
                } catch (error) {
                  console.error(`[advanceDEMO] 读取文件内容 失败 ` + error)
                  promptAction.showToast({
                    message: `读取文件内容 失败  ${error}`
                  })
                }
              })

              // 8月10日 新增
              Button('position 为boolean ').width(600).onClick(() => {
                try {
                  let res = this.fsManager.readFileSync(this.filePath, 'utf-8', true, 10)
                  console.log('[AdvancedAPI] fileSystemManager readFileSync  success ')
                  promptAction.showToast({
                    message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                  })
                } catch (error) {
                  console.error(`[advanceDEMO] 读取文件内容 失败 ` + error)
                  promptAction.showToast({
                    message: `读取文件内容 失败  ${error}`
                  })
                }
              })

              Button('position 为undefined ').width(600).onClick(() => {
                try {
                  let res = this.fsManager.readFileSync(this.filePath, 'utf-8', undefined, 10)
                  console.log('[AdvancedAPI] fileSystemManager readFileSync  success ')
                  promptAction.showToast({
                    message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                  })
                } catch (error) {
                  console.error(`[advanceDEMO] 读取文件内容 失败 ` + error)
                  promptAction.showToast({
                    message: `读取文件内容 失败  ${error}`
                  })
                }
              })

              Button('position 为\'\' ').width(600).onClick(() => {
                try {
                  let res = this.fsManager.readFileSync(this.filePath, '', 0, 10)
                  console.log('[AdvancedAPI] fileSystemManager readFileSync  success ')
                  promptAction.showToast({
                    message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                  })
                } catch (error) {
                  console.error(`[advanceDEMO] 读取文件内容 失败 ` + error)
                  promptAction.showToast({
                    message: `读取文件内容 失败  ${error}`
                  })
                }
              })

              Button('position 为\'ab\' ').width(600).onClick(() => {
                try {
                  let res = this.fsManager.readFileSync(this.filePath, 'utf-8', 'ab', 10)
                  console.log('[AdvancedAPI] fileSystemManager readFileSync  success ')
                  promptAction.showToast({
                    message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                  })
                } catch (error) {
                  console.error(`[advanceDEMO] 读取文件内容 失败 ` + error)
                  promptAction.showToast({
                    message: `读取文件内容 失败  ${error}`
                  })
                }
              })

              Button('position 为object ').width(600).onClick(() => {
                try {
                  let res = this.fsManager.readFileSync(this.filePath, 'utf-8', { 'name': 'test' }, 10)
                  console.log('[AdvancedAPI] fileSystemManager readFileSync  success ')
                  promptAction.showToast({
                    message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                  })
                } catch (error) {
                  console.error(`[advanceDEMO] 读取文件内容 失败 ` + error)
                  promptAction.showToast({
                    message: `读取文件内容 失败  ${error}`
                  })
                }
              })

              Button('length 为boolean ').width(600).onClick(() => {
                try {
                  let res = this.fsManager.readFileSync(this.filePath, 'utf-8', 0, true)
                  console.log('[AdvancedAPI] fileSystemManager readFileSync  success ')
                  promptAction.showToast({
                    message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                  })
                } catch (error) {
                  console.error(`[advanceDEMO] 读取文件内容 失败 ` + error)
                  promptAction.showToast({
                    message: `读取文件内容 失败  ${error}`
                  })
                }
              })

              Button('length 为undefined ').width(600).onClick(() => {
                try {
                  let res = this.fsManager.readFileSync(this.filePath, 'utf-8', 0, undefined)
                  console.log('[AdvancedAPI] fileSystemManager readFileSync  success ')
                  promptAction.showToast({
                    message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                  })
                } catch (error) {
                  console.error(`[advanceDEMO] 读取文件内容 失败 ` + error)
                  promptAction.showToast({
                    message: `读取文件内容 失败  ${error}`
                  })
                }
              })

              Button('length 为\'\' ').width(600).onClick(() => {
                try {
                  let res = this.fsManager.readFileSync(this.filePath, 'utf-8', 0, '')
                  console.log('[AdvancedAPI] fileSystemManager readFileSync  success ')
                  promptAction.showToast({
                    message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                  })
                } catch (error) {
                  console.error(`[advanceDEMO] 读取文件内容 失败 ` + error)
                  promptAction.showToast({
                    message: `读取文件内容 失败  ${error}`
                  })
                }
              })

              Button('length 为\'ab\' ').width(600).onClick(() => {
                try {
                  let res = this.fsManager.readFileSync(this.filePath, 'utf-8', 0, 'ab')
                  console.log('[AdvancedAPI] fileSystemManager readFileSync  success ')
                  promptAction.showToast({
                    message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                  })
                } catch (error) {
                  console.error(`[advanceDEMO] 读取文件内容 失败 ` + error)
                  promptAction.showToast({
                    message: `读取文件内容 失败  ${error}`
                  })
                }
              })

              Button('length 为object').width(600).onClick(() => {
                try {
                  let res = this.fsManager.readFileSync(this.filePath, 'utf-8', 0, { 'name': 'test' })
                  console.log('[AdvancedAPI] fileSystemManager readFileSync  success ')
                  promptAction.showToast({
                    message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                  })
                } catch (error) {
                  console.error(`[advanceDEMO] 读取文件内容 失败 ` + error)
                  promptAction.showToast({
                    message: `读取文件内容 失败  ${error}`
                  })
                }
              })

              Button('encoding 为支持的utf-8').width(600).onClick(() => {
                try {
                  let res = this.fsManager.readFileSync(this.filePath, 'utf-8', 0, 10)
                  console.log('[AdvancedAPI] fileSystemManager readFileSync  success ')
                  promptAction.showToast({
                    message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                  })
                } catch (error) {
                  console.error(`[advanceDEMO] 读取文件内容 失败 ` + error)
                  promptAction.showToast({
                    message: `读取文件内容 失败  ${error}`
                  })
                }
              })

              Button('encoding 为支持的utf8').width(600).onClick(() => {
                try {
                  let res = this.fsManager.readFileSync(this.filePath, 'utf8', 0, 10)
                  console.log('[AdvancedAPI] fileSystemManager readFileSync  success ')
                  promptAction.showToast({
                    message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                  })
                } catch (error) {
                  console.error(`[advanceDEMO] 读取文件内容 失败 ` + error)
                  promptAction.showToast({
                    message: `读取文件内容 失败  ${error}`
                  })
                }
              })

              Button('encoding 为合法但暂不支持的binary').width(600).onClick(() => {
                try {
                  let res = this.fsManager.readFileSync(this.filePath, 'binary', 0, 10)
                  console.log('[AdvancedAPI] fileSystemManager readFileSync  success ')
                  promptAction.showToast({
                    message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                  })
                } catch (error) {
                  console.error(`[advanceDEMO] 读取文件内容 失败 ` + error)
                  promptAction.showToast({
                    message: `读取文件内容 失败  ${error}`
                  })
                }
              })

              Button('encoding 为num').width(600).onClick(() => {
                try {
                  let res = this.fsManager.readFileSync(this.filePath, 12, 0, 10)
                  console.log('[AdvancedAPI] fileSystemManager readFileSync  success ')
                  promptAction.showToast({
                    message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                  })
                } catch (error) {
                  console.error(`[advanceDEMO] 读取文件内容 失败 ` + error)
                  promptAction.showToast({
                    message: `读取文件内容 失败  ${error}`
                  })
                }
              })

              Button('encoding 为null').width(600).onClick(() => {
                try {
                  let res = this.fsManager.readFileSync(this.filePath, null, 0, 10)
                  console.log('[AdvancedAPI] fileSystemManager readFileSync  success ')
                  promptAction.showToast({
                    message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                  })
                } catch (error) {
                  console.error(`[advanceDEMO] 读取文件内容 失败 ` + error)
                  promptAction.showToast({
                    message: `读取文件内容 失败  ${error}`
                  })
                }
              })

              Button('encoding 为boolean').width(600).onClick(() => {
                try {
                  let res = this.fsManager.readFileSync(this.filePath, true, 0, 10)
                  console.log('[AdvancedAPI] fileSystemManager readFileSync  success ')
                  promptAction.showToast({
                    message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                  })
                } catch (error) {
                  console.error(`[advanceDEMO] 读取文件内容 失败 ` + error)
                  promptAction.showToast({
                    message: `读取文件内容 失败  ${error}`
                  })
                }
              })

              Button('encoding 为\'ab\'').width(600).onClick(() => {
                try {
                  let res = this.fsManager.readFileSync(this.filePath, 'ab', 0, 10)
                  console.log('[AdvancedAPI] fileSystemManager readFileSync  success ')
                  promptAction.showToast({
                    message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                  })
                } catch (error) {
                  console.error(`[advanceDEMO] 读取文件内容 失败 ` + error)
                  promptAction.showToast({
                    message: `读取文件内容 失败  ${error}`
                  })
                }
              })

              Button('encoding 为object').width(600).onClick(() => {
                try {
                  let res = this.fsManager.readFileSync(this.filePath, { 'name': 'test' }, 0, 10)
                  console.log('[AdvancedAPI] fileSystemManager readFileSync  success ')
                  promptAction.showToast({
                    message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                  })
                } catch (error) {
                  console.error(`[advanceDEMO] 读取文件内容 失败 ` + error)
                  promptAction.showToast({
                    message: `读取文件内容 失败  ${error}`
                  })
                }
              })

              Button('encoding 为\'\'').width(600).onClick(() => {
                try {
                  let res = this.fsManager.readFileSync(this.filePath, '', 0, 10)
                  console.log('[AdvancedAPI] fileSystemManager readFileSync  success ')
                  promptAction.showToast({
                    message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                  })
                } catch (error) {
                  console.error(`[advanceDEMO] 读取文件内容 失败 ` + error)
                  promptAction.showToast({
                    message: `读取文件内容 失败  ${error}`
                  })
                }
              })

              Button('encoding 为undefined').width(600).onClick(() => {
                try {
                  let res = this.fsManager.readFileSync(this.filePath, undefined, 0, 10)
                  console.log('[AdvancedAPI] fileSystemManager readFileSync  success ')
                  promptAction.showToast({
                    message: `读取文件内容  成功 res = ${JSON.stringify(res)}`
                  })
                } catch (error) {
                  console.error(`[advanceDEMO] 读取文件内容 失败 ` + error)
                  promptAction.showToast({
                    message: `读取文件内容 失败  ${error}`
                  })
                }
              })
            }
          }

          // fs.rename
          ListItem() {
            Column({ space: 10 }) {
              Text('fs.rename').fontSize(25)

              Button('先用鸿蒙接口创建文件test.txt，创建目录filesDir下，写入内容hello, world').width(600).onClick(() => {
                let file = fs.openSync(this.filePath, fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE)
                let num = fs.writeSync(file.fd, "hello, world")
                promptAction.showToast({
                  message: `文件内容写入成功，长度：${num},path:${this.filePath}`,
                })
                console.debug('[advanceDEMO] write data to file succeed and size is:' + num + this.filePath)
              })

              Button('1 oldPath不存在 newPath取任意值').width(600).onClick(() => {
                this.fsManager.rename({
                  oldPath:this.context.filesDir+'/oldPathUnexist',
                  newPath:this.filePath,
                  success: (res) => {
                    promptAction.showToast({
                      message: `重命名  成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 重命名 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `重命名 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('2 oldPath为\'\' newPath取任意值').width(600).onClick(() => {
                this.fsManager.rename({
                  oldPath:'',
                  newPath:this.filePath,
                  success: (res) => {
                    promptAction.showToast({
                      message: `重命名  成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 重命名 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `重命名 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('3 oldPath为\'ab\' newPath取任意值').width(600).onClick(() => {
                this.fsManager.rename({
                  oldPath:'ab',
                  newPath:this.filePath,
                  success: (res) => {
                    promptAction.showToast({
                      message: `重命名  成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 重命名 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `重命名 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('4 oldPath为object newPath取任意值').width(600).onClick(() => {
                this.fsManager.rename({
                  oldPath:{'name':'test'},
                  newPath:this.filePath,
                  success: (res) => {
                    promptAction.showToast({
                      message: `重命名  成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 重命名 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `重命名 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('5 oldPath为num newPath取任意值').width(600).onClick(() => {
                this.fsManager.rename({
                  oldPath:12,
                  newPath:this.filePath,
                  success: (res) => {
                    promptAction.showToast({
                      message: `重命名  成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 重命名 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `重命名 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              // 有一点点奇怪 类型居然是object
              Button('6 oldPath为null newPath取任意值').width(600).onClick(() => {
                this.fsManager.rename({
                  oldPath:null,
                  newPath:this.filePath,
                  success: (res) => {
                    promptAction.showToast({
                      message: `重命名  成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 重命名 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `重命名 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('7 oldPath为boolean newPath取任意值').width(600).onClick(() => {
                this.fsManager.rename({
                  oldPath:true,
                  newPath:this.filePath,
                  success: (res) => {
                    promptAction.showToast({
                      message: `重命名  成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 重命名 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `重命名 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('8 oldPath为undefined newPath取任意值').width(600).onClick(() => {
                this.fsManager.rename({
                  oldPath:undefined,
                  newPath:this.filePath,
                  success: (res) => {
                    promptAction.showToast({
                      message: `重命名  成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 重命名 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `重命名 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('1 oldPath存在 newPath不存在').width(600).onClick(() => {
                this.fsManager.rename({
                  oldPath:this.filePath,
                  newPath:this.context.filesDir+'/newPathForRename',
                  success: (res) => {
                    promptAction.showToast({
                      message: `重命名 成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 重命名 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `重命名 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('2 oldPath存在 newPath存在 oldPath===newPath').width(600).onClick(() => {
                this.fsManager.rename({
                  oldPath:this.filePath,
                  newPath:this.filePath,
                  success: (res) => {
                    promptAction.showToast({
                      message: `重命名 成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 重命名 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `重命名 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('3 oldPath存在 newPath存在 oldPath!=newPath 【无效】').width(600).onClick(() => {
                this.fsManager.rename({
                  oldPath:this.filePath,
                  newPath:this.context.filesDir+'/newPathForRename',
                  success: (res) => {
                    promptAction.showToast({
                      message: `重命名 成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 重命名 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `重命名 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('4 oldPath存在 newPath为null【无效】').width(600).onClick(() => {
                this.fsManager.rename({
                  oldPath:this.filePath,
                  newPath:null,
                  success: (res) => {
                    promptAction.showToast({
                      message: `重命名 成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 重命名 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `重命名 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('5 oldPath存在 newPath为num【无效】').width(600).onClick(() => {
                this.fsManager.rename({
                  oldPath:this.filePath,
                  newPath:12,
                  success: (res) => {
                    promptAction.showToast({
                      message: `重命名 成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 重命名 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `重命名 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('6 oldPath存在 newPath为boolean【无效】').width(600).onClick(() => {
                this.fsManager.rename({
                  oldPath:this.filePath,
                  newPath:true,
                  success: (res) => {
                    promptAction.showToast({
                      message: `重命名 成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 重命名 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `重命名 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('7 oldPath存在 newPath为object【无效】').width(600).onClick(() => {
                this.fsManager.rename({
                  oldPath:this.filePath,
                  newPath:{'name':'test'},
                  success: (res) => {
                    promptAction.showToast({
                      message: `重命名 成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 重命名 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `重命名 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('8 oldPath存在 newPath为undefined【无效】').width(600).onClick(() => {
                this.fsManager.rename({
                  oldPath:this.filePath,
                  newPath:undefined,
                  success: (res) => {
                    promptAction.showToast({
                      message: `重命名 成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 重命名 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `重命名 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('9 oldPath存在 newPath为\'\'【无效】').width(600).onClick(() => {
                this.fsManager.rename({
                  oldPath:this.filePath,
                  newPath:``,
                  success: (res) => {
                    promptAction.showToast({
                      message: `重命名 成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 重命名 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `重命名 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('10 oldPath存在 newPath为\'ab\'【无效】').width(600).onClick(() => {
                this.fsManager.rename({
                  oldPath:this.filePath,
                  newPath:'ab',
                  success: (res) => {
                    promptAction.showToast({
                      message: `重命名 成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 重命名 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `重命名 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('11 oldPath存在 newPath的上级目录不存在【无效】').width(600).onClick(() => {
                this.fsManager.rename({
                  oldPath:this.filePath,
                  newPath:this.context.filesDir+'/upDirUnexist/hello.txt',
                  success: (res) => {
                    promptAction.showToast({
                      message: `重命名 成功 res = ${JSON.stringify(res)}`
                    })
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 重命名 失败 ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `重命名 失败 ${JSON.stringify(res)}`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })
            }
          }

          // fs.renameSync
          ListItem() {
            Column({ space: 10 }) {
              Text('fs.renameSync').fontSize(25)

              Button('先用鸿蒙接口创建文件test.txt，创建目录filesDir下，写入内容hello, world').width(600).onClick(() => {
                let file = fs.openSync(this.filePath, fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE)
                let num = fs.writeSync(file.fd, "hello, world")
                promptAction.showToast({
                  message: `文件内容写入成功，长度：${num},path:${this.filePath}`,
                })
                console.debug('[advanceDEMO] write data to file succeed and size is:' + num + this.filePath)
              })

              Button('1 oldPath不存在 newPath取任意值').width(600).onClick(() => {
                try {
                  let res=this.fsManager.renameSync(this.context.filesDir+'/oldPathUnexist',this.filePath)
                  console.log('[AdvancedAPI] fileSystemManager readFileSync  success ' )
                  promptAction.showToast({
                    message: `重命名  成功`
                  })
                } catch (error) {
                  console.error(`[advanceDEMO] 重命名 失败 ${error}`)
                  promptAction.showToast({
                    message: `重命名 失败 ${error}`
                  })
                }
              })

              Button('2 oldPath为\'\' newPath取任意值').width(600).onClick(() => {
                try {
                  let res=this.fsManager.renameSync('',this.filePath)
                  console.log('[AdvancedAPI] fileSystemManager readFileSync  success ' )
                  promptAction.showToast({
                    message: `重命名  成功`
                  })
                } catch (error) {
                  console.error(`[advanceDEMO] 重命名 失败 ${error}`)
                  promptAction.showToast({
                    message: `重命名 失败 ${error}`
                  })
                }
              })

              Button('3 oldPath为\'ab\' newPath取任意值').width(600).onClick(() => {
                try {
                  let res=this.fsManager.renameSync('ab',this.filePath)
                  console.log('[AdvancedAPI] fileSystemManager readFileSync  success ' )
                  promptAction.showToast({
                    message: `重命名  成功`
                  })
                } catch (error) {
                  console.error(`[advanceDEMO] 重命名 失败 ${JSON.stringify(error)}`)
                  promptAction.showToast({
                    message: `重命名 失败 ${error}`
                  })
                }
              })

              Button('4 oldPath为object newPath取任意值').width(600).onClick(() => {
                try {
                  let res=this.fsManager.renameSync({'name':'test'},this.filePath)
                  console.log('[AdvancedAPI] fileSystemManager readFileSync  success ' )
                  promptAction.showToast({
                    message: `重命名  成功`
                  })
                } catch (error) {
                  console.error(`[advanceDEMO] 重命名 失败 ${error}`)
                  promptAction.showToast({
                    message: `重命名 失败 ${error}`
                  })
                }
              })

              Button('5 oldPath为num newPath取任意值').width(600).onClick(() => {
                try {
                  let res=this.fsManager.renameSync(12,this.filePath)
                  console.log('[AdvancedAPI] fileSystemManager readFileSync  success ' )
                  promptAction.showToast({
                    message: `重命名  成功 `
                  })
                } catch (error) {
                  console.error(`[advanceDEMO] 重命名 失败 ${error}`)
                  promptAction.showToast({
                    message: `重命名 失败 ${error}`
                  })
                }
              })

              // 有一点点奇怪 类型居然是object
              Button('6 oldPath为null newPath取任意值').width(600).onClick(() => {
                try {
                  let res=this.fsManager.renameSync(null,this.filePath)
                  console.log('[AdvancedAPI] fileSystemManager readFileSync  success ' )
                  promptAction.showToast({
                    message: `重命名  成功 `
                  })
                } catch (error) {
                  console.error(`[advanceDEMO] 重命名 失败 ${error}`)
                  promptAction.showToast({
                    message: `重命名 失败 ${error}`
                  })
                }
              })

              Button('7 oldPath为boolean newPath取任意值').width(600).onClick(() => {
                try {
                  let res=this.fsManager.renameSync(true,this.filePath)
                  console.log('[AdvancedAPI] fileSystemManager readFileSync  success ' )
                  promptAction.showToast({
                    message: `重命名  成功 `
                  })
                } catch (error) {
                  console.error(`[advanceDEMO] 重命名 失败 ${error}`)
                  promptAction.showToast({
                    message: `重命名 失败 ${error}`
                  })
                }
              })

              Button('8 oldPath为undefined newPath取任意值').width(600).onClick(() => {
                try {
                  let res=this.fsManager.renameSync(undefined,this.filePath)
                  console.log('[AdvancedAPI] fileSystemManager readFileSync  success ' )
                  promptAction.showToast({
                    message: `重命名  成功 `
                  })
                } catch (error) {
                  console.error(`[advanceDEMO] 重命名 失败 ${error}`)
                  promptAction.showToast({
                    message: `重命名 失败 ${error}`
                  })
                }
              })

              Button('1 oldPath存在 newPath不存在').width(600).onClick(() => {
                try {
                  let res=this.fsManager.renameSync(this.filePath,this.context.filesDir+'/newPathForRename')
                  console.log('[AdvancedAPI] fileSystemManager readFileSync  success ' )
                  promptAction.showToast({
                    message: `重命名 成功 `
                  })
                } catch (error) {
                  console.error(`[advanceDEMO] 重命名 失败 ${error}`)
                  promptAction.showToast({
                    message: `重命名 失败 ${error}`
                  })
                }
              })

              Button('2 oldPath存在 newPath存在 oldPath===newPath').width(600).onClick(() => {
                try {
                  let res=this.fsManager.renameSync(this.filePath,this.filePath)
                  console.log('[AdvancedAPI] fileSystemManager readFileSync  success ' )
                  promptAction.showToast({
                    message: `重命名 成功 `
                  })
                } catch (error) {
                  console.error(`[advanceDEMO] 重命名 失败 ${error}`)
                  promptAction.showToast({
                    message: `重命名 失败 ${error}`
                  })
                }
              })

              Button('3 oldPath存在 newPath存在 oldPath!=newPath 【无效】').width(600).onClick(() => {
                try {
                  let res=this.fsManager.renameSync(this.filePath,this.context.filesDir+'/newPathForRename')
                  console.log('[AdvancedAPI] fileSystemManager readFileSync  success ' )
                  promptAction.showToast({
                    message: `重命名 成功 `
                  })
                } catch (error) {
                  console.error(`[advanceDEMO] 重命名 失败 ${error}`)
                  promptAction.showToast({
                    message: `重命名 失败 ${error}`
                  })
                }
              })

              Button('4 oldPath存在 newPath为null【无效】').width(600).onClick(() => {
                try {
                  let res=this.fsManager.renameSync(this.filePath,null)
                  console.log('[AdvancedAPI] fileSystemManager readFileSync  success ' )
                  promptAction.showToast({
                    message: `重命名 成功 `
                  })
                } catch (error) {
                  console.error(`[advanceDEMO] 重命名 失败 ${error}`)
                  promptAction.showToast({
                    message: `重命名 失败 ${error}`
                  })
                }
              })

              Button('5 oldPath存在 newPath为num【无效】').width(600).onClick(() => {
                try {
                  let res=this.fsManager.renameSync(this.filePath,12)
                  console.log('[AdvancedAPI] fileSystemManager readFileSync  success ' )
                  promptAction.showToast({
                    message: `重命名 成功 `
                  })
                } catch (error) {
                  console.error(`[advanceDEMO] 重命名 失败 ${error}`)
                  promptAction.showToast({
                    message: `重命名 失败 ${error}`
                  })
                }
              })

              Button('6 oldPath存在 newPath为boolean【无效】').width(600).onClick(() => {
                try {
                  let res=this.fsManager.renameSync(this.filePath,true)
                  console.log('[AdvancedAPI] fileSystemManager readFileSync  success ' )
                  promptAction.showToast({
                    message: `重命名 成功 `
                  })
                } catch (error) {
                  console.error(`[advanceDEMO] 重命名 失败 ${error}`)
                  promptAction.showToast({
                    message: `重命名 失败 ${error}`
                  })
                }
              })

              Button('7 oldPath存在 newPath为object【无效】').width(600).onClick(() => {
                try {
                  let res=this.fsManager.renameSync(this.filePath,{'name':'test'})
                  console.log('[AdvancedAPI] fileSystemManager readFileSync  success ' )
                  promptAction.showToast({
                    message: `重命名 成功 `
                  })
                } catch (error) {
                  console.error(`[advanceDEMO] 重命名 失败 ${error}`)
                  promptAction.showToast({
                    message: `重命名 失败 ${error}`
                  })
                }
              })

              Button('8 oldPath存在 newPath为undefined【无效】').width(600).onClick(() => {
                try {
                  let res=this.fsManager.renameSync(this.filePath,undefined)
                  console.log('[AdvancedAPI] fileSystemManager readFileSync  success ' )
                  promptAction.showToast({
                    message: `重命名 成功 `
                  })
                } catch (error) {
                  console.error(`[advanceDEMO] 重命名 失败 ${error}`)
                  promptAction.showToast({
                    message: `重命名 失败 ${error}`
                  })
                }
              })

              Button('9 oldPath存在 newPath为\'\'【无效】').width(600).onClick(() => {
                try {
                  let res=this.fsManager.renameSync(this.filePath,'')
                  console.log('[AdvancedAPI] fileSystemManager readFileSync  success ' )
                  promptAction.showToast({
                    message: `重命名 成功 `
                  })
                } catch (error) {
                  console.error(`[advanceDEMO] 重命名 失败 ${error}`)
                  promptAction.showToast({
                    message: `重命名 失败 ${error}`
                  })
                }
              })

              Button('10 oldPath存在 newPath为\'ab\'【无效】').width(600).onClick(() => {
                try {
                  let res=this.fsManager.renameSync(this.filePath,'ab')
                  console.log('[AdvancedAPI] fileSystemManager readFileSync  success ' )
                  promptAction.showToast({
                    message: `重命名 成功 `
                  })
                } catch (error) {
                  console.error(`[advanceDEMO] 重命名 失败 ${error}`)
                  promptAction.showToast({
                    message: `重命名 失败 ${error}`
                  })
                }
              })

              Button('11 oldPath存在 newPath的上级目录不存在【无效】').width(600).onClick(() => {
                try {
                  let res=this.fsManager.renameSync(this.filePath,this.context.filesDir+'/upDirUnexist/hello.txt')
                  console.log('[AdvancedAPI] fileSystemManager readFileSync  success ' )
                  promptAction.showToast({
                    message: `重命名 成功 `
                  })
                } catch (error) {
                  console.error(`[advanceDEMO] 重命名 失败 ${error}`)
                  promptAction.showToast({
                    message: `重命名 失败 ${error}`
                  })
                }
              })

            }
          }

          // fs.rmdir
          ListItem() {
            Column({ space: 10 }) {
              Text('fs.rmdir ').fontSize(25)

              Button('传入的路径不存在').width(600).onClick(() => {
                this.fsManager.rmdir({
                  dirPath: this.context.filesDir+'/testDirForRmdirUnexist',
                  success: (res) => {
                    promptAction.showToast({
                      message: `删除目录 成功 res = ${JSON.stringify(res)}`
                    })
                    console.debug('[advanceDEMO] 删除目录 成功 ' )
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 打开目录 失败 +  ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `删除目录 失败 ${JSON.stringify(res)} }`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('传入的路径为\'ab\'').width(600).onClick(() => {
                this.fsManager.rmdir({
                  dirPath:'ab',
                  recursive:false,
                  success: (res) => {
                    promptAction.showToast({
                      message: `删除目录 成功 res = ${JSON.stringify(res)}`
                    })
                    console.debug('[advanceDEMO] 删除目录 成功 ' )
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 打开目录 失败 +  ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `删除目录 失败 ${JSON.stringify(res)} }`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('传入的路径为\'\'').width(600).onClick(() => {
                this.fsManager.rmdir({
                  dirPath:'',
                  recursive:false,
                  success: (res) => {
                    promptAction.showToast({
                      message: `删除目录 成功 res = ${JSON.stringify(res)}`
                    })
                    console.debug('[advanceDEMO] 删除目录 成功 ' )
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 打开目录 失败 +  ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `删除目录 失败 ${JSON.stringify(res)} }`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('传入的路径为num').width(600).onClick(() => {
                this.fsManager.rmdir({
                  dirPath:12,
                  recursive:false,
                  success: (res) => {
                    promptAction.showToast({
                      message: `删除目录 成功 res = ${JSON.stringify(res)}`
                    })
                    console.debug('[advanceDEMO] 删除目录 成功 ' )
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 打开目录 失败 +  ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `删除目录 失败 ${JSON.stringify(res)} }`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('传入的路径为object').width(600).onClick(() => {
                this.fsManager.rmdir({
                  dirPath:{'name':'test'},
                  recursive:false,
                  success: (res) => {
                    promptAction.showToast({
                      message: `删除目录 成功 res = ${JSON.stringify(res)}`
                    })
                    console.debug('[advanceDEMO] 删除目录 成功 ' )
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 打开目录 失败 +  ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `删除目录 失败 ${JSON.stringify(res)} }`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('传入的路径为null').width(600).onClick(() => {
                this.fsManager.rmdir({
                  dirPath: null,
                  recursive:false,
                  success: (res) => {
                    promptAction.showToast({
                      message: `删除目录 成功 res = ${JSON.stringify(res)}`
                    })
                    console.debug('[advanceDEMO] 删除目录 成功 ' )
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 打开目录 失败 +  ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `删除目录 失败 ${JSON.stringify(res)} }`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('传入的路径为boolean').width(600).onClick(() => {
                this.fsManager.rmdir({
                  dirPath:true,
                  recursive:false,
                  success: (res) => {
                    promptAction.showToast({
                      message: `删除目录 成功 res = ${JSON.stringify(res)}`
                    })
                    console.debug('[advanceDEMO] 删除目录 成功 ' )
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 打开目录 失败 +  ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `删除目录 失败 ${JSON.stringify(res)} }`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('传入的路径为undefined').width(600).onClick(() => {
                this.fsManager.rmdir({
                  dirPath:undefined,
                  recursive:false,
                  success: (res) => {
                    promptAction.showToast({
                      message: `删除目录 成功 res = ${JSON.stringify(res)}`
                    })
                    console.debug('[advanceDEMO] 删除目录 成功 ' )
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 打开目录 失败 +  ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `删除目录 失败 ${JSON.stringify(res)} }`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('为下面的button创建一个文件').width(600).onClick(() => {
                let file = fs.openSync(this.filePath, fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE)
                let num = fs.writeSync(file.fd, "hello, world")
                promptAction.showToast({
                  message: `文件内容写入成功，长度：${num},path:${this.filePath}`,
                })
                console.debug('[advanceDEMO] write data to file succeed and size is:' + num + this.filePath)
              })

              Button('传入的路径为文件路径非目录').width(600).onClick(() => {
                this.fsManager.rmdir({
                  dirPath:this.filePath,
                  recursive:false,
                  success: (res) => {
                    promptAction.showToast({
                      message: `文件 res = ${JSON.stringify(res)}`
                    })
                    console.debug('[advanceDEMO] 删除文件 成功 ' )
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 打开文件 失败 +  ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `删除文件 失败 ${JSON.stringify(res)} }`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              /**
               * mkdirPathText1 = this.context.filesDir+'/files/mkdirtest1.txt' //用于接口mkdir的测试样例1 ，直接给出需要删除的文件
               * mkdirPathText2 = this.context.filesDir+'/files/mkdirtest2' //用于接口mkdir的测试样例2 ，直接给出需要删除的文件,不带后缀
               * mkdirPathFolder1 = this.context.filesDir+'/files'         //用于接口mkdir的测试样例3， 给出包含【多个文件】的文件夹，测试是否可以递归删除
               */
              Button('创建目录1').width(600).onClick(() => {
                try {
                  this.fsManager.mkdirSync(this.context.filesDir+'/files',true)
                  promptAction.showToast({
                    message: `创建目录1成功`
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `创建目录1失败，目录已存在 或其他错误 ${error}`
                  })
                }
              })

              Button('在目录1下创建文件mkdirtest1.txt，写入内容hello, world').width(600).onClick(() => {
                let file = fs.openSync(this.mkdirPathText1, fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE)
                let num = fs.writeSync(file.fd, "hello, world")
                promptAction.showToast({
                  message: `文件内容写入成功，长度：${num},path:${this.mkdirPathText1}`,
                })
                console.debug('[advanceDEMO] write data to file succeed and size is:' + num + this.mkdirPathText1)
              })

              Button('在目录1下创建文件mkdirtest2（不带后缀），写入内容hello, world').width(600).onClick(() => {
                let file = fs.openSync(this.mkdirPathText2, fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE)
                let num = fs.writeSync(file.fd, "hello, world")
                promptAction.showToast({
                  message: `文件内容写入成功，长度：${num},path:${this.mkdirPathText2}`,
                })
                console.debug('[advanceDEMO] write data to file succeed and size is:' + num + this.mkdirPathText2)
              })

              Button('创建目录2').width(600).onClick(() => {
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

              Button('删除目录2 目录下没有文件 recursive为false').width(600).onClick(() => {
                this.fsManager.rmdir({
                  dirPath:this.context.filesDir+'/testMkdir/test1',
                  recursive:false,
                  success: (res) => {
                    promptAction.showToast({
                      message: `删除目录 成功 res = ${JSON.stringify(res)}`
                    })
                    console.debug('[advanceDEMO] 删除目录 成功 ' )
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 打开目录 失败 +  ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `删除目录 失败 ${JSON.stringify(res)} }`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('删除mkdirPathFolder1文件夹 目录下有多个文件 recursive为false').width(600).onClick(() => {
                this.fsManager.rmdir({
                  dirPath: this.mkdirPathFolder1,
                  recursive:false,
                  success: (res) => {
                    promptAction.showToast({
                      message: `删除目录 成功 res = ${JSON.stringify(res)}`
                    })
                    console.debug('[advanceDEMO] 删除目录 成功 ' )
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 打开目录 失败 +  ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `删除目录 失败 ${JSON.stringify(res)} }`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('删除mkdirPathFolder1文件夹 目录下有多个文件 recursive为true').width(600).onClick(() => {
                this.fsManager.rmdir({
                  dirPath: this.mkdirPathFolder1,
                  recursive:true,
                  success: (res) => {
                    promptAction.showToast({
                      message: `删除目录 成功 res = ${JSON.stringify(res)}`
                    })
                    console.debug('[advanceDEMO] 删除目录 成功 ' )
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 打开目录 失败 +  ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `删除目录 失败 ${JSON.stringify(res)} }`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              // 当recursive的值为 'ab' num object 时，recursive的值会被转换成true，从而支持递归删除
              // 因此每执行完一次这类按钮后都需要先创建目录1 然后在目录1下创建文件
              Button('recursive为\'ab\'').width(600).onClick(() => {
                this.fsManager.rmdir({
                  dirPath:this.mkdirPathFolder1,
                  recursive:'ab',
                  success: (res) => {
                    promptAction.showToast({
                      message: `删除目录 成功 res = ${JSON.stringify(res)}`
                    })
                    console.debug('[advanceDEMO] 删除目录 成功 ' )
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 打开目录 失败 +  ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `删除目录 失败 ${JSON.stringify(res)} }`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('recursive为num').width(600).onClick(() => {
                this.fsManager.rmdir({
                  dirPath:this.mkdirPathFolder1,
                  recursive:'ab',
                  success: (res) => {
                    promptAction.showToast({
                      message: `删除目录 成功 res = ${JSON.stringify(res)}`
                    })
                    console.debug('[advanceDEMO] 删除目录 成功 ' )
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 打开目录 失败 +  ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `删除目录 失败 ${JSON.stringify(res)} }`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('recursive为object').width(600).onClick(() => {
                this.fsManager.rmdir({
                  dirPath:this.mkdirPathFolder1,
                  recursive:{'name':'test'},
                  success: (res) => {
                    promptAction.showToast({
                      message: `删除目录 成功 res = ${JSON.stringify(res)}`
                    })
                    console.debug('[advanceDEMO] 删除目录 成功 ' )
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 打开目录 失败 +  ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `删除目录 失败 ${JSON.stringify(res)} }`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              // 当recursive的值为 null undefined '' 时，recursive的值会被转换成false
              // 执行下列按钮之前需要先创建先创建目录1 然后在目录1下创建文件 该流程只需执行一次
              Button('recursive为null').width(600).onClick(() => {
                this.fsManager.rmdir({
                  dirPath:this.mkdirPathFolder1,
                  recursive:null,
                  success: (res) => {
                    promptAction.showToast({
                      message: `删除目录 成功 res = ${JSON.stringify(res)}`
                    })
                    console.debug('[advanceDEMO] 删除目录 成功 ' )
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 打开目录 失败 +  ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `删除目录 失败 ${JSON.stringify(res)} }`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('recursive为undefined').width(600).onClick(() => {
                this.fsManager.rmdir({
                  dirPath:this.mkdirPathFolder1,
                  recursive:undefined,
                  success: (res) => {
                    promptAction.showToast({
                      message: `删除目录 成功 res = ${JSON.stringify(res)}`
                    })
                    console.debug('[advanceDEMO] 删除目录 成功 ' )
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 打开目录 失败 +  ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `删除目录 失败 ${JSON.stringify(res)} }`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('recursive为\'\'').width(600).onClick(() => {
                this.fsManager.rmdir({
                  dirPath:this.mkdirPathFolder1,
                  recursive:'',
                  success: (res) => {
                    promptAction.showToast({
                      message: `删除目录 成功 res = ${JSON.stringify(res)}`
                    })
                    console.debug('[advanceDEMO] 删除目录 成功 ' )
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 打开目录 失败 +  ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `删除目录 失败 ${JSON.stringify(res)} }`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })
            }
          }

          // fs.rmdirSync
          ListItem() {
            Column({ space: 10 }) {
              Text('fs.rmdirSync ').fontSize(25)

              Button('传入的路径不存在').width(600).onClick(() => {
                try {
                  this.fsManager.rmdirSync(this.context.filesDir+'/testDirForRmdirUnexist',false)
                  console.log('[advanceDEMO] 删除目录 成功' )
                  promptAction.showToast({
                    message: `删除目录 成功 `
                  })
                } catch (error) {
                  console.log('删除目录 失败 fail = '+error)
                  promptAction.showToast({
                    message: `删除目录 失败 ${error}`
                  })
                }
              })

              Button('传入的路径为\'ab\'').width(600).onClick(() => {
                try {
                  this.fsManager.rmdirSync('ab',false)
                  console.log('[advanceDEMO] 删除目录 成功' )
                  promptAction.showToast({
                    message: `删除目录 成功 `
                  })
                } catch (error) {
                  console.log('删除目录 失败 fail = '+error)
                  promptAction.showToast({
                    message: `删除目录 失败 ${error}`
                  })
                }
              })

              Button('传入的路径为\'\'').width(600).onClick(() => {
                try {
                  this.fsManager.rmdirSync('',false)
                  console.log('[advanceDEMO] 删除目录 成功' )
                  promptAction.showToast({
                    message: `删除目录 成功 `
                  })
                } catch (error) {
                  console.log('删除目录 失败 fail = '+error)
                  promptAction.showToast({
                    message: `删除目录 失败 ${error}`
                  })
                }
              })

              Button('传入的路径为num').width(600).onClick(() => {
                try {
                  this.fsManager.rmdirSync(12,false)
                  console.log('[advanceDEMO] 删除目录 成功' )
                  promptAction.showToast({
                    message: `删除目录 成功 `
                  })
                } catch (error) {
                  console.log('删除目录 失败 fail = '+error)
                  promptAction.showToast({
                    message: `删除目录 失败 ${error}`
                  })
                }
              })

              Button('传入的路径为object').width(600).onClick(() => {
                try {
                  this.fsManager.rmdirSync({'name':'test'},false)
                  console.log('[advanceDEMO] 删除目录 成功' )
                  promptAction.showToast({
                    message: `删除目录 成功 `
                  })
                } catch (error) {
                  console.log('删除目录 失败 fail = '+error)
                  promptAction.showToast({
                    message: `删除目录 失败 ${error}`
                  })
                }
              })

              Button('传入的路径为null').width(600).onClick(() => {
                try {
                  this.fsManager.rmdirSync(null,false)
                  console.log('[advanceDEMO] 删除目录 成功' )
                  promptAction.showToast({
                    message: `删除目录 成功 `
                  })
                } catch (error) {
                  console.log('删除目录 失败 fail = '+error)
                  promptAction.showToast({
                    message: `删除目录 失败 ${error}`
                  })
                }
              })

              Button('传入的路径为boolean').width(600).onClick(() => {
                try {
                  this.fsManager.rmdirSync(true,false)
                  console.log('[advanceDEMO] 删除目录 成功' )
                  promptAction.showToast({
                    message: `删除目录 成功 `
                  })
                } catch (error) {
                  console.log('删除目录 失败 fail = '+error)
                  promptAction.showToast({
                    message: `删除目录 失败 ${error}`
                  })
                }
              })

              Button('传入的路径为undefined').width(600).onClick(() => {
                try {
                  this.fsManager.rmdirSync(undefined,false)
                  console.log('[advanceDEMO] 删除目录 成功' )
                  promptAction.showToast({
                    message: `删除目录 成功 `
                  })
                } catch (error) {
                  console.log('删除目录 失败 fail = '+error)
                  promptAction.showToast({
                    message: `删除目录 失败 ${error}`
                  })
                }
              })

              Button('为下面的button创建一个文件').width(600).onClick(() => {
                let file = fs.openSync(this.filePath, fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE)
                let num = fs.writeSync(file.fd, "hello, world")
                promptAction.showToast({
                  message: `文件内容写入成功，长度：${num},path:${this.filePath}`,
                })
                console.debug('[advanceDEMO] write data to file succeed and size is:' + num + this.filePath)
              })

              Button('传入的路径为文件路径非目录').width(600).onClick(() => {
                this.fsManager.rmdir({
                  dirPath:this.filePath,
                  recursive:false,
                  success: (res) => {
                    promptAction.showToast({
                      message: `文件 res = ${JSON.stringify(res)}`
                    })
                    console.debug('[advanceDEMO] 删除文件 成功 ' )
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 打开文件 失败 +  ${JSON.stringify(res)}`)
                    promptAction.showToast({
                      message: `删除文件 失败 ${JSON.stringify(res)} }`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              /**
               * mkdirPathText1 = this.context.filesDir+'/files/mkdirtest1.txt' //用于接口mkdir的测试样例1 ，直接给出需要删除的文件
               * mkdirPathText2 = this.context.filesDir+'/files/mkdirtest2' //用于接口mkdir的测试样例2 ，直接给出需要删除的文件,不带后缀
               * mkdirPathFolder1 = this.context.filesDir+'/files'         //用于接口mkdir的测试样例3， 给出包含【多个文件】的文件夹，测试是否可以递归删除
               */
              Button('创建目录1').width(600).onClick(() => {
                try {
                  this.fsManager.mkdirSync(this.context.filesDir+'/files',true)
                  promptAction.showToast({
                    message: `创建目录1成功`
                  })
                } catch (error) {
                  promptAction.showToast({
                    message: `创建目录1失败，目录已存在 或其他错误 ${error}`
                  })
                }
              })

              Button('在目录1下创建文件mkdirtest1.txt，写入内容hello, world').width(600).onClick(() => {
                let file = fs.openSync(this.mkdirPathText1, fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE)
                let num = fs.writeSync(file.fd, "hello, world")
                promptAction.showToast({
                  message: `文件内容写入成功，长度：${num},path:${this.mkdirPathText1}`,
                })
                console.debug('[advanceDEMO] write data to file succeed and size is:' + num + this.mkdirPathText1)
              })

              Button('在目录1下创建文件mkdirtest2（不带后缀），写入内容hello, world').width(600).onClick(() => {
                let file = fs.openSync(this.mkdirPathText2, fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE)
                let num = fs.writeSync(file.fd, "hello, world")
                promptAction.showToast({
                  message: `文件内容写入成功，长度：${num},path:${this.mkdirPathText2}`,
                })
                console.debug('[advanceDEMO] write data to file succeed and size is:' + num + this.mkdirPathText2)
              })

              Button('创建目录2').width(600).onClick(() => {
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

              Button('删除目录2 目录下没有文件 recursive为false').width(600).onClick(() => {
                this.fsManager.rmdir({
                  dirPath:this.context.filesDir+'/testMkdir/test1',
                  recursive:false,
                  success: (res) => {
                    promptAction.showToast({
                      message: `文件 res = ${JSON.stringify(res)}`
                    })
                    console.debug('[advanceDEMO] 删除文件 成功 ' + this.mkdirPathFolder1)
                  },
                  fail: (res) => {
                    console.error(`[advanceDEMO] 删除文件 失败 +  ${JSON.stringify(res)}` + this.mkdirPathFolder1)
                    promptAction.showToast({
                      message: `删除文件 失败 ${JSON.stringify(res)} }`
                    })
                  },
                  complete: (res) => {
                    console.log(`[advanceDEMO] close complete res = ${JSON.stringify(res)}`)
                  }
                })
              })

              Button('删除mkdirPathFolder1文件夹 目录下有多个文件 recursive为false').width(600).onClick(() => {
                try {
                  this.fsManager.rmdirSync(this.mkdirPathFolder1,false)
                  console.log('[advanceDEMO] 删除目录 成功' )
                  promptAction.showToast({
                    message: `删除目录 成功 `
                  })
                } catch (error) {
                  console.log('删除目录 失败 fail = '+error)
                  promptAction.showToast({
                    message: `删除目录 失败 ${error}`
                  })
                }
              })

              Button('删除mkdirPathFolder1文件夹 目录下有多个文件 recursive为true').width(600).onClick(() => {
                try {
                  this.fsManager.rmdirSync(this.mkdirPathFolder1,true)
                  console.log('[advanceDEMO] 删除目录 成功' )
                  promptAction.showToast({
                    message: `删除目录 成功 `
                  })
                } catch (error) {
                  console.log('删除目录 失败 fail = '+error)
                  promptAction.showToast({
                    message: `删除目录 失败 ${error}`
                  })
                }
              })

              // 当recursive的值为 'ab' num object 时，recursive的值会被转换成true，从而支持递归删除
              // 因此每执行完一次这类按钮后都需要先创建目录1 然后在目录1下创建文件
              Button('recursive为\'ab\'').width(600).onClick(() => {
                try {
                  this.fsManager.rmdirSync(this.mkdirPathFolder1,true)
                  console.log('[advanceDEMO] 删除目录 成功' )
                  promptAction.showToast({
                    message: `删除目录 成功 `
                  })
                } catch (error) {
                  console.log('删除目录 失败 fail = '+error)
                  promptAction.showToast({
                    message: `删除目录 失败 ${error}`
                  })
                }
              })

              Button('recursive为num').width(600).onClick(() => {
                try {
                  this.fsManager.rmdirSync(this.mkdirPathFolder1,'ab')
                  console.log('[advanceDEMO] 删除目录 成功' )
                  promptAction.showToast({
                    message: `删除目录 成功 `
                  })
                } catch (error) {
                  console.log('删除目录 失败 fail = '+error)
                  promptAction.showToast({
                    message: `删除目录 失败 ${error}`
                  })
                }
              })

              Button('recursive为object').width(600).onClick(() => {
                try {
                  this.fsManager.rmdirSync(this.mkdirPathFolder1,{'name':'test'})
                  console.log('[advanceDEMO] 删除目录 成功' )
                  promptAction.showToast({
                    message: `删除目录 成功 `
                  })
                } catch (error) {
                  console.log('删除目录 失败 fail = '+error)
                  promptAction.showToast({
                    message: `删除目录 失败 ${error}`
                  })
                }
              })

              // 当recursive的值为 null undefined '' 时，recursive的值会被转换成false
              // 执行下列按钮之前需要先创建先创建目录1 然后在目录1下创建文件 该流程只需执行一次
              Button('recursive为null').width(600).onClick(() => {
                try {
                  this.fsManager.rmdirSync(this.mkdirPathFolder1,null)
                  console.log('[advanceDEMO] 删除目录 成功' )
                  promptAction.showToast({
                    message: `删除目录 成功 `
                  })
                } catch (error) {
                  console.log('删除目录 失败 fail = '+error)
                  promptAction.showToast({
                    message: `删除目录 失败 ${error}`
                  })
                }
              })

              Button('recursive为undefined').width(600).onClick(() => {
                try {
                  this.fsManager.rmdirSync(this.mkdirPathFolder1,undefined)
                  console.log('[advanceDEMO] 删除目录 成功' )
                  promptAction.showToast({
                    message: `删除目录 成功 `
                  })
                } catch (error) {
                  console.log('删除目录 失败 fail = '+error)
                  promptAction.showToast({
                    message: `删除目录 失败 ${error}`
                  })
                }
              })

              Button('recursive为\'\'').width(600).onClick(() => {
                try {
                  this.fsManager.rmdirSync(this.mkdirPathFolder1,'')
                  console.log('[advanceDEMO] 删除目录 成功' )
                  promptAction.showToast({
                    message: `删除目录 成功 `
                  })
                } catch (error) {
                  console.log('删除目录 失败 fail = '+error)
                  promptAction.showToast({
                    message: `删除目录 失败 ${error}`
                  })
                }
              })
            }
          }

          // fs.truncate
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

              Button('再截取文件 路径存在').width(600).onClick(() => {
                this.fsManager.truncate({
                  filePath:this.filePath,
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
              Button('截取文件 filePath为null【无效】').width(600).onClick(() => {
                this.fsManager.truncate({
                  filePath: null,
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

              Button('截取文件 filePath为\'\'【无效】').width(600).onClick(() => {
                this.fsManager.truncate({
                  filePath:``,
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

              Button('截取文件 filePath为boolean【无效】').width(600).onClick(() => {
                this.fsManager.truncate({
                  filePath: true,
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

              Button('截取文件 filePath为object【无效】').width(600).onClick(() => {
                this.fsManager.truncate({
                  filePath: {'name':'test'},
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

              Button('截取文件 filePath为undefined【无效】').width(600).onClick(() => {
                this.fsManager.truncate({
                  filePath:undefined,
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

              Button('截取文件 filePath为\'ab\'【无效】').width(600).onClick(() => {
                this.fsManager.truncate({
                  filePath: 'ab',
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
                this.fsManager.truncate({
                  filePath: this.filePath,
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
                this.fsManager.truncate({
                  filePath:this.filePath,
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
                this.fsManager.truncate({
                  filePath:this.filePath,
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
                this.fsManager.truncate({
                  filePath:this.filePath,
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
                this.fsManager.truncate({
                  filePath:this.filePath,
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
                this.fsManager.truncate({
                  filePath:this.filePath,
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
                this.fsManager.truncate({
                  filePath:this.filePath,
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
                this.fsManager.truncate({
                  filePath:this.filePath,
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

          // fs.truncateSync
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
                  let res=this.fsManager.truncateSync({filePath:this.filePath,length:10}) //
                  console.debug(`
                      [advanceDEMO] 鸿蒙截取文件 成功
                    `)
                  promptAction.showToast({
                    message: `鸿蒙截取文件 成功`
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

              // fd的值为null num等非string的情况 属于同一类错误
              Button('截取文件 filePath为null【无效】').width(600).onClick(() => {
                try {
                  let res=this.fsManager.truncateSync({filePath:null,length:10}) //
                  console.debug(`
                      [advanceDEMO] 鸿蒙截取文件 成功
                    `)
                  promptAction.showToast({
                    message: `鸿蒙截取文件 成功`
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

              Button('截取文件 filePath为\'\'【无效】').width(600).onClick(() => {
                try {
                  let res=this.fsManager.truncateSync({filePath:'',length:10}) //
                  console.debug(`
                      [advanceDEMO] 鸿蒙截取文件 成功
                    `)
                  promptAction.showToast({
                    message: `鸿蒙截取文件 成功 `
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

              Button('截取文件 filePath为boolean【无效】').width(600).onClick(() => {
                try {
                  let res=this.fsManager.truncateSync({filePath:true,length:10}) //
                  console.debug(`
                      [advanceDEMO] 鸿蒙截取文件 成功
                    `)
                  promptAction.showToast({
                    message: `鸿蒙截取文件 成功  `
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

              Button('截取文件 filePath为object【无效】').width(600).onClick(() => {
                try {
                  let res=this.fsManager.truncateSync({filePath:{'name':'test'},length:10}) //
                  console.debug(`
                      [advanceDEMO] 鸿蒙截取文件 成功
                    `)
                  promptAction.showToast({
                    message: `鸿蒙截取文件 成功`
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

              Button('截取文件 filePath为undefined【无效】').width(600).onClick(() => {
                try {
                  let res=this.fsManager.truncateSync({filePath:undefined,length:10}) //
                  console.debug(`
                      [advanceDEMO] 鸿蒙截取文件 成功
                    `)
                  promptAction.showToast({
                    message: `鸿蒙截取文件 成功`
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

              Button('截取文件 filePath为\'ab\'【无效】').width(600).onClick(() => {
                try {
                  let res=this.fsManager.truncateSync({filePath:'ab',length:10}) //
                  console.debug(`
                      [advanceDEMO] 鸿蒙截取文件 成功
                    `)
                  promptAction.showToast({
                    message: `鸿蒙截取文件 成功`
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
                  let res=this.fsManager.truncateSync({filePath:this.filePath,length:-10}) //
                  console.debug(`
                      [advanceDEMO] 鸿蒙截取文件 成功
                    `)
                  promptAction.showToast({
                    message: `鸿蒙截取文件 成功`
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
                  let res=this.fsManager.truncateSync({filePath:this.filePath,length:50}) //
                  console.debug(`
                      [advanceDEMO] 鸿蒙截取文件 成功
                    `)
                  promptAction.showToast({
                    message: `鸿蒙截取文件 成功`
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
                  let res=this.fsManager.truncateSync({filePath:this.filePath,length:true}) //
                  console.debug(`
                      [advanceDEMO] 鸿蒙截取文件 成功
                    `)
                  promptAction.showToast({
                    message: `鸿蒙截取文件 成功`
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
                  let res=this.fsManager.truncateSync({filePath:this.filePath,length:{'name':'test'}}) //
                  console.debug(`
                      [advanceDEMO] 鸿蒙截取文件 成功
                    `)
                  promptAction.showToast({
                    message: `鸿蒙截取文件 成功`
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
                  let res=this.fsManager.truncateSync({filePath:this.filePath,length:null}) //
                  console.debug(`
                      [advanceDEMO] 鸿蒙截取文件 成功
                    `)
                  promptAction.showToast({
                    message: `鸿蒙截取文件 成功`
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
                  let res=this.fsManager.truncateSync({filePath:this.filePath,length:'ab'}) //
                  console.debug(`
                      [advanceDEMO] 鸿蒙截取文件 成功
                    `)
                  promptAction.showToast({
                    message: `鸿蒙截取文件 成功`
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
                  let res=this.fsManager.truncateSync({filePath:this.filePath,length:''}) //
                  console.debug(`
                      [advanceDEMO] 鸿蒙截取文件 成功
                    `)
                  promptAction.showToast({
                    message: `鸿蒙截取文件 成功`
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
                  let res=this.fsManager.truncateSync({filePath:this.filePath,length:undefined}) //
                  console.debug(`
                      [advanceDEMO] 鸿蒙截取文件 成功
                    `)
                  promptAction.showToast({
                    message: `鸿蒙截取文件 成功`
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

        }.alignListItem(ListItemAlign.Center) // 每行之间的分界线
      }
    }
  }
}