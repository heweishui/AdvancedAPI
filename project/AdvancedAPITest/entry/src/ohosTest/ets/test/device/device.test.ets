import hilog from '@ohos.hilog';
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect } from '@ohos/hypium'

export default function deviceTest() {
  describe('deviceTest', function () {
    // Defines a test suite. Two parameters are supported: test suite name and test suite function.
    beforeAll(function () {
      // Presets an action, which is performed only once before all test cases of the test suite start.
      // This API supports only one parameter: preset action function.
    })
    beforeEach(function () {
      // Presets an action, which is performed before each unit test case starts.
      // The number of execution times is the same as the number of test cases defined by **it**.
      // This API supports only one parameter: preset action function.
    })
    afterEach(function () {
      // Presets a clear action, which is performed after each unit test case ends.
      // The number of execution times is the same as the number of test cases defined by **it**.
      // This API supports only one parameter: clear action function.
    })
    afterAll(function () {
      // Presets a clear action, which is performed after all test cases of the test suite end.
      // This API supports only one parameter: clear action function.
    })
    it('uni.getSystemInfo',0, function (done) {
      // Defines a test case. This API supports three parameters: test case name, filter parameter, and test case function.
      hilog.info(0x0000, 'testTag', '%{public}s', 'it begin');
      // @ts-ignore
      as.getSystemInfo({
        success: (res) => {
          const platform = res.platform;
          expect(platform).assertEqual('OpenHarmony');
        }
      })
      done()
    })
    it('uni.getSystemInfoSync',0, function () {
      hilog.info(0x0000, 'testTag', '%{public}s', 'it begin');
      // @ts-ignore
      const res = as.getSystemInfoSync()
      expect(res.platform).assertEqual('OpenHarmony')
    })
  })
}