import hilog from '@ohos.hilog';

@Entry
@Component
struct Index {
  aboutToAppear() {
    hilog.info(0x0000, 'testTag', '%{public}s', 'TestAbility index aboutToAppear');
  }

   build() {

   }
 }