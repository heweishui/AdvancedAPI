// @ts-nocheck
import promptAction from '@ohos.promptAction'

@Entry
@Component
struct video {
  aboutToAppear() {
  }

  build() {
    Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
      Column({ space: 5 }) {
        List({ space: 20, initialIndex: 0 }) {
          ListItem(){
            Text("视频").fontSize(35)
          }
          ListItem(){
            Button("as.chooseVideo camera").width(300).onClick(()=>{
              // @ts-ignore
              as.chooseVideo({
                sourceType: ['camera'], //从相册选择
                success: function (res) {
                  promptAction.showToast({
                    message: JSON.stringify(res),
                    duration: 2000,
                    bottom:500
                  })
                  console.log('[AdvancedAPIDEMO]' + JSON.stringify(res.tempFilePath));
                }
              })
            })
          }
          ListItem(){
            Button("as.chooseVideo album").width(300).onClick(()=>{
              // @ts-ignore
              as.chooseVideo({
                sourceType: ['album'], //从相册选择
                success: function (res) {
                  promptAction.showToast({
                    message: JSON.stringify(res),
                    duration: 2000,
                    bottom:500
                  })
                  console.log('[AdvancedAPIDEMO]' + JSON.stringify(res.tempFilePath));
                }
              })
            })
          }
          ListItem(){
            Button("as.chooseMedia").width(300).onClick(()=>{
              // @ts-ignore
              as.chooseMedia({
                count: 6, //默认9
                sourceType: ['album'], //从相册选择
                success: function (res) {
                  promptAction.showToast({
                    message: JSON.stringify(res),
                    duration: 2000,
                    bottom:500
                  })
                  console.log('[AdvancedAPIDEMO]' + JSON.stringify(res.tempFilePaths));
                }
              })
            })
          }
          ListItem(){
            Button("as.saveVideoToPhotosAlbum camera").width(300).onClick(()=>{
              // @ts-ignore
              as.chooseVideo({
                count: 1,
                sourceType: ['camera'],
                success: function (res) {
                  // @ts-ignore
                  as.saveVideoToPhotosAlbum({
                    filePath: res.tempFilePath,
                    success: function () {
                      promptAction.showToast({
                        message: 'save success',
                        duration: 2000,
                        bottom:500
                      })
                      console.log('[AdvancedAPIDEMO]' +'save success');
                    }
                  });
                }
              });
            })
          }
          ListItem(){
            Button("as.saveVideoToPhotosAlbum album").width(300).onClick(()=>{
              // @ts-ignore
              as.chooseVideo({
                count: 1,
                sourceType: ['album'],
                success: function (res) {
                  // @ts-ignore
                  as.saveVideoToPhotosAlbum({
                    filePath: res.tempFilePath,
                    success: function () {
                      promptAction.showToast({
                        message: 'save success',
                        duration: 2000,
                        bottom:500
                      })
                      console.log('[AdvancedAPIDEMO]' +'save success');
                    }
                  });
                }
              });
            })
          }
          ListItem(){
            Button("as.getVideoInfo").width(300).onClick(()=>{
              // @ts-ignore
              as.chooseVideo({
                count: 1,
                sourceType: ['album'],
                success: function (res) {
                  // @ts-ignore
                  as.getVideoInfo({
                    src: res.tempFilePath,
                    success: function (video) {
                      promptAction.showToast({
                        message: JSON.stringify(video),
                        duration: 2000,
                        bottom:500
                      })
                      console.log('[AdvancedAPIDEMO]' + video.width);
                      console.log('[AdvancedAPIDEMO]' + video.height);
                    }
                  });
                }
              })
            })
          }

        }.divider({ strokeWidth: 2, color: 0xFFFFFF, startMargin: 20, endMargin: 20 }) // 每行之间的分界线
        .alignListItem(ListItemAlign.Center)
      }
    }
  }
}