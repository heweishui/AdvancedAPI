// @ts-nocheck
import prompt from '@ohos.prompt'

@Entry
@Component
struct Bluetooth {
  @State disable1: boolean = true;
  @State disable2: boolean = false;
  @State disable3: boolean = false;
  @State disable4: boolean = false;
  @State disable5: boolean = false;
  @State disable6: boolean = false;
  @State disable7: boolean = false;
  @State disable8: boolean = false;
  @State disable9: boolean = false;
  @State disable10: boolean = false;
  @State discovering: boolean = false;
  @State showMaskType: string = 'device';
  @State maskShow: boolean = false;
  @State deviceList: object[] = [];
  @State selected_device: string = '';
  @State connected: boolean = false;
  private characteristics = [];
  private servicesList = [];
  private isStop = false;
  private equipment = [];
  private servicesData = [];
  private characteristicsData = [];
  private valueChangeData = {};
  private adapterState = [];
  private searchLoad = false;

  /**
   * 获取在蓝牙模块生效期间所有已发现的蓝牙设备。包括已经和本机处于连接状态的设备。
   */
  getBluetoothDevices() {
    as.getBluetoothDevices({
      success: res => {
        this.newDeviceLoad = false;
        this.deviceList = res.devices;
      },
      fail: e => {
        console.log('[AdvancedAPI] 获取蓝牙设备错误，错误码：' + e.errCode);
        if (e.errCode !== 0) {
          initTypes(e.errCode);
        }
      }
    });
  }

  getBluetoothAdapterState() {
    console.log('[AdvancedAPI] --->');
    as.getBluetoothAdapterState({
      success: res => {
        prompt.showToast({
          message: JSON.stringify(res)
        })
        console.log(`[AdvancedAPI] ${JSON.stringify(res)}`);
        this.adapterState = res;
      },
      fail: e => {
        console.log('[AdvancedAPI] 获取本机蓝牙适配器状态失败，错误码：' + e.errCode);
        if (e.errCode !== 0) {
          initTypes(e.errCode);
        }
      }
    });
  }

  /**
   * 发现外围设备
   */
  onBluetoothDeviceFound() {
    as.onBluetoothDeviceFound(devices => {
      this.getBluetoothDevices();
    });
  }

  private deviceFoundlistener = function (devices) {
    console.log('[AdvancedAPI] BluetoothDeviceFound ' + JSON.stringify(devices[0]))

  }

