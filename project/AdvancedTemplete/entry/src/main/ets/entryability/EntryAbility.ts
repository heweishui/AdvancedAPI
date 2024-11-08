import UIAbility from '@ohos.app.ability.UIAbility';
import hilog from '@ohos.hilog';
import window from '@ohos.window';
import { AdvancedAPI } from 'advancedApi';


let url:string = "index.html";
let server:string = "https://as-server/";
let storage = new LocalStorage({url, server});
export default class EntryAbility extends UIAbility {
    onCreate(want, launchParam) {
        hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
        AdvancedAPI.init(this.context);
        if (want.parameters.params !== undefined) {
            let params = JSON.parse(want.parameters.params);
            console.info("[ADSAPI] onCreate router message:" + params.url);
            if(params.url){
                url = params.url;
                storage.setOrCreate('url',url);
            }
        }
    }

    onDestroy() {
        hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
    }

    onNewWant(want, launchParam) {
        console.info("[ADSAPI]onNewWant want:" + JSON.stringify(want));
        if (want.parameters.params !== undefined) {
            let params = JSON.parse(want.parameters.params);
            console.info("[ADSAPI]onNewWant router message:" + params.url);
            if(params.url){
                url = params.url;
                storage.setOrCreate('url',url);
            }
        }
    }

    onWindowStageCreate(windowStage: window.WindowStage) {
        // Main window is created, set main page for this ability
        hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

        let windowClass = null;
        windowStage.getMainWindow((err, data) => {
            if (err.code) {
                console.error('Failed to obtain the main window. Cause: ' + JSON.stringify(err));
                return;
            }
            windowClass = data;
            console.info('Succeeded in obtaining the main window. Data: ' + JSON.stringify(data));
            let isLayoutFullScreen = true;
            /*windowClass.setWindowLayoutFullScreen(isLayoutFullScreen, (err) => {
                if (err.code) {
                    console.error('Failed to set the window layout to full-screen mode. Cause:' + JSON.stringify(err));
                    return;
                }
                console.info('Succeeded in setting the window layout to full-screen mode.');
            });*/
            let sysBarProps = {
                statusBarColor: '#ffffff',
                // 以下两个属性从API Version 8开始支持
                statusBarContentColor: '#000000'
            };
            windowClass.setWindowSystemBarProperties(sysBarProps, (err) => {
                if (err.code) {
                    console.error('Failed to set the system bar properties. Cause: ' + JSON.stringify(err));
                    return;
                }
                console.info('Succeeded in setting the system bar properties.');
            });
        })
        windowStage.loadContent('pages/Index',storage, (err, data) => {
            if (err.code) {
                hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
                return;
            }
            hilog.info(0x0000, 'testTag', 'Succeeded in loading the content. Data: %{public}s', JSON.stringify(data) ?? '');
        });
    }

    onWindowStageDestroy() {
        // Main window is destroyed, release UI related resources
        hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
    }

    onForeground() {
        // Ability has brought to foreground
        hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
    }

    onBackground() {
        // Ability has back to background
        hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
    }
}
