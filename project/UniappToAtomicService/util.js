const fs = require('fs')
const path = require('path')

const TAG = '[UniappToAtomicService] '

const CONDITION_COMPILER_NAME = 'HOS'
const CONDITION_COMPILER_NAME_UPPER = CONDITION_COMPILER_NAME.toUpperCase()
const SUPPORT_COMPILER_FILE_TYPE = ['.vue', '.nvue', '.js', '.css', '.json', '.scss', '.less', '.stylus', '.ts', '.pug']

const regIncludeJs = /(\/\/)(\s)*(#ifdef)(\s)+/g
const regExcludeJs = /(\/\/)(\s)*(#ifndef)(\s)+/g
const regIncludeCss = /(\/\*)(\s)*(#ifdef)(\s)+/g
const regExcludeCss = /(\/\*)(\s)*(#ifndef)(\s)+/g
const regIncludeHtml = /(<!--)(\s)*(#ifdef)(\s)+/g
const regExcludeHtml = /(<!--)(\s)*(#ifndef)(\s)+/g
const END_FLAG_CSS = '*/'
const END_FLAG_HTML = '-->'
const INCLUDE_FLAG = '#ifdef'
const EXCLUDE_FLAG = '#ifndef'
const DISTS = ['dist', 'unpackage']

function copy (from, to, { exclude = [] } = {}, isRootPath = false) {
  const fromPath = path.resolve(from)
  const toPath = path.resolve(to)
  try {
    // 判断目标位置是否存在
    fs.accessSync(toPath)
  } catch (err) {
    fs.mkdirSync(toPath, { mode: 0o777, recursive: true })
  }
  try {
    const paths = fs.readdirSync(fromPath)
    paths.forEach(function (item) {
      if (exclude.includes(item) || (isRootPath && DISTS.includes(item))) {
        return
      }
      const newFromPath = fromPath + '/' + item
      const newToPath = path.resolve(toPath + '/' + item)

      const stat = fs.statSync(newFromPath)
      if (stat.isFile()) {
        copyFile(newFromPath, newToPath)
      } else if (stat.isDirectory()) {
        copy(newFromPath, newToPath, { exclude })
      }
    })
  } catch (err) {
    if (err) {
      console.log(TAG, err)
      return
    }
  }
}

function copyFile (from, to) {
  fs.copyFileSync(from, to)
}

function findCodeFile (dir, { exclude = [] } = {}) {
  const dirPath = path.resolve(dir)
  try {
    // 判断目标位置是否存在
    fs.accessSync(dirPath)
  } catch (err) {
    console.error(TAG, `[modifyCompileContidion] 目标路径不存在：${dirPath}`)
    return
  }

  const paths = fs.readdirSync(dirPath)
  paths.forEach(function (item) {
    if (exclude.includes(item)) {
      return
    }
    const newDirPath = dirPath + '/' + item

    const stat = fs.statSync(newDirPath)
    if (stat.isFile()) {
      const suffixIndex = newDirPath.lastIndexOf('.')
      const fileType = newDirPath.substr(suffixIndex)
      if (!SUPPORT_COMPILER_FILE_TYPE.includes(fileType.toLowerCase())) {
        return
      }
      const fileContent = fs.readFileSync(newDirPath, 'utf8')
      const { value, isModify } = matchCompileCondition(fileContent)
      if (isModify) {
        fs.writeFileSync(newDirPath, value, 'utf8')
      }
    } else if (stat.isDirectory()) {
      findCodeFile(newDirPath, { exclude })
    }
  })
}

function matchCompileCondition (str = '') {
  if (!str.includes(INCLUDE_FLAG) && !str.includes(EXCLUDE_FLAG)) {
    return { value: str, isModify: false }
  }
  // H5 ----> H5-disabled
  const lines = str.split('\n')
  for (let i = 0; i < lines.length; i++) {
    if (lines[i].match(regIncludeJs)) { // 匹配// #ifdef
      const startIndex = lines[i].indexOf(INCLUDE_FLAG) + INCLUDE_FLAG.length
      const prefix = lines[i].substr(0, startIndex)
      const platformStr = lines[i].substr(startIndex)
      lines[i] = disableH5(platformStr, prefix)
    } else if (lines[i].match(regExcludeJs)) { // 匹配// #ifndef
      const startIndex = lines[i].indexOf(EXCLUDE_FLAG) + EXCLUDE_FLAG.length
      const prefix = lines[i].substr(0, startIndex)
      const platformStr = lines[i].substr(startIndex)
      lines[i] = disableH5(platformStr, prefix)
    } else if (lines[i].match(regIncludeCss)) { // 匹配/* #ifdef
      const endIndex = lines[i].indexOf(END_FLAG_CSS)
      if (endIndex > 0) {
        const startIndex = lines[i].indexOf(INCLUDE_FLAG) + INCLUDE_FLAG.length
        const prefix = lines[i].substr(0, startIndex)
        const suffix = lines[i].substr(endIndex)
        const platformStr = lines[i].substring(startIndex, endIndex)
        lines[i] = disableH5(platformStr, prefix, suffix)
      }
    } else if (lines[i].match(regExcludeCss)) { // 匹配/* #ifndef
      const endIndex = lines[i].indexOf(END_FLAG_CSS)
      if (endIndex > 0) {
        const startIndex = lines[i].indexOf(EXCLUDE_FLAG) + EXCLUDE_FLAG.length
        const prefix = lines[i].substr(0, startIndex)
        const suffix = lines[i].substr(endIndex)
        const platformStr = lines[i].substring(startIndex, endIndex)
        lines[i] = disableH5(platformStr, prefix, suffix)
      }
    } else if (lines[i].match(regIncludeHtml)) { // 匹配<!-- #ifdef
      const endIndex = lines[i].indexOf(END_FLAG_HTML)
      if (endIndex > 0) {
        const startIndex = lines[i].indexOf(INCLUDE_FLAG) + INCLUDE_FLAG.length
        const prefix = lines[i].substr(0, startIndex)
        const suffix = lines[i].substr(endIndex)
        const platformStr = lines[i].substring(startIndex, endIndex)
        lines[i] = disableH5(platformStr, prefix, suffix)
      }
    } else if (lines[i].match(regExcludeHtml)) { // 匹配<!-- #ifndef
      const endIndex = lines[i].indexOf(END_FLAG_HTML)
      if (endIndex > 0) {
        const startIndex = lines[i].indexOf(EXCLUDE_FLAG) + EXCLUDE_FLAG.length
        const prefix = lines[i].substr(0, startIndex)
        const suffix = lines[i].substr(endIndex)
        const platformStr = lines[i].substring(startIndex, endIndex)
        lines[i] = disableH5(platformStr, prefix, suffix)
      }
    }
  }
  return { value: lines.join('\n'), isModify: true }
}

function disableH5 (line, prefix = '', suffix = '') {
  let condition = line.replace(/(\s)+/g, '')
  const platforms = condition.split('||')
  // 如果这个编译条件中包含HOS，则不处理这一条
  // 比如：// #ifdef MP-WEIXIN || H5 || HOS ||APP
  // 若处理了这条，会导致uniapp打包无法识别H5-disabled，代码就不会被打包
  if (platforms.includes(CONDITION_COMPILER_NAME_UPPER)) {
    return prefix + ' ' + line + ' ' + suffix
  }
  for (let j = 0; j < platforms.length; j++) {
    if (platforms[j].trim() === 'H5') {
      platforms[j] = 'H5-disabled'
    }
  }
  condition = platforms.join('||')
  return prefix + ' ' + condition + ' ' + suffix
}

function clearComment (manifest) {
  const startIndex = manifest.indexOf('/*')
  if (startIndex < 0) {
    return manifest
  }
  const endIndex = manifest.indexOf('*/')
  const target = manifest.substring(startIndex, endIndex + 2)
  manifest = manifest.replace(target, '')
  return clearComment(manifest)
}

module.exports = { copy, clearComment, findCodeFile }
