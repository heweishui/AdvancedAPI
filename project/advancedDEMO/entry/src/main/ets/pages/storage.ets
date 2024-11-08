import fileio from '@ohos.fileio'
import common from '@ohos.app.ability.common';
import promptAction from '@ohos.promptAction'
@Entry
@Component
struct storage {
  aboutToAppear() {

  }
  build() {
    Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center })  {
      Column({ space: 20 }) {
        List({ space: 20, initialIndex: 0 }) {
          ListItem() {
            Text("数据存储").fontSize(15)
          }
          ListItem() {
            Text("Normal").fontSize(25)
          }
          ListItem() {
            Button("读取文件").width(300).onClick(()=>{
              const context = getContext(this) as common.UIAbilityContext
              const str = fileio.readTextSync(context.filesDir+'/storageData.json')
            })
          }
          ListItem() {
            Button("as.setStorage").width(300).onClick(()=>{
              // @ts-ignore
              as.setStorage({
                key: 'storage_key',
                data: 'hello',
                success: function () {
                  console.log('TestCase set success');
                }
              })
            })
          }
          ListItem() {
            Button("as.setStorageSync").width(300).onClick(()=>{
              try {
                // @ts-ignore
                as.setStorageSync('storage_key', 'hello Sync 123')
              } catch (e) {
                // error
                console.log('TestCase setStorageSync : ' + e);
              }
            })
          }
          ListItem() {
            Button("as.getStorage").width(300).onClick(()=>{
              // @ts-ignore
              as.getStorage({
                key: 'storage_key',
                success: function (data) {
                  promptAction.showToast({
                    message:'getStorage value is: ' + JSON.stringify(data),
                    duration: 2000,
                  });
                }
              })
            })
          }
          ListItem() {
            Button("as.getStorageSync").width(300).onClick(()=>{
              // @ts-ignore
              try {
                // @ts-ignore
                as.setStorageSync('key_sync', 'hello Sync 321')
                // @ts-ignore
                const value = as.getStorageSync('key_sync')
                promptAction.showToast({
                  message:'getStorageSync value is: ' + value,
                  duration: 2000,
                });
              } catch (err) {
                console.log('TestCase err = '+JSON.stringify(err))
              }
            })
          }
          ListItem() {
            Button("as.getStorageInfo").width(300).onClick(()=>{
              // @ts-ignore
              as.getStorageInfo({
                success: function (res) {
                  console.log('TestCase getInfo : ' + JSON.stringify(res.keys));
                  console.log('TestCase getInfo : ' + res.currentSize);
                  console.log('TestCase getInfo : ' + res.limitSize);
                  promptAction.showToast({
                    message:'getStorageInfo value is: ' + JSON.stringify(res.keys) + ' cur size: ' + res.currentSize +
                    ' limit size: ' + res.limitSize,
                    duration: 2000,
                  });
                }
              })
            })
          }
          ListItem() {
            Button("as.getStorageInfoSync").width(300).onClick(()=>{
              // @ts-ignore
              try {
                // @ts-ignore
                const res = as.getStorageInfoSync();
                console.log('TestCase' + JSON.stringify(res.keys));
                console.log('TestCase' + res.currentSize);
                console.log('TestCase' + res.limitSize);
                promptAction.showToast({
                  message:'getStorageInfoSync value is: ' + JSON.stringify(res.keys) + ' cur size: ' + res.currentSize +
                  ' limit size: ' + res.limitSize,
                  duration: 2000,
                });
              } catch (e) {
                // error
                console.log('TestCase Storage info sync exception: ' + e);
              }
            })
          }
          ListItem() {
            Button("as.removeStorage").width(300).onClick(()=>{
              // @ts-ignore
              as.removeStorage({
                key: 'storage_key',
                success: function (res) {
                  console.log('TestCase removeStorage success');
                }
              })
            })
          }
          ListItem() {
            Button("as.removeStorageSync").width(300).onClick(()=>{
              try {
                // @ts-ignore
                as.removeStorageSync('storage_key');
              } catch (e) {
                // error
              }
            })
          }
          ListItem() {
            Button("as.clearStorage").width(300).onClick(()=>{
              // @ts-ignore
              as.clearStorage();
            })
          }
          ListItem() {
            Button("as.clearStorageSync").width(300).onClick(()=>{
              try {
                // @ts-ignore
                as.clearStorageSync();
              } catch (e) {
                // error
              }
            })
          }
          ListItem() {
            Button("setStorage value is number").width(300).onClick(() => {
              // @ts-ignore
              as.setStorage({
                key: 'storage_key',
                data: 123,
                success: function () {
                  promptAction.showToast({
                    message:'setStorage value is number: success ',
                    duration: 2000,
                  });
                },
                fail: function (data) {
                  promptAction.showToast({
                    message:'setStorage value is number: fail ' + JSON.stringify(data),
                    duration: 2000,
                  });
                }
              })
            })
          }
          ListItem() {
            Button("setStorage value is object").width(300).onClick(() => {
              // @ts-ignore
              as.setStorage({
                key: 'storage_key',
                data: { test: '123'},
                success: function () {
                  promptAction.showToast({
                    message:'setStorage value is object: success ',
                    duration: 2000,
                  });
                },
                fail: function (data) {
                  promptAction.showToast({
                    message:'setStorage value is object: fail ' + JSON.stringify(data),
                    duration: 2000,
                  });
                }
              })
            })
          }
          ListItem() {
            Text("Exceptions").fontSize(25).textAlign(TextAlign.Start)
          }
          ListItem() {
            Button("setStorage key is number").width(300).onClick(() => {
              // @ts-ignore
              as.setStorage({
                key: 123,
                data: 'hello',
                success: function () {
                  console.log('TestCase set success');
                },
                fail: function (data) {
                  promptAction.showToast({
                    message:'setStorage key is number: fail ' + JSON.stringify(data),
                    duration: 2000,
                  });
                }
              })
            }).backgroundColor(Color.Orange)
          }
          ListItem() {
            Button("setStorage key is object").width(300).onClick(() => {
              // @ts-ignore
              as.setStorage({
                key: { test: '123'},
                data: 'hello',
                success: function () {
                  console.log('TestCase set success');
                },
                fail: function (data) {
                  promptAction.showToast({
                    message:'setStorage key is object: fail ' + JSON.stringify(data),
                    duration: 2000,
                  });
                }
              })
            }).backgroundColor(Color.Orange)
          }
          ListItem() {
            Button("setStorage key is null").width(300).onClick(() => {
              // @ts-ignore
              as.setStorage({
                key: null,
                data: 'hello',
                success: function () {
                  console.log('TestCase set success');
                },
                fail: function (data) {
                  promptAction.showToast({
                    message:'setStorage key is null: fail ' + JSON.stringify(data),
                    duration: 2000,
                  });
                }
              })
            }).backgroundColor(Color.Orange)
          }
          ListItem() {
            Button("setStorage value is null").width(300).onClick(() => {
              // @ts-ignore
              as.setStorage({
                key: 'storage_key',
                data: null,
                success: function () {
                  console.log('TestCase set success');
                },
                fail: function (data) {
                  promptAction.showToast({
                    message:'setStorage value is null: fail ' + JSON.stringify(data),
                    duration: 2000,
                  });
                }
              })
            }).backgroundColor(Color.Orange)
          }
          ListItem() {
            Button("setStorage key is undefined").width(300).onClick(() => {
              // @ts-ignore
              as.setStorage({
                key: undefined,
                data: 'hello',
                success: function () {
                  console.log('TestCase set success');
                },
                fail: function (data) {
                  promptAction.showToast({
                    message:'setStorage key is undefined: fail ' + JSON.stringify(data),
                    duration: 2000,
                  });
                }
              })
            }).backgroundColor(Color.Orange)
          }
          ListItem() {
            Button("setStorage value is undefined").width(300).onClick(() => {
              // @ts-ignore
              as.setStorage({
                key: 'storage_key',
                data: undefined,
                success: function () {
                  console.log('TestCase set success');
                },
                fail: function (data) {
                  promptAction.showToast({
                    message:'setStorage value is undefined: fail ' + JSON.stringify(data),
                    duration: 2000,
                  });
                }
              })
            }).backgroundColor(Color.Orange)
          }
          ListItem() {
            Button("getStorage key is object").width(300).onClick(() => {
              // @ts-ignore
              as.getStorage({
                key: { test: 123},
                success: function (data) {
                  console.log('TestCase getStorage : ' + JSON.stringify(data));
                },
                fail: function (data) {
                  promptAction.showToast({
                    message:'getStorage key is object: fail ' + JSON.stringify(data),
                    duration: 2000,
                  });
                }
              })
            }).backgroundColor(Color.Orange)
          }
          ListItem() {
            Button("getStorage key is null").width(300).onClick(() => {
              // @ts-ignore
              as.getStorage({
                key: null,
                success: function (data) {
                  console.log('TestCase getStorage : ' + JSON.stringify(data));
                },
                fail: function (data) {
                  promptAction.showToast({
                    message:'getStorage key is null: fail ' + JSON.stringify(data),
                    duration: 2000,
                  });
                }
              })
            }).backgroundColor(Color.Orange)
          }
          ListItem() {
            Button("getStorage key is number").width(300).onClick(() => {
              // @ts-ignore
              as.getStorage({
                key: 123,
                success: function (data) {
                  console.log('TestCase getStorage : ' + JSON.stringify(data));
                },
                fail: function (data) {
                  promptAction.showToast({
                    message:'getStorage key is number: fail ' + JSON.stringify(data),
                    duration: 2000,
                  });
                }
              })
            }).backgroundColor(Color.Orange)
          }
          ListItem() {
            Button("getStorage key is undefined").width(300).onClick(() => {
              // @ts-ignore
              as.getStorage({
                key: undefined,
                success: function (data) {
                  console.log('TestCase getStorage : ' + JSON.stringify(data));
                },
                fail: function (data) {
                  promptAction.showToast({
                    message:'getStorage key is undefined: fail ' + JSON.stringify(data),
                    duration: 2000,
                  });
                }
              })
            }).backgroundColor(Color.Orange)
          }
          ListItem() {
            Button("removeStorage key is number").width(300).onClick(() => {
              // @ts-ignore
              as.getStorage({
                key: 123,
                success: function (data) {
                  console.log('removeStorage key is number: success');
                },
                fail: function (data) {
                  promptAction.showToast({
                    message:'removeStorage key is number: fail ' + JSON.stringify(data),
                    duration: 2000,
                  });
                }
              })
            }).backgroundColor(Color.Orange)
          }
          ListItem() {
            Button("removeStorage key is null").width(300).onClick(() => {
              // @ts-ignore
              as.getStorage({
                key: null,
                success: function (data) {
                  console.log('removeStorage key is null: success');
                },
                fail: function (data) {
                  promptAction.showToast({
                    message:'removeStorage key is null: fail ' + JSON.stringify(data),
                    duration: 2000,
                  });
                }
              })
            }).backgroundColor(Color.Orange)
          }
          ListItem() {
            Button("removeStorage key is undefined").width(300).onClick(() => {
              // @ts-ignore
              as.getStorage({
                key: undefined,
                success: function (data) {
                  console.log('removeStorage key is undefined: success');
                },
                fail: function (data) {
                  promptAction.showToast({
                    message:'removeStorage key is undefined: fail ' + JSON.stringify(data),
                    duration: 2000,
                  });
                }
              })
            }).backgroundColor(Color.Orange)
          }
          ListItem() {
            Button("removeStorage key is object").width(300).onClick(() => {
              // @ts-ignore
              as.getStorage({
                key: { test: 123 },
                success: function (data) {
                  console.log('removeStorage key is object: success');
                },
                fail: function (data) {
                  promptAction.showToast({
                    message:'removeStorage key is object: fail ' + JSON.stringify(data),
                    duration: 2000,
                  });
                }
              })
            }).backgroundColor(Color.Orange)
          }
        }.listDirection(Axis.Vertical) // 排列方向
        .divider({ strokeWidth: 2, color: 0xFFFFFF, startMargin: 20, endMargin: 20 }) // 每行之间的分界线
        .alignListItem(ListItemAlign.Center)
      }
    }
  }
}