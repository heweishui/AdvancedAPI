// @ts-nocheck
import promptAction from '@ohos.promptAction'

// @ts-ignore
const innerAudioContext  = as.createInnerAudioContext()
innerAudioContext.src = 'https://ss0.bdstatic.com/-0U0bnSm1A5BphGlnYG/cae-legoup-video-target/93be3d88-9fc2-4fbd-bd14-833bca731ca7.mp4';
innerAudioContext.startTime = '';
innerAudioContext.autoplay = true;
innerAudioContext.loop = true;

@Entry
@Component
struct innerAudioContextTest {
  // 非属性接口验证屏蔽下方，是则屏蔽上方全局定义
  private innerAudioContext2 = as.createInnerAudioContext();
  aboutToAppear() {
  }

  build() {
    Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
      Column({ space: 5 }) {
        List({ space: 20, initialIndex: 0 }) {
          ListItem(){
            Column({ space: 10 }) {
              Text("innerAudioContext").fontSize(30)
              Button("播放 ").width(300).onClick(() => {
                console.log('innerAudioContext 播放 ');
                innerAudioContext.play();
              })

              Button("暂停 ").width(300).onClick(() => {
                console.log('innerAudioContext 暂停 ');
                innerAudioContext.pause();
              })

              Button("停止 ").width(300).onClick(() => {
                console.log('innerAudioContext 停止 ');
                innerAudioContext.stop();
              })
            }
          }

          ListItem(){
            Column({ space: 10 }) {
              Text("innerAudioContext callback事件").fontSize(30)
              Button(" 音频进入可以播放状态").width(300).onClick(() => {
                console.log('innerAudioContext  音频进入可以播放状态');
                innerAudioContext.onCanplay(function (res){
                  console.log('[AdvancedAPIDEMO] innerAudioContext onCanplay  ' + JSON.stringify(res))
                });
              })

              Button(" 播放事件").width(300).onClick(() => {
                console.log('innerAudioContext  播放事件');
                innerAudioContext.onPlay(function (res){
                  console.log('[AdvancedAPIDEMO] innerAudioContext onPlay  ' + JSON.stringify(res))
                });
              })

              Button(" 暂停事件").width(300).onClick(() => {
                console.log('innerAudioContext  暂停事件');
                innerAudioContext.onPause(res => {
                  console.log('[AdvancedAPIDEMO] innerAudioContext onPause  ' + JSON.stringify(res))
                });
              })

              Button(" 停止事件").width(300).onClick(() => {
                console.log('innerAudioContext  停止事件');
                innerAudioContext.onStop(res => {
                  console.log('[AdvancedAPIDEMO] innerAudioContext onStop  ' + JSON.stringify(res))
                }
                );
              })

              Button("销毁当前实例--全局").width(300).onClick(() => {
                console.log('innerAudioContext  销毁当前实例');
                innerAudioContext.destroy(res => {
                  console.log('[AdvancedAPIDEMO] innerAudioContext destroy  ' + JSON.stringify(res))
                }
                );
              })

              Button("销毁当前实例--页面内定义").width(300).onClick(() => {
                console.log('innerAudioContext2  销毁当前实例');
                this.innerAudioContext2.destroy(res => {
                  console.log('[AdvancedAPIDEMO] innerAudioContext2 destroy  ' + JSON.stringify(res))
                }
                );
              })

              Button("页面内定义--播放").width(300).onClick(() => {
                console.log('innerAudioContext2  页面内定义--播放');
                // @ts-ignore
                const audioManager = as.createInnerAudioContext()
                audioManager.startTime = 2
                audioManager.autoplay = true
                audioManager.src = 'https://ss0.bdstatic.com/-0U0bnSm1A5BphGlnYG/cae-legoup-video-target/93be3d88-9fc2-4fbd-bd14-833bca731ca7.mp4';
              })


              Button(" 自然播放结束事件").width(300).onClick(() => {
                console.log('innerAudioContext  自然播放结束事件');
                innerAudioContext.onEnded(res => {
                  console.log('[AdvancedAPIDEMO] innerAudioContext onEnded  ' + JSON.stringify(res))
                }
                );
              })

              Button(" 播放进度更新事件").width(300).onClick(() => {
                console.log('innerAudioContext  播放进度更新事件');
                innerAudioContext.onTimeUpdate(res => {
                  console.log('[AdvancedAPIDEMO] innerAudioContext onTimeUpdate  ' + JSON.stringify(res))
                }
                );
              })

              Button(" 错误事件").width(300).onClick(() => {
                console.log('innerAudioContext  错误事件');
                innerAudioContext.onError(function (res){
                  console.log('[AdvancedAPIDEMO] innerAudioContext onError  ' + JSON.stringify(res))
                });
              })

              Button(" 等待事件").width(300).onClick(() => {
                //音频加载中事件，当音频因为数据不足，需要停下来加载时会触发
                console.log('innerAudioContext  等待事件');
                innerAudioContext.onWaiting(function (res){
                  console.log('[AdvancedAPIDEMO] innerAudioContext onWaiting  ' + JSON.stringify(res))
                });
              })

              Button(" 进行 seek 操作事件").width(300).onClick(() => {
                console.log('innerAudioContext  进行 seek 操作事件');
                innerAudioContext.onSeeking(function (res){
                  console.log('[AdvancedAPIDEMO] innerAudioContext onSeeking  ' + JSON.stringify(res))
                });
              })

              Button(" 完成 seek 操作事件").width(300).onClick(() => {
                console.log('innerAudioContext  完成 seek 操作事件');
                innerAudioContext.onSeeked(function (res){
                  console.log('[AdvancedAPIDEMO] innerAudioContext onSeeked  ' + JSON.stringify(res))
                });
              })

              Button(" 取消监听音频进入可以播放状态").width(300).onClick(() => {
                console.log('innerAudioContext  取消监听音频进入可以播放状态');
                innerAudioContext.offCanplay(function (res){
                  console.log('[AdvancedAPIDEMO] innerAudioContext offCanplay  ' + JSON.stringify(res))
                });
              })

              Button(" 取消监听播放事件").width(300).onClick(() => {
                console.log('innerAudioContext  取消监听播放事件');
                innerAudioContext.offPlay(function (res){
                  console.log('[AdvancedAPIDEMO] innerAudioContext offPlay  ' + JSON.stringify(res))
                });
              })

              Button(" 取消监听暂停事件").width(300).onClick(() => {
                console.log('innerAudioContext  取消监听暂停事件');
                innerAudioContext.offPause(res => {
                  console.log('[AdvancedAPIDEMO] innerAudioContext offPause  ' + JSON.stringify(res))
                });
              })

              Button(" 取消监听停止事件").width(300).onClick(() => {
                console.log('innerAudioContext  取消监听停止事件');
                innerAudioContext.offStop(res => {
                  console.log('[AdvancedAPIDEMO] innerAudioContext offStop  ' + JSON.stringify(res))
                }
                );
              })

              Button(" 取消监听自然播放结束事件").width(300).onClick(() => {
                console.log('innerAudioContext  取消监听自然播放结束事件');
                innerAudioContext.offEnded(res => {
                  console.log('[AdvancedAPIDEMO] innerAudioContext offEnded  ' + JSON.stringify(res))
                }
                );
              })

              Button(" 取消监听播放进度更新事件").width(300).onClick(() => {
                console.log('innerAudioContext  取消监听播放进度更新事件');
                innerAudioContext.offTimeUpdate(res => {
                  console.log('[AdvancedAPIDEMO] innerAudioContext offTimeUpdate  ' + JSON.stringify(res))
                }
                );
              })

              Button(" 取消监听错误事件").width(300).onClick(() => {
                console.log('innerAudioContext  取消监听错误事件');
                innerAudioContext.offError(function (res){
                  console.log('[AdvancedAPIDEMO] innerAudioContext offError  ' + JSON.stringify(res))
                });
              })

              Button(" 取消监听等待事件").width(300).onClick(() => {
                //音频加载中事件，当音频因为数据不足，需要停下来加载时会触发
                console.log('innerAudioContext  取消监听等待事件');
                innerAudioContext.offWaiting(function (res){
                  console.log('[AdvancedAPIDEMO] innerAudioContext offWaiting  ' + JSON.stringify(res))
                });
              })

              Button(" 取消监听进行 seek 操作事件").width(300).onClick(() => {
                console.log('innerAudioContext  取消监听进行 seek 操作事件');
                innerAudioContext.offSeeking(function (res){
                  console.log('[AdvancedAPIDEMO] innerAudioContext offSeeking  ' + JSON.stringify(res))
                });
              })

              Button(" 取消监听完成 seek 操作事件").width(300).onClick(() => {
                console.log('innerAudioContext  取消监听完成 seek 操作事件');
                innerAudioContext.offSeeked(function (res){
                  console.log('[AdvancedAPIDEMO] innerAudioContext offSeeked  ' + JSON.stringify(res))
                });
              })



            }
          }

          ListItem(){
            Column({ space: 10 }) {
              Text("seek 跳转到指定位置").fontSize(30)
              //无此参数上方已验证
              Button("position number 正常值").width(300).onClick(() => {
                console.log('innerAudioContext position 跳转播放');
                innerAudioContext.seek(30
                );
              })

              Button("position number 超出最大值 ").width(300).onClick(() => {
                console.log('innerAudioContext position 跳转播放');
                innerAudioContext.seek(6666
                );
              })

              Button("position number 取值负数").width(300).onClick(() => {
                console.log('innerAudioContext position 跳转播放');
                innerAudioContext.seek(-30
                );
              })

              Button("position String").width(300).onClick(() => {
                console.log('innerAudioContext position 跳转播放');
                innerAudioContext.seek('test'
                );
              })

              Button("position Object").width(300).onClick(() => {
                console.log('innerAudioContext position 跳转播放');
                innerAudioContext.seek( { 'test':'name' }
                );
              })

              Button("position Boolean").width(300).onClick(() => {
                console.log('innerAudioContext position 跳转播放');
                innerAudioContext.seek(true
                );
              })

              Button("position null").width(300).onClick(() => {
                console.log('innerAudioContext position 跳转播放');
                innerAudioContext.seek(null
                );
              })

              Button("position 空字符").width(300).onClick(() => {
                console.log('innerAudioContext position 跳转播放');
                innerAudioContext.seek(''
                );
              })

              Button("position undefined").width(300).onClick(() => {
                console.log('innerAudioContext position 跳转播放');
                innerAudioContext.seek(undefined
                );
              })
            }
          }

          ListItem(){
            Column({ space: 10 }) {
              Text("innerAudioContext 对象的属性列表").fontSize(30)

              Button("播放 ").width(300).onClick(() => {
                console.log('this.innerAudioContext2 播放 ');
                this.innerAudioContext2.play();
                console.log('innerAudioContext 相关属性');
                console.log('innerAudioContext duration = '+ this.innerAudioContext2.duration);
                console.log('innerAudioContext currentTime = '+ this.innerAudioContext2.currentTime);
                console.log('innerAudioContext paused = '+ this.innerAudioContext2.paused);
                console.log('innerAudioContext buffered = '+ this.innerAudioContext2.buffered);

                console.log('innerAudioContext src = '+ this.innerAudioContext2.src);
                console.log('innerAudioContext startTime = '+ this.innerAudioContext2.startTime);
                console.log('innerAudioContext autoplay = '+ this.innerAudioContext2.autoplay);
                console.log('innerAudioContext loop = '+ this.innerAudioContext2.loop);
              })

              Button("参数正常场景 ").width(300).onClick(() => {
                this.innerAudioContext2.src = 'https://ss0.bdstatic.com/-0U0bnSm1A5BphGlnYG/cae-legoup-video-target/93be3d88-9fc2-4fbd-bd14-833bca731ca7.mp4';
                this.innerAudioContext2.startTime = 20;
                this.innerAudioContext2.autoplay = false;
                this.innerAudioContext2.loop = false;
              })

              Button("参数异常 ").width(300).onClick(() => {
                this.innerAudioContext2.src = 7788;
                this.innerAudioContext2.startTime = true;
                this.innerAudioContext2.autoplay = null;
                this.innerAudioContext2.loop = '';
              })
            }
          }
        }.divider({ strokeWidth: 2, color: 0xFFFFFF, startMargin: 20, endMargin: 20 }) // 每行之间的分界线
        .alignListItem(ListItemAlign.Center)
      }
    }
  }
}