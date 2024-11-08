import web_webview from '@ohos.web.webview'
import { Adapter } from '../adapter/adapter'
import { isFileUri,isSandboxPath } from '../adapter/util'
import fs from '@ohos.file.fs';
import abilityAccessCtrl from "@ohos.abilityAccessCtrl"
import picker from '@ohos.file.picker';
import {as} from 'advancedApi'
import {onInterceptRequestEvent, onConsoleEvent, onShowFileSelectorEvent } from '../utils/type'
let storage = LocalStorage.GetShared()

@Entry(storage)
@Component
struct WebComponent {
  @LocalStorageLink('url')  url:string = 'about:blank';
  @LocalStorageLink('server')  server:string = '';
  fileAccess: boolean = true;
  controller: web_webview.WebviewController = new web_webview.WebviewController();
  adapter:Adapter = new Adapter(this.controller)
  ua:string = 'mozilla/5.0 (linux; android 10; harmonyos; els-an00; hmscore 6.10.4.302) applewebkit/537.36 (khtml, like gecko) chrome/99.0.4844.88 huaweibrowser/13.0.6.302 mobile safari/537.36'
  adapterProxy:ProxyConstructor = this.adapter.getAdapterProxy(as)
  @State webResult: string = ''


  onBackPress() {
    try {
      if(this.controller.accessBackward()){
        this.controller.backward();
        return true
      }
    } catch (error) {
      console.error(`ErrorCode: ${error?.code},  Message: ${error?.message}`);
    }
    return false
  }
  aboutToAppear(){
    web_webview.WebviewController.setWebDebuggingAccess(true)
  }
  onPageShow(){
    try {
      if(this.url!=='' && this.controller.getUrl()!==(this.server + this.url)){
        this.controller.loadUrl((this.server + this.url))
      }
    }catch (e){
      console.info("[ADSAPI] load url fail")
    }
  }
  onPageHide(){
    this.url = this.controller.getUrl().replace(this.server,'');
  }
  build(){
    Column(){
      Web({src:(this.server + this.url),controller:this.controller})
        .fileAccess(this.fileAccess).domStorageAccess(true)
        .mixedMode(MixedMode.All).databaseAccess(true)
        .geolocationAccess(true).userAgent(this.ua)
        .javaScriptAccess(true).javaScriptProxy({
        object:this.adapterProxy,
        name:"as",
        methodList:this.adapter.getMethodList(),
        controller:this.controller
      }).onConsole((event?:onConsoleEvent) => {
        if(event){
          console.log('[ADSAPI] [WEB]' + event?.message?.getMessage())
        }
        return false
      }).zoomAccess(false).horizontalScrollBarAccess(false)
        .onPageEnd(e=>{
          try {
            this.controller.runJavaScript(
            this.adapter.getRunJavaScript(),
              (error, result) => {
                if (error) {
                  console.info(`[ADSAPI] run JavaScript error: ` + JSON.stringify(error))
                  return;
                }
                if (result) {
                  this.webResult = result
                  console.info(`[ADSAPI] The asFinish() return value is: ${result}`)
                }
              });
          } catch (error) {
            console.error(`[ADSAPI] ErrorCode: ${error?.code},  Message: ${error?.message}`);
          }
        })
        .onShowFileSelector((event?:onShowFileSelectorEvent) => {
          if(event && event?.fileSelector?.getAcceptType().length===1 && event?.fileSelector?.getAcceptType()[0] === '.advanced'){
            AppStorage.setOrCreate('fileSelectorEvent',
              event);
          }else if(event){
            const atManager = abilityAccessCtrl.createAtManager()
            atManager.requestPermissionsFromUser(getContext(),['ohos.permission.READ_MEDIA', 'ohos.permission.WRITE_MEDIA']).then(() => {
              let uri:Array<string> = []
              let PhotoSelectOptions = new picker.PhotoSelectOptions();
              PhotoSelectOptions.MIMEType = picker.PhotoViewMIMETypes.IMAGE_VIDEO_TYPE;
              PhotoSelectOptions.maxSelectNumber = 99;
              let photoPicker = new picker.PhotoViewPicker();
              photoPicker.select(PhotoSelectOptions).then((abilityResult) => {
                uri = abilityResult.photoUris
                event?.result?.handleFileList(uri)
              })
                .catch((err:Error) => {
                console.error('[ADSAPI] MyFileUploader FilePicker startAbilityForResult got error: ' + JSON.stringify(err))
              })
            })
          }
          return true
        })
        .onInterceptRequest((event?:onInterceptRequestEvent) =>{
          if(!event){
            return null
          }
          const url:string = event?.request?.getRequestUrl()
          if(isFileUri(url) || (isSandboxPath(url) && fs.accessSync(url))){
              const path =  url;
              const file = fs.openSync(path,fs.OpenMode.READ_ONLY);
              const fd = file.fd;
              const responseWeb = new WebResourceResponse();
              responseWeb.setResponseData(fd);
              responseWeb.setResponseCode(200);
              responseWeb.setReasonMessage('OK');
              responseWeb.setResponseIsReady(true)
              console.info(`[ADSAPI] responseWeb`);
              return responseWeb;
          } else if(url.startsWith(this.server)){
            const path = url.replace(this.server,'')
            let mime:string;
            if (url.toLowerCase().endsWith('.png')) {
              mime = "image/png";
            } else if (url.toLowerCase().endsWith(".svg")) {
              mime = "image/svg+xml";
            } else if (url.endsWith(".js")) {
              mime = "text/javascript";
            } else if (url.endsWith('.css')) {
              mime = "text/css";
            } else if (url.endsWith('.ttf')) {
              mime = "font/ttf";
            } else {
              mime = "text/html";
            }
            const resource:Resource = $rawfile(path);
            const responseWeb = new WebResourceResponse();
            responseWeb.setResponseEncoding('utf-8');
            responseWeb.setResponseData(resource);
            responseWeb.setResponseMimeType(mime);
            responseWeb.setResponseCode(200);
            responseWeb.setReasonMessage('OK');
            responseWeb.setResponseIsReady(true);
            console.info(`[ADSAPI] responseWeb`);
            return responseWeb;
          }
          return null
        })
        .onSslErrorEventReceive((event) => {
          console.info(`[ADSAPI] onSslErrorEventReceive:${event.error}`)
          AlertDialog.show({
            title: 'SSL证书无效',
            message: '当前请求发生SSL证书错误，是否继续访问',
            primaryButton: {
              value: '继续',
              action: () => {
                event.handler.handleConfirm()
              }
            },
            secondaryButton: {
              value: '取消',
              action: () => {
                event.handler.handleCancel()
              }
            },
            cancel: () => {
              event.handler.handleCancel()
            }
          })
          return true
        }).geolocationAccess(true)
        .onGeolocationShow((event) => {
          if(event){
            event?.geolocation?.invoke(event?.origin, true, true)
          }
        })
    }
  }
}