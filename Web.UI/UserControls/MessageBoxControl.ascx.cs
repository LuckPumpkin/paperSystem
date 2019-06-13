using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UserControls_MessageBoxControl : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public void ShowErrorMessage(string msg)
    {
      imgMessageBoxIcon.ImageUrl = "~/images/exclamation_icon.png";
      lblMessageBoxMsg.ForeColor = System.Drawing.Color.Red;
      lblMessageBoxMsg.Text = msg;
      MessageBoxPopupControl.ShowOnPageLoad = true;
    }

    public void ShowMessage(string msg)
    {
      imgMessageBoxIcon.ImageUrl = "~/images/Information_icon.png";
      lblMessageBoxMsg.ForeColor = System.Drawing.Color.Black;
      lblMessageBoxMsg.Text = msg;
      MessageBoxPopupControl.ShowOnPageLoad = true;
    }

}