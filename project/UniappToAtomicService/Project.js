const fs = require('fs')
const hx = require('hbuilderx')
const { exec } = require('child_process')
const { clearComment } = require('./util')
const OutputChannel = require('./OutputChannel.js')

const TAG = '[Project]'

class Project {
  static TYPE = {
    VUE_CLI: 'vue-cli',
    HBUILDERX: 'HBuilderX',
    HARMONY: 'harmony'
  }
  static VUE_VERSION = {
    CLI_2: 2,
    CLI_3: 3
  }
  static VUE_DIST_RELATIVE_PATH = '/dist/build/HOS'
  static HBUILDERX_DIST_RELATIVE_PATH = '/unpackage/dist/build/HOS'

  constructor ({ rootPath, name, type, targetDir, label, icon, cardImage, manifest }) {
    this.rootPath = rootPath
    this.name = name
    this.type = type
    this.targetDir = targetDir
    this.label = label
    this.icon = icon
    this.cardImage = cardImage
    this.manifest = manifest
    this.init()
  }

  init () {
    if (!this.type) {
      this.getType()
    }
    if (this.type === Project.TYPE.HBUILDERX) {
      this.manifestPath = this.rootPath + '/manifest.json'
    } else {
      this.manifestPath = this.rootPath + '/src/manifest.json'
    }
    this._setAsSource()
  }

  getVueVersion () {
    return new Promise((resolve, reject) => {
      hx.util.readJSONValue(this.manifestPath, 'vueVersion').then((data) => {
        if (Number(data.code) !== 0) {
          this.vueVersion = Project.VUE_VERSION.CLI_2
          OutputChannel.getInstance().appendLine('获取manifest.vueVersion失败，默认vue2')
          reject(this.vueVersion)
          return
        }
        if (Project.VUE_VERSION.CLI_3 === Number(data.data)) {
          this.vueVersion = Project.VUE_VERSION.CLI_3
        } else {
          this.vueVersion = Project.VUE_VERSION.CLI_2
        }
        resolve(this.vueVersion)
      })
    })
  }

  _setAsSource () {
    if (this.type === Project.TYPE.VUE_CLI) {
      this.asSource = this.rootPath + Project.VUE_DIST_RELATIVE_PATH
    } else if (this.type === Project.TYPE.HBUILDERX) {
      this.asSource = this.rootPath + Project.HBUILDERX_DIST_RELATIVE_PATH
    } else if (this.type === Project.TYPE.HARMONY) {
      this.asSource = this.rootPath + '/entry/src/main/resources/rawfile'
    }
  }

  setType (type) {
    this.type = type
  }

  getType () {
    if (this.type) {
      return this.type
    }
    let type = Project.TYPE.HBUILDERX
    try {
      fs.accessSync(this.rootPath + '/pages')
    } catch (error) {
      type = Project.TYPE.VUE_CLI
    }
    this.type = type
    return type
  }

  getHarmonyConfig () {
    return new Promise((resolve, reject) => {
      if (!this.manifestPath) {
        this.getType()
      }
      hx.util.readJSONValue(this.manifestPath, 'HOS').then((data) => {
        if (Number(data.code) !== 0) {
          console.debug(TAG, '没有关联harmony工程')
        }
        this.harmonyConfig = data.data
        resolve(data.data)
      })
    })
  }

  setHarmonyConfig ({ name, label, icon, cardImage }) {
    // 如果在manifest已经配置的元服务，则不修改
    if (this.harmonyConfig) {
      return
    }
    const asHuwei = {
      icon: icon,
      bundleName: name,
      label: label,
      cardImage: cardImage
    }

    const result = hx.util.writeJSONValue(this.manifestPath, 'HOS', asHuwei)
    result.then((data) => {
      if (Number(data.code) === 0) {
        console.debug(TAG, 'setHarmonyConfig success')
      } else {
        console.error(TAG, 'setHarmonyConfig fail')
      }
    })
  }

  changeRouterPath (path) {
    return new Promise((resolve, reject) => {
      const result = hx.util.writeJSONValue(this.manifestPath, 'h5.router.base', path)
      result.then((data) => {
        if (Number(data.code) === 0) {
          OutputChannel.getInstance().appendLine('修改运行路径成功')
          resolve()
        } else {
          OutputChannel.getInstance().appendLine('修改运行路径失败')
          reject()
        }
      })
    })
  }

  // 获取uniapp的manifest.json或者package.json信息
  getUniappConfig () {
    let configInfoStr
    try {
      fs.accessSync(this.manifestPath)
      configInfoStr = fs.readFileSync(this.manifestPath, { encoding: 'utf-8' })
    } catch (err) {
      OutputChannel.getInstance().appendLine('获取manifest信息失败')
      throw new Error(`${TAG} 不存在${this.manifestPath}，请检查`)
    }

    configInfoStr = clearComment(configInfoStr)
    this.manifest = JSON.parse(configInfoStr)
    console.log(TAG, 'getUniappConfig success')
    return this.manifest
  }

  install (packageName) {
    return new Promise((resolve, reject) => {
      exec(`npm install ${packageName}`,
        {
          encoding: 'utf-8',
          cwd: this.rootPath
        },
        (error, stdout, stderr) => {
          OutputChannel.getInstance().appendLine(`npm install ${packageName}`)
          if (error) {
            OutputChannel.getInstance().appendLine(`${stdout}`)
            OutputChannel.getInstance().appendLine(`${stderr}`)
            reject({ stdout, stderr })
            return
          }
          OutputChannel.getInstance().appendLine(`${stdout}`)
          resolve({ stdout, stderr })
        })
    })
  }

  runScript (command) {
    return new Promise((resolve, reject) => {
      console.log(TAG, `waiting for publishH5 ${this.manifest.name}`)
      OutputChannel.getInstance().appendLine(command)
      // 需要增加自定义条件编译
      exec(command,
        {
          encoding: 'utf-8',
          cwd: this.rootPath
        },
        (error, stdout, stderr) => {
          if (error) {
            OutputChannel.getInstance().appendLine(`${stdout}`)
            OutputChannel.getInstance().appendLine(`${stderr}`)
            reject({ stdout, stderr })
            return
          }
          OutputChannel.getInstance().appendLine(`${stdout}`)
          resolve({ stdout, stderr })
        })
    })
  }

  // 删除工程中as打包资源
  clear () {
    try {
      this.uniapp.h5Path = this.uniapp.path + '/dist/build/h5'
      fs.rmdirSync(this.uniapp.h5Path, { recursive: true })
    } catch (error) {
      console.debug(TAG, '工程中不存在元服务打包资源')
    }
    console.debug(TAG, '已删除元服务打包资源')
  }
}

module.exports = Project
