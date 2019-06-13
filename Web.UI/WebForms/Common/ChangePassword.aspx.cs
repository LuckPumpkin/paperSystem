using System;
using System.Collections;
using System.Configuration;
using System.Data;

using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;


public partial class WebForms_Common_ChangePassword : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void ChangePasswordPushButton_Click(object sender, EventArgs e)
    {
        string OldePsw = CurrentPassword.Text;
        string NewPsw = NewPassword.Text;
        string UserCode = Session["UserCode"].ToString();
        User userService = new User();
        if (!userService.ChangePasword(UserCode, OldePsw, NewPsw))
        {
           FailureText.Text = "密码错误，请重试。 ";           
            return;
        }
        else
        {
            MessageBox.ShowOnPageLoad = true;
        }
        



    }
   
}
