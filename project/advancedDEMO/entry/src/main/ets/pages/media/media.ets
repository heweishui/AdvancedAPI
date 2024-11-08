// @ts-nocheck
import router from '@ohos.router';

@Entry
@Component
struct media {
  aboutToAppear() {
  }

  build() {
    Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
      Column({ space: 5 }) {
        List({ space: 20, initialIndex: 0 }) {
          ListItem() {
            Text("媒体").fontSize(35)
          }
          ListItem() {
            Button("图片").width(300).onClick(() => {
              router.pushUrl({ url: 'pages/media/image' })
            })
          }
          ListItem() {
            Button("图片-test").width(300).onClick(() => {
              router.pushUrl({ url: 'pages/media/imageTest' })
            })
          }
          ListItem() {
            Button("文件").width(300).onClick(() => {
              router.pushUrl({ url: 'pages/media/file' })
            })
          }
          ListItem() {
            Button("文件-test").width(300).onClick(() => {
              router.pushUrl({ url: 'pages/media/fileTest' })
            })
          }
          ListItem() {
            Button("录音管理").width(300).onClick(() => {
              router.pushUrl({ url: 'pages/media/recorderManager' })
            })
          }
          ListItem() {
            Button("录音管理-test").width(300).onClick(() => {
              router.pushUrl({ url: 'pages/media/recorderManagerTest' })
            })
          }
          ListItem() {
            Button("背景音频播放管理").width(300).onClick(() => {
              router.pushUrl({ url: 'pages/media/backgroundAudioManager' })
            })
          }
          ListItem() {
            Button("背景音频播放管理-test").width(300).onClick(() => {
              router.pushUrl({ url: 'pages/media/backgroundAudioManagerTest' })
            })
          }
          ListItem() {
            Button("音频组件控制").width(300).onClick(() => {
              router.pushUrl({ url: 'pages/media/innerAudioContext' })
            })
          }
          ListItem() {
            Button("音频组件控制-test").width(300).onClick(() => {
              router.pushUrl({ url: 'pages/media/innerAudioContextTest' })
            })
          }
          ListItem() {
            Button("视频").width(300).onClick(() => {
              router.pushUrl({ url: 'pages/media/video' })
            })
          }
          ListItem() {
            Button("视频-test").width(300).onClick(() => {
              router.pushUrl({ url: 'pages/media/videoTest' })
            })
          }
          ListItem() {
            Button("相机组件控制").width(300).onClick(() => {
              router.pushUrl({ url: 'pages/media/cameraContext' })
            })
          }
          ListItem() {
            Button("相机组件控制-test").width(300).onClick(() => {
              router.pushUrl({ url: 'pages/media/cameraContextTest' })
            })
          }
        }.divider({ strokeWidth: 2, color: 0xFFFFFF, startMargin: 20, endMargin: 20 }) // 每行之间的分界线
        .alignListItem(ListItemAlign.Center)
      }
    }
  }
}