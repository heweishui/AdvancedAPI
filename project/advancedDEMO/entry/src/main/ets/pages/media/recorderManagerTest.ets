// @ts-nocheck
import promptAction from '@ohos.promptAction'
const recorderManager = as.getRecorderManager();
const  innerAudioContext = as.createInnerAudioContext();
@Entry
@Component
struct recorderManagerTest {
//  private recorderManager = as.getRecorderManager({
//    success: function (data) {
//      console.log('[AdvancedAPI]getRecorderManager success '+JSON.stringify(data))
//    },
//    fail: function (data) {
//      console.log('[AdvancedAPI]getRecorderManager fail '+JSON.stringify(data))
//    },
//    complete: (data) => {
//      console.log('[AdvancedAPI]getRecorderManager complete  ' + JSON.stringify(data));
//    }
//  });
//  private recorderManager = as.getRecorderManager();
//  private innerAudioContext = as.createInnerAudioContext();
  private voicePath = '';
  aboutToAppear() {
  }

  build() {
    Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
      Column({ space: 5 }) {
        List({ space: 20, initialIndex: 0 }) {
          ListItem(){
            Text("录音管理").fontSize(35)
          }

          ListItem(){
            Column({ space: 10 }) {
              Text("RecorderManager").fontSize(30)
              Button("开始录音").width(300).onClick(() => {
                console.log('recorderManager 开始录音');
                recorderManager.start();
              })

              Button("暂停录音").width(300).onClick(() => {
                console.log('recorderManager 暂停录音');
                recorderManager.pause();
              })

              Button("继续录音").width(300).onClick(() => {
                console.log('recorderManager 继续录音');
                recorderManager.resume();
              })

              Button("结束录音").width(300).onClick(() => {
                console.log('recorderManager 结束录音');
                recorderManager.stop();

              })

              Button("播放录音").width(300).onClick(() => {
                console.log('recorderManager 播放录音');
                if (this.voicePath) {
                  innerAudioContext.src = this.voicePath;
                  innerAudioContext.play();
                  console.log('recorderManager 正在播放录音');
                }
              })


            }
          }

          ListItem(){
            Column({ space: 10 }) {
              Text("RecorderManager callback事件").fontSize(30)
              Button("录音开始事件").width(300).onClick(() => {
                console.log('recorderManager 录音开始事件');
                recorderManager.onStart(function (res){
                  console.log('[AdvancedAPIDEMO] recorderManager onStart  ' + JSON.stringify(res))
                });
              })

              Button("录音暂停事件").width(300).onClick(() => {
                console.log('recorderManager 录音暂停事件');
                recorderManager.onPause(res => {
                  console.log('[AdvancedAPIDEMO] recorderManager onPause  ' + JSON.stringify(res))
                });
              })

              Button("监听录音继续事件").width(300).onClick(() => {
                console.log('recorderManager 监听录音继续事件');
                recorderManager.onResume(function (res){
                  console.log('[AdvancedAPIDEMO] recorderManager onResume  ' +  JSON.stringify(res))
                });
              })

              Button("录音停止事件，会回调文件地址").width(300).onClick(() => {
                console.log('recorderManager 录音停止事件');
                recorderManager.onStop(res => {
                  console.log('[AdvancedAPIDEMO] recorderManager onStop  ' + res.tempFilePath)
                  console.log('[AdvancedAPIDEMO] recorderManager onStop  ' + JSON.stringify(res))
                    this.voicePath = res.tempFilePath;

                }

                );
              })

              Button("监听录音因为受到系统占用而被中断开始事件").width(300).onClick(() => {
                console.log('recorderManager 监听录音因为受到系统占用而被中断开始事件。');
                //以下场景会触发此事件：微信语音聊天、微信视频聊天、QQ语音聊天、QQ视频聊天、电话响铃、接听电话。此事件触发后，录音会被暂停。pause 事件在此事件后触发
                recorderManager.onInterruptionBegin(res =>{
                  console.log('[AdvancedAPIDEMO] recorderManager onInterruptionBegin  ')
//                  console.log('[AdvancedAPIDEMO] recorderManager onInterruptionBegin  ' + JSON.stringify(res))
                });
              })

              Button("监听录音中断结束事件").width(300).onClick(() => {
                console.log('recorderManager 监听录音中断结束事件');
                // 兼顾场景：如无onInterruptionBegin 监听，及时操作得当，不会触发onInterruptionEnd 事件
                recorderManager.onInterruptionEnd(function (res){
                  console.log('[AdvancedAPIDEMO] recorderManager onInterruptionEnd  ')
//                  console.log('[AdvancedAPIDEMO] recorderManager onInterruptionEnd  ' + JSON.stringify(res))
                });
              })

              Button("录音错误事件").width(300).onClick(() => {
                console.log('recorderManager 录音错误事件');
                recorderManager.onError(function (res){
                  console.log('[AdvancedAPIDEMO] recorderManager onError  ' + JSON.stringify(res))
                });
              })
            }
          }

          ListItem(){
            Column({ space: 10 }) {
              Text("start 开始录音").fontSize(30)
              //无此参数上方已验证
              Button("duration number 正常值").width(300).onClick(() => {
                console.log('recorderManager duration 开始录音');
                recorderManager.start({
                  duration:20000
                });
              })

              Button("duration number 超出最大值 ").width(300).onClick(() => {
                console.log('recorderManager duration 开始录音');
                recorderManager.start({
                  duration:660000
                });
              })

              Button("duration number 取值负数").width(300).onClick(() => { //成功触发，这是1秒不到自动结束
                console.log('recorderManager duration 开始录音');
                recorderManager.start({
                  duration:-60000
                });
              })

              Button("duration String").width(300).onClick(() => {
                console.log('recorderManager duration 开始录音');
                recorderManager.start({
                  duration:'test'
                });
              })

              Button("duration Object").width(300).onClick(() => {
                console.log('recorderManager duration 开始录音');
                recorderManager.start({
                  duration: { 'test':'name' }
                });
              })

              Button("duration Boolean").width(300).onClick(() => {
                console.log('recorderManager duration 开始录音');
                recorderManager.start({
                  duration:true
                });
              })

              Button("duration null").width(300).onClick(() => {
                console.log('recorderManager duration 开始录音');
                recorderManager.start({
                  duration:null
                });
              })

              Button("duration 空字符").width(300).onClick(() => {
                console.log('recorderManager duration 开始录音');
                recorderManager.start({
                  duration:''
                });
              })

              Button("duration undefined").width(300).onClick(() => {
                console.log('recorderManager duration 开始录音');
                recorderManager.start({
                  duration:undefined
                });
              })
            }
          }

          ListItem(){
            Column({ space: 10 }) {
              //无此参数上方已验证
              Button("sampleRate number 正常值1").width(300).onClick(() => {
                console.log('recorderManager sampleRate 开始录音');
                recorderManager.start({
                  sampleRate:8000
                });
              })

              Button("sampleRate number 正常值2").width(300).onClick(() => {
                console.log('recorderManager sampleRate 开始录音');
                recorderManager.start({
                  sampleRate:16000
                });
              })

              Button("sampleRate number 正常值3").width(300).onClick(() => {
                console.log('recorderManager sampleRate 开始录音');
                recorderManager.start({
                  sampleRate:441000
                });
              })

              Button("sampleRate number 非指定值 ").width(300).onClick(() => {
                console.log('recorderManager sampleRate 开始录音');
                recorderManager.start({
                  sampleRate:660
                });
              })

              Button("sampleRate number 取值负数").width(300).onClick(() => {
                console.log('recorderManager sampleRate 开始录音');
                recorderManager.start({
                  sampleRate:-60000
                });
              })

              Button("sampleRate String").width(300).onClick(() => {
                console.log('recorderManager sampleRate 开始录音');
                recorderManager.start({
                  sampleRate:'test'
                });
              })

              Button("sampleRate Object").width(300).onClick(() => {
                console.log('recorderManager sampleRate 开始录音');
                recorderManager.start({
                  sampleRate: { 'test':'name' }
                });
              })

              Button("sampleRate Boolean").width(300).onClick(() => {
                console.log('recorderManager sampleRate 开始录音');
                recorderManager.start({
                  sampleRate:true
                });
              })

              Button("sampleRate null").width(300).onClick(() => {
                console.log('recorderManager sampleRate 开始录音');
                recorderManager.start({
                  sampleRate:null
                });
              })

              Button("sampleRate 空字符").width(300).onClick(() => {
                console.log('recorderManager sampleRate 开始录音');
                recorderManager.start({
                  sampleRate:''
                });
              })

              Button("sampleRate undefined").width(300).onClick(() => {
                console.log('recorderManager sampleRate 开始录音');
                recorderManager.start({
                  sampleRate:undefined
                });
              })
            }
          }

          ListItem(){
            Column({ space: 10 }) {
              //无此参数上方已验证
              Button("numberOfChannels number 正常值1").width(300).onClick(() => {
                console.log('recorderManager numberOfChannels 开始录音');
                recorderManager.start({
                  numberOfChannels:1
                });
              })

              Button("numberOfChannels number 正常值2").width(300).onClick(() => {
                console.log('recorderManager numberOfChannels 开始录音');
                recorderManager.start({
                  numberOfChannels:2
                });
              })

              Button("numberOfChannels number 非指定值 ").width(300).onClick(() => {
                console.log('recorderManager numberOfChannels 开始录音');
                recorderManager.start({
                  numberOfChannels:8
                });
              })

              Button("numberOfChannels number 取值负数").width(300).onClick(() => {
                console.log('recorderManager numberOfChannels 开始录音');
                recorderManager.start({
                  numberOfChannels:-1
                });
              })

              Button("numberOfChannels String").width(300).onClick(() => {
                console.log('recorderManager numberOfChannels 开始录音');
                recorderManager.start({
                  numberOfChannels:'test'
                });
              })

              Button("numberOfChannels Object").width(300).onClick(() => {
                console.log('recorderManager numberOfChannels 开始录音');
                recorderManager.start({
                  numberOfChannels: { 'test':'name' }
                });
              })

              Button("numberOfChannels Boolean").width(300).onClick(() => {
                console.log('recorderManager numberOfChannels 开始录音');
                recorderManager.start({
                  numberOfChannels:true
                });
              })

              Button("numberOfChannels null").width(300).onClick(() => {
                console.log('recorderManager numberOfChannels 开始录音');
                recorderManager.start({
                  numberOfChannels:null
                });
              })

              Button("numberOfChannels 空字符").width(300).onClick(() => {
                console.log('recorderManager numberOfChannels 开始录音');
                recorderManager.start({
                  numberOfChannels:''
                });
              })

              Button("numberOfChannels undefined").width(300).onClick(() => {
                console.log('recorderManager numberOfChannels 开始录音');
                recorderManager.start({
                  numberOfChannels:undefined
                });
              })

            }
          }

          ListItem(){
            Column({ space: 10 }) {
              // 无此参数上方已验证
              Button("encodeBitRate number 正常值1").width(300).onClick(() => {
                console.log('recorderManager encodeBitRate 开始录音');
                recorderManager.start({
                  encodeBitRate:16000
                });
              })

              Button("encodeBitRate number 正常值2").width(300).onClick(() => {
                console.log('recorderManager encodeBitRate 开始录音');
                recorderManager.start({
                  encodeBitRate:24000
                });
              })

              Button("encodeBitRate number 非指定值 ").width(300).onClick(() => {
                console.log('recorderManager encodeBitRate 开始录音');
                recorderManager.start({
                  encodeBitRate:320000
                });
              })

              Button("encodeBitRate number 取值负数").width(300).onClick(() => {
                console.log('recorderManager encodeBitRate 开始录音');
                recorderManager.start({
                  encodeBitRate:-1
                });
              })

              Button("encodeBitRate String").width(300).onClick(() => {
                console.log('recorderManager encodeBitRate 开始录音');
                recorderManager.start({
                  encodeBitRate:'test'
                });
              })

              Button("encodeBitRate Object").width(300).onClick(() => {
                console.log('recorderManager encodeBitRate 开始录音');
                recorderManager.start({
                  encodeBitRate: { 'test':'name' }
                });
              })

              Button("encodeBitRate Boolean").width(300).onClick(() => {
                console.log('recorderManager encodeBitRate 开始录音');
                recorderManager.start({
                  encodeBitRate:true
                });
              })

              Button("encodeBitRate null").width(300).onClick(() => {
                console.log('recorderManager encodeBitRate 开始录音');
                recorderManager.start({
                  encodeBitRate:null
                });
              })

              Button("encodeBitRate 空字符").width(300).onClick(() => {
                console.log('recorderManager encodeBitRate 开始录音');
                recorderManager.start({
                  encodeBitRate:''
                });
              })

              Button("encodeBitRate undefined").width(300).onClick(() => {
                console.log('recorderManager encodeBitRate 开始录音');
                recorderManager.start({
                  encodeBitRate:undefined
                });
              })

            }
          }

          ListItem(){
            Column({ space: 10 }) {
              // 无此参数上方已验证
              // 有效值 仅支持m4a    aac/mp3/wav/PCM
              Button("format String m4a ").width(300).onClick(() => {
                console.log('recorderManager format 开始录音');
                recorderManager.start({
                  format:'m4a'
                });
              })

              Button("format String aac").width(300).onClick(() => {
                console.log('recorderManager format 开始录音');
                recorderManager.start({
                  format:'aac'
                });
              })

              Button("format String mp3 ").width(300).onClick(() => {
                console.log('recorderManager format 开始录音');
                recorderManager.start({
                  format:'mp3'
                });
              })

              Button("format String wav ").width(300).onClick(() => {
                console.log('recorderManager format 开始录音');
                recorderManager.start({
                  format:'wav'
                });
              })

              Button("format String PCM ").width(300).onClick(() => {
                console.log('recorderManager format 开始录音');
                recorderManager.start({
                  format:'PCM'
                });
              })

              Button("format String 取值负数").width(300).onClick(() => {
                console.log('recorderManager format 开始录音');
                recorderManager.start({
                  format:-1
                });
              })

              Button("format Number").width(300).onClick(() => {
                console.log('recorderManager format 开始录音');
                recorderManager.start({
                  format:33
                });
              })

              Button("format Object").width(300).onClick(() => {
                console.log('recorderManager format 开始录音');
                recorderManager.start({
                  format: { 'test':'name' }
                });
              })

              Button("format Boolean").width(300).onClick(() => {
                console.log('recorderManager format 开始录音');
                recorderManager.start({
                  format:true
                });
              })

              Button("format null").width(300).onClick(() => {
                console.log('recorderManager format 开始录音');
                recorderManager.start({
                  format:null
                });
              })

              Button("format 空字符").width(300).onClick(() => {
                console.log('recorderManager format 开始录音');
                recorderManager.start({
                  format:''
                });
              })

              Button("format undefined").width(300).onClick(() => {
                console.log('recorderManager format 开始录音');
                recorderManager.start({
                  format:undefined
                });
              })

            }
          }

        }.divider({ strokeWidth: 2, color: 0xFFFFFF, startMargin: 20, endMargin: 20 }) // 每行之间的分界线
        .alignListItem(ListItemAlign.Center)
      }
    }
  }
}