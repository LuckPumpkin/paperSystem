using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WebForms_Teacher_AnalysisEdit : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string anaID = Request.QueryString["anaID"].ToString();
    }
}