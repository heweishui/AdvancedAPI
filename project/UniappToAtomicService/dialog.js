const hx = require('hbuilderx')
const Project = require('./Project')

/**
 * @description 显示webview
 */
function showDialog (options, uniappProjectNames, selectedProjectInfo) {
  return new Promise(async (resolve, reject) => {
    const dialogInfo = getDialogBaseInfo()
    const { wsFolders } = options

    if (wsFolders.length === 1) { // 当左边项目管理器只有一个项目时，默认选中
      const wsFolder = wsFolders[0]
      selectedProjectInfo = {
        rootPath: wsFolder.uri.fsPath,
        projectName: wsFolder.name
      }
    } else {
      const uniappProjectInfo = await chooseUniappProject(dialogInfo, uniappProjectNames, selectedProjectInfo)
      const { uniappProjectName } = uniappProjectInfo
      const projectNameIndex = uniappProjectNames.indexOf(uniappProjectName)
      if (projectNameIndex < 0) {
        reject()
        return
      }
      const selectedWsFolder = wsFolders[projectNameIndex]
      selectedProjectInfo = {
        rootPath: selectedWsFolder.uri.fsPath,
        projectName: uniappProjectName
      }
    }

    const project = new Project({ rootPath: selectedProjectInfo.rootPath, name: selectedProjectInfo.projectName })
    let harmonyOptions = await project.getHarmonyConfig()
    if (!harmonyOptions) {
      harmonyOptions = await inputHarmonyInfo(dialogInfo, options)
    }
    harmonyOptions.rootPath = selectedProjectInfo.rootPath
    harmonyOptions.uniappName = selectedProjectInfo.projectName
    resolve(harmonyOptions)
  })
}

function chooseUniappProject (dialogInfo, uniappProjectNames, selectedProjectInfo) {
  return hx.window.showFormDialog({
    title: dialogInfo.title,
    subtitle: dialogInfo.subtitle,
    formItems: [{
      type: 'comboBox',
      name: 'uniappProjectName',
      items: uniappProjectNames,
      text: selectedProjectInfo.projectName || '',
      editable: true,
      placeholder: '请选择要发行的uniapp工程'
    }],
    width: 520,
    height: 220,
    submitButtonText: '确认',
    cancelButtonText: '取消',
    validate: function (formData) {
      const selectedProjectNameIndex = uniappProjectNames.indexOf(formData.uniappProjectName)
      if (selectedProjectNameIndex < 0) {
        this.showError('请在下拉框中选择要发行的uniapp工程')
        return false
      }
      return true
    }
  })
}

function inputHarmonyInfo (dialogOptions, options) {
  return hx.window.showFormDialog({
    formItems: [{
      type: 'input',
      name: 'projectName',
      label: '<span style="color:red">*</span> 应用名称',
      placeholder: '桌面图标、弹窗等处显示的应用名称',
      value: options.label || ''
    }, {
      type: 'input',
      name: 'bundleName',
      label: '<span style="color:red">*</span> 应用包名',
      placeholder: '推荐采用com.company.module的格式',
      value: options.bundleName || ''
    }, {
      type: 'fileSelectInput',
      name: 'projectIcon',
      label: '  应用图标',
      placeholder: '应用图标(png格式)',
      value: options.icon || '',
      mode: 'file'
    }, {
      type: 'fileSelectInput',
      name: 'projectCard',
      label: '  应用卡片',
      placeholder: '桌面显示的卡片(png格式)',
      value: options.cardImage || '',
      mode: 'file'
    }],
    title: dialogOptions.title,
    subtitle: dialogOptions.subtitle,
    width: 520,
    height: 420,
    submitButtonText: '确定',
    cancelButtonText: '取消',
    validate: function (formData) {
      if (!formData.projectName) {
        this.showError('应用名称不能为空，请填写')
        return false
      }
      if (!formData.bundleName) {
        this.showError('应用包名不能为空，请填写')
        return false
      }
      if (formData.bundleName.length < 7 || formData.bundleName.length > 128) {
        this.showError('应用包名长度范围7~128，请修改')
        return false
      }
      const bundleNameReg = /^[a-zA-Z][0-9a-zA-Z_.]+$/
      if (!bundleNameReg.test(formData.bundleName)) {
        this.showError('应用包名格式不正确，请修改')
        return false
      }
      if (formData.projectIcon) {
        const iconSuffixs = ['.png']
        const pointIndex = formData.projectIcon.lastIndexOf('.')
        const selectedIconSuffix = formData.projectIcon.substr(pointIndex)
        if (!iconSuffixs.includes(selectedIconSuffix)) {
          this.showError('应用图标格式只支持png，请修改')
          return false
        }
      }
      if (formData.projectCard) {
        const iconSuffixs = ['.png']
        const pointIndex = formData.projectCard.lastIndexOf('.')
        const selectedIconSuffix = formData.projectCard.substr(pointIndex)
        if (!iconSuffixs.includes(selectedIconSuffix)) {
          this.showError('应用卡片格式只支持png，请修改')
          return false
        }
      }
      return true
    }
  })
}

function getDialogBaseInfo () {
  return {
    title: '华为元服务发行',
    subtitle: `<a href="https://developer.harmonyos.com/cn/develop/deveco-studio#download_beta_openharmony">鸿蒙编译器DevEco</a><br/>
    <a href="https://docs.openharmony.cn/pages/v4.0/zh-cn/application-dev/application-dev-guide.md/">鸿蒙文档</a>`
  }
}

module.exports = {
  showDialog
}
