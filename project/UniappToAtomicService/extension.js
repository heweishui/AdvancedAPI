const hx = require('hbuilderx')
const Compiler = require('./Compiler.js')
const { showDialog } = require('./dialog.js')
const OutputChannel = require('./OutputChannel.js')

const TAG = 'UniappToAtomicService'

// 该方法将在插件激活的时候调用
function activate (context) {
  const createProject = hx.commands.registerCommand('extension.createHarmony', async () => {
    try {
      OutputChannel.getInstance().appendLine('运行环境校验中...')
      await Compiler.checkEnvironment()
      OutputChannel.getInstance().appendLine('运行环境校验成功！')
    } catch (error) {
      return
    }
    const wsFolders = await hx.workspace.getWorkspaceFolders()
    if (!wsFolders.length) {
      OutputChannel.getInstance().appendLine('项目管理器中没有可用工程')
      return
    }
    const options = { platform: 'h5' }
    options.wsFolders = wsFolders
    let selectedProjectInfo = {}
    try {
      const activeEditor = hx.window.getActiveTextEditor()
      activeEditor.then(function(editor) {
        const rootPath = editor.document.workspaceFolder.uri.fsPath
        if (!rootPath) {
          return
        }

        selectedProjectInfo = {
          rootPath,
          projectName: editor.document.workspaceFolder.name
        }
      })
    } catch (error) {
      OutputChannel.getInstance().appendLine('当前没有焦点文件')
    }
    // 若当前没有焦点文件，activeEditor对象不触发resolve，且也不触发reject
    setTimeout(() => {
      getHarmonyInfo(options, selectedProjectInfo)
    }, 100)
  })
  // 订阅销毁钩子，插件禁用的时候，自动注销该command。
  context.subscriptions.push(createProject)
}

// 该方法将在插件禁用的时候调用（目前是在插件卸载的时候触发）
function deactivate () { }

function getHarmonyInfo (options, selectedProjectInfo) {
  let compiler
  const uniappProjectNames = options.wsFolders.map(workFolder => workFolder.name)
  OutputChannel.getInstance().appendLine('等待选择uniapp工程...')
  showDialog(options, uniappProjectNames, selectedProjectInfo).then(async inputOpt => {
    OutputChannel.getInstance().appendLine(`编译选项: ${JSON.stringify(inputOpt)}`)
    compiler = new Compiler({
      rootPath: inputOpt.rootPath,
      uniappName: inputOpt.uniappName,
      platform: options.platform,
      bundleName: inputOpt.bundleName,
      projectIcon: inputOpt.projectIcon || inputOpt.icon,
      projectCard: inputOpt.projectCard || inputOpt.cardImage,
      projectName: inputOpt.projectName || inputOpt.label,
      appRoot: hx.env.appRoot
    })
    try {
      await compiler.copyUniappProjectForHarmony(compiler.uniapp)
      compiler.disposeFile(compiler.copyUniapp)
      await compiler.publishH5(compiler.copyUniapp)
      await compiler.createHarmonyPorject()
      await compiler.copyH5PackagetoRawfile()
      compiler.updateAppConfig()
      compiler.openDir()
      compiler.uniapp.setHarmonyConfig(compiler.harmony)
    } catch (e) {
      console.error(TAG, e)
      const msg = e && e.stdout || e
      compiler.createErrFile(msg)
      OutputChannel.getInstance().appendLine(msg)
    }
    compiler.clear(compiler.copyUniapp)
  }, () => {
    OutputChannel.getInstance().appendLine('弹窗已关闭')
    if (compiler) {
      compiler.clear(this.copyUniapp)
    }
  })
}

module.exports = {
  activate,
  deactivate
}
