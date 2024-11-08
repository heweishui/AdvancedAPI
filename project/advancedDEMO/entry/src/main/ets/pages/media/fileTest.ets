// @ts-nocheck
import promptAction from '@ohos.promptAction'

@Entry
@Component
struct file {
  aboutToAppear() {
  }

  build() {
    Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
      Column({ space: 5 }) {
        List({ space: 20, initialIndex: 0 }) {
          ListItem(){
            Text("文件").fontSize(35)
          }
          ListItem(){
            Column({ space: 10 }) {
              Text("as. chooseFile (Object)").fontSize(30)
              //count 参数取值正常值内 Number
              Button("count 取值正常 ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseFile({
                  count: 6,
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.chooseFile  count success ' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.chooseFile count fail ' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.chooseFile count complete ' + JSON.stringify(res));
                  }
                })
              })
              //count 参数 Number -7  小于
              Button("count  -7 ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseFile({
                  count: -7,
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.chooseFile  count success 1 ' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.chooseFile count fail 1' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.chooseFile count complete 1' + JSON.stringify(res));
                  }
                })
              })
              //count 参数 Number 12  大于
              Button("count 12 ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseFile({
                  count: 12,
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.chooseFile  count success 2' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.chooseFile count fail 2' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.chooseFile count complete 2' + JSON.stringify(res));
                  }
                })
              })
              //count 参数 Number 0  极端值
              Button("count 0 ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseFile({
                  count: 0,
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.chooseFile  count success 3' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.chooseFile count fail 3' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.chooseFile count complete 3' + JSON.stringify(res));
                  }
                })
              })
              //count 无此参数
              Button("无此参数count ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseFile({
                  //                  count: 6,
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.chooseFile  count success 4' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.chooseFile count fail 4' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.chooseFile count complete 4' + JSON.stringify(res));
                  }
                })
              })
              //count 参数取值类型不同 boolean
              Button("count boolean ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseFile({
                  count: true,
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.chooseFile  count success 5' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.chooseFile count fail 5' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.chooseFile count complete 5 ' + JSON.stringify(res));
                  }
                })
              })
              //count 参数取值类型不同 String
              Button("count String ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseFile({
                  count: 'test',
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.chooseFile  count success 6' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.chooseFile count fail 6' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.chooseFile count complete 6' + JSON.stringify(res));
                  }
                })
              })
              //count 参数取值类型不同 Object
              Button("count Object ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseFile({
                  count: { 'name':'test' },
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.chooseFile  count success 7' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.chooseFile count fail 7' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.chooseFile count complete 7' + JSON.stringify(res));
                  }
                })
              })
              //count 参数取值异常 null
              Button("count null ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseFile({
                  count: null,
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.chooseFile  count success 8' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.chooseFile count fail 8' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.chooseFile count complete 8' + JSON.stringify(res));
                  }
                })
              })
              //count 参数取值异常 空字符
              Button("count 空字符 ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseFile({
                  count: '',
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.chooseFile  count success 9' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.chooseFile count fail 9' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.chooseFile count complete 9' + JSON.stringify(res));
                  }
                })
              })
              //count 参数取值异常 undefined
              Button("count undefined ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseFile({
                  count: undefined,
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.chooseFile  count success 10' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.chooseFile count fail 10' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.chooseFile count complete 10' + JSON.stringify(res));
                  }
                })
              })

              //sourceType 参数 Array<String>  album
              Button("sourceType album ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseFile({
                  sourceType: ['album'],
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.chooseFile  sourceType success ' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.chooseFile sourceType fail ' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.chooseFile sourceType complete ' + JSON.stringify(res));
                  }
                })
              })
              //sourceType 参数 Array<String>  camera
              Button("sourceType camera ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseFile({
                  sourceType: ['camera'],
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.chooseFile  sourceType success 0' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.chooseFile sourceType fail 0' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.chooseFile sourceType complete 0' + JSON.stringify(res));
                  }
                })
              })
              //sourceType 参数 Array<String> camera，album
              Button("sourceType camera，album ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseFile({
                  sourceType: ['camera','album'],
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.chooseFile  sourceType success 00' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.chooseFile sourceType fail 00' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.chooseFile sourceType complete 00' + JSON.stringify(res));
                  }
                })
              })
              //sourceType 无此参数
              Button("sourceType 无此参数 ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseFile({
                  //                  sourceType: ['album'],
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.chooseFile  sourceType success 1 ' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.chooseFile sourceType fail 1' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.chooseFile sourceType complete ' + JSON.stringify(res));
                  }
                })
              })
              //sourceType 参数取值类型不同 boolean
              Button("sourceType boolean ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseFile({
                  sourceType: true,
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.chooseFile  sourceType success 2' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.chooseFile sourceType fail 2' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.chooseFile sourceType complete 2' + JSON.stringify(res));
                  }
                })
              })
              //sourceType 参数取值类型不同 String
              Button("sourceType String ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseFile({
                  sourceType: 'album',
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.chooseFile  sourceType success 3' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.chooseFile sourceType fail 3' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.chooseFile sourceType complete 3' + JSON.stringify(res));
                  }
                })
              })
              //sourceType 参数取值类型不同 Object
              Button("sourceType Object ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseFile({
                  sourceType: {'cate':'album'},
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.chooseFile  sourceType success 4' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.chooseFile sourceType fail 4' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.chooseFile sourceType complete 4' + JSON.stringify(res));
                  }
                })
              })
              //sourceType 参数取值异常 null
              Button("sourceType null ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseFile({
                  sourceType: null,
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.chooseFile  sourceType success 5' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.chooseFile sourceType fail 5' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.chooseFile sourceType complete 5' + JSON.stringify(res));
                  }
                })
              })
              //sourceType 参数取值异常 空字符
              Button("sourceType 空字符 ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseFile({
                  sourceType: '',
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.chooseFile  sourceType success 6' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.chooseFile sourceType fail 6' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.chooseFile sourceType complete 6 ' + JSON.stringify(res));
                  }
                })
              })
              //sourceType 参数取值异常 undefined
              Button("sourceType undefined ").width(300).onClick(()=>{
                // @ts-ignore
                as.chooseFile({
                  sourceType: undefined,
                  success: function (res) {
                    console.log('[AdvancedAPIDEMO] as.chooseFile  sourceType success 7' + JSON.stringify(res));
                  },
                  fail: (res) => {
                    console.error('[AdvancedAPIDEMO] as.chooseFile sourceType fail 7' + JSON.stringify(res));
                  },
                  complete: (res) => {
                    console.log('[AdvancedAPIDEMO] as.chooseFile sourceType complete 7' + JSON.stringify(res));
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