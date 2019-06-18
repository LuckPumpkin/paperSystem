using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WebForms_Common_Error : System.Web.UI.Page
{
  protected void Page_Load(object sender, EventArgs e)
  {
    int ErrorMsgID = int.Parse(Request.QueryString["ErrorMsgID"]);

    switch (ErrorMsgID)
    {
      case 1:
        lblMessage.Text = "您检索的文件不存在！";
        break;
      case 2:
        lblMessage.Text = "参数错误！";
        break;
    }
  }
}
