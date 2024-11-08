import promptAction from '@ohos.promptAction'

@Entry
@Component
struct Wifi {
  netId = 0

  private GetWifiListCallback = (data) => {
    console.log('[AdvancedAPI] GetWifiList data.wifiList.length = '+data.wifiList.length)
    console.log("[AdvancedAPI] GetWifiList happened, data: " + JSON.stringify(data.wifiList));//日志过大,无法输出
    console.log("[AdvancedAPI] GetWifiList happened, data: " + JSON.stringify(data));//日志过大,无法输出
  };
  private GetWifiListCallback2 = (data) => {
    console.log('[AdvancedAPI] GetWifiList 2 data.wifiList.length = '+data.wifiList.length)
    console.log("[AdvancedAPI] GetWifiList happened2, data: " + JSON.stringify(data.wifiList));//日志过大,无法输出
    console.log("[AdvancedAPI] GetWifiList happened2, data: " + JSON.stringify(data));//日志过大,无法输出
  };
  private WifiConnectedCallback = (data) => {
    console.log("[AdvancedAPI] WifiConnected happened, data: " + JSON.stringify(data));
  };
  private WifiConnectedCallback2 = (data) => {
    console.log("[AdvancedAPI] WifiConnected happened2, data: " + JSON.stringify(data));
  };
  private WifiConnectedWithPartialInfoCallback = (data) => {
    console.log("[AdvancedAPI] WifiConnectedWithPartialInfo happened, data: " +JSON.stringify(data));
  };
  private WifiConnectedWithPartialInfoCallback2 = (data) => {
    console.log("[AdvancedAPI] WifiConnectedWithPartialInfo happened2, data: " + JSON.stringify(data));
  };

