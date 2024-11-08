// @ts-nocheck
import prompt from '@ohos.prompt'

@Entry
@Component
struct Authentication {
  aboutToAppear() {
  }

  build() {
    Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
      Column({ space: 5 }) {
        List({ space: 20 }) {
          ListItem() {
            Text("生物认证").fontSize(35)
          }

          ListItem() {
            Button("as.startSoterAuthentication").width(300).onClick(() => {
              as.startSoterAuthentication({
                requestAuthModes: ['facial'],
                challenge: '123456',
                authContent: '请用FaceID解锁',
                success:function (res) {
                  console.log(`[AdvancedAPI] auth.start success res = ${JSON.stringify(res)}`)
                },
                fail:function (err) {
                  prompt.showToast({
                    message:`fail! ${err.errMsg}`
                  })
                  console.log(`[AdvancedAPI] auth.start fail err = ${JSON.stringify(err)}`);
                },
                complete:function (res) {
                  console.log(`[AdvancedAPI] auth.start complete res = ${JSON.stringify(res)}`);
                }
              })
            })
          }

          ListItem() {
            Button("as.checkIsSupportSoterAuthentication").width(300).onClick(() => {
              as.checkIsSupportSoterAuthentication({
                success:function (res) {
                  prompt.showToast({
                    message:`success! ${JSON.stringify(res)}`
                  })
                  console.log(`[AdvancedAPI] checkIsSupportSoterAuthentication success res = ${JSON.stringify(res)}`);
                },
                fail:function (err) {
                  console.log(`[AdvancedAPI] checkIsSupportSoterAuthentication fail err = ${JSON.stringify(err)}`);
                },
                complete:function (res) {
                  console.log(`[AdvancedAPI] checkIsSupportSoterAuthentication complete res = ${JSON.stringify(res)}`);
                }
              });
            })
          }

          ListItem() {
            Button("as.checkIsSoterEnrolledInDevice").width(300).onClick(() => {
              as.checkIsSoterEnrolledInDevice({
                checkAuthMode: 'facial',
                success:function (res) {
                  prompt.showToast({
                    message:`success! ${JSON.stringify(res)}`
                  })
                  console.log(`[AdvancedAPI] checkIsSoterEnrolledInDevice success res = ${JSON.stringify(res)}`);
                },
                fail:function (err) {
                  prompt.showToast({
                    message:`fail! ${err.errMsg}`
                  })
                  console.log(`[AdvancedAPI] checkIsSoterEnrolledInDevice fail err = ${JSON.stringify(err)}`);
                },
                complete:function (res) {
                  console.log(`[AdvancedAPI] checkIsSoterEnrolledInDevice complete res = ${JSON.stringify(res)}`);
                }
              })
            })
          }
        }.listDirection(Axis.Vertical) // 排列方向
        .divider({ strokeWidth: 2, color: 0xFFFFFF, startMargin: 20, endMargin: 20 }) // 每行之间的分界线
        .alignListItem(ListItemAlign.Center)
      }
    }
  }
}