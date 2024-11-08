export interface onInterceptRequestEvent {
  request: {
    getRequestHeader:Function,
    getRequestUrl:Function,
    isRequestGesture:Function,
    isMainFrame:Function,
    isRedirect:Function,
    getRequestMethod:Function
  }
}

export interface onConsoleEvent {
  message: {
    getMessage:Function,
    getSourceId:Function,
    getLineNumber:Function,
    getMessageLevel:Function
  }
}

export interface onShowFileSelectorEvent {
  result: {
    handleFileList:Function
  };
  fileSelector: {
    getTitle:Function,
    getMode:Function,
    getAcceptType:Function,
    isCapture:Function
  };
}
