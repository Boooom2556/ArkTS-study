import router from '@ohos.router'
import http from '@ohos.net.http'
import Prompt from '@system.prompt'

class RouterInfo{
  url:string
  title:string

  constructor(url:string,title:string) {
    this.url = url
    this.title =title
  }
}


@Entry
@Component
struct Login{
  //定义用户名
  @State username:string ="";
  //定义密码
  @State password:string ="";
  //定义重复用户名密码
  @State repeatPwd:string ="";
  //提示语
  @State message:string ="";
  httpUtil:http.HttpRequest
  aboutToAppear() {
    let httpRequest = http.createHttp()
    this.httpUtil = httpRequest
  }


  async jwt(jwt: string) {
    try {
      const res = await this.httpUtil.request(`http://localhost:8080/admin/list`, {
        method: http.RequestMethod.GET,
        extraData: { no: jwt },
      });
      let data = JSON.parse(res.result.toString());
      return data;
    } catch (error) {
      throw error;
    }
  }

  async login(){
  if (this.username && this.password) {

      try {
        const res = await this.httpUtil.request(`http://localhost:8080/admin/login`,{
        method: http.RequestMethod.POST,
        extraData: { no: this.username,pwd: this.password },
         });
        let jsonResult = res.result.toString();
        let responseObject = JSON.parse(jsonResult);
        if (responseObject['code'] === 0) {
          console.log("console");
          router.pushUrl({
            url: "pages/Index",
          }, router.RouterMode.Single)

        }
      } catch (error) {
        console.error(error);
        Prompt.showDialog({
          message: "登录失败",
        });
      }
    } else {
      if (!this.username || !this.password) {
        Prompt.showDialog({
          message: "请输入正确的用户名和密码",
        });
      }
    }

  }



 build(){
    Column({space:20}){
      Row(){
        Text("欢迎来到公司管理系统")
          .fontSize(30)
          .fontWeight(700)
          .margin({top:100})
      }
      Row(){
        Text("登录")
          .fontSize(25)
      }
      Row() {
        Text("账号：")
        TextInput({ placeholder: this.username===''? "请输入您的用户名":this.username })
          .width("60%")
          .onChange(val=>{
            this.username=val
            console.log(val)
          })

      }
      Row() {
        Text("密码：")
        TextInput({ placeholder: this.password===''?"请输入您的密码":this.password })
          .width("60%")
          .onChange(val=>{
            this.password=val
            console.log(val)
          })

      }
      Button("登录")
        .onClick(() => {
          this.login()
        })
      Text("没有账户？去注册")
        .onClick(this.clickNext.bind(this))
    }
   .height('100%')
   .width('100%')
 }
  clickNext() {
    router.pushUrl({
      url: "pages/Register",
    }, router.RouterMode.Single)
  }

}