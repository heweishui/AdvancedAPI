/**
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2022. All rights reserved.
 * Description: @ohos.deviceInfo
 * Author: wangtianpeng
 * Create: 03/14/2022
 * Notes: N/A
 */

import deviceInfo from '@ohos.deviceInfo'
export class DeivceBase {
  static getDeviceInfo () {
    const resultInfo = {
      brand: deviceInfo.brand,
      productModel: deviceInfo.productModel,
      osFullName: deviceInfo.osFullName,
      deviceType: deviceInfo.deviceType,
      udid: deviceInfo.udid,
      sdkApiVersion: deviceInfo.sdkApiVersion
    }
    return resultInfo
  }
}
