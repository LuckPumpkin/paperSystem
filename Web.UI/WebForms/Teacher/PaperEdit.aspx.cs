using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WebForms_Teacher_PaperEdit : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string paperID = Request.QueryString["paperID"].ToString();
    }
}