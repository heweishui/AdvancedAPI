const hx = require('hbuilderx')

const TAG = 'UniappToAtomicService'

class OutputChannel {
  constructor (name) {
    this.channel = hx.window.createOutputChannel(name)
    this.channel.show()
  }

  static getInstance () {
    if (!OutputChannel._instance) {
      OutputChannel._instance = new OutputChannel(TAG)
    }
    return OutputChannel._instance
  }

  appendLine (lines) {
    this.channel.appendLine(lines)
  }
}

module.exports = OutputChannel
