using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

public partial class _Default : System.Web.UI.Page
{
  #region Page_Load

  protected void Page_Load(object sender, EventArgs e)
  {
      if (!User.Identity.IsAuthenticated)
      {
          ScriptManager.RegisterStartupScript(this, this.GetType(), "ToLoginPage", "location.href='Login.aspx';", true);
          return;
      }
      else
      {
          DSUserTableAdapters.UserTableAdapter user = new DSUserTableAdapters.UserTableAdapter();
          lblName.Text = user.ScalarQuery(User.Identity.Name);
      }
  }

  #endregion

  #region btnLogout_Click

  protected void btnLogout_Click(object sender, EventArgs e)
  {
    FormsAuthentication.SignOut();
    Response.Write(string.Format("<script language='javascript'>parent.location.href='{0}';</script>", FormsAuthentication.LoginUrl));
  }

  #endregion

  protected void siteMapTree_TreeNodeDataBound(object sender, TreeNodeEventArgs e)
  {
    e.Node.Target = "fContent";
  }

}