  build() {
    Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
      Column({ space: 5 }) {
        Text('wifi').fontSize(35)
        List({ space: 20, }) {
          ListItem() {
            Column({ space: 10 }) {
              Button('as.startWifi').width(300).onClick(() => {
                // @ts-ignore
                as.startWifi({
                  success: function (data) {
                    console.log('[AdvancedAPI]: startWifi success data = '+JSON.stringify(data))
                    promptAction.showToast({
                      message: 'startWifi 成功'
                    })
                  },
                  fail: function (data) {
                    console.log('[AdvancedAPI]: startWifi fail data = '+JSON.stringify(data))
                    promptAction.showToast({
                      message: 'startWifi 失败'
                    })
                  },
                  complete: (data) => {
                    console.log('[AdvancedAPI] startWifi complete data = ' + JSON.stringify(data))
                  }
                })
              })

              Button('as.stopWifi').width(300).onClick(() => {
                // @ts-ignore
                as.stopWifi({
                  success: function (data) {
                    console.log('[AdvancedAPI]: stopWifi success '+JSON.stringify(data))
                    promptAction.showToast({
                      message: 'stopWifi 成功'
                    })
                  },
                  fail: function () {
                    promptAction.showToast({
                      message: 'stopWifi 失败'
                    })
                  },
                  complete: function () {}
                })
              })

              Button('as.getConnectedWifi').width(300).onClick(() => {
                // @ts-ignore
                as.getConnectedWifi({
                  success: function (data) {
                    console.log('[AdvancedAPI]: getConnectedWifi success data = '+JSON.stringify(data))
                    promptAction.showToast({
                      message: 'getConnectedWifi 成功'
                    })
                  },
                  fail: function (err) {
                    console.log('[AdvancedAPI]: getConnectedWifi fail data = '+JSON.stringify(err))
                    promptAction.showToast({
                      message: 'getConnectedWifi 失败'
                    })
                  }
                })
              })

              Button('as.getWifiList').width(300).onClick(() => {
                // @ts-ignore
                as.getWifiList({
                  success: function (data) {
                    console.log('[AdvancedAPI]: getWifiList success data = '+JSON.stringify(data))
                    promptAction.showToast({
                      message: 'getWifiList 成功'
                    })
                  },
                  fail: function (err) {
                    console.log('[AdvancedAPI]: getWifiList fail data = '+JSON.stringify(err))
                    promptAction.showToast({
                      message: 'getWifiList 失败'
                    })
                  },
                  complete: function () {}
                })
              })

              Button('as.onGetWifiList').width(300).onClick(() => {
                // @ts-ignore
                as.onGetWifiList(function (data) {
                  console.log('[AdvancedAPI] onGetWifiList success')
                  console.log('[AdvancedAPI] onGetWifiList data.wifiList.length = '+data.wifiList.length)
                  promptAction.showToast({
                    message: 'onGetWifiList 监听触发'
                  })
                })
              })

              Button('as.offGetWifiList').width(300).onClick(() => {
                // @ts-ignore
                as.offGetWifiList()
                promptAction.showToast({
                  message: '取消监听成功'
                })
              })

              Button('as.connectWifi 9F-249-NanJing-Upark').width(300).onClick(() => {
                // @ts-ignore
                as.connectWifi({
                  SSID: '9F-249-NanJing-Upark',
                  BSSID: 'b4:a8:98:48:2d:fc',
                  password: 'Fast*#06#',
                  success: function (data) {
                    console.log('[AdvancedAPI] connectWifi success'+JSON.stringify(data))
                    promptAction.showToast({
                      message: '连接wifi成功'
                    })
                  },
                  fail: function (err) {
                    console.log('[AdvancedAPI] connectWifi fail err = '+JSON.stringify(err))
                    promptAction.showToast({
                      message: '连接wifi失败'
                    })
                  }
                })
              })

              Button('as.connectWifi 缺少BSSID值').width(300).onClick(() => {
                // @ts-ignore
                as.connectWifi({
                  SSID: '9F-249-NanJing-Upark',
                  password: 'Fast*#06#',
                  success: function (data) {
                    console.log('[AdvancedAPI] connectWifi success'+JSON.stringify(data))
                    promptAction.showToast({
                      message: '连接wifi成功'
                    })
                  },
                  fail: function (err) {
                    console.log('[AdvancedAPI] connectWifi fail err = '+JSON.stringify(err))
                    promptAction.showToast({
                      message: '连接wifi失败'
                    })
                  }
                })
              })

              Button('as.onWifiConnected').width(300).onClick(() => {
                // @ts-ignore
                as.onWifiConnected(function (wifiInfo) {
                  console.log('[AdvancedAPI] onWifiConnected')
                  console.log('[AdvancedAPI] wifiInfo = '+JSON.stringify(wifiInfo))
                  promptAction.showToast({
                    message: '监听wifi连接状态回调触发'
                  })
                })
              })

              Button('as.offWifiConnected').width(300).onClick(() => {
                // @ts-ignore
                as.offWifiConnected()
                promptAction.showToast({
                  message: '取消监听wifi连接状态'
                })
              })

              Button('as.onWifiConnectedWithPartialInfo').width(300).onClick(() => {
                // @ts-ignore
                as.onWifiConnectedWithPartialInfo(function (wifiInfo) {
                  console.log('[AdvancedAPI] wifiInfo = '+JSON.stringify(wifiInfo))
                  promptAction.showToast({
                    message: '监听wifi连接状态回调触发'
                  })
                })
              })

              Button('as.offWifiConnectedWithPartialInfo').width(300).onClick(() => {
                // @ts-ignore
                as.offWifiConnectedWithPartialInfo()
                promptAction.showToast({
                  message: '取消监听wifi连接状态'
                })
              })
            }
          }

          //startWifi与stopWifi
          ListItem() {
            Column({ space: 10 }) {
              Button('as.startWifi').width(300).onClick(() => {
                // @ts-ignore
                as.startWifi({
                  success: function (data) {
                    console.log('[AdvancedAPI]: startWifi success ' + JSON.stringify(data))
                  },
                  fail: function (data) {
                    console.log('[AdvancedAPI]: startWifi fail  ' + JSON.stringify(data))
                  },
                  complete: (data) => {
                    console.log('[AdvancedAPI] startWifi complete' + JSON.stringify(data))
                  }
                })
              })

              Button('as.stopWifi').width(300).onClick(() => {
                // @ts-ignore
                as.stopWifi({
                  success: function (data) {
                    console.log('[AdvancedAPI]: stopWifi success' + JSON.stringify(data))
                  },
                  fail: function (data) {
                    console.log('[AdvancedAPI]: stopWifi fail' + JSON.stringify(data))
                  },
                  complete: (data) => {
                    console.log('[AdvancedAPI] stopWifi complete ' + JSON.stringify(data))
                  }
                })
              })
            }
          }

          //getConnectedWifi
          ListItem() {
            Column({ space: 10 }) {
              Text('getConnectedWifi').fontSize(28).backgroundColor(Color.Orange)

              // partialInfo 无此参数
              Button('partialInfo无此参数').width(300).onClick(() => {
                // @ts-ignore
                as.getConnectedWifi({
                  //                    partialInfo: true,
                  success: function (data) {
                    console.log('[AdvancedAPI]: getConnectedWifi success 0' + JSON.stringify(data))
                  },
                  fail: function (err) {
                    console.log('[AdvancedAPI]: getConnectedWifi fail 0' + JSON.stringify(err))
                  },
                  complete: (data) => {
                    console.log('[AdvancedAPI]: getConnectedWifi complete 0' + JSON.stringify(data))
                  }
                })
              })

              // partialInfo 参数取值正常boolean  false
              Button('partialInfo取值false').width(300).onClick(() => {
                // @ts-ignore
                as.getConnectedWifi({
                  partialInfo: false,
                  success: function (data) {
                    console.log('[AdvancedAPI]: getConnectedWifi success 1' + JSON.stringify(data))
                  },
                  fail: function (err) {
                    console.log('[AdvancedAPI]: getConnectedWifi fail 1' + JSON.stringify(err))
                  },
                  complete: (data) => {
                    console.log('[AdvancedAPI]: getConnectedWifi complete ' + JSON.stringify(data))
                  }
                })
              })

              // partialInfo 参数取值正常boolean  true
              Button('partialInfo取值true').width(300).onClick(() => {
                // @ts-ignore
                as.getConnectedWifi({
                  partialInfo: true,
                  success: function (data) {
                    console.log('[AdvancedAPI]: getConnectedWifi success 2' + JSON.stringify(data))
                  },
                  fail: function (err) {
                    console.log('[AdvancedAPI]: getConnectedWifi fail 2' + JSON.stringify(err))
                  },
                  complete: (data) => {
                    console.log('[AdvancedAPI]: getConnectedWifi complete 2' + JSON.stringify(data))
                  }
                })
              })

              // partialInfo 参数取值类型不同 Number
              Button('partialInfo取值Number').width(300).onClick(() => {
                // @ts-ignore
                as.getConnectedWifi({
                  partialInfo: 7788,
                  success: function (data) {
                    console.log('[AdvancedAPI]: getConnectedWifi success 3' + JSON.stringify(data))
                  },
                  fail: function (err) {
                    console.log('[AdvancedAPI]: getConnectedWifi fail 3' + JSON.stringify(err))
                  },
                  complete: (data) => {
                    console.log('[AdvancedAPI]: getConnectedWifi complete 3' + JSON.stringify(data))
                  }
                })
              })

              // partialInfo 参数取值类型不同 String
              Button('partialInfo取值String').width(300).onClick(() => {
                // @ts-ignore
                as.getConnectedWifi({
                  partialInfo: 'test',
                  success: function (data) {
                    console.log('[AdvancedAPI]: getConnectedWifi success 4' + JSON.stringify(data))
                  },
                  fail: function (err) {
                    console.log('[AdvancedAPI]: getConnectedWifi fail 4' + JSON.stringify(err))
                  },
                  complete: (data) => {
                    console.log('[AdvancedAPI]: getConnectedWifi complete 4' + JSON.stringify(data))
                  }
                })
              })

              // partialInfo 参数取值类型不同 Object
              Button('partialInfo取值Object').width(300).onClick(() => {
                // @ts-ignore
                as.getConnectedWifi({
                  partialInfo: { 'name': 'test' },
                  success: function (data) {
                    console.log('[AdvancedAPI]: getConnectedWifi success 5' + JSON.stringify(data))
                  },
                  fail: function (err) {
                    console.log('[AdvancedAPI]: getConnectedWifi fail 5' + JSON.stringify(err))
                  },
                  complete: (data) => {
                    console.log('[AdvancedAPI]: getConnectedWifi complete 5' + JSON.stringify(data))
                  }
                })
              })

              // partialInfo 参数取值异常 null
              Button('partialInfo取值null').width(300).onClick(() => {
                // @ts-ignore
                as.getConnectedWifi({
                  partialInfo: null,
                  success: function (data) {
                    console.log('[AdvancedAPI]: getConnectedWifi success 6' + JSON.stringify(data))
                  },
                  fail: function (err) {
                    console.log('[AdvancedAPI]: getConnectedWifi fail 6' + JSON.stringify(err))
                  },
                  complete: (data) => {
                    console.log('[AdvancedAPI]: getConnectedWifi complete 6' + JSON.stringify(data))
                  }
                })
              })

              // partialInfo 参数取值异常 空字符
              Button('partialInfo取值空字符').width(300).onClick(() => {
                // @ts-ignore
                as.getConnectedWifi({
                  partialInfo: '',
                  success: function (data) {
                    console.log('[AdvancedAPI]: getConnectedWifi success 7' + JSON.stringify(data))
                  },
                  fail: function (err) {
                    console.log('[AdvancedAPI]: getConnectedWifi fail 7' + JSON.stringify(err))
                  },
                  complete: (data) => {
                    console.log('[AdvancedAPI]: getConnectedWifi complete 7' + JSON.stringify(data))
                  }
                })
              })

              // partialInfo 参数取值异常 undefined
              Button('partialInfo取值undefined').width(300).onClick(() => {
                // @ts-ignore
                as.getConnectedWifi({
                  partialInfo: undefined,
                  success: function (data) {
                    console.log('[AdvancedAPI]: getConnectedWifi success 8' + JSON.stringify(data))
                  },
                  fail: function (err) {
                    console.log('[AdvancedAPI]: getConnectedWifi fail 8' + JSON.stringify(err))
                  },
                  complete: (data) => {
                    console.log('[AdvancedAPI]: getConnectedWifi complete 8' + JSON.stringify(data))
                  }
                })
              })
            }
          }

          //getWifiList
          ListItem() {
            Button('as.getWifiList').width(300).onClick(() => {
              // @ts-ignore
              as.getWifiList({
                success: function (data) {
                  console.log('[AdvancedAPI]: getWifiList success ' + JSON.stringify(data))
                },
                fail: function (err) {
                  console.log('[AdvancedAPI]: getWifiList fail ' + JSON.stringify(err))
                },
                complete: (data) => {
                  console.log('[AdvancedAPI]: getWifiList complete ' + JSON.stringify(data))
                }
              })
            })
          }.backgroundColor(Color.Pink)

          //onGetWifiList与offGetWifiList
          ListItem() {
            Column({ space: 10 }) {
              Button('as.onGetWifiList').width(300).onClick(() => {
                // @ts-ignore
                as.onGetWifiList(this.GetWifiListCallback)
              })

              Button('as.onGetWifiList2').width(300).onClick(() => {
                // @ts-ignore
                as.onGetWifiList(this.GetWifiListCallback2)
              })

              Button('as.offGetWifiList').width(300).onClick(() => {
                // @ts-ignore
                as.offGetWifiList(this.GetWifiListCallback)
              })

              Button('as.offGetWifiList 参数2').width(300).onClick(() => {
                // @ts-ignore
                as.offGetWifiList(this.GetWifiListCallback2)
              })

              Button('as.offGetWifiList 不传参数').width(300).onClick(() => {
                // @ts-ignore
                as.offGetWifiList()
              })
            }
          }.backgroundColor(Color.Orange)

          //connectWifi(OBJECT)
          ListItem() {
            Column({ space: 10 }) {
              Text('connectWifi').fontSize(35)
              Column({ space: 10 }) {

                //SSID + password + BSSID 参数正常且对应 String
                Button('SSID + password + BSSID 正常').width(300).onClick(() => {
                  // @ts-ignore
                  as.connectWifi({
                    SSID: '9F-249-NanJing-Upark',
                    BSSID: 'b4:a8:98:48:2d:fc',
                    password: 'Fast*#06#',
                    success: function (data) {
                      console.log('[AdvancedAPI] connectWifi success' + JSON.stringify(data))
                    },
                    fail: function (err) {
                      console.log('[AdvancedAPI] connectWifi fail' + JSON.stringify(err))
                    },
                    complete: (data) => {
                      console.log('[AdvancedAPI] connectWifi complete ' + JSON.stringify(data))
                    }
                  })
                })

                //SSID + password 参数正常且对应 String
                Button('SSID + password 正常').width(300).onClick(() => {
                  // @ts-ignore
                  as.connectWifi({
                    SSID: '9F-249-NanJing-Upark',
                    password: 'Fast*#06#',
                    success: function (data) {
                      console.log('[AdvancedAPI] connectWifi success 00' + JSON.stringify(data))
                    },
                    fail: function (err) {
                      console.log('[AdvancedAPI] connectWifi fail 00' + JSON.stringify(err))
                    },
                    complete: (data) => {
                      console.log('[AdvancedAPI] connectWifi complete 00 ' + JSON.stringify(data))
                    }
                  })
                })

                // SSID + password 参数正常但不对应 String
                Button('SSID + password 不对应').width(300).onClick(() => {
                  // @ts-ignore
                  as.connectWifi({
                    SSID: 'myWifi',
                    password: 'Fast*#06#',
                    success: function (data) {
                      console.log('[AdvancedAPI] connectWifi success 1' + JSON.stringify(data))
                    },
                    fail: function (err) {
                      console.log('[AdvancedAPI] connectWifi fail 1 ' + JSON.stringify(err))
                    },
                    complete: (data) => {
                      console.log('[AdvancedAPI] connectWifi complete 1 ' + JSON.stringify(data))
                    }
                  })
                })

                //SSID + password 均无此参数
                Button('SSID + password 均无此参数').width(300).onClick(() => {
                  // @ts-ignore
                  as.connectWifi({
                    //                    SSID: '9F-249-NanJing-Upark',
                    //                    password: 'Fast*#06#',
                    success: function (data) {
                      console.log('[AdvancedAPI] connectWifi success 2' + JSON.stringify(data))
                    },
                    fail: function (err) {
                      console.log('[AdvancedAPI] connectWifi fail 2' + JSON.stringify(err))
                    },
                    complete: (data) => {
                      console.log('[AdvancedAPI] connectWifi complete 2' + JSON.stringify(data))
                    }
                  })
                })

                //SSID + password 均类型异常 boolean
                Button('SSID + password boolean').width(300).onClick(() => {
                  // @ts-ignore
                  as.connectWifi({
                    SSID: true,
                    password: false,
                    success: function (data) {
                      console.log('[AdvancedAPI] connectWifi success 3' + JSON.stringify(data))
                    },
                    fail: function (err) {
                      console.log('[AdvancedAPI] connectWifi fail 3' + JSON.stringify(err))
                    },
                    complete: (data) => {
                      console.log('[AdvancedAPI] connectWifi complete 3 ' + JSON.stringify(data))
                    }
                  })
                })

                //SSID + password 均类型异常 Number
                Button('SSID + password Number').width(300).onClick(() => {
                  // @ts-ignore
                  as.connectWifi({
                    SSID: 77,
                    password: 12345678,
                    success: function (data) {
                      console.log('[AdvancedAPI] connectWifi success 4' + JSON.stringify(data))
                    },
                    fail: function (err) {
                      console.log('[AdvancedAPI] connectWifi fail 4' + JSON.stringify(err))
                    },
                    complete: (data) => {
                      console.log('[AdvancedAPI] connectWifi complete 4' + JSON.stringify(data))
                    }
                  })
                })

                //SSID + password 均类型异常 Object
                Button('SSID + password Object').width(300).onClick(() => {
                  // @ts-ignore
                  as.connectWifi({
                    SSID: { 'name': 'test' },
                    password: { 'name': 'test' },
                    success: function (data) {
                      console.log('[AdvancedAPI] connectWifi success 5' + JSON.stringify(data))
                    },
                    fail: function (err) {
                      console.log('[AdvancedAPI] connectWifi fail 5' + JSON.stringify(err))
                    },
                    complete: (data) => {
                      console.log('[AdvancedAPI] connectWifi complete 5 ' + JSON.stringify(data))
                    }
                  })
                })

                //SSID + password 均参数取值异常 null
                Button('SSID + password null').width(300).onClick(() => {
                  // @ts-ignore
                  as.connectWifi({
                    SSID: null,
                    password: null,
                    success: function (data) {
                      console.log('[AdvancedAPI] connectWifi success 6' + JSON.stringify(data))
                    },
                    fail: function (err) {
                      console.log('[AdvancedAPI] connectWifi fail 6' + JSON.stringify(err))
                    },
                    complete: (data) => {
                      console.log('[AdvancedAPI] connectWifi complete 6' + JSON.stringify(data))
                    }
                  })
                })

                //SSID + password 均参数取值异常 空字符
                Button('SSID + password 空字符').width(300).onClick(() => {
                  // @ts-ignore
                  as.connectWifi({
                    SSID: '',
                    password: '',
                    success: function (data) {
                      console.log('[AdvancedAPI] connectWifi success 7' + JSON.stringify(data))
                    },
                    fail: function (err) {
                      console.log('[AdvancedAPI] connectWifi fail 7' + JSON.stringify(err))
                    },
                    complete: (data) => {
                      console.log('[AdvancedAPI] connectWifi complete  7' + JSON.stringify(data))
                    }
                  })
                })

                //SSID + password 均参数取值异常 undefined
                Button('SSID + password undefined').width(300).onClick(() => {
                  // @ts-ignore
                  as.connectWifi({
                    SSID: undefined,
                    password: undefined,
                    success: function (data) {
                      console.log('[AdvancedAPI] connectWifi success 8' + JSON.stringify(data))
                    },
                    fail: function (err) {
                      console.log('[AdvancedAPI] connectWifi fail 8' + JSON.stringify(err))
                    },
                    complete: (data) => {
                      console.log('[AdvancedAPI] connectWifi complete 8' + JSON.stringify(data))
                    }
                  })
                })
              }.backgroundColor(Color.Green)

              Column({ space: 10 }) {
                //BSSID 无此参数，上面已包含 前提：SSID + password 参数正常且对应
                //BSSID 参数正常String 前提：SSID + password 参数正常且对应
                Button('BSSID 无效String').width(300).onClick(() => {
                  // @ts-ignore
                  as.connectWifi({
                    SSID: '9F-249-NanJing-Upark',
                    password: 'Fast*#06#',
                    BSSID: 'test',
                    success: function (data) {
                      console.log('[AdvancedAPI] connectWifi  BSSID success' + JSON.stringify(data))
                    },
                    fail: function (err) {
                      console.log('[AdvancedAPI] connectWifi BSSID fail' + JSON.stringify(err))
                    },
                    complete: (data) => {
                      console.log('[AdvancedAPI] connectWifi BSSID complete ' + JSON.stringify(data))
                    }
                  })
                })

                //BSSID 参数取值类型不同 Number 前提：SSID + password 参数正常且对应
                Button('BSSID  Number').width(300).onClick(() => {
                  // @ts-ignore
                  as.connectWifi({
                    SSID: '9F-249-NanJing-Upark',
                    password: 'Fast*#06#',
                    BSSID: 666,
                    success: function (data) {
                      console.log('[AdvancedAPI] connectWifi BSSID success 11' + JSON.stringify(data))
                    },
                    fail: function (err) {
                      console.log('[AdvancedAPI] connectWifi BSSID fail 11' + JSON.stringify(err))
                    },
                    complete: (data) => {
                      console.log('[AdvancedAPI] connectWifi BSSID complete 11 ' + JSON.stringify(data))
                    }
                  })
                })

                //BSSID 参数取值类型不同 Boolean 前提：SSID + password 参数正常且对应
                Button('BSSID  Boolean').width(300).onClick(() => {
                  // @ts-ignore
                  as.connectWifi({
                    SSID: '9F-249-NanJing-Upark',
                    password: 'Fast*#06#',
                    BSSID: false,
                    success: function (data) {
                      console.log('[AdvancedAPI] connectWifi BSSID success 12' + JSON.stringify(data))
                    },
                    fail: function (err) {
                      console.log('[AdvancedAPI] connectWifi BSSID fail 12' + JSON.stringify(err))
                    },
                    complete: (data) => {
                      console.log('[AdvancedAPI] connectWifi BSSID complete 12 ' + JSON.stringify(data))
                    }
                  })
                })
                //BSSID 参数参数取值类型不同 Object 前提：SSID + password 参数正常且对应
                Button('BSSID  Object').width(300).onClick(() => {
                  // @ts-ignore
                  as.connectWifi({
                    SSID: '9F-249-NanJing-Upark',
                    password: 'Fast*#06#',
                    BSSID: { 'name': 'test' },
                    success: function (data) {
                      console.log('[AdvancedAPI] connectWifi BSSID success 13' + JSON.stringify(data))
                    },
                    fail: function (err) {
                      console.log('[AdvancedAPI] connectWifi BSSID fail 13' + JSON.stringify(err))
                    },
                    complete: (data) => {
                      console.log('[AdvancedAPI] connectWifi BSSID complete 13 ' + JSON.stringify(data))
                    }
                  })
                })
                //BSSID 参数取值异常 null 前提：SSID + password 参数正常且对应
                Button('BSSID  null').width(300).onClick(() => {
                  // @ts-ignore
                  as.connectWifi({
                    SSID: '9F-249-NanJing-Upark',
                    password: 'Fast*#06#',
                    BSSID: null,
                    success: function (data) {
                      console.log('[AdvancedAPI] connectWifi BSSID success 14' + JSON.stringify(data))
                    },
                    fail: function (err) {
                      console.log('[AdvancedAPI] connectWifi BSSID fail 14' + JSON.stringify(err))
                    },
                    complete: (data) => {
                      console.log('[AdvancedAPI] connectWifi BSSID complete 14' + JSON.stringify(data))
                    }
                  })
                })
                //BSSID 参数取值异常 空字符 前提：SSID + password 参数正常且对应
                Button('BSSID  空字符').width(300).onClick(() => {
                  // @ts-ignore
                  as.connectWifi({
                    SSID: '9F-249-NanJing-Upark',
                    password: 'Fast*#06#',
                    BSSID: '',
                    success: function (data) {
                      console.log('[AdvancedAPI] connectWifi BSSID success 15' + JSON.stringify(data))
                    },
                    fail: function (err) {
                      console.log('[AdvancedAPI] connectWifi BSSID fail 15' + JSON.stringify(err))
                    },
                    complete: (data) => {
                      console.log('[AdvancedAPI] connectWifi BSSID complete 15 ' + JSON.stringify(data))
                    }
                  })
                })
                //BSSID 参数取值异常 undefined 前提：SSID + password 参数正常且对应
                Button('BSSID undefined').width(300).onClick(() => {
                  // @ts-ignore
                  as.connectWifi({
                    SSID: '9F-249-NanJing-Upark',
                    password: 'Fast*#06#',
                    BSSID: undefined,
                    success: function (data) {
                      console.log('[AdvancedAPI] connectWifi BSSID success 16' + JSON.stringify(data))
                    },
                    fail: function (err) {
                      console.log('[AdvancedAPI] connectWifi BSSID fail 16' + JSON.stringify(err))
                    },
                    complete: (data) => {
                      console.log('[AdvancedAPI] connectWifi BSSID complete 16 ' + JSON.stringify(data))
                    }
                  })
                })
              }.backgroundColor(Color.Pink)

              Column({ space: 10 }) {
                //该跳转属性不支持
                //maunal 无此参数，上面已包含 前提：SSID + password 参数正常且对应
                //maunal 参数正常Boolean true 前提：SSID + password 参数正常且对应
                Button('maunal  true').width(300).onClick(() => {
                  // @ts-ignore
                  as.connectWifi({
                    SSID: '9F-249-NanJing-Upark',
                    password: 'Fast*#06#',
                    manual: true,
                    success: function (data) {
                      console.log('[AdvancedAPI] connectWifi manual success' + JSON.stringify(data))
                    },
                    fail: function (err) {
                      console.log('[AdvancedAPI] connectWifi manual fail' + JSON.stringify(err))
                    },
                    complete: (data) => {
                      console.log('[AdvancedAPI] connectWifi manual complete ' + JSON.stringify(data))
                    }
                  })
                })
                //maunal 参数正常Boolean false 前提：SSID + password 参数正常且对应
                //maunal 参数取值类型不同 Number 前提：SSID + password 参数正常且对应
                //maunal 参数取值类型不同 String 前提：SSID + password 参数正常且对应
                //maunal 参数参数取值类型不同 Object 前提：SSID + password 参数正常且对应
                //maunal 参数取值异常 null 前提：SSID + password 参数正常且对应
                //maunal 参数取值异常 空字符 前提：SSID + password 参数正常且对应
                //maunal 参数取值异常 undefined 前提：SSID + password 参数正常且对应
              }.backgroundColor(Color.Blue)

              Column({ space: 10 }) {
                // partialInfo 无此参数，上面已包含 前提：SSID + password 参数正常且对应
                // partialInfo 参数正常Boolean true 前提：SSID + password 参数正常且对应
                Button('partialInfo 参数正常Boolean true').width(300).onClick(() => {
                  // @ts-ignore
                  as.connectWifi({
                    SSID: '9F-249-NanJing-Upark',
                    password: 'Fast*#06#',
                    partialInfo: true,
                    success: function (data) {
                      console.log('[AdvancedAPI] connectWifi success 20' + JSON.stringify(data))
                    },
                    fail: function (err) {
                      console.log('[AdvancedAPI] connectWifi fail 20' + JSON.stringify(err))
                    },
                    complete: (data) => {
                      console.log('[AdvancedAPI] connectWifi complete 20' + JSON.stringify(data))
                    }
                  })
                })

                // partialInfo 参数正常Boolean false 前提：SSID + password 参数正常且对应
                Button('partialInfo 参数正常Boolean false').width(300).onClick(() => {
                  // @ts-ignore
                  as.connectWifi({
                    SSID: '9F-249-NanJing-Upark',
                    password: 'Fast*#06#',
                    partialInfo: false,
                    success: function (data) {
                      console.log('[AdvancedAPI] connectWifi success 21' + JSON.stringify(data))
                    },
                    fail: function (err) {
                      console.log('[AdvancedAPI] connectWifi fail 21' + JSON.stringify(err))
                    },
                    complete: (data) => {
                      console.log('[AdvancedAPI] connectWifi complete 21' + JSON.stringify(data))
                    }
                  })
                })

                // partialInfo 参数取值类型不同 Number 前提：SSID + password 参数正常且对应
                Button('partialInfo 参数取值类型不同 Number').width(300).onClick(() => {
                  // @ts-ignore
                  as.connectWifi({
                    SSID: '9F-249-NanJing-Upark',
                    password: 'Fast*#06#',
                    partialInfo: 7788,
                    success: function (data) {
                      console.log('[AdvancedAPI] connectWifi success 22' + JSON.stringify(data))
                    },
                    fail: function (err) {
                      console.log('[AdvancedAPI] connectWifi fail 22' + JSON.stringify(err))
                    },
                    complete: (data) => {
                      console.log('[AdvancedAPI] connectWifi complete 22' + JSON.stringify(data))
                    }
                  })
                })

                // partialInfo 参数取值类型不同 String 前提：SSID + password 参数正常且对应
                Button('partialInfo 参数取值类型不同 String').width(300).onClick(() => {
                  // @ts-ignore
                  as.connectWifi({
                    SSID: '9F-249-NanJing-Upark',
                    password: 'Fast*#06#',
                    partialInfo: 'test',
                    success: function (data) {
                      console.log('[AdvancedAPI] connectWifi success 23' + JSON.stringify(data))
                    },
                    fail: function (err) {
                      console.log('[AdvancedAPI] connectWifi fail 23' + JSON.stringify(err))
                    },
                    complete: (data) => {
                      console.log('[AdvancedAPI] connectWifi complete 23' + JSON.stringify(data))
                    }
                  })
                })

                // partialInfo 参数参数取值类型不同 Object 前提：SSID + password 参数正常且对应
                Button('partialInfo 参数参数取值类型不同 Object').width(300).onClick(() => {
                  // @ts-ignore
                  as.connectWifi({
                    SSID: '9F-249-NanJing-Upark',
                    password: 'Fast*#06#',
                    partialInfo: { 'name': 'test' },
                    success: function (data) {
                      console.log('[AdvancedAPI] connectWifi success 24' + JSON.stringify(data))
                    },
                    fail: function (err) {
                      console.log('[AdvancedAPI] connectWifi fail 24' + JSON.stringify(err))
                    },
                    complete: (data) => {
                      console.log('[AdvancedAPI] connectWifi complete 24' + JSON.stringify(data))
                    }
                  })
                })

                // partialInfo 参数取值异常 null 前提：SSID + password 参数正常且对应
                Button('partialInfo 参数取值异常 null').width(300).onClick(() => {
                  // @ts-ignore
                  as.connectWifi({
                    SSID: '9F-249-NanJing-Upark',
                    password: 'Fast*#06#',
                    partialInfo: null,
                    success: function (data) {
                      console.log('[AdvancedAPI] connectWifi success 25' + JSON.stringify(data))
                    },
                    fail: function (err) {
                      console.log('[AdvancedAPI] connectWifi fail 25' + JSON.stringify(err))
                    },
                    complete: (data) => {
                      console.log('[AdvancedAPI] connectWifi complete 25' + JSON.stringify(data))
                    }
                  })
                })

                // partialInfo 参数取值异常 空字符 前提：SSID + password 参数正常且对应
                Button('partialInfo 参数取值异常 空字符').width(300).onClick(() => {
                  // @ts-ignore
                  as.connectWifi({
                    SSID: '9F-249-NanJing-Upark',
                    password: 'Fast*#06#',
                    partialInfo: '',
                    success: function (data) {
                      console.log('[AdvancedAPI] connectWifi success 26' + JSON.stringify(data))
                    },
                    fail: function (err) {
                      console.log('[AdvancedAPI] connectWifi fail 26' + JSON.stringify(err))
                    },
                    complete: (data) => {
                      console.log('[AdvancedAPI] connectWifi complete 26' + JSON.stringify(data))
                    }
                  })
                })

                // partialInfo 参数取值异常 undefined 前提：SSID + password 参数正常且对应
                Button('partialInfo 参数取值异常 undefined').width(300).onClick(() => {
                  // @ts-ignore
                  as.connectWifi({
                    SSID: '9F-249-NanJing-Upark',
                    password: 'Fast*#06#',
                    partialInfo: undefined,
                    success: function (data) {
                      console.log('[AdvancedAPI] connectWifi success 27' + JSON.stringify(data))
                    },
                    fail: function (err) {
                      console.log('[AdvancedAPI] connectWifi fail 27' + JSON.stringify(err))
                    },
                    complete: (data) => {
                      console.log('[AdvancedAPI] connectWifi complete 27' + JSON.stringify(data))
                    }
                  })
                })
              }.backgroundColor(Color.Orange)
            }
          }

          //onWifiConnected与offWifiConnected
          ListItem() {
            Column({ space: 10 }) {
              Button('onWifiConnected').width(300).onClick(() => {
                // @ts-ignore
                as.onWifiConnected(this.WifiConnectedCallback)
              })
              Button('onWifiConnected 2').width(300).onClick(() => {
                // @ts-ignore
                as.onWifiConnected(this.WifiConnectedCallback2)
              })
              Button('offWifiConnected 2').width(300).onClick(() => {
                // @ts-ignore
                as.offWifiConnected(this.WifiConnectedCallback2)
              })
              Button('offWifiConnected 不传参数').width(300).onClick(() => {
                // @ts-ignore
                as.offWifiConnected()
              })

              Button('onWifiConnectedWithPartialInfo').width(300).onClick(() => {
                // @ts-ignore
                as.onWifiConnectedWithPartialInfo(this.WifiConnectedWithPartialInfoCallback)
              })
              Button('onWifiConnectedWithPartialInfo 2').width(300).onClick(() => {
                // @ts-ignore
                as.onWifiConnectedWithPartialInfo(this.WifiConnectedWithPartialInfoCallback2)
              })
              Button('offWifiConnectedWithPartialInfo 2').width(300).onClick(() => {
                // @ts-ignore
                as.offWifiConnectedWithPartialInfo(this.WifiConnectedWithPartialInfoCallback2)
              })
              Button('offWifiConnectedWithPartialInfo 不传参数').width(300).onClick(() => {
                // @ts-ignore
                as.offWifiConnectedWithPartialInfo()
              })
            }
          }.backgroundColor(Color.Brown)
        }.divider({ strokeWidth: 2, color: 0xFFFFFF, startMargin: 20, endMargin: 20 }) // 每行之间的分界线
        .alignListItem(ListItemAlign.Center)
      }
    }
  }
}