const fs = require('fs')
const path = require('path')
const hx = require('hbuilderx')
const { exec } = require('child_process')
const { copy, findCodeFile } = require('./util.js')
const Project = require('./Project.js')
const OutputChannel = require('./OutputChannel.js')

const TAG = '[UniappToAtomicService] '
const EXCLUDE = [
  '.git',
  '.gitignore',
  '.hbuilderx',
  'README.md',
  'package-lock.json'
]

class Compiler {
  static CONDITION_COMPILER_NAME = 'HOS'

  constructor({
    rootPath,
    uniappName,
    platform,
    bundleName,
    projectIcon,
    projectCard,
    projectName,
    appRoot }) {
    this.encoding = 'cp936'
    this.platform = platform
    this.appRoot = appRoot

    this.uniapp = new Project({ rootPath, name: uniappName })

    this.advancedTemplate = path.resolve(__dirname, './project/AdvancedTemplete')
    this.harmony = new Project({
      targetDir: this.uniapp.asSource,
      rootPath: this.uniapp.asSource + '/' + bundleName,
      name: bundleName,
      label: projectName,
      icon: projectIcon,
      cardImage: projectCard,
      type: 'harmony'
    })
    this.harmony.rawfilePath = this.harmony.rootPath + '/entry/src/main/resources/rawfile'
  }

  static checkEnvironment () {
    return Promise.all([
      this.checkNpm(),
      this.installCrossEnv(),
      this.checkUniappCli()
    ])
  }

  static checkNpm () {
    return new Promise((resolve, reject) => {
      this.runScript('npm -version').then(stdout => {
        resolve()
      }, (err) => {
        reject(err)
      })
    })
  }

  static installCrossEnv () {
    return new Promise((resolve, reject) => {
      this.runScript('npm ls -g').then(stdout => {
        const hasCrossEnv = stdout.split('\n').some(line => {
          return line.includes(' cross-env@')
        })
        if (!hasCrossEnv) {
          this.runScript('npm i cross-env -g').then(() => {
            resolve()
          }, (err) => {
            reject(`npm i cross-env -g下载失败，报错信息：${err}`)
          })
        } else {
          resolve()
        }
      }, (err) => {
        reject(`npm ls -g命令失败，${err}`)
      })
    })
  }

  static checkUniappCli () {
    return new Promise((resolve, reject) => {
      fs.access(hx.env.appRoot + '/plugins/uniapp-cli', (err) => {
        if (err) {
          OutputChannel.getInstance().appendLine(`请检查是否已安装HBuilderX核心插件uniapp-cli`)
          reject()
          return
        }
        resolve()
      })
    })
  }

  static runScript (script) {
    return new Promise((resolve, reject) => {
      exec(script,
        { encoding: 'utf-8' },
        (error, stdout, stderr) => {
          OutputChannel.getInstance().appendLine(script)
          if (error) {
            OutputChannel.getInstance().appendLine(stdout + stderr)
            reject(stdout + stderr)
            return
          }
          OutputChannel.getInstance().appendLine(stdout)
          resolve(stdout)
        })
    })
  }

  // 根据pages判断项目类型
  getProjectType (project) {
    return project.getType()
  }

  // copy cp的uniapp项目
  copyUniappProjectForHarmony (targetProject) {
    return new Promise(async (resolve, reject) => {
      const type = this.getProjectType(targetProject)
      const copyName = targetProject.name + '.asHarmony'
      const copyUniapp = new Project({
        rootPath: path.resolve(__dirname, './asbuild/' + copyName),
        name: copyName,
        type,
        manifest: targetProject.manifest
      })
      this.copyUniapp = copyUniapp
      console.debug(TAG, '下载鸿蒙模板工程中...')
      copy(targetProject.rootPath, copyUniapp.rootPath, {
        exclude: EXCLUDE
      }, true)
      await copyUniapp.changeRouterPath('./')
      copyUniapp.getUniappConfig()
      await this.modifyConfig(copyUniapp)
      console.debug(TAG, 'create uniappProject success')
      resolve()
    })
  }

  // 修改配置文件
  async modifyConfig (copyUniapp) {
    const { rootPath, name, type } = copyUniapp
    let packageJSON
    const packagePath = rootPath + '/package.json'
    try {
      fs.accessSync(packagePath)
      const packageStr = fs.readFileSync(packagePath, { encoding: 'utf-8' })
      packageJSON = JSON.parse(packageStr)
    } catch (error) {
      console.debug(TAG, `新建${rootPath}/package.json`)
      // 创建package.json文件
      packageJSON = {
        'name': name,
        'version': '1.0.0',
        'description': '',
        'scripts': {
          'test': 'echo "Error: no test specified" && exit 1'
        },
        'author': '',
        'license': 'ISC',
        'uni-app': {
          'scripts': {
            [Compiler.CONDITION_COMPILER_NAME]: {
              'title': '编译鸿蒙工程资源',
              'env': {
                'UNI_PLATFORM': 'h5'
              },
              'define': {
                [Compiler.CONDITION_COMPILER_NAME.toUpperCase()]: true
              }
            }
          }
        }
      }
    }
    this.addASCondition(packageJSON)
    const vueVersion = await copyUniapp.getVueVersion()
    this.addCommand(packageJSON, type, vueVersion)
    const updatePackageStr = JSON.stringify(packageJSON, null, 2)
    fs.writeFileSync(packagePath, updatePackageStr)
  }

