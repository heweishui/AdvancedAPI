import web_webview from '@ohos.web.webview'
const METHOD_LIST: Array<string> = [
    'chooseImage',
    'getNetworkType',
    'onNetworkStatusChange',
    'offNetworkStatusChange',
    'getDeviceInfo',
    'getWindowInfo',
    'getAppBaseInfo',
    'getAppAuthorizeSetting',
    'getSystemSetting',
    'openAppAuthorizeSetting',
    'compressImage',
    'setScreenBrightness',
    'getScreenBrightness',
    'setKeepScreenOn',
    'makePhoneCall',
    'onUserCaptureScreen',
    'offUserCaptureScreen',
    'setUserCaptureScreen',
    'vibrate',
    'vibrateLong',
    'vibrateShort',
    'openBluetoothAdapter',
    'startBluetoothDevicesDiscovery',
    'stopBluetoothDevicesDiscovery',
    'onBluetoothDeviceFound',
    'getBluetoothDevices',
    'getBluetoothAdapterState',
    'createBLEConnection',
    'closeBLEConnection',
    'getBLEDeviceServices',
    'getBLEDeviceCharacteristics',
    'onBLEConnectionStateChange',
    'readBLECharacteristicValue',
    'onBLECharacteristicValueChange',
    'notifyBLECharacteristicValueChange',
    'closeBluetoothAdapter',
    'stopAccelerometer',
    'onAccelerometerChange',
    'startAccelerometer',
    'offAccelerometerChange',
    'onCompassChange',
    'offCompassChange',
    'startCompass',
    'stopCompass',
    'onGyroscopeChange',
    'startGyroscope',
    'stopGyroscope',
    'addPhoneContact',
    'setClipboardData',
    'getClipboardData',
    'startWifi',
    'stopWifi',
    'getConnectedWifi',
    'getWifiList',
    'onGetWifiList',
    'offGetWifiList',
    'connectWifi',
    'onWifiConnected',
    'offWifiConnected',
    'onWifiConnectedWithPartialInfo',
    'offWifiConnectedWithPartialInfo',
    'getBatteryInfo',
    'saveFile',
    'getSavedFileList',
    'getSavedFileInfo',
    'removeSavedFile',
    'getFileInfo',
    'chooseVideo',
    'chooseMedia',
    'createInnerAudioContext',
    'getRecorderManager',
    'getBackgroundAudioManager',
    'saveImageToPhotosAlbum',
    'saveVideoToPhotosAlbum',
    'getVideoInfo',
    'createCameraContext',
    'getLocation',
    'onLocationChange',
    'offLocationChange',
    'onLocationChangeError',
    'offLocationChangeError',
    'startLocationUpdate',
    'stopLocationUpdate',
    'startLocationUpdateBackground',
    'uploadFile',
    'downloadFile',
    'onWindowResize',
    'offWindowResize',
    'hideKeyboard',
    'onKeyboardHeightChange',
    'offKeyboardHeightChange',
    'login',
    'getUserInfo',
    'getProvider',
    'sendToAs',
    'saveBlobMap',
    'initCustomUni',
]

