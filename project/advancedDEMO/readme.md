## 需要到sdk的ets/build-tools/ets-loader目录下执行
## npm install @babel/plugin-proposal-decorators
## 增加修饰器支持，并修改该目录下的webpack.config.js文件中的setJsConfigRule方法，
```javascript
function setJsConfigRule() {
  const jsRule = {
    test: /\.js$/,
    use: [
      {
        loader: 'babel-loader',
        options: {
          // 修改的是这个plugins属性，其他的不用改
          plugins: [
          ['@babel/plugin-proposal-decorators',
          {
            "legacy": true
          }],
          ["@babel/plugin-proposal-class-properties", { "loose": true }]
        ],
          compact: false
        }
      },
      { loader: path.resolve(__dirname, 'lib/process_js_file.js')},
      { loader: path.resolve(__dirname, 'lib/process_system_module.js') }
    ]
  };
  if (projectConfig.compileMode !== 'esmodule') {
    jsRule.type = 'javascript/auto';
    jsRule.use[0].options.plugins.unshift('@babel/plugin-transform-modules-commonjs');
  }
  return jsRule;
}
```
## 项目根目录下的packageTemp.json文件需要改名为package.json，因为叫package.json上库的话会和原有的api打包指令冲突。
