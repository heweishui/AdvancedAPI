@Entry
@Component
struct Account {
  build() {
    Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
      Column({ space: 5 }) {
        List({ space: 20, }) {
          // TC1
          ListItem() {
            Button("Login").width(300).onClick(() => {
              // @ts-ignore
              as.login({
                success: (res) => {
                  console.log('[AdvancedAPI] 登录成功 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'Login success' })
                },
                fail: (err) => {
                  console.log('[AdvancedAPI] 登录失败 ' + JSON.stringify(err));
                  AlertDialog.show({ message: 'Login failed' })
                },
                complete: (res) => {
                  console.log('[AdvancedAPI] 登录完成 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'Login complete' })
                },
              })
            })
          }
          // TC2
          ListItem() {
            Button("getUserInfo").width(300).onClick(() => {
              // @ts-ignore
              as.getUserInfo({
                success: (res) => {
                  console.log('[AdvancedAPI] getUserInfo成功 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'getUserInfo success' })
                },
                fail: (err) => {
                  console.log('[AdvancedAPI] getUserInfo失败 ' + JSON.stringify(err));
                  AlertDialog.show({ message: 'getUserInfo failed' })
                },
                complete: (res) => {
                  console.log('[AdvancedAPI] getUserInfo完成 ' + JSON.stringify(res));
                  AlertDialog.show({ message: 'getUserInfo complete' })
                },
              })
            })
          }
        }.alignListItem(ListItemAlign.Center)
      }
    }
  }
}