export class Adapter {
    constructor(controller: web_webview.WebviewController) {
        this.controller = controller,
        this.asObjectId = 0,
        this.asObjectMap = new Map(),
        this.asCallbackMap = new Map(),
        this.blobFilePathMap = new Map(),
        this.pathBlobFileMap = new Map(),
        this.sendTaskPromise = new Promise((resolve,reject)=>{resolve('')})
    }
    controller: web_webview.WebviewController
    asObjectId: number
    asObjectMap:Map<number,Object>
    asCallbackMap:Map<number,Object>
    blobFilePathMap:Map<string,string>
    pathBlobFileMap:Map<string,string>
    sendTaskPromise:Promise<string>
    blockMap:Map<number,number> = new Map()
    getMethodList(): Array<string>{
        return METHOD_LIST
    }
    getBlobFilePathMap():Map<string,string>{
        return this.blobFilePathMap
    }
    getRunJavaScript(): string{
        let result:string = `
        if(typeof(adapterInited) === 'undefined'){
            var asCallbackMap = new Map();
            var asAPIMap = new Map();
            var asCallbackId = 0;
            var fileBlobMethod = [
              'chooseVideo','chooseMedia'
            ]
            var receiveTask = (callbackId,resObject) =>{
                if(asCallbackMap.get(callbackId)){
                   asCallbackMap.get(callbackId).apply(null,resObject);
                }
                return true
            }
            var temp_uni = uni
            uni = new Proxy({},{
                get(target,property){
                    if(asAPIMap.has(property)){
                        return asAPIMap.get(property)
                    }
                    return temp_uni[property]
                }
            })
            var getCallbackParam = (args) =>{
                const callbackObj = []
                args.forEach((arg,index)=>{
                    if(typeof(arg) === 'object'){
                        callbackObj[index] = {}
                        for(let name in arg){
                            if(typeof(arg[name])==='function'){
                               asCallbackMap.set(asCallbackId,arg[name]);
                               callbackObj[index][name] = asCallbackId++;
                            }
                        }
                    }else if(typeof(arg) === 'function'){
                        let tempId = null;
                        for(let prop of asCallbackMap){
                            if(prop[1] === arg){
                                tempId = prop[0];
                                break;
                            }
                        }
                        if(tempId !== null){
                            callbackObj[index] = arg.name ? tempId + '_'+arg.name : tempId;
                        }else{
                            asCallbackMap.set(asCallbackId,arg);
                            callbackObj[index] = arg.name ? (asCallbackId++)+'_'+arg.name : asCallbackId++;
                        }

                    }
                })
                const argsStr = JSON.stringify(args);
                const callbackString = JSON.stringify(callbackObj);
                return [callbackString,argsStr]
            }
            var openFilePicker = (fn) =>{
              const inpEle = document.createElement("input");
              inpEle.id = '__file_' + Math.trunc(Math.random() * 100000);
              inpEle.type = "file";
              inpEle.style.display = "none";
              inpEle.accept = ".advanced";
              inpEle.addEventListener("change", event => fn.call(inpEle, event, inpEle.files), {once: true});
              inpEle.dispatchEvent(new MouseEvent('click'));
            }
            var setAsAPIFunction = (method) =>{
                return (...args) => {
                    console.info('call as method:'+method);
                    if(fileBlobMethod.includes(method)){
                        openFilePicker(
                            (e, files) => {
                              console.log("files", files);
                              const blobPathArray = [];
                              for(let i = 0; i < files.length; i++){
                                let blobPath = URL.createObjectURL(files[i]);
                                blobPathArray.push(blobPath);
                              }
                              as.saveBlobMap(JSON.stringify(blobPathArray));
                            }
                        );
                    }
                    const callbackParam = getCallbackParam(args);
                    const result = as[method](callbackParam[0],callbackParam[1]);
                    if(result){
                        const resultObj = JSON.parse(result)
                        const resultObjT = JSON.parse(result)
                        const asObjectId = resultObj.asObjectId
                        const proxy = new Proxy(resultObjT,{
                            get:(target,property)=>{
                                const type = resultObj[property]
                                if(type ==='function'){
                                    return (...args1) => {
                                        const callbackParam = getCallbackParam(args1)
                                        as.sendToAs(asObjectId,'get_function',property,callbackParam[0],callbackParam[1])
                                    }
                                } else {
                                    return as.sendToAs(asObjectId,'get_value',property)
                                }
                            },
                            set:(target,property,value)=>{
                                as.sendToAs(asObjectId,'set',property,value)
                                return true
                            }
                        })
                        return proxy
                    }
                }
            }
            var adapterInited = true;
        }
        `
        METHOD_LIST.forEach(method=>{
            result = result + this.createJavaScriptString(method)
        })
        return result
    }
    createJavaScriptString(method:string) : string{
        return `
        asAPIMap.set('${method}',setAsAPIFunction('${method}'))
        `
    }
    async sendTask(callbackId,res){
        // 由于媒体类涉及到视频文件的几个接口需要webview处理File对象，此处会将这几个接口涉及到的路径转化为webview能识别的blob路径
        const fileBlobMethod = [
            'chooseVideo','chooseMedia'
        ]
        if(res && res[0] && res[0].errMsg && fileBlobMethod.includes(res[0].errMsg.split(':')[0])){

            let tempFilePaths = [];
            const tempFileSandBoxPaths = [];

            if(res[0].errMsg.split(':')[0] ==='chooseMedia') {
                tempFilePaths = res[0].tempFiles
                for(let i = 0; i < tempFilePaths.length; i++){
                    if(res[0].tempFiles[i].fileType === 'mp4'){
                        tempFileSandBoxPaths.push(tempFilePaths[i].tempFilePath)
                    }
                }
            }else{
                tempFilePaths = [res[0].tempFilePath]
                tempFileSandBoxPaths.push(res[0].tempFilePath)
            }
            if(tempFilePaths && tempFilePaths.length!==0){
                AppStorage.SetOrCreate('sandboxPath',tempFilePaths);
                const fileSelectorEvent = AppStorage.Get('fileSelectorEvent');
                if(fileSelectorEvent){
                    // @ts-ignore
                    fileSelectorEvent.result.handleFileList(tempFileSandBoxPaths);
                    AppStorage.Delete('fileSelectorEvent');

                    if(res[0].errMsg.split(':')[0] ==='chooseMedia') {
                        for(let i = 0; i < res[0].tempFiles.length;i++){
                            if(tempFilePaths[i].fileType !== 'mp4'){
                                continue;
                            }
                            while (!this.blobFilePathMap.has(tempFilePaths[i].tempFilePath) && tempFilePaths[i].fileType === 'mp4'){
                                await new Promise(res=> setTimeout(res,50));
                            }
                            res[0].tempFilePaths[i].tempFilePath = this.blobFilePathMap.get(tempFilePaths[i].tempFilePath);
                        }
                    }else{
                        while (!this.blobFilePathMap.has(res[0].tempFilePath)){
                            await new Promise(res=> setTimeout(res,50));
                        }
                        res[0].tempFilePath = this.blobFilePathMap.get(res[0].tempFilePath);
                    }
                }
            }
        }
        // 高评率触发的限流，单位时间触发过多会导致进程锁死
        const resStrTmp = JSON.stringify(res)
        if(this.blockMap.has(callbackId)){
            const lastTime = this.blockMap.get(callbackId);
            const currTime = new Date().getTime();
            // 限流条件为同一回调事件，时间间隔100ms，且消息长度超过1000字符
            const interval = 100
            const resLengthLimit = 1000
            if(currTime - lastTime < interval && resStrTmp.length > resLengthLimit){
                return
            }
        }
        this.blockMap.set(callbackId,new Date().getTime());
        console.info(`[ADSAPI] callbackId:${callbackId}`)
        console.info(`[ADSAPI] res: ${resStrTmp}`)
        const that = this
        that.sendTaskPromise = that.sendTaskPromise.then(()=>{
            return that.controller.runJavaScript(`receiveTask(${callbackId},${resStrTmp})`)
                .then(result=>{
                    console.info(`[ADSAPI] The receiveTask() return value is: ${result}`)
                    return result
                }).catch(error=>{
                    console.info(`[ADSAPI] run JavaScript error: ` + JSON.stringify(error))
                    return JSON.stringify(error)
                })
        })
        // arkTs 向 WebView的限流，当前可以先放开，等后续有场景需要时再开启
            /*.then(result=>{
            return new Promise((resolve)=>{
                setTimeout(()=>{
                    resolve(result)
                },1000)
            })
        })*/
    }
    getAdapterProxy(as){
        const that = this
        Object.defineProperty(as,'sendToAs',{
            get:()=>{
                return (asObjectId,type,method,...args)=>{
                    console.info(`[ADSAPI] asObjectId ${asObjectId} ${method}`)
                    const asObject = that.asObjectMap.get(asObjectId)
                    if(type === 'get_function'){
                        if(args){
                            const callbackString = args[0]
                            const argsStr = args[1]
                            const argsT = JSON.parse(argsStr)
                            const callbackObj = JSON.parse(callbackString)
                            callbackObj.forEach((obj,index)=>{
                                if(typeof(obj) === 'object'){
                                    for(let name in obj){
                                        argsT[index][name] = (...res)=>{
                                            that.sendTask(obj[name],res)
                                        }
                                    }
                                }else{
                                    argsT[index] = (...res)=>{
                                        that.sendTask(obj,res)
                                    }
                                }
                            })
                            return asObject[method].apply(asObject,argsT)
                        }else{
                            return asObject[method]()
                        }
                    }else if(type === 'get_value'){
                        const res = asObject[method]
                        console.log(`[ADSAPI] ${method} : ${res}`)
                        return res
                    }else if(type === 'set'){
                        return asObject[method] = args[0]
                    }
                }
            }
        })

        Object.defineProperty(as,'initCustomUni',{
            get:()=>{
                return ()=>{
                    return that.getRunJavaScript()
                }
            }
        })
        Object.defineProperty(as,'saveBlobMap',{
            get:()=>{
                return (values)=>{
                    console.log(`[ADSAPI] saveBlobMap`)
                    const paths = JSON.parse(values)
                    const sandboxPath = AppStorage.Get('sandboxPath');
                    paths.forEach((value,index)=>{
                        that.blobFilePathMap.set(sandboxPath[index], value)
                        that.pathBlobFileMap.set(value, sandboxPath[index])

                    })
                    AppStorage.Delete('sandboxPath');
                    return true
                }
            }
        })
        const proxy = new Proxy(as,{
            get(target,property){
                console.info('[ADSAPI] methodName:'+property.toString());
                if(property == 'sendToAs' || property == 'initCustomUni' || property == 'saveBlobMap'){
                    return target[property]
                }
                return (callbackString,argsStr)=>{
                    const args = JSON.parse(argsStr)
                    const callbackObj = JSON.parse(callbackString)
                    if(property == 'saveVideoToPhotosAlbum' &&args.length == 1 && args[0].filePath  && that.pathBlobFileMap.has(args[0].filePath)){
                        args[0].filePath = that.pathBlobFileMap.get(args[0].filePath)
                    }
                    if(property == 'getVideoInfo' &&args.length == 1 && args[0].src  && that.pathBlobFileMap.has(args[0].src)){
                        args[0].src = that.pathBlobFileMap.get(args[0].src)
                    }
                    callbackObj.forEach((obj,index)=>{
                        if(typeof(obj) === 'object'){
                            for(let name in obj){
                                args[index][name] = (...res)=>{
                                    that.sendTask(obj[name],res)
                                }
                            }
                        }else{
                            let key = obj;
                            let objArray = []
                            if(typeof(obj) === 'string'){
                                objArray = obj.split('_')
                                key = Number.parseInt(objArray[0])
                            }
                            // objArray[1]存在的情况下CP代码传递过来的方法为命名函数，此时才需要放在Map当中保证重复调用的时候指向同一个对象
                            if(objArray.length > 1){
                                if(that.asCallbackMap.has(key)){
                                    const callback = that.asCallbackMap.get(key);
                                    args[index] = callback;
                                }else{
                                    const callback = (...res)=>{
                                        that.sendTask(key,res)
                                    }
                                    args[index] = callback;
                                    that.asCallbackMap.set(key,callback);
                                }
                            } else {
                                args[index] = (...res)=>{
                                    that.sendTask(key,res)
                                }
                            }
                        }
                    })
                    const asObject = target[property].apply(null,args)
                    if(typeof(asObject)==='object'){
                        that.asObjectMap.set(that.asObjectId,asObject)
                        const proto = Object.getPrototypeOf(asObject)
                        const list = Object.getOwnPropertyNames(proto).concat(Object.getOwnPropertyNames(asObject))
                        const resultJson = {asObjectId:that.asObjectId++}
                        list.forEach(value=>{
                            if(value!=='constructor'){
                                resultJson[value] = typeof(asObject[value])
                            }
                        })
                        const resultStr = JSON.stringify(resultJson)
                        return resultStr
                    }else {
                        return asObject
                    }
                }
            }
        })
        return proxy
    }
}