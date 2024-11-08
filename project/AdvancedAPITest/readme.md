# 1.当前使用的qafapi为2023/8/9构建版本，如需更新请执行流水线获取最新代码的har包，如不需更新可跳过第一步
## https://clouddragon.huawei.com/pipeline/project/g066725574d884eeab17aa631b8c5d5eb/services/6636f8b4c7b54730a5985745cd427e5b/pipeline/details/635883cbf17f400e8d062d24ed7322b8
开发分支 AS_HSP_HAR任务，编译出压缩包后从har目录下获取advanced_api_har.har，解压到src/ohosTest/ets/目录下覆盖原文件

删除project/AdvancedAPITest/entry/oh_modules

在project/AdvancedAPITest/entry目录下命令行执行ohpm install安装最新的qafapi代码
# 2.在src/ohosTest/ets/test目录下创建模块目录，编写测试用例套
# 3.编写完成的测试用例引入到List.test.ets中
# 4.测试用例名称只能由字母数字下划线点号组成
# 5.异步方法的done()不要放到回调中，否则运行会报超时
# 6.回调方法使用箭头函数,不要使用function(){...},否则启动阶段会卡住