  // 加入自定义条件编译
  addASCondition (packageJSON) {
    if (!packageJSON['uni-app']) {
      packageJSON['uni-app'] = {}
    }
    if (!packageJSON['uni-app']['scripts']) {
      packageJSON['uni-app']['scripts'] = {}
    }
    packageJSON['uni-app']['scripts'][Compiler.CONDITION_COMPILER_NAME] = {
      'title': '编译鸿蒙工程资源',
      'env': {
        'UNI_PLATFORM': 'h5'
      },
      'define': {
        [Compiler.CONDITION_COMPILER_NAME.toUpperCase()]: true
      }
    }
  }

  // 加入条件编译命令
  addCommand (packageJSON, type, vueVersion) {
    if (!packageJSON['scripts']) {
      packageJSON['scripts'] = {}
    }
    if (type === Project.TYPE.VUE_CLI) {
      if (vueVersion === Project.VUE_VERSION.CLI_2) {
        packageJSON['scripts']['build:as'] = `cross-env UNI_OUTPUT_DIR=$INIT_CWD${Project.VUE_DIST_RELATIVE_PATH} NODE_ENV=production uniapp-cli custom HOS`
      } else {
        packageJSON['scripts']['build:as'] = `cross-env UNI_OUTPUT_DIR=$INIT_CWD${Project.VUE_DIST_RELATIVE_PATH} NODE_ENV=production uni build -p HOS`
      }
    } else {
      const appRoot = this.appRoot
      const disc = appRoot.substr(0, appRoot.indexOf(':'))
      if (vueVersion === Project.VUE_VERSION.CLI_2) {
        packageJSON['scripts']['build:as'] = `${disc}: && cd "${appRoot}/plugins/uniapp-cli/" && cross-env UNI_INPUT_DIR=$INIT_CWD/ UNI_OUTPUT_DIR=$INIT_CWD${Project.HBUILDERX_DIST_RELATIVE_PATH} NODE_ENV=production UNI_SCRIPT=${Compiler.CONDITION_COMPILER_NAME} "${appRoot}/plugins/node/node.exe" bin/uniapp-cli.js`
      } else {
        packageJSON['scripts']['build:as'] = `${disc}: && cd "${appRoot}/plugins/uniapp-cli-vite/" && cross-env UNI_INPUT_DIR=$INIT_CWD/ UNI_OUTPUT_DIR=$INIT_CWD/unpackage/dist/build/HOS NODE_ENV=production UNI_SCRIPT=HOS "${appRoot}/plugins/node/node.exe" node_modules/@dcloudio/vite-plugin-uni/bin/uni.js build`
      }
    }
  }

  disposeFile (project) {
    try {
      // 删除static/h5文件夹资源
      let staticH5
      if (project.type === Project.TYPE.VUE_CLI) {
        staticH5 = project.rootPath + '/src/static/h5'
      } else {
        staticH5 = project.rootPath + '/static/h5'
      }
      fs.rmdirSync(staticH5, { recursive: true })
    } catch (error) {
      console.debug(TAG, '不存在static/h5')
    }

    // 把编译条件H5改成H5-disabled
    findCodeFile(project.rootPath, { exclude: EXCLUDE.concat(['node_modules', 'uni_modules']) })
  }

  // uniapp工程打包
  publishH5 (project) {
    return new Promise(async (resolve, reject) => {
      if (project.type === Project.TYPE.VUE_CLI) {
        if (!this.checkInstall(project)) {
          await project.install()
        }
      }
      OutputChannel.getInstance().appendLine('准备开始编译...')
      await project.runScript('npm run build:as')
      OutputChannel.getInstance().appendLine('编译成功')
      resolve()
    })
  }

  checkInstall (project) {
    try {
      fs.accessSync(project.rootPath + '/node_modules')
      console.debug(TAG, `存在${project.rootPath}/node_modules文件夹`)
      return true
    } catch (error) {
      return false
    }
  }

  // copy鸿蒙webview工程模板
  createHarmonyPorject () {
    OutputChannel.getInstance().appendLine('准备创建元服务')
    return new Promise((resolve, reject) => {
      try {
        const projectDir = path.resolve(this.harmony.rootPath)
        fs.access(projectDir, (err) => {
          if (err) {
            fs.mkdirSync(projectDir, { recursive: true })
            // 当前要创建的鸿蒙工程文件夹不存在，可以直接创建
            copy(this.advancedTemplate, projectDir)
            setTimeout(() => {
              console.log(TAG, 'create harmony Project success')
              OutputChannel.getInstance().appendLine(`元服务创建成功，地址:${this.harmony.rootPath}`)
              resolve()
            }, 500)
          } else {
            OutputChannel.getInstance().appendLine('已存在元服务')
            this.harmony.updateRawfiles = true
            resolve()
          }
        })
      } catch (e) {
        reject(e)
      }
    })
  }

