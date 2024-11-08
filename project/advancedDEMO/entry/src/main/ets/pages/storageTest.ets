import fileio from '@ohos.fileio'
import common from '@ohos.app.ability.common';
import promptAction from '@ohos.promptAction'
@Entry
@Component
struct storageTest {
  aboutToAppear() {

  }
  build() {
    Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center })  {
      Column({ space: 20 }) {
        List({ space: 20, initialIndex: 0 }) {
          ListItem() {
            Text("数据存储").fontSize(35)
          }
          //setStorage -key
          ListItem(){
            Column({ space: 10 }) {
              Text("setStorage").fontSize(20).fontWeight(FontWeight.Bold)
              Button("key 正常传参 String").width(300).onClick(() => {
                // @ts-ignore
                as.setStorage({
                  key: 'hello',
                  data: 'world',
                  success: (res) => {
                    console.log('[AdvancedAPI] Storage setStorage key  success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] Storage setStorage key  fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] Storage setStorage key  complete ' + JSON.stringify(res));
                  }
                })
              })

              Button("key 无此参数").width(300).onClick(() => {
                // @ts-ignore
                as.setStorage({
                  data: 'hello',
                  success: (res) => {
                    console.log('[AdvancedAPI] Storage setStorage key  success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] Storage setStorage key  fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] Storage setStorage key  complete ' + JSON.stringify(res));
                  }
                })
              })

              Button("key Number").width(300).onClick(() => {
                // @ts-ignore
                as.setStorage({
                  key: 77777,
                  data: 'hello',
                  success: (res) => {
                    console.log('[AdvancedAPI] Storage setStorage key  success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] Storage setStorage key  fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] Storage setStorage key  complete ' + JSON.stringify(res));
                  }
                })
              })

              Button("key Object").width(300).onClick(() => {
                // @ts-ignore
                as.setStorage({
                  key: {'name': 'ws://websocket-echo.com' },
                  data: 'hello',
                  success: (res) => {
                    console.log('[AdvancedAPI] Storage setStorage key  success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] Storage setStorage key  fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] Storage setStorage key  complete ' + JSON.stringify(res));
                  }
                })
              })

              Button("key Boolean").width(300).onClick(() => {
                // @ts-ignore
                as.setStorage({
                  key: true,
                  data: 'hello',
                  success: (res) => {
                    console.log('[AdvancedAPI] Storage setStorage key  success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] Storage setStorage key  fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] Storage setStorage key  complete ' + JSON.stringify(res));
                  }
                })
              })

              Button("key null").width(300).onClick(() => {
                // @ts-ignore
                as.setStorage({
                  key: null,
                  data: 'hello',
                  success: (res) => {
                    console.log('[AdvancedAPI] Storage setStorage key  success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] Storage setStorage key  fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] Storage setStorage key  complete ' + JSON.stringify(res));
                  }
                })
              })

              Button("key 空字符").width(300).onClick(() => {
                // @ts-ignore
                as.setStorage({
                  key: '',
                  data: 'hello',
                  success: (res) => {
                    console.log('[AdvancedAPI] Storage setStorage key  success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] Storage setStorage key  fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] Storage setStorage key  complete ' + JSON.stringify(res));
                  }
                })
              })

              Button("key undefined").width(300).onClick(() => {
                // @ts-ignore
                as.setStorage({
                  key: undefined,
                  data: 'hello',
                  success: (res) => {
                    console.log('[AdvancedAPI] Storage setStorage key  success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] Storage setStorage key  fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] Storage setStorage key  complete ' + JSON.stringify(res));
                  }
                })
              })
            }
          }
          //setStorage -data
          ListItem(){
            Column({ space: 10 }) {
              Button("data 正常传参 String").width(300).onClick(() => {
                // @ts-ignore
                as.setStorage({
                  data: 'world',
                  key: 'hello',
                  success: (res) => {
                    console.log('[AdvancedAPI] Storage setStorage data  success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] Storage setStorage data  fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] Storage setStorage data  complete ' + JSON.stringify(res));
                  }
                })
              })

              Button("data 无此参数").width(300).onClick(() => {
                // @ts-ignore
                as.setStorage({
                  key: 'hello',
                  success: (res) => {
                    console.log('[AdvancedAPI] Storage setStorage data 1 success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] Storage setStorage data 1 fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] Storage setStorage data 1 complete ' + JSON.stringify(res));
                  }
                })
              })

              Button("data Number").width(300).onClick(() => {
                // @ts-ignore
                as.setStorage({
                  data: 77777,
                  key: 'hello',
                  success: (res) => {
                    console.log('[AdvancedAPI] Storage setStorage data 2 success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] Storage setStorage data 2 fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] Storage setStorage data 2 complete ' + JSON.stringify(res));
                  }
                })
              })

              Button("data Object").width(300).onClick(() => {
                // @ts-ignore
                as.setStorage({
                  data: {'name': 'ws://websocket-echo.com' },
                  key: 'hello',
                  success: (res) => {
                    console.log('[AdvancedAPI] Storage setStorage data 3 success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] Storage setStorage data 3 fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] Storage setStorage data 3 complete ' + JSON.stringify(res));
                  }
                })
              })

              Button("data Boolean").width(300).onClick(() => {
                // @ts-ignore
                as.setStorage({
                  data: true,
                  key: 'hello',
                  success: (res) => {
                    console.log('[AdvancedAPI] Storage setStorage data 4 success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] Storage setStorage data 4 fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] Storage setStorage data 4 complete ' + JSON.stringify(res));
                  }
                })
              })

              Button("data null").width(300).onClick(() => {
                // @ts-ignore
                as.setStorage({
                  data: null,
                  key: 'hello',
                  success: (res) => {
                    console.log('[AdvancedAPI] Storage setStorage data 5 success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] Storage setStorage data 5 fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] Storage setStorage data 5 complete ' + JSON.stringify(res));
                  }
                })
              })

              Button("data 空字符").width(300).onClick(() => {
                // @ts-ignore
                as.setStorage({
                  data: '',
                  key: 'hello',
                  success: (res) => {
                    console.log('[AdvancedAPI] Storage setStorage data 6 success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] Storage setStorage data 6 fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] Storage setStorage data 6 complete ' + JSON.stringify(res));
                  }
                })
              })

              Button("data undefined").width(300).onClick(() => {
                // @ts-ignore
                as.setStorage({
                  data: undefined,
                  key: 'hello',
                  success: (res) => {
                    console.log('[AdvancedAPI] Storage setStorage data 7 success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] Storage setStorage data 7 fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] Storage setStorage data 7 complete ' + JSON.stringify(res));
                  }
                })
              })
            }
          }
          //getStorage -key
          ListItem(){
            Column({ space: 10 }) {
              Text("getStorage").fontSize(20).fontWeight(FontWeight.Bold)
              Button("key 缓存指定存储 String").width(300).onClick(() => {
                // @ts-ignore
                as.getStorage({
                  key: 'hello',
                  success: (res) => {
                    console.log('[AdvancedAPI] storage getStorage key  success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] storage getStorage key  fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] storage getStorage key  complete ' + JSON.stringify(res));
                  }
                })
              })

              Button("key 非缓存指定存储 String").width(300).onClick(() => {
                // @ts-ignore
                as.getStorage({
                  key: 'test',
                  success: (res) => {
                    console.log('[AdvancedAPI] storage getStorage key 1 success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] storage getStorage key 1 fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] storage getStorage key 1 complete ' + JSON.stringify(res));
                  }
                })
              })

              Button("key 无此参数").width(300).onClick(() => {
                // @ts-ignore
                as.getStorage({
                  success: (res) => {
                    console.log('[AdvancedAPI] storage getStorage key 2 success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] storage getStorage key 2 fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] storage getStorage key 2 complete ' + JSON.stringify(res));
                  }
                })
              })

              Button("key Number").width(300).onClick(() => {
                // @ts-ignore
                as.getStorage({
                  key: 77777,
                  success: (res) => {
                    console.log('[AdvancedAPI] storage getStorage key 3 success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] storage getStorage key 3 fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] storage getStorage key 3 complete ' + JSON.stringify(res));
                  }
                })
              })

              Button("key Object").width(300).onClick(() => {
                // @ts-ignore
                as.getStorage({
                  key: {'name': 'ws://websocket-echo.com' },
                  success: (res) => {
                    console.log('[AdvancedAPI] storage getStorage key 4 success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] storage getStorage key 4 fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] storage getStorage key 4 complete ' + JSON.stringify(res));
                  }
                })
              })

              Button("key Boolean").width(300).onClick(() => {
                // @ts-ignore
                as.getStorage({
                  key: true,
                  success: (res) => {
                    console.log('[AdvancedAPI] storage getStorage key 5 success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] storage getStorage key 5 fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] storage getStorage key 5 complete ' + JSON.stringify(res));
                  }
                })
              })

              Button("key null").width(300).onClick(() => {
                // @ts-ignore
                as.getStorage({
                  key: null,
                  success: (res) => {
                    console.log('[AdvancedAPI] storage getStorage key 6 success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] storage getStorage key 6 fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] storage getStorage key 6 complete ' + JSON.stringify(res));
                  }
                })
              })

              Button("key 空字符").width(300).onClick(() => {
                // @ts-ignore
                as.getStorage({
                  key: '',
                  success: (res) => {
                    console.log('[AdvancedAPI] storage getStorage key 6 success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] storage getStorage key 6 fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] storage getStorage key 6 complete ' + JSON.stringify(res));
                  }
                })
              })

              Button("key undefined").width(300).onClick(() => {
                // @ts-ignore
                as.getStorage({
                  key: undefined,
                  success: (res) => {
                    console.log('[AdvancedAPI] storage getStorage key 7 success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] storage getStorage key 7 fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] storage getStorage key 7 complete ' + JSON.stringify(res));
                  }
                })
              })
            }
          }
          //getStorageInfo
          ListItem(){
            Column({ space: 10 }) {
              Text("getStorageInfo").fontSize(20).fontWeight(FontWeight.Bold)
              Button("查看接口回调").width(300).onClick(() => {
                // @ts-ignore
                as.getStorageInfo({
                  success: (res) => {
                    console.log('[AdvancedAPI] storage getStorageInfo success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] storage getStorageInfo fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] storage getStorageInfo  complete ' + JSON.stringify(res));
                  }
                })
              })


            }
          }
          //removeStorage
          ListItem(){
            Column({ space: 10 }) {
              Text("removeStorage").fontSize(20).fontWeight(FontWeight.Bold)
              Button("key 缓存指定存储 String").width(300).onClick(() => {
                // @ts-ignore
                as.removeStorage({
                  key: 'hello',
                  success: (res) => {
                    console.log('[AdvancedAPI] storage removeStorage key  success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] storage removeStorage key  fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] storage removeStorage key  complete ' + JSON.stringify(res));
                  }
                })
              })

              Button("key 非缓存指定存储 String").width(300).onClick(() => {
                // @ts-ignore
                as.removeStorage({
                  key: '124587lihn',
                  success: (res) => {
                    console.log('[AdvancedAPI] storage removeStorage key 1 success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] storage removeStorage key 1 fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] storage removeStorage key 1 complete ' + JSON.stringify(res));
                  }
                })
              })

              Button("key 无此参数").width(300).onClick(() => {
                // @ts-ignore
                as.removeStorage({
                  success: (res) => {
                    console.log('[AdvancedAPI] storage removeStorage key 2 success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] storage removeStorage key 2 fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] storage removeStorage key 2 complete ' + JSON.stringify(res));
                  }
                })
              })

              Button("key Number").width(300).onClick(() => {
                // @ts-ignore
                as.removeStorage({
                  key: 77777,
                  success: (res) => {
                    console.log('[AdvancedAPI] storage removeStorage key 3 success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] storage removeStorage key 3 fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] storage removeStorage key 3 complete ' + JSON.stringify(res));
                  }
                })
              })

              Button("key Object").width(300).onClick(() => {
                // @ts-ignore
                as.removeStorage({
                  key: {'name': 'ws://websocket-echo.com' },
                  success: (res) => {
                    console.log('[AdvancedAPI] storage removeStorage key 4 success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] storage removeStorage key 4 fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] storage removeStorage key 4 complete ' + JSON.stringify(res));
                  }
                })
              })

              Button("key Boolean").width(300).onClick(() => {
                // @ts-ignore
                as.removeStorage({
                  key: true,
                  success: (res) => {
                    console.log('[AdvancedAPI] storage removeStorage key 5 success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] storage removeStorage key 5 fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] storage removeStorage key 5 complete ' + JSON.stringify(res));
                  }
                })
              })

              Button("key null").width(300).onClick(() => {
                // @ts-ignore
                as.removeStorage({
                  key: null,
                  success: (res) => {
                    console.log('[AdvancedAPI] storage removeStorage key 6 success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] storage removeStorage key 6 fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] storage removeStorage key 6 complete ' + JSON.stringify(res));
                  }
                })
              })

              Button("key 空字符").width(300).onClick(() => {
                // @ts-ignore
                as.removeStorage({
                  key: '',
                  success: (res) => {
                    console.log('[AdvancedAPI] storage removeStorage key 6 success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] storage removeStorage key 6 fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] storage removeStorage key 6 complete ' + JSON.stringify(res));
                  }
                })
              })

              Button("key undefined").width(300).onClick(() => {
                // @ts-ignore
                as.removeStorage({
                  key: undefined,
                  success: (res) => {
                    console.log('[AdvancedAPI] storage removeStorage key 7 success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] storage removeStorage key 7 fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] storage removeStorage key 7 complete ' + JSON.stringify(res));
                  }
                })
              })
            }
          }
          //clearStorage与clearStorageSync
          ListItem(){
            Column({ space: 10 }) {
              Text("clearStorage与clearStorageSync").fontSize(20).fontWeight(FontWeight.Bold)
              Button("clearStorage").width(300).onClick(() => {
                // @ts-ignore
                as.clearStorage({
                  success: (res) => {
                    console.log('[AdvancedAPI] storage clearStorage success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] storage clearStorage fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] storage clearStorage  complete ' + JSON.stringify(res));
                  }
                })
              })
              Button("clearStorageSync").width(300).onClick(() => {
                // @ts-ignore
                as.clearStorageSync({
                  success: (res) => {
                    console.log('[AdvancedAPI] storage clearStorageSync success ' + JSON.stringify(res));
                  },
                  fail: (err) => {
                    console.error('[AdvancedAPI] storage clearStorageSync fail ' + JSON.stringify(err));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPI] storage clearStorageSync  complete ' + JSON.stringify(res));
                  }
                })
              })

            }
          }
          //Sync -key
          ListItem(){
            Column({ space: 10 }) {
              Text("Sync").fontSize(20).fontWeight(FontWeight.Bold)

              Button("setStorageSync").width(300).onClick(() => {
                try {
                  // @ts-ignore
                  const value = as.setStorageSync('storage_key', 'hello');
                  if (value) {
                    console.log('[AdvancedAPI] storage setStorageSync  ' +value);
                  }
                } catch (e) {
                  // error
                  console.log('[AdvancedAPI] storage setStorageSync error ' + e);
                }
              })
              Button("key类型不对").width(300).onClick(() => {
                try {
                  // @ts-ignore
                  const value = as.setStorageSync(7788, 'hello');
                  if (value) {
                    console.log('[AdvancedAPI] storage setStorageSync 2  ' +value);
                  }
                } catch (e) {
                  // error
                  console.log('[AdvancedAPI] storage setStorageSync 2 error ' + e);
                }
              })
              Button("data类型不对").width(300).onClick(() => {
                try {
                  // @ts-ignore
                  const value = as.setStorageSync('storage_key2', null);
                  if (value) {
                    console.log('[AdvancedAPI] storage setStorageSync 2  ' +value);
                  }
                } catch (e) {
                  // error
                  console.log('[AdvancedAPI] storage setStorageSync 2 error ' + e);
                }
              })

              Button("getStorageSync").width(300).onClick(() => {
                try {
                  // @ts-ignore
                  const value = as.getStorageSync('storage_key');
                  if (value) {
                    console.log('[AdvancedAPI] storage getStorageSync  ' +value);
                  }
                } catch (e) {
                  // error
                  console.log('[AdvancedAPI] storage getStorageSync error ' + e);
                }
              })
              Button("非指定").width(300).onClick(() => {
                try {
                  // @ts-ignore
                  const value = as.getStorageSync('get');
                  if (value) {
                    console.log('[AdvancedAPI] storage getStorageSync 2  ' +value);
                  }
                } catch (e) {
                  // error
                  console.log('[AdvancedAPI] storage getStorageSync 2 error ' + e);
                }
              })

              Button("getStorageInfoSync").width(300).onClick(() => {
                try {
                  // @ts-ignore
                  const res = as.getStorageInfoSync();
                  console.log('[AdvancedAPI] storage getStorageInfoSync  '+ JSON.stringify(res));
                  console.log('[AdvancedAPI] storage getStorageInfoSync  '+ res.keys);
                  console.log('[AdvancedAPI] storage getStorageInfoSync  '+ res.currentSize);
                  console.log('[AdvancedAPI] storage getStorageInfoSync  '+ res.limitSize);
                } catch (e) {
                  // error
                  console.log('[AdvancedAPI] storage getStorageInfoSync error ' + e);
                }
              })

              Button("removeStorageSync").width(300).onClick(() => {
                try {
                  // @ts-ignore
                  const res = as.removeStorageSync('storage_key');
                  console.log('[AdvancedAPI] storage removeStorageSync  '+ JSON.stringify(res));
                } catch (e) {
                  // error
                  console.log('[AdvancedAPI] storage removeStorageSync error ' + e);
                }
              })
              Button("非指定").width(300).onClick(() => {
                try {
                  // @ts-ignore
                  const res = as.removeStorageSync('remove');
                  console.log('[AdvancedAPI] storage removeStorageSync 2 '+ JSON.stringify(res));
                } catch (e) {
                  // error
                  console.log('[AdvancedAPI] storage removeStorageSync 2 error ' + e);
                }
              })

            }
          }

        }.listDirection(Axis.Vertical) // 排列方向
        .divider({ strokeWidth: 2, color: 0xFFFFFF, startMargin: 20, endMargin: 20 }) // 每行之间的分界线
        .alignListItem(ListItemAlign.Center)
      }
    }
  }
}