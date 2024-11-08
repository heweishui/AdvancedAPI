// @ts-nocheck
import prompt from '@ohos.prompt'
@Entry
@Component
struct Clipboard {
  @State text: string = ''
  aboutToAppear() {
  }
/*
  data：2023/04/18
 */

  build() {
    Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
      Column({ space: 20 }) {
        Text("拨打电话").fontSize(35)

        List({ space: 20, initialIndex: 0 }){
          ListItem(){
            Column ({ space: 10 }) {
              Text('makePhoneCall').fontSize(28).backgroundColor(Color.Orange)
              // makePhoneCall   phoneNumber  String 正常入参
              Button("phoneNumber String正常值").width(300).onClick(() => {
                as.makePhoneCall({
                  phoneNumber: '18112973134',
                  success: function (res) {
                    console.log('[AdvancedAPI] makePhoneCall success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI] makePhoneCall fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI] makePhoneCall complete' + JSON.stringify(res))
                  }
                })
              })

              // makePhoneCall   phoneNumber -String 非number入参   success
              Button("phoneNumber String 非number入参").width(300).onClick(() => {
                as.makePhoneCall({
                  phoneNumber: 'test',
                  success: function (res) {
                    console.log('[AdvancedAPI] makePhoneCall success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI] makePhoneCall fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI] makePhoneCall complete' + JSON.stringify(res))
                  }
                })
              })

              // makePhoneCall   phoneNumber -String 检验含参是否对电话或手机位数校验  success
              Button("phoneNumber String 对手机位数").width(300).onClick(() => {
                as.makePhoneCall({
                  phoneNumber: '052312457896541236548892',
                  success: function (res) {
                    console.log('[AdvancedAPI] makePhoneCall success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI] makePhoneCall fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI] makePhoneCall complete' + JSON.stringify(res))
                  }
                })
              })

              // makePhoneCall   phoneNumber -无此参数验证   闪退
              Button("phoneNumber 无此参数").width(300).onClick(() => {
                as.makePhoneCall({
//                   phoneNumber: '18112973134',
                  success: function (res) {
                    console.log('[AdvancedAPI] makePhoneCall success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI] makePhoneCall fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI] makePhoneCall complete' + JSON.stringify(res))
                  }
                })
              })

              // makePhoneCall   phoneNumber -int参数验证   闪退
              Button("phoneNumber int").width(300).onClick(() => {
                as.makePhoneCall({
                  phoneNumber: 115,
                  success: function (res) {
                    console.log('[AdvancedAPI] makePhoneCall success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI] makePhoneCall fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI] makePhoneCall complete' + JSON.stringify(res))
                  }
                })
              })

              // makePhoneCall   phoneNumber -object参数验证 闪退
              Button("phoneNumber object").width(300).onClick(() => {
                as.makePhoneCall({
                  phoneNumber: {'name':'18112973134'},
                  success: function (res) {
                    console.log('[AdvancedAPI] makePhoneCall success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI] makePhoneCall fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI] makePhoneCall complete' + JSON.stringify(res))
                  }
                })
              })

              // makePhoneCall   phoneNumber -boolean参数验证 true 闪退
              Button("phoneNumber boolean（true） ").width(300).onClick(() => {
                as.makePhoneCall({
                  phoneNumber: true,
                  success: function (res) {
                    console.log('[AdvancedAPI] makePhoneCall success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI] makePhoneCall fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI] makePhoneCall complete' + JSON.stringify(res))
                  }
                })
              })

              // makePhoneCall   phoneNumber -boolean参数验证 false  闪退
              Button("phoneNumber boolean（false）").width(300).onClick(() => {
                as.makePhoneCall({
                  phoneNumber: false,
                  success: function (res) {
                    console.log('[AdvancedAPI] makePhoneCall success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI] makePhoneCall fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI] makePhoneCall complete' + JSON.stringify(res))
                  }
                })
              })

              // makePhoneCall   phoneNumber --空字符参数验证  sucess
              Button("phoneNumber 空字符").width(300).onClick(() => {
                as.makePhoneCall({
                  phoneNumber: '',
                  success: function (res) {
                    console.log('[AdvancedAPI] makePhoneCall success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI] makePhoneCall fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI] makePhoneCall complete' + JSON.stringify(res))
                  }
                })
              })

              // makePhoneCall   phoneNumber --null参数验证  闪退
              Button("phoneNumber null").width(300).onClick(() => {
                as.makePhoneCall({
                  phoneNumber: null,
                  success: function (res) {
                    console.log('[AdvancedAPI] makePhoneCall success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI] makePhoneCall fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI] makePhoneCall complete' + JSON.stringify(res))
                  }
                })
              })

              // makePhoneCall   phoneNumber --undefined参数验证  闪退
              Button("phoneNumber undefined").width(300).onClick(() => {
                as.makePhoneCall({
                  phoneNumber: undefined,
                  success: function (res) {
                    console.log('[AdvancedAPI] makePhoneCall success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI] makePhoneCall fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI] makePhoneCall complete' + JSON.stringify(res))
                  }
                })
              })
            }.alignItems(HorizontalAlign.Center).width('90%').border({ width: 1 })
          }
        }.divider({ strokeWidth: 2, color: 0xFFFFFF, startMargin: 20, endMargin: 20 }) // 每行之间的分界线
        .alignListItem(ListItemAlign.Center)
      }
    }
  }
}