  // 把打包好的资源到鸿蒙工程rawfile路径下
  copyH5PackagetoRawfile () {
    OutputChannel.getInstance().appendLine('准备同步打包资源到元服务')
    return new Promise((resolve, reject) => {
      try {
        copy(this.copyUniapp.asSource, this.harmony.asSource)
        OutputChannel.getInstance().appendLine('打包资源同步成功')
        resolve()
      } catch (e) {
        OutputChannel.getInstance().appendLine('打包资源同步失败')
        reject(e)
      }
    })
  }

  // 同步uniapp.manifest信息到鸿蒙工程
  updateAppConfig () {
    OutputChannel.getInstance().appendLine('同步uniapp工程信息到元服务')
    const { versionName = '', versionCode = '100', version } = this.copyUniapp.manifest
    try {
      const appScopeConfigPath = this.harmony.rootPath + '/AppScope/app.json5'
      let appInfo = fs.readFileSync(appScopeConfigPath, { encoding: 'utf-8' })
      appInfo = JSON.parse(appInfo)
      appInfo.app.bundleName = this.harmony.name
      appInfo.app.versionCode = Number(versionCode)
      appInfo.app.versionName = versionName || version
      fs.writeFileSync(appScopeConfigPath, JSON.stringify(appInfo, null, 2))

      const stringPath = this.harmony.rootPath + '/AppScope/resources/base/element/string.json'
      let stringInfo = fs.readFileSync(stringPath, { encoding: 'utf-8' })
      stringInfo = JSON.parse(stringInfo)
      for (let i = 0; i < stringInfo.string.length; i++) {
        const item = stringInfo.string[i]
        if (item.name === 'app_name') {
          item.value = this.harmony.label
          break
        }
      }
      fs.writeFileSync(stringPath, JSON.stringify(stringInfo, null, 2))

      const resZHStringPath = this.harmony.rootPath + '/entry/src/main/resources/zh_CN/element/string.json'
      let resZHInfo = fs.readFileSync(resZHStringPath, { encoding: 'utf-8' })
      resZHInfo = JSON.parse(resZHInfo)
      for (let i = 0; i < resZHInfo.string.length; i++) {
        const item = resZHInfo.string[i]
        if (item.name === 'EntryAbility_label') {
          item.value = this.harmony.label
          break
        }
      }
      fs.writeFileSync(resZHStringPath, JSON.stringify(resZHInfo, null, 2))

      const resENStringPath = this.harmony.rootPath + '/entry/src/main/resources/en_US/element/string.json'
      let resENInfo = fs.readFileSync(resENStringPath, { encoding: 'utf-8' })
      resENInfo = JSON.parse(resENInfo)
      for (let i = 0; i < resENInfo.string.length; i++) {
        const item = resENInfo.string[i]
        if (item.name === 'EntryAbility_label') {
          item.value = this.harmony.label
          break
        }
      }
      fs.writeFileSync(resENStringPath, JSON.stringify(resENInfo, null, 2))

      const resBaseStringPath = this.harmony.rootPath + '/entry/src/main/resources/base/element/string.json'
      let resBaseInfo = fs.readFileSync(resBaseStringPath, { encoding: 'utf-8' })
      resBaseInfo = JSON.parse(resBaseInfo)
      for (let i = 0; i < resBaseInfo.string.length; i++) {
        const item = resBaseInfo.string[i]
        if (item.name === 'EntryAbility_label') {
          item.value = this.harmony.label
          break
        }
      }
      fs.writeFileSync(resBaseStringPath, JSON.stringify(resBaseInfo, null, 2))

      try {
        if (this.harmony.icon) {
          const iconPath = this.uniapp.rootPath + this.harmony.icon
          fs.accessSync(iconPath)
          fs.copyFileSync(iconPath, this.harmony.rootPath + '/AppScope/resources/base/media/app_icon.png')
          fs.copyFileSync(iconPath, this.harmony.rootPath + '/entry/src/main/resources/base/media/icon.png')
        }
      } catch (error) {
        OutputChannel.getInstance().appendLine(`${error}`)
      }
      try {
        if (this.harmony.cardImage) {
          const cardImage = this.uniapp.rootPath + this.harmony.cardImage
          fs.accessSync(cardImage)
          fs.copyFileSync(cardImage, this.harmony.rootPath + '/entry/src/main/resources/rawfile/desktop_card.png')
        }
      } catch (error) {
        OutputChannel.getInstance().appendLine(`${error}`)
      }
      OutputChannel.getInstance().appendLine(`同步uniapp工程信息到元服务成功，可以使用DevEco打开元服务，工程地址: ${this.harmony.rootPath}`)
    } catch (err) {
      OutputChannel.getInstance().appendLine(err)
    }
  }

  clear (project) {
    // 删除新建的工程
    fs.rmdirSync(project.rootPath, { recursive: true })
    console.debug(TAG, 'compiler.clear success')
  }

  openDir () {
    exec(`explorer.exe /select, "${path.resolve(this.harmony.rootPath)}"`)
  }
}

module.exports = Compiler
