// @ts-nocheck
import promptAction from '@ohos.promptAction'

// @ts-ignore
// const bgAudioManager = as.getBackgroundAudioManager()
// bgAudioManager.src = 'https://vkceyugu.cdn.bspapp.com/VKCEYUGU-hello-uniapp/2cc220e0-c27a-11ea-9dfb-6da8e309e0d8.mp3';
// bgAudioManager.title = '';
// bgAudioManager.epname = '';
// bgAudioManager.singer = '';
// bgAudioManager.coverImgUrl = '';
// bgAudioManager.webUrl = '';
// bgAudioManager.protocol = '';


@Entry
@Component
struct backgroundAudioManagerTest {
  private backgroundAudioManager = as.getBackgroundAudioManager();
  aboutToAppear() {
  }

  build() {
    Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
      Column({ space: 5 }) {
        List({ space: 20, initialIndex: 0 }) {
          ListItem(){
            Column({ space: 10 }) {
              Text("bgAudioManager").fontSize(30)
              Button("播放 ").width(300).onClick(() => {
                console.log('bgAudioManager 播放 ');
                bgAudioManager.play();
              })

              Button("暂停 ").width(300).onClick(() => {
                console.log('bgAudioManager 暂停 ');
                bgAudioManager.pause();
              })

              Button("结束 ").width(300).onClick(() => {
                console.log('bgAudioManager 停止 ');
                bgAudioManager.stop();
              })
            }
          }

          ListItem(){
            Column({ space: 10 }) {
              Text("bgAudioManager callback事件").fontSize(30)
              Button(" 背景音频进入可以播放状态").width(300).onClick(() => {
                console.log('bgAudioManager  背景音频进入可以播放状态');
                bgAudioManager.onCanplay(function (res){
                  console.log('[AdvancedAPIDEMO] bgAudioManager onCanplay  ' + JSON.stringify(res))
                });
              })

              Button(" 播放事件").width(300).onClick(() => {
                console.log('bgAudioManager  播放事件');
                bgAudioManager.onPlay(function (res){
                  console.log('[AdvancedAPIDEMO] bgAudioManager onPlay  ' + JSON.stringify(res))
                });
              })

              Button(" 暂停事件").width(300).onClick(() => {
                console.log('bgAudioManager  暂停事件');
                bgAudioManager.onPause(res => {
                  console.log('[AdvancedAPIDEMO] bgAudioManager onPause  ' + JSON.stringify(res))
                });
              })

              Button(" 停止事件").width(300).onClick(() => {
                console.log('bgAudioManager  停止事件');
                bgAudioManager.onStop(res => {
                  console.log('[AdvancedAPIDEMO] bgAudioManager onStop  ' + JSON.stringify(res))
                }
                );
              })

              Button(" 自然播放结束事件").width(300).onClick(() => {
                console.log('bgAudioManager  自然播放结束事件');
                bgAudioManager.onEnded(res => {
                  console.log('[AdvancedAPIDEMO] bgAudioManager onEnded  ' + JSON.stringify(res))
                }
                );
              })

              Button(" 播放进度更新事件").width(300).onClick(() => {
                console.log('bgAudioManager  播放进度更新事件');
                bgAudioManager.onTimeUpdate(res => {
                  console.log('[AdvancedAPIDEMO] bgAudioManager onTimeUpdate  ' + JSON.stringify(res))
                }
                );
              })

              Button(" 错误事件").width(300).onClick(() => {
                console.log('bgAudioManager  错误事件');
                bgAudioManager.onError(function (res){
                  console.log('[AdvancedAPIDEMO] bgAudioManager onError  ' + JSON.stringify(res))
                });
              })

              Button(" 等待事件").width(300).onClick(() => {
                //音频加载中事件，当音频因为数据不足，需要停下来加载时会触发
                console.log('bgAudioManager  等待事件');
                bgAudioManager.onWaiting(function (res){
                  console.log('[AdvancedAPIDEMO] bgAudioManager onWaiting  ' + JSON.stringify(res))
                });
              })
            }
          }

          ListItem(){
            Column({ space: 10 }) {
              Text("seek 跳转到指定位置").fontSize(30)
              //无此参数上方已验证
              Button("position number 正常值").width(300).onClick(() => {
                console.log('bgAudioManager position 跳转播放');
                bgAudioManager.seek(10
              );
            })

            Button("position number 超出最大值 ").width(300).onClick(() => {
              console.log('bgAudioManager position 跳转播放');
              bgAudioManager.seek(666
              );
            })

            Button("position number 取值负数").width(300).onClick(() => {
              console.log('bgAudioManager position 跳转播放');
              bgAudioManager.seek(-30
              );
            })

            Button("position String").width(300).onClick(() => {
              console.log('bgAudioManager position 跳转播放');
              bgAudioManager.seek('test'
              );
            })

            Button("position Object").width(300).onClick(() => {
              console.log('bgAudioManager position 跳转播放');
              bgAudioManager.seek( { 'test':'name' }
              );
            })

            Button("position Boolean").width(300).onClick(() => {
              console.log('bgAudioManager position 跳转播放');
              bgAudioManager.seek(true
              );
            })

            Button("position null").width(300).onClick(() => {
              console.log('bgAudioManager position 跳转播放');
              bgAudioManager.seek(null
              );
            })

            Button("position 空字符").width(300).onClick(() => {
              console.log('bgAudioManager position 跳转播放');
              bgAudioManager.seek(''
              );
            })

            Button("position undefined").width(300).onClick(() => {
              console.log('bgAudioManager position 跳转播放');
              bgAudioManager.seek(undefined
              );
            })
          }
        }

        ListItem(){
          Column({ space: 10 }) {
            Text("backgroundAudioManager 对象的属性列表").fontSize(30)

            Button("播放 ").width(300).onClick(() => {
              console.log('backgroundAudioManager 播放 ');
              this.backgroundAudioManager.play();
              console.log('backgroundAudioManager 相关属性');
              console.log('backgroundAudioManager duration = '+ this.backgroundAudioManager.duration);
              console.log('backgroundAudioManager currentTime = '+ this.backgroundAudioManager.currentTime);
              console.log('backgroundAudioManager paused = '+ this.backgroundAudioManager.paused);
              console.log('backgroundAudioManager buffered = '+ this.backgroundAudioManager.buffered);

              console.log('backgroundAudioManager src = '+ this.backgroundAudioManager.src);
              console.log('backgroundAudioManager startTime = '+ this.backgroundAudioManager.startTime);
              console.log('backgroundAudioManager title = '+ this.backgroundAudioManager.title);
              console.log('backgroundAudioManager epname = '+ this.backgroundAudioManager.epname);
              console.log('backgroundAudioManager singer = '+ this.backgroundAudioManager.singer);
              console.log('backgroundAudioManager coverImgUrl = '+ this.backgroundAudioManager.coverImgUrl);
              console.log('backgroundAudioManager webUrl = '+ this.backgroundAudioManager.webUrl);
              console.log('backgroundAudioManager protocol = '+ this.backgroundAudioManager.protocol);
            })

            Button("参数值均ok").width(300).onClick(() => {
              this.backgroundAudioManager.src = 'https://vkceyugu.cdn.bspapp.com/VKCEYUGU-hello-uniapp/2cc220e0-c27a-11ea-9dfb-6da8e309e0d8.mp3';
              this.backgroundAudioManager.startTime=0;
              this.backgroundAudioManager.title = '标题-听风';
              this.backgroundAudioManager.epname = '专辑-听风随感';
              this.backgroundAudioManager.singer = '歌手-呆呆';
              this.backgroundAudioManager.coverImgUrl = 'https://www-file.huawei.com/-/media/corporate/images/home/video/fully_connecte_world_960.jpg';
              this.backgroundAudioManager.webUrl = 'https://www.baidu.com';
              this.backgroundAudioManager.protocol = 'https';
            })

            Button("protocol为http;coverImgUrl为https").width(300).onClick(() => {
              this.backgroundAudioManager.src = 'https://vkceyugu.cdn.bspapp.com/VKCEYUGU-hello-uniapp/2cc220e0-c27a-11ea-9dfb-6da8e309e0d8.mp3';
              this.backgroundAudioManager.startTime=10;
              this.backgroundAudioManager.title = '标题-听风';
              this.backgroundAudioManager.epname = '专辑-听风随感';
              this.backgroundAudioManager.singer = '歌手-呆呆';
              this.backgroundAudioManager.coverImgUrl = 'http://www.huawei.com/Assets/CBG/img/logo.png';
              this.backgroundAudioManager.webUrl = 'https://www.baidu.com';
              this.backgroundAudioManager.protocol = 'https';
            })

            Button("参数值类型不对").width(300).onClick(() => {
              this.backgroundAudioManager.src = 111;
              this.backgroundAudioManager.startTime='10';
              this.backgroundAudioManager.title = true;
              this.backgroundAudioManager.epname = false;
              this.backgroundAudioManager.singer = null;
              this.backgroundAudioManager.coverImgUrl = '';
              this.backgroundAudioManager.webUrl = undefined;
              this.backgroundAudioManager.protocol = 77;
            })
          }
        }
      }.divider({ strokeWidth: 2, color: 0xFFFFFF, startMargin: 20, endMargin: 20 }) // 每行之间的分界线
      .alignListItem(ListItemAlign.Center)
    }
  }
}
}