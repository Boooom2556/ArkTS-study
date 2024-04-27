import router from '@ohos.router'

@Component
struct Index {
  @State message: string = '欢迎来到公司管理系统'

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(30)
          .fontWeight(FontWeight.Bold)

        Text("退出登录")
          .fontColor('blue')
          .fontSize(15)
          .margin({bottom:20})
         .onClick(this.clickNext.bind(this))
      }
      .width('100%')
    }
    .height('100%')
  }
  clickNext() {
    router.pushUrl({
      url: "pages/Login",
    }, router.RouterMode.Single)
  }
}