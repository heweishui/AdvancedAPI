import common from '@ohos.app.ability.common'
import contact from '@ohos.contact'
import promptAction from '@ohos.promptAction'
import abilityAccessCtrl from '@ohos.abilityAccessCtrl'

@Entry
@Component
struct Contact {
  netId = 0

  build() {
    Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
      Column({ space: 5 }) {
        List({ space: 20, initialIndex: 0 }){
          ListItem() {
            Column ({ space: 10 }) {
              Text("联系人 contact").fontSize(35)
              Button('添加联系人').width(300).onClick(() => {
                // @ts-ignore
                as.addPhoneContact({
                  lastName: '王',
                  firstName: '小明',
                  photoFilePath: '', // 当前手机不支持上传头像
                  mobilePhoneNumber: '13912345678',
                  addressCountry: '中国',
                  workPhoneNumber: '15212345678',
                  homeAddressCountry: '中国',
                  homeAddressState: '江苏',
                  homeAddressCity: '南京',
                  homeAddressStreet: '秣周东路',
                  url: 'baidu.com',
                  organization: 'xxxx公司',
                  title: 'XXXX职位',
                  success: function (data) {
                    console.log('[AdvancedAPI] addPhoneContact success ' + JSON.stringify(data))
                    promptAction.showToast({
                      message: '添加联系人成功'
                    })
                  },
                  fail: function (err) {
                    console.log('[AdvancedAPI] addPhoneContact fail err = ' + JSON.stringify(err))
                    promptAction.showToast({
                      message: '添加联系人失败'
                    })
                  }
                })
              })

              Button('temp: 鸿蒙接口添加联系人').width(300).onClick(async  () => {
                const context = getContext(this) as common.UIAbilityContext;
                // @ts-ignore
                let atManager = abilityAccessCtrl.createAtManager()
                await atManager.requestPermissionsFromUser(context,['ohos.permission.WRITE_CONTACTS'])
                const contactInfo = {
                  name: {fullName: '王小明'},
                  emails: [{
                    email: '1111@qq.com',
                    displayName: 'QQ邮箱'  // 没有生效
                  }],
                  //phoneNumbers: [{ phoneNumber: '13912345678', labelName: '住宅', labelId: contact.PhoneNumber.NUM_HOME }],
                  postalAddresses: [{
                    city: '南京', country: '中国', postcode: '000000',
                    street: 'XXX街道',
                    postalAddress: 'XXXX地址',
                    labelId: contact.PostalAddress.ADDR_HOME  // 没有生效
                  }],
                  websites: [{ website: 'www.baidu.com' }],
                  organization: { // ok
                    name: 'XXXX公司',
                    title: 'XXX职位'
                  },
                  note: { noteContent: '备注内容' }, // ok
                  nickName: {  // 没有生效
                    nickName: '昵称'
                  }
                }
                let phoneNumber = new contact.PhoneNumber();
                phoneNumber.phoneNumber = "13800000000";
                phoneNumber.labelId = contact.PhoneNumber.NUM_HOME;
                phoneNumber.labelName = '住宅';
                // @ts-ignore
                contactInfo.phoneNumbers = [phoneNumber]
                contact.addContact(contactInfo).then((contactId) => {
                  console.log(`[AdvancedAPI] addContact callback: success contactId = ${contactId}`)
                }).catch((err) => {
                  console.log(`[AdvancedAPI] addContact callback: err->${JSON.stringify(err)}`)
                })
              })
            }
          }
          // addPhoneContact -必填参数 firstName
          ListItem(){
            Column ({ space: 10 }) {
              Text('addPhoneContact -必填参数 firstName ').fontSize(35)
              // 正常验证联系人 set
              Button("firstName 正常入参String").width(300).onClick(() => {
                // @ts-ignore
                as.addPhoneContact({
                  firstName: 'hello',
                  success: function (res) {
                    console.log('[AdvancedAPI]  addPhoneContact--firstName success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI]  addPhoneContact--firstName fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI]  addPhoneContact--firstName complete' + JSON.stringify(res))
                  }
                })
              })

              // 联系人 .addPhoneContact--firstName-无此参数验证  fail
              Button("无此参数").width(300).onClick(() => {
                // @ts-ignore
                as.addPhoneContact({
                  //             firstName: 'hello',
                  success: function (res) {
                    console.log('[AdvancedAPI]  addPhoneContact--firstName1 success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI]  addPhoneContact--firstName1 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI]  addPhoneContact--firstName1 complete' + JSON.stringify(res))
                  }
                })
              })

              // 联系人 .addPhoneContact--firstName-int参数验证   fail
              Button("Number").width(300).onClick(() => {
                // @ts-ignore
                as.addPhoneContact({
                  firstName: 1111,
                  success: function (res) {
                    console.log('[AdvancedAPI]  addPhoneContact--firstName2 success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI]  addPhoneContact--firstName2 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI]  addPhoneContact--firstName2 complete' + JSON.stringify(res))
                  }
                })
              })

              // 联系人 .addPhoneContact--firstName-object参数验证 fail
              Button("Object").width(300).onClick(() => {
                // @ts-ignore
                as.addPhoneContact({
                  firstName: { "name":"aaa" },
                  success: function (res) {
                    console.log('[AdvancedAPI]  addPhoneContact--firstName3 success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI]  addPhoneContact--firstName3 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI]  addPhoneContact--firstName3 complete'+ JSON.stringify(res))
                  }
                })
              })

              // 联系人 .addPhoneContact--firstName-boolean参数验证 fail
              Button("Boolean").width(300).onClick(() => {
                // @ts-ignore
                as.addPhoneContact({
                  firstName: false,
                  success: function (res) {
                    console.log('[AdvancedAPI]  addPhoneContact--firstName4 success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI]  addPhoneContact--firstName4 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI]  addPhoneContact--firstName4 complete' + JSON.stringify(res))
                  }
                })
              })

              // 联系人 .addPhoneContact--firstName--空字符参数验证   success 回调
              Button("空字符").width(300).onClick(() => {
                // @ts-ignore
                as.addPhoneContact({
                  firstName: "",
                  success: function (res) {
                    console.log('[AdvancedAPI]  addPhoneContact--firstName5 success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI]  addPhoneContact--firstName5 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI]  addPhoneContact--firstName5 complete' +  JSON.stringify(res))
                  }
                })
              })

              // 联系人 .addPhoneContact--firstName--null参数验证 fail
              Button("null").width(300).onClick(() => {
                // @ts-ignore
                as.addPhoneContact({
                  firstName: null,
                  success: function (res) {
                    console.log('[AdvancedAPI]  addPhoneContact--firstName6 success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI]  addPhoneContact--firstName6 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI]  addPhoneContact--firstName6 complete' + JSON.stringify(res))
                  }
                })
              })

              // 联系人 .addPhoneContact--firstName--undefined参数验证  fail
              Button("undefined").width(300).onClick(() => {
                // @ts-ignore
                as.addPhoneContact({
                  firstName: undefined,
                  success: function (res) {
                    console.log('[AdvancedAPI]  addPhoneContact--firstName7 success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI]  addPhoneContact--firstName7 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI]  addPhoneContact--firstName7 complete' + JSON.stringify(res))
                  }
                })
              })

              // 联系人 .addPhoneContact--firstName--关于此参数长度的参数验证
              Button("String 超长").width(300).onClick(() => {
                // @ts-ignore
                as.addPhoneContact({
                  firstName: "听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。" +
                  "听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。" +
                  "听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。" +
                  "听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。" +
                  "听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。" +
                  "听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。" +
                  "听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。" +
                  "听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。" +
                  "听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。" +
                  "听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。" +
                  "听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。" +
                  "听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。听我说，谢谢你！温暖的四季。",
                  success: function (res) {
                    console.log('[AdvancedAPI]  addPhoneContact--firstName8 success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI]  addPhoneContact--firstName8 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI]  addPhoneContact--firstName8 complete' + JSON.stringify(res))
                  }
                })
              })
            }
          }
          //添加的电话，邮件，地址等信息：指定其类型（家庭电话，住宅电话等）无效  设置昵称无效
          // addPhoneContact -非必填参数（文档备注无效或不支持的） weChatNumber  photoFilePath  nickName  remark  mobilePhoneNumber weChatNumber
          // addPhoneContact -非必填参数  photoFilePath nickName  lastName  middleName  remark  mobilePhoneNumber weChatNumber
          // addPhoneContact -非必填参数 addressCountry  addressState  addressCity  addressStreet  addressPostalCode
          // addPhoneContact -非必填参数 organization  title  workFaxNumber  workPhoneNumber  hostNumber email url
          // addPhoneContact -非必填参数 workAddressCountry  workAddressState  workAddressCity  workAddressStreet  workAddressPostalCode
          // addPhoneContact -非必填参数 homeFaxNumber  homePhoneNumber  homeAddressCountry  homeAddressState  homeAddressCity homeAddressStreet homeAddressPostalCode
          ListItem(){
            Column ({ space: 10 }) {
              Text('非必填参数 验证').fontSize(35)
              Text('无此参数 上述已验证').fontSize(25)

              // 正常验证联系人
              Button(" 正常入参String").width(300).onClick(() => {
                // @ts-ignore
                as.addPhoneContact({
                  firstName: 'BBB',
                  photoFilePath:'',
                  nickName:'昵称BB',
                  lastName:'姓氏李',
                  middleName:'中间字四',
                  remark:'备注99haiziba',
                  mobilePhoneNumber:'12345678988',
                  weChatNumber:'微信号test',
                  // addressCountry:'星辰国',
                  // addressState:'曦月省',
                  // addressCity:'上虞市',
                  // addressStreet:'无人街道',
                  addressCountry:'中国',
                  addressState:'江苏省',
                  addressCity:'苏州市',
                  addressStreet:'吴江区',
                  addressPostalCode:'8124535',
                  organization:'日出江花有限公司',
                  title:'发呆组组长',
                  workFaxNumber:'55555555',
                  workPhoneNumber:'55555555',
                  hostNumber:'8859999',
                  email:'75842277@163.com',
                  url:'http：www.99.com',
                  workAddressCountry:'虚假国',
                  workAddressState:'缥缈省',
                  workAddressCity:'虚无市',
                  workAddressStreet:'有鬼街道',
                  workAddressPostalCode:'5354218',
                  homeFaxNumber:'66666666',
                  homePhoneNumber:'66666666',
                  homeAddressCountry:'修仙国',
                  homeAddressState:'长生省',
                  homeAddressCity:'短命市',
                  homeAddressStreet:'幽冥街道',
                  homeAddressPostalCode:'7777777',
                  success: function (res) {
                    console.log('[AdvancedAPI]  addPhoneContact--11  success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI]  addPhoneContact--11  fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI]  addPhoneContact--11  complete' + JSON.stringify(res))
                  }
                })
              })

              // 联系人 .addPhoneContact--11 -int参数验证   fail
              Button("Number").width(300).onClick(() => {
                // @ts-ignore
                as.addPhoneContact({
                  firstName: '名称number',
                  photoFilePath:7777,
                  nickName:7777,
                  lastName:7777,
                  middleName:7777,
                  remark:7777,
                  mobilePhoneNumber:7777,
                  weChatNumber:7777,
                  addressCountry:7777,
                  addressState:7777,
                  addressCity:7777,
                  addressStreet:7777,
                  addressPostalCode:7777,
                  organization:7777,
                  title:7777,
                  workFaxNumber:7777,
                  workPhoneNumber:7777,
                  hostNumber:7777,
                  email:7777,
                  url:7777,
                  workAddressCountry:7777,
                  workAddressState:7777,
                  workAddressCity:7777,
                  workAddressStreet:7777,
                  workAddressPostalCode:7777,
                  homeFaxNumber:7777,
                  homePhoneNumber:7777,
                  homeAddressCountry:7777,
                  homeAddressState:7777,
                  homeAddressCity:7777,
                  homeAddressStreet:7777,
                  homeAddressPostalCode:7777,
                  success: function (res) {
                    console.log('[AdvancedAPI]  addPhoneContact--11 2 success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI]  addPhoneContact--11 2 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI]  addPhoneContact--11 2 complete' + JSON.stringify(res))
                  }
                })
              })

              // 联系人 .addPhoneContact--11 -object参数验证 fail
              Button("Object").width(300).onClick(() => {
                // @ts-ignore
                as.addPhoneContact({
                  firstName: '名称Object',
                  photoFilePath:{ "name":"777" },
                  nickName:{ "name":"777" },
                  lastName:{ "name":"777" },
                  middleName:{ "name":"777" },
                  remark:{ "name":"777" },
                  mobilePhoneNumber:{ "name":"777" },
                  weChatNumber:{ "name":"777" },
                  addressCountry:{ "name":"777" },
                  addressState:{ "name":"777" },
                  addressCity:{ "name":"777" },
                  addressStreet:{ "name":"777" },
                  addressPostalCode:{ "name":"777" },
                  organization:{ "name":"777" },
                  title:{ "name":"777" },
                  workFaxNumber:{ "name":"777" },
                  workPhoneNumber:{ "name":"777" },
                  hostNumber:{ "name":"777" },
                  email:{ "name":"777" },
                  url:{ "name":"777" },
                  workAddressCountry:{ "name":"777" },
                  workAddressState:{ "name":"777" },
                  workAddressCity:{ "name":"777" },
                  workAddressStreet:{ "name":"777" },
                  workAddressPostalCode:{ "name":"777" },
                  homeFaxNumber:{ "name":"777" },
                  homePhoneNumber:{ "name":"777" },
                  homeAddressCountry:{ "name":"777" },
                  homeAddressState:{ "name":"777" },
                  homeAddressCity:{ "name":"777" },
                  homeAddressStreet:{ "name":"777" },
                  homeAddressPostalCode:{ "name":"777" },
                  success: function (res) {
                    console.log('[AdvancedAPI]  addPhoneContact--11 3 success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI]  addPhoneContact--11 3 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI]  addPhoneContact--11 3 complete'+ JSON.stringify(res))
                  }
                })
              })

              // 联系人 .addPhoneContact--11 -boolean参数验证 fail
              Button("Boolean").width(300).onClick(() => {
                // @ts-ignore
                as.addPhoneContact({
                  firstName: '名称Boolean',
                  photoFilePath:false,
                  nickName:false,
                  lastName:false,
                  middleName:false,
                  remark:false,
                  mobilePhoneNumber:false,
                  weChatNumber:false,
                  addressCountry:false,
                  addressState:false,
                  addressCity:false,
                  addressStreet:false,
                  addressPostalCode:false,
                  organization:false,
                  title:false,
                  workFaxNumber:false,
                  workPhoneNumber:false,
                  hostNumber:false,
                  email:false,
                  url:false,
                  workAddressCountry:false,
                  workAddressState:false,
                  workAddressCity:false,
                  workAddressStreet:false,
                  workAddressPostalCode:false,
                  homeFaxNumber:false,
                  homePhoneNumber:false,
                  homeAddressCountry:false,
                  homeAddressState:false,
                  homeAddressCity:false,
                  homeAddressStreet:false,
                  homeAddressPostalCode:false,
                  success: function (res) {
                    console.log('[AdvancedAPI]  addPhoneContact--11 4 success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI]  addPhoneContact--11 4 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI]  addPhoneContact--11 4 complete' + JSON.stringify(res))
                  }
                })
              })

              // 联系人 .addPhoneContact--11 --空字符参数验证   success 回调
              Button("空字符").width(300).onClick(() => {
                // @ts-ignore
                as.addPhoneContact({
                  firstName: '名称空字符',
                  photoFilePath:'',
                  nickName:'',
                  lastName:'',
                  middleName:'',
                  remark:'',
                  mobilePhoneNumber:'',
                  weChatNumber:'',
                  addressCountry:'',
                  addressState:'',
                  addressCity:'',
                  addressStreet:'',
                  addressPostalCode:'',
                  organization:'',
                  title:'',
                  workFaxNumber:'',
                  workPhoneNumber:'',
                  hostNumber:'',
                  email:'',
                  url:'',
                  workAddressCountry:'',
                  workAddressState:'',
                  workAddressCity:'',
                  workAddressStreet:'',
                  workAddressPostalCode:'',
                  homeFaxNumber:'',
                  homePhoneNumber:'',
                  homeAddressCountry:'',
                  homeAddressState:'',
                  homeAddressCity:'',
                  homeAddressStreet:'',
                  homeAddressPostalCode:'',
                  success: function (res) {
                    console.log('[AdvancedAPI]  addPhoneContact--11 5 success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI]  addPhoneContact--11 5 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI]  addPhoneContact--11 5 complete' +  JSON.stringify(res))
                  }
                })
              })

              // 联系人 .addPhoneContact--11 --null参数验证 fail
              Button("null").width(300).onClick(() => {
                // @ts-ignore
                as.addPhoneContact({
                  firstName: '名称null',
                  photoFilePath:null,
                  nickName:null,
                  lastName:null,
                  middleName:null,
                  remark:null,
                  mobilePhoneNumber:null,
                  weChatNumber:null,
                  addressCountry:null,
                  addressState:null,
                  addressCity:null,
                  addressStreet:null,
                  addressPostalCode:null,
                  organization:null,
                  title:null,
                  workFaxNumber:null,
                  workPhoneNumber:null,
                  hostNumber:null,
                  email:null,
                  url:null,
                  workAddressCountry:null,
                  workAddressState:null,
                  workAddressCity:null,
                  workAddressStreet:null,
                  workAddressPostalCode:null,
                  homeFaxNumber:null,
                  homePhoneNumber:null,
                  homeAddressCountry:null,
                  homeAddressState:null,
                  homeAddressCity:null,
                  homeAddressStreet:null,
                  homeAddressPostalCode:null,
                  success: function (res) {
                    console.log('[AdvancedAPI]  addPhoneContact--11 6 success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI]  addPhoneContact--11 6 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI]  addPhoneContact--11 6 complete' + JSON.stringify(res))
                  }
                })
              })

              // 联系人 .addPhoneContact--11 --undefined参数验证  fail
              Button("undefined").width(300).onClick(() => {
                // @ts-ignore
                as.addPhoneContact({
                  firstName: '名称undefined',
                  photoFilePath:undefined,
                  nickName:undefined,
                  lastName:undefined,
                  middleName:undefined,
                  remark:undefined,
                  mobilePhoneNumber:undefined,
                  weChatNumber:undefined,
                  addressCountry:undefined,
                  addressState:undefined,
                  addressCity:undefined,
                  addressStreet:undefined,
                  addressPostalCode:undefined,
                  organization:undefined,
                  title:undefined,
                  workFaxNumber:undefined,
                  workPhoneNumber:undefined,
                  hostNumber:undefined,
                  email:undefined,
                  url:undefined,
                  workAddressCountry:undefined,
                  workAddressState:undefined,
                  workAddressCity:undefined,
                  workAddressStreet:undefined,
                  workAddressPostalCode:undefined,
                  homeFaxNumber:undefined,
                  homePhoneNumber:undefined,
                  homeAddressCountry:undefined,
                  homeAddressState:undefined,
                  homeAddressCity:undefined,
                  homeAddressStreet:undefined,
                  homeAddressPostalCode:undefined,
                  success: function (res) {
                    console.log('[AdvancedAPI]  addPhoneContact--11 7 success'+ JSON.stringify(res))
                  },
                  fail:function (e){
                    console.log('[AdvancedAPI]  addPhoneContact--11 7 fail' + JSON.stringify(e))
                  },
                  complete:function(res){
                    console.log('[AdvancedAPI]  addPhoneContact--11 7 complete' + JSON.stringify(res))
                  }
                })
              })

            }
          }
        }.alignListItem(ListItemAlign.Center) // 每行之间的分界线
      }
    }
  }
}