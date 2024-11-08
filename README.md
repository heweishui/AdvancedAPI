### 仓库信息

- 链接：https://codehub-g.huawei.com/Ecosystem/taro-ohos/AdvancedAPI_OHOS/files?ref=master
- 简介：高阶API实现，引用OS原生能力SDK，对外提供符合快应用、Taro标准的API（原始库支持快应用，Taro适配中）

### 编译生成js

git clone下载源码，在根目录中执行：

```
npm install
```

然后使用如下命令打包生成一个js文件：

```
npm run build:advanced
```

### 生成har包或者hsp包

- 使用DevEco Studio打开project/advancedHsp工程，新建如下两个路径：
  - project\advancedApiHsp\advanced_api_har\src\main\ets\utils\
  - project\advancedApiHsp\advanced_api_hsp\src\main\ets\utils\
- 把生成的js文件dist/advancedapi.min.js复制到上述位置
- 点击菜单: `Build` -- `Make All Modules`生成所有模块
- har包生成在路径：advancedApiHsp\advanced_api_har\build\default\outputs\default中