  private stateChangelistener = function (res) {
    console.log('[AdvancedAPI] stateChangeListener ' + JSON.stringify(res))

  }
  build() {
    Column() {
      Text("蓝牙").fontSize(35)
      List({ space: 20 }) {
        ListItem() {
          Stack() {
            Column({ space: 20 }) {
              Text('场景测试').fontSize(32)
              /**
               * 初始化蓝牙设备
               */
              Button("初始化蓝牙设备", { type: ButtonType.Normal, stateEffect: this.disable1 })
                .width(300)
                .onClick(() => {
                  if (!this.disable1) {
                    console.log('[AdvancedAPI] 蓝牙已开启');
                    return
                  }
                  as.openBluetoothAdapter({
                    success: e => {
                      console.log('[AdvancedAPI] 初始化蓝牙成功');
                      console.log(JSON.stringify(e));
                      this.disable1 = false;
                      this.disable2 = true;

                    },
                    fail: e => {
                      console.log(e)
                      console.log('[AdvancedAPI] 初始化蓝牙失败，错误码：' + (e.errCode || e.errMsg));
                      if (e.errCode !== 0) {
                        initTypes(e.errCode, e.errMsg);
                      }
                    }
                  });
                })
                .opacity(this.disable1 ? 1 : 0.4)
                .borderRadius(8)
                .backgroundColor(0x317aff)
              Button("获取蓝牙设备状态", { type: ButtonType.Normal })
                .width(300)
                .onClick(() => {
                  this.getBluetoothAdapterState();
                })
                .opacity(1)
                .borderRadius(8)
                .backgroundColor(0x317aff)
              if (this.disable1) {
                Text('蓝牙设备不可用，请初始化蓝牙模块').fontSize(12)
              }
              Button({ type: ButtonType.Normal, stateEffect: this.disable2 }) {
                Row() {
                  if (this.discovering) {
                    LoadingProgress().width(16).height(16).margin({ left: 12 }).color(0xFFFFFF)
                  }
                  Text('开始搜索蓝牙设备').fontSize(16).fontColor(0xffffff).margin({ left: 5, right: 12 })
                }.alignItems(VerticalAlign.Center)
              }
              .width(300)
              .onClick(() => {
                as.startBluetoothDevicesDiscovery({
                  success: e => {
                    console.log('开始搜索蓝牙设备:' + e.errMsg);
                    this.disable3 = true;
                    this.disable4 = true;
                    this.discovering = true;
                    this.onBluetoothDeviceFound();
                  },
                  fail: e => {
                    console.log('[AdvancedAPI] 搜索蓝牙设备失败，错误码：' + e.errCode);
                    if (e.errCode !== 0) {
                      initTypes(e.errCode);
                    }
                  }
                });
              })
              .opacity(this.disable2 ? 1 : 0.4)
              .borderRadius(8)
              .backgroundColor(0x317aff)
              .height(40)

              Button("停止搜索蓝牙设备", { type: ButtonType.Normal, stateEffect: this.disable3 })
                .width(300)
                .onClick(() => {
                  as.stopBluetoothDevicesDiscovery({
                    success: e => {
                      console.log('[AdvancedAPI] 停止搜索蓝牙设备:' + e.errMsg);
                      this.disable3 = false;
                      this.discovering = false;
                      this.searchLoad = false;
                    },
                    fail: e => {
                      console.log('[AdvancedAPI] 停止搜索蓝牙设备失败，错误码：' + e.errCode);
                      if (e.errCode !== 0) {
                        initTypes(e.errCode);
                      }
                    }
                  });
                })
                .opacity(this.disable3 ? 1 : 0.4)
                .borderRadius(8)
                .backgroundColor(0x317aff)
              Button("选择设备", { type: ButtonType.Normal, stateEffect: this.disable4 })
                .width(300)
                .onClick(() => {
                  // this.newDeviceLoad = true;
                  this.showMaskType = 'device';
                  this.maskShow = true;
                })
                .opacity(this.disable4 ? 1 : 0.4)
                .borderRadius(8)
                .backgroundColor(0x317aff)
              if (this.selected_device != '') {
                Text(`已选择设备:${this.selected_device}`).fontSize(12)

                Button("连接蓝牙设备(仅支持低功耗设备)", {
                  type: ButtonType.Normal,
                  stateEffect: this.selected_device != ''
                })
                  .width(300)
                  .onClick(() => {
                    let deviceId = this.selected_device;
                    as.showToast({
                      title: `连接蓝牙:${deviceId}...`,
                      icon: 'loading',
                      duration: 99999
                    });
                    as.createBLEConnection({
                      // 这里的 deviceId 需要已经通过 createBLEConnection 与对应设备建立链接
                      deviceId,
                      success: res => {
                        console.log(res);
                        console.log('[AdvancedAPI] 开始连接蓝牙...');
                        // 连接设备后断开搜索 并且不能搜索设备
                        as.stopBluetoothDevicesDiscovery({
                          success: e => {
                            console.log('[AdvancedAPI] 停止搜索蓝牙设备:' + e.errMsg);
                            this.disable3 = false;
                            this.discovering = false;
                            this.searchLoad = false;
                          },
                          fail: e => {
                            console.log('[AdvancedAPI] 停止搜索蓝牙设备失败，错误码：' + e.errCode);
                            if (e.errCode !== 0) {
                              initTypes(e.errCode);
                            }
                          }
                        });
                        this.connected = true;
                      },
                      fail: e => {
                        console.log('[AdvancedAPI] 连接低功耗蓝牙失败，错误码：' + e.errCode);
                        if (e.errCode !== 0) {
                          initTypes(e.errCode);
                        }
                      }
                    });
                  })
                  .opacity(this.selected_device != '' ? 1 : 0.4)
                  .borderRadius(8)
                  .backgroundColor(0x317aff)
              }
              Button("断开蓝牙设备", { type: ButtonType.Normal, stateEffect: this.connected })
                .width(300)
                .onClick(() => {
                  let deviceId = this.selected_device;
                  as.closeBLEConnection({
                    deviceId,
                    success: res => {
                      console.log(res);
                      console.log('[AdvancedAPI] 断开低功耗蓝牙成功:');
                      this.connected = false;
                    },
                    fail: e => {
                      console.log('[AdvancedAPI] 断开低功耗蓝牙成功');
                      if (e.errCode !== 0) {
                        initTypes(e.errCode);
                      }
                    }
                  });
                })
                .opacity(this.connected ? 1 : 0.4)
                .borderRadius(8)
                .backgroundColor(0x317aff)
              Button("关闭蓝牙模块", { type: ButtonType.Normal, stateEffect: !this.disable1 })
                .width(300)
                .onClick(() => {
                  as.closeBluetoothAdapter({
                    success: () => {
                      console.log('断开蓝牙模块成功');
                      this.isStop = true;
                      this.disable1 = true;
                      this.disable2 = false;
                      this.disable3 = false;
                      this.disable4 = false;
                      this.disable5 = false;
                      this.disable6 = false;
                      this.disable7 = false;
                      this.disable8 = false;
                      this.disable9 = false;
                      this.disable10 = false;
                      this.equipment = [];
                      this.servicesData = [];
                      this.characteristicsData = [];
                      this.valueChangeData = {};
                      this.adapterState = [];
                      this.searchLoad = false;
                      this.deviceList = [];
                      toast('断开蓝牙模块');
                    }
                  });
                })
                .opacity(!this.disable1 ? 1 : 0.4)
                .borderRadius(8)
                .backgroundColor(0x317aff)
              Text(`上划展示接口测试`).fontSize(24)
            }
            .justifyContent(FlexAlign.Start)
            .alignItems(Align.Center)
            .onClick(() => {
              console.info('AdvancedAPI column click')
              this.maskShow = false
            })
            .borderWidth(1)
            .borderColor(0xa7a2a2)
            .width('100%')
            .height('100%')

            if (this.maskShow) {
              Column() {
              }
              .width('100%')
              .height('100%')
              .backgroundColor(0x000000)
              .opacity(0.6)
              .onClick(() => {
                console.info('AdvancedAPI column click')
                this.maskShow = false
              })

              Column() {
                Text(`已经发现 ${this.deviceList.length} 台设备`).fontSize(18).width('100%').textAlign(TextAlign.Center)
                List({ space: 10 }) {
                  ForEach(this.deviceList, (listItem) => {
                    ListItem() {
                      Column() {
                        Text(`${listItem.name}`).fontSize(14).fontColor(0x317aff)
                        Text(`信号强度:${listItem.RSSI} dBm`).fontSize(12)
                        Text(`UUID   :${listItem.deviceId}`).fontSize(12)
                      }.width('100%').alignItems(Align.Start)
                    }.onClick(() => {
                      this.maskShow = false;
                      this.selected_device = listItem.deviceId;
                      console.info('AdvancedAPI 选择设备：' + this.selected_device)
                    })
                  })
                }
                .divider({ strokeWidth: 1, color: 0xa7a2a2, startMargin: 0, endMargin: 0 }) // 每行之间的分界线
              }
              .width(300)
              .height(400)
              .backgroundColor(0xffffff)
              .alignItems(Align.Center)
              .justifyContent(FlexAlign.Center)
            }
          }.alignContent(Alignment.Center).width('100%').height('100%')
        }

        ListItem() {
          Text('蓝牙模块接口测试').fontSize(28)
        }

        ListItem() {
          Button("as.openBluetoothAdapter").width(300).onClick(() => {
            as.openBluetoothAdapter({
              success: function (res) {
                prompt.showToast({
                  message: 'openBluetoothAdapter success'
                })
                console.log('[AdvancedAPI] openBluetoothAdapter success');
              }
            });
          })
        }

        ListItem() {
          Button("as.closeBluetoothAdapter").width(300).onClick(() => {
            as.closeBluetoothAdapter({
              success: function (res) {
                prompt.showToast({
                  message: 'closeBluetoothAdapter success'
                })
                console.log('[AdvancedAPI] closeBluetoothAdapter success');
              }
            });
          })
        }

        ListItem() {
          Button("as.startBluetoothDevicesDiscovery").width(300).onClick(() => {
            as.startBluetoothDevicesDiscovery({
              allowDuplicatesKey: false,
              interval: 500,
              success: function (res) {
                prompt.showToast({
                  message: 'startBluetoothDevicesDiscovery success'
                })
                console.log('[AdvancedAPI]startBluetoothDevicesDiscovery success')
              }
            });
          })
        }

        ListItem() {
          Button("as.stopBluetoothDevicesDiscovery").width(300).onClick(() => {
            as.stopBluetoothDevicesDiscovery({
              success: function (res) {
                prompt.showToast({
                  message: 'stopBluetoothDevicesDiscovery success'
                })
                console.log('[AdvancedAPI]stopBluetoothDevicesDiscovery success' + JSON.stringify(res))
              }
            });
          })
        }

        ListItem() {
          Button("as.getBluetoothDevices").width(300).onClick(() => {
            as.getBluetoothDevices({
              success: function (res) {
                if (res.devices[0]) {
                  prompt.showToast({
                    message: `getBluetoothDevices dievces[0]:${JSON.stringify(res.devices[0])}`
                  })
                  console.log('[AdvancedAPI] getBluetoothDevices, size = ' + res.devices.length + ' dievces[0]:' + JSON.stringify(res.devices[0]))
                }
              }
            });
          })
        }

        ListItem() {
          Button("as.onBluetoothDeviceFound").width(300).onClick(() => {
            as.onBluetoothDeviceFound(this.deviceFoundlistener);
          })
        }

        ListItem() {
          Button("as.offBluetoothDeviceFound").width(300).onClick(() => {
            as.offBluetoothDeviceFound(this.deviceFoundlistener);
          })
        }
        ListItem() {
          Button("offBluetoothDeviceFound clear all").width(300).onClick(() => {
            as.offBluetoothDeviceFound();
          })
        }
        ListItem() {
          Button("as.onBluetoothAdapterStateChange").width(300).onClick(() => {
            as.onBluetoothAdapterStateChange(this.stateChangelistener);
          })
        }

        ListItem() {
          Button("as.offBluetoothAdapterStateChange").width(300).onClick(() => {
            as.offBluetoothAdapterStateChange(this.stateChangelistener);
          })
        }
        ListItem() {
          Button("offBluetoothAdapterStateChange clear all").width(300).onClick(() => {
            as.offBluetoothAdapterStateChange();
          })
        }

        ListItem() {
          Button("as.getConnectedBluetoothDevices").width(300).onClick(() => {
            let services = []
            this.servicesList.forEach(item => {
              services.push(item.uuid)
            })
            console.info('AdvancedAPI start call getConnectedBluetoothDevices, services = ' + JSON.stringify(services))
            as.getConnectedBluetoothDevices({
              services,
              success: function (res) {
                prompt.showToast({
                  message: `getConnectedBluetoothDevices :${JSON.stringify(res)}`
                })
                console.log('[AdvancedAPI] getConnectedBluetoothDevices success' + JSON.stringify(res))
              },
              fail: function (data) {
                prompt.showToast({
                  message: `fail :${JSON.stringify(data)}`
                })
                console.log('[AdvancedAPI] getConnectedBluetoothDevices fail' + JSON.stringify(data))
              }
            });
          })
        }

        ListItem() {
          Text("低功耗蓝牙模块接口测试").fontSize(28)
        }

        ListItem() {
          Button("as.setBLEMTU").width(300).onClick(() => {
            const deviceId = this.selected_device
            as.setBLEMTU({
              deviceId,
              mtu: 128,
              success: function () {
                console.log('[AdvancedAPI] setBLEMTU success')
              }
            });
          })
        }

        ListItem() {
          Button("as.writeBLECharacteristicValue").width(300).onClick(() => {
            const buffer = new ArrayBuffer(1)
            const dataView = new DataView(buffer)
            dataView.setUint8(0, 0)
            as.writeBLECharacteristicValue({
              // 这里的 deviceId 需要在 getBluetoothDevices 或 onBluetoothDeviceFound 接口中获取
              deviceId:this.selected_device,
              // 这里的 serviceId 需要在 getBLEDeviceServices 接口中获取
              serviceId:'0000aaa8-0000-1000-8000-00805f9b34fb',
              // 这里的 characteristicId 需要在 getBLEDeviceCharacteristics 接口中获取
              characteristicId:'0000aad8-0000-1000-8000-00805f9b34fb',
              // 这里的value是ArrayBuffer类型
              value: buffer,
              success:(res)=> {
                console.log('[AdvancedAPI] writeBLECharacteristicValue success', res.errMsg)
              },
              fail:res=>{
                console.log('[AdvancedAPI] writeBLECharacteristicValue success', res.errMsg)
              }
            })
          })
        }

        ListItem() {
          Button("as.readBLECharacteristicValue").width(300).onClick(() => {
            as.readBLECharacteristicValue({
              // 这里的 deviceId 需要已经通过 createBLEConnection 与对应设备建立链接
              deviceId: this.selected_device,
              // 这里的 serviceId 需要在 getBLEDeviceServices 接口中获取
              serviceId: '0000aaa8-0000-1000-8000-00805f9b34fb',
              // 这里的 characteristicId 需要在 getBLEDeviceCharacteristics 接口中获取
              characteristicId:  '0000aad8-0000-1000-8000-00805f9b34fb',
              success: (res)=> {
                console.log('[AdvancedAPI] readBLECharacteristicValue success:', JSON.stringify(res))
              },
              fail: res => {
                console.error('[AdvancedAPI] readBLECharacteristicValue fail:', JSON.stringify(res))
              }
            })
          })
        }

        ListItem() {
          Button("as.onBLEConnectionStateChange").width(300).onClick(() => {
            as.onBLEConnectionStateChange(function (res) {
              // 该方法回调中可以用于处理连接意外断开等异常情况
              console.log(`[AdvancedAPI] device ${res.deviceId} state has changed, connected: ${res.connected}`)
            })
          })
        }

        ListItem() {
          Button("as.onBLECharacteristicValueChange").width(300).onClick(() => {
            as.onBLECharacteristicValueChange(function (res) {
              console.log(`[AdvancedAPI]characteristic ${res.characteristicId} has changed, now is ${res.value}`)
            })
          })
        }

        ListItem() {
          Button("as.notifyBLECharacteristicValueChange").width(300).onClick(() => {

            as.notifyBLECharacteristicValueChange({
              state: true, // 启用 notify 功能
              // 这里的 deviceId 需要已经通过 createBLEConnection 与对应设备建立链接
              deviceId: this.selected_device,
              // 这里的 serviceId 需要在 getBLEDeviceServices 接口中获取
              serviceId: '0000aaa8-0000-1000-8000-00805f9b34fb',
              // 这里的 characteristicId 需要在 getBLEDeviceCharacteristics 接口中获取
              characteristicId: '0000aad8-0000-1000-8000-00805f9b34fb',
              success:(res)=> {
                console.log('[AdvancedAPI] notifyBLECharacteristicValueChange success', res.errMsg)
              },
              fail:res=>{
                console.log('[AdvancedAPI] notifyBLECharacteristicValueChange fail', res.errMsg)
              }
            })
          })
        }

        ListItem() {
          Button("as.getBLEDeviceServices").width(300).onClick(() => {
            as.getBLEDeviceServices({
              // 这里的 deviceId 需要已经通过 createBLEConnection 与对应设备建立链接
              deviceId: this.selected_device,
              success: (res) => {
                console.log('[AdvancedAPI]getBLEDeviceServices services:', typeof res.services + res.services.length)
                this.servicesList = res.services
                console.log('[AdvancedAPI]getBLEDeviceServices services2:', JSON.stringify(this.servicesList))
              }
            })
          })
        }

        ListItem() {
          Button("as.getBLEDeviceRSSI").width(300).onClick(() => {
            as.getBLEDeviceRSSI({
              deviceId: this.selected_device,
              success: function (res) {
                console.log('[AdvancedAPI] getBLEDeviceRSSI res = ' + JSON.stringify(res))
              }
            });
          })
        }

        ListItem() {
          Button("as.getBLEDeviceCharacteristics").width(300).onClick(() => {
            const deviceId = this.selected_device
            const serviceId = this.servicesList[1].uuid
            console.info('[AdvancedAPI] getBLEDeviceCharacteristics start deviceId = ' + deviceId + ' serviceId = ' + serviceId)
            as.getBLEDeviceCharacteristics({
              // 这里的 deviceId 需要已经通过 createBLEConnection 与对应设备建立链接
              deviceId,
              // 这里的 serviceId 需要在 getBLEDeviceServices 接口中获取
              serviceId,
              success:(res) => {
                console.log('[AdvancedAPI]device getBLEDeviceCharacteristics2:', typeof res.characteristics, JSON.stringify(res.characteristics))
                this.characteristics = res.characteristics
                console.log('[AdvancedAPI]device getBLEDeviceCharacteristics3:', JSON.stringify(this.characteristics))
              },
              fail:(res)=>{
                console.log('[AdvancedAPI]device getBLEDeviceCharacteristics fail')
              }
            })
          })
        }

        ListItem() {
          Button("as.createBLEConnection").width(300).onClick(() => {
            as.createBLEConnection({
              // 这里的 deviceId 需要已经通过 createBLEConnection 与对应设备建立链接
              deviceId: this.selected_device,
              success: function (res) {
                console.log('[AdvancedAPI] createBLEConnection ' + res)
              }
            })
          })
        }

        ListItem() {
          Button("as.closeBLEConnection").width(300).onClick(() => {
            as.closeBLEConnection({
              deviceId: this.selected_device,
              success(res) {
                console.log('[AdvancedAPI] closeBLEConnection ' + res)
              }
            })
          })
        }
      }.listDirection(Axis.Vertical) // 排列方向
      .divider({ strokeWidth: 2, color: 0xFFFFFF, startMargin: 20, endMargin: 20 }) // 每行之间的分界线
      .alignListItem(ListItemAlign.Center)
    }
  }
}