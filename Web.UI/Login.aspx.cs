using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Infrastructure.Authentication;
using System.Web.Security;
using DevExpress.Web.ASPxEditors;

public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void MyLoginButton_Click(object sender, EventArgs e)
    {
        //-- 判断是否登录成功
        string UserCode = "";
        string username = ((ASPxTextBox)Login1.FindControl("UserName")).Text;
        string password = ((ASPxTextBox)Login1.FindControl("Password")).Text;
        bool rememberMe = ((CheckBox)Login1.FindControl("RememberMe")).Checked;

        User userService = new User();
        if (!userService.AuthenticateUser(username, password, out UserCode))
        {
            ((Literal)Login1.FindControl("FailureText")).Text = "用户名或密码错误，请重试。 ";
            return;
        }
        Session["UserCode"] = UserCode;
        FormsAuthentication.RedirectFromLoginPage(UserCode.ToString(), rememberMe);

    }
}