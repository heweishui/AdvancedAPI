import promptAction from '@ohos.promptAction'
@Entry
@Component
struct navigateTo {
  scroller: Scroller = new Scroller()
  aboutToAppear() {

  }
  build() {
    Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center })  {
      Column({ space: 5 }) {
        List({ space: 20, initialIndex: 0 }) {
          ListItem(){
            Column({ space: 10 }) {
              Text("navigateTo").fontSize(30)
              Button('url String 主页面').width(300).onClick(() => {
                // @ts-ignore
                as.navigateTo({
                  url: 'pages/Index',
                  success: function (data) {
                    console.log('[AdvancedAPI] navigateTo success 0  data = ' + JSON.stringify(data))
                  },
                  fail: function (err) {
                    console.log('[AdvancedAPI] navigateTo fail 0  data = ' + JSON.stringify(err))
                  },
                  complete: function (data) {
                    console.log('[AdvancedAPI] navigateTo complete 0  data = ' + JSON.stringify(data))
                  }
                })
              })

              Button('url String tabbar页面').width(300).onClick(() => {
                // @ts-ignore
                as.navigateTo({
                  url: 'pages/Index?id=1&name=uniapp', //暂无法构造
                  success: function (data) {
                    console.log('[AdvancedAPI] navigateTo success 00  data = ' + JSON.stringify(data))
                  },
                  fail: function (err) {
                    console.log('[AdvancedAPI] navigateTo fail 00  data = ' + JSON.stringify(err))
                  },
                  complete: function (data) {
                    console.log('[AdvancedAPI] navigateTo complete 00  data = ' + JSON.stringify(data))
                  }
                })
              })

              Button('url String 非tabbar页面携带参数').width(300).onClick(() => {
                // @ts-ignore
                as.navigateTo({
                  url: 'pages/Index?id=1&name=uniapp',
                  success: function (data) {
                    console.log('[AdvancedAPI] navigateTo success 01  data = ' + JSON.stringify(data))
                  },
                  fail: function (err) {
                    console.log('[AdvancedAPI] navigateTo fail 01  data = ' + JSON.stringify(err))
                  },
                  complete: function (data) {
                    console.log('[AdvancedAPI] navigateTo complete 01  data = ' + JSON.stringify(data))
                  }
                })
              })

              Button('url String 非tabbar页面携带超长参数').width(300).onClick(() => {
                // @ts-ignore
                as.navigateTo({
                  url: 'pages/Index??jumpType=single&selectedTabIndex=index&ptag=jiudian&tactics=1&refid=1484836981&jumpUrl=https%3A%2F%2Fm.ly.com%2Fhotel%2Fhotellist%3Fcity%3D321%26pagesize%3D20%26versions%3Dtrue%26isnear%3D1%26pagefrom%3Dquickapp%26refid%3D1484836981%26if%3D26296%26of%3D2611043&__PARAM_LAUNCH_AG_DETAILID__=app%7CC100263269__HiAd__c8eb8384f481404ea795a19d38bad507__cds_310__20__null____null%3Faglocation%3D%257B%2522cres%2522%253A%257B%2522lPos%2522%253A0%252C%2522lid%2522%253A%2522902052%2522%252C%2522pos%2522%253A20%252C%2522relResId%2522%253A%2522C100263269%2522%252C%2522relType%2522%253A%2522app%2522%252C%2522resid%2522%253A%2522C100263269%2522%252C%2522rest%2522%253A%2522app%2522%252C%2522tid%2522%253A%2522dist_81ce30ee2e414e0cb62b6730a39a67cc%2522%257D%252C%2522ftid%2522%253A%2522dist_2bb2a5f464d3445580782b5a995ab7b9%2522%252C%2522pres%2522%253A%257B%2522lPos%2522%253A0%252C%2522pos%2522%253A9%252C%2522resid%2522%253A%252281ce30ee2e414e0cb62b6730a39a67cc%2522%252C%2522rest%2522%253A%2522tab%2522%252C%2522tid%2522%253A%2522dist_482e71b8f4372f4ebb4a5f837cb2e552%2522%257D%257D%26templateId%3D3a1fbe3fded741ebb004d9268572864f%26maple%3D0%26trackId%3D0%26appoid%3Dbc131112997e47e3a74ccd97638da8e4%26listId%3Dcds_310%26listIdType%3Dcds%26adFlag%3DHiAd%26cdrInfo%3D202204011608544l01j602705%255E%257BopType%257D%255E601561319%255EC100263269%255Ecds_310%255E20%255E608743720196880259_p20%255E608743720196880259%255Ef6f0a6376e692e0273e3738b7f9ef63adf9acb696d4a7d8ec3810b4f954b08b6566c1ff11fc1996740d949d28951de3bc54d292c455332a30332127ec8c0af7ecf735ef632f1803fdf2bd5784027586cd857619b25ecf451d2145b48f7cd91c9%255Ectr%255EfkM1MTU3%255E2022-04-01%2B16%253A08%253A54%255E%255EP40-Pro%255E0.035539%255E0%255E0.1%255E0.1%255E1502107218253455376%255E900086000000026339%255E20358%255E%255E%255E%255E12.1.1.302%255E1648800510525%255E0%255E1%255E%255E%255E%255E9%255E%255E0%255E%255E%255ECN%255ECNY%255E609388176304868500%255E%255E136636050038664803%255E%255E%255Ecd1471026d434c4fa2fad21fd34be185%255ECPC%255E67%255E%255E1502108026521264128%255E608743721296802994%255E%255EMA%255E%255E%255E%255E%255E%255E1%255E1%255E4010001%255E%255E6G%255E%255E0%255E%255E%255E%255E%255E%255E0%255E1%255E%255E%255E1sign%253A2ee7d7316e8c296c2add75759f73dc8e458234d92946d4cde5b69ff5972249a3%26version%3D2%26phase%3D0%26requestId%3Dcd1471026d434c4fa2fad21fd34be185',
                  success: function (data) {
                    console.log('[AdvancedAPI] navigateTo success  02 data = ' + JSON.stringify(data))
                  },
                  fail: function (err) {
                    console.log('[AdvancedAPI] navigateTo fail 02  data = ' + JSON.stringify(err))
                  },
                  complete: function (data) {
                    console.log('[AdvancedAPI] navigateTo complete 02  data = ' + JSON.stringify(data))
                  }
                })
              })

              Button('url String 自身页面').width(300).onClick(() => {
                // @ts-ignore
                as.navigateTo({
                  url: 'pages/pageAndRouter/navigateTo?id=1',
                  success: function (data) {
                    console.log('[AdvancedAPI] navigateTo success 03  data = ' + JSON.stringify(data))
                  },
                  fail: function (err) {
                    console.log('[AdvancedAPI] navigateTo fail 03  data = ' + JSON.stringify(err))
                  },
                  complete: function (data) {
                    console.log('[AdvancedAPI] navigateTo complete 03  data = ' + JSON.stringify(data))
                  }
                })
              })

              Button('url String 2层以上子页面').width(300).onClick(() => {
                // @ts-ignore
                as.navigateTo({
                  url: 'pages/media/image?id=1&name=uniapp',
                  success: function (data) {
                    console.log('[AdvancedAPI] navigateTo success 04  data = ' + JSON.stringify(data))
                  },
                  fail: function (err) {
                    console.log('[AdvancedAPI] navigateTo fail 04  data = ' + JSON.stringify(err))
                  },
                  complete: function (data) {
                    console.log('[AdvancedAPI] navigateTo complete 04  data = ' + JSON.stringify(data))
                  }
                })
              })

              Button('url 无此参数').width(300).onClick(() => {
                // @ts-ignore
                as.navigateTo({
                  // url: 'pages/media/image?id=1&name=uniapp',
                  success: function (data) {
                    console.log('[AdvancedAPI] navigateTo success  data = ' + JSON.stringify(data))
                  },
                  fail: function (err) {
                    console.log('[AdvancedAPI] navigateTo fail   data = ' + JSON.stringify(err))
                  },
                  complete: function (data) {
                    console.log('[AdvancedAPI] navigateTo complete   data = ' + JSON.stringify(data))
                  }
                })
              })

              Button('url Number').width(300).onClick(() => {
                // @ts-ignore
                as.navigateTo({
                  url: 7788,
                  success: function (data) {
                    console.log('[AdvancedAPI] navigateTo success  1 data = ' + JSON.stringify(data))
                  },
                  fail: function (err) {
                    console.log('[AdvancedAPI] navigateTo fail 1  data = ' + JSON.stringify(err))
                  },
                  complete: function (data) {
                    console.log('[AdvancedAPI] navigateTo complete 1  data = ' + JSON.stringify(data))
                  }
                })
              })

              Button('url Boolean').width(300).onClick(() => {
                // @ts-ignore
                as.navigateTo({
                  url: true,
                  success: function (data) {
                    console.log('[AdvancedAPI] navigateTo success 2  data = ' + JSON.stringify(data))
                  },
                  fail: function (err) {
                    console.log('[AdvancedAPI] navigateTo fail 2  data = ' + JSON.stringify(err))
                  },
                  complete: function (data) {
                    console.log('[AdvancedAPI] navigateTo complete 2  data = ' + JSON.stringify(data))
                  }
                })
              })

              Button('url Object').width(300).onClick(() => {
                // @ts-ignore
                as.navigateTo({
                  url: {'name':'test'},
                  success: function (data) {
                    console.log('[AdvancedAPI] navigateTo success 3  data = ' + JSON.stringify(data))
                  },
                  fail: function (err) {
                    console.log('[AdvancedAPI] navigateTo fail 3  data = ' + JSON.stringify(err))
                  },
                  complete: function (data) {
                    console.log('[AdvancedAPI] navigateTo complete 3  data = ' + JSON.stringify(data))
                  }
                })
              })

              Button('url null').width(300).onClick(() => {
                // @ts-ignore
                as.navigateTo({
                  url: null,
                  success: function (data) {
                    console.log('[AdvancedAPI] navigateTo success 4  data = ' + JSON.stringify(data))
                  },
                  fail: function (err) {
                    console.log('[AdvancedAPI] navigateTo fail 4  data = ' + JSON.stringify(err))
                  },
                  complete: function (data) {
                    console.log('[AdvancedAPI] navigateTo complete  4 data = ' + JSON.stringify(data))
                  }
                })
              })

              Button('url 空字符').width(300).onClick(() => {
                // @ts-ignore
                as.navigateTo({
                  url: '',
                  success: function (data) {
                    console.log('[AdvancedAPI] navigateTo success 5  data = ' + JSON.stringify(data))
                  },
                  fail: function (err) {
                    console.log('[AdvancedAPI] navigateTo fail 5  data = ' + JSON.stringify(err))
                  },
                  complete: function (data) {
                    console.log('[AdvancedAPI] navigateTo complete 5  data = ' + JSON.stringify(data))
                  }
                })
              })

              Button('url undefined').width(300).onClick(() => {
                // @ts-ignore
                as.navigateTo({
                  url: undefined,
                  success: function (data) {
                    console.log('[AdvancedAPI] navigateTo success 6  data = ' + JSON.stringify(data))
                  },
                  fail: function (err) {
                    console.log('[AdvancedAPI] navigateTo fail 6  data = ' + JSON.stringify(err))
                  },
                  complete: function (data) {
                    console.log('[AdvancedAPI] navigateTo complete 6  data = ' + JSON.stringify(data))
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