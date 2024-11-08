## 应用间HSP使用说明
### 本工程为HarmonyOS工程，非OpenHarmony
### DevEco Studio使用4.0.1.200以上版本，SDK使用IDE配套版本
### 本地编译需要将advancedapi.min.js文件放在src/ets/utils下，后续流水线会自动将最新的js文件复制过去再出包。
### 不要使用 IDE的RUN功能安装HSP，当前IDE还没适配。
### 使用Build->Build Hap(s)/App(s)->Build App(s)进行本地编译。
### 安装时需要先将hsp包推送到设备上，比如data/hsp目录，然后执行
```shell
# bm install -s data/hsp/advanced_api_hsp-default-signed.hsp
```
### 卸载时使用如下命令
```shell
# bm uninstall -s com.huawei.hmos.advancedapi -n com.huawei.hmos.advancedapi 
```