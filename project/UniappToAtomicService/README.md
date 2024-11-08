### 把本工程解压在HBuilderX的安装目录/plugins，重启HbuildX

### 菜单栏-工具-插件安装，请检查是否已安装HBuilderX核心插件，VUE2工程安装uniapp-cli；VUE3工程安装uniapp-cli-vite

### 打开需要转元服务的工程下manifest.json，点击源码视图，增加元服务配置，如下
```json
"HOS" : {
  "bundleName" : "com.test",
  "cardImage" : "/static/images/introduce/introduction.png",
  "icon" : "/static/logo.png",
  "label" : "test"
}
```
bundleName: 元服务包名
cardImage: 卡片图片地址
icon: 应用图标地址
label: 元服务名称

### 点击菜单栏发行，华为-元服务选项

### 若插件发布报错，错误会写入项目根目录下的error.log文件

### Q&A
1、binding.node缺失
报错信息：LibSass 的二进制文件(D:\xxx\HBuilderX\plugins\compile-node-sass\node_modules\node-sass-china\vendor\win32-x64-93\binding.node)缺失，请执行下面3条命令下载对应版本的二进制文件：（有可能引发此错误的原因是 Node 版本变更）[0m 
  mkdir -p D:\xxx\HBuilderX\plugins\compile-node-sass\node_modules\node-sass-china\vendor\win32-x64-93
  cd D:\xxx\HBuilderX\plugins\compile-node-sass\node_modules\node-sass-china\vendor\win32-x64-93
  curl -o binding.node http://npm.inhuawei.com/mirrors/node-sass//v4.7.2/win32-x64-93_binding.node
[0;31m--> MacOS 、Unix/Linux 请根据权限使用 sudo [0m 
解决方案：执行如上三条命令，请注意win32-x64-93版本用自己报错信息中提到的版本

2、元服务白屏
请检查uniapp工程下的manifest.json文件，web配置-运行的基础路径，改成./

