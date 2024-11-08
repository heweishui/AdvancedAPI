import webview from '@ohos.web.webview'
import router from '@ohos.router'

@Entry
@Component
struct WebComponent {
  @State url: string = router.getParams()['url']
  controller: webview.WebviewController = new webview.WebviewController()
  build() {
    Column() {
      Web({ src: this.url, controller: this.controller })
    }
  }
}