import router from '@ohos.router'
import http from '@ohos.net.http';
import Prompt from '@system.prompt';

@Entry
@Component
struct Register{

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

  async Register(){
    if (this.username && this.password &&this.repeatPwd) {

      try {
        if (this.password != this.repeatPwd) {
          Prompt.showDialog({
            message: "两次输入的密码不一样",
          });
        }
        else if (this.repeatPwd = this.password){
          const res = await this.httpUtil.request(`http://localhost:8080/admin/save`,{
            method: http.RequestMethod.POST,
            extraData: { username: this.username,password: this.password },
          });
          let jsonResult = res.result.toString();
          let responseObject = JSON.parse(jsonResult);

          if ( responseObject['code'] === 0) {
            console.log("console");
            Prompt.showDialog({
              message: "注册成功，请回到登录页面",
            });
          }
        }

      } catch (error) {
        console.error(error);
        Prompt.showDialog({
          message: "注册失败，请联系管理员",
        });
      }
    }

  }


  build(){
    Column({space:20}){

      Row(){
        Text("用户注册")
        .fontSize(25)
        .fontWeight(700)
          .margin({top:200})
      }
      Row() {
        Text("请输入账号：")
        TextInput({placeholder: this.username===''?"请设置您的账号":this.username})
          .width("60%")
          .onChange(val=>{
            this.username=val
            console.log(val)
          })
      }
      Row() {
        Text("请输入密码：")
        TextInput({placeholder:this.password===''?"请设置您的密码":this.password})
          .width("60%")
          .onChange(val=>{
            this.password=val
            console.log(val)
          })
      }
      Row() {
        Text("确认密码：   ")
        TextInput({placeholder:this.repeatPwd===''?"请再次输入密码":this.repeatPwd})
          .width("60%")
          .onChange(val=>{
            this.repeatPwd=val
            console.log(val)
          })
      }
      Button("注册")
        .onClick(() => {
        this.Register()
      })
     Text("回到登录界面")
       .onClick(this.clickNext1.bind(this))

    }.height('100%')
      .width('100%')
  }
  clickNext1() {
    router.pushUrl({
      url: "pages/Login",
    }, router.RouterMode.Single)
  }
}