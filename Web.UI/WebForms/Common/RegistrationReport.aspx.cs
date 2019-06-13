using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using SysData = System.Data;
using System.Configuration;
using DevExpress.XtraReports.UI;

public partial class WebForms_RegistrationReport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        int regID = Convert.ToInt32(Request.QueryString["regID"].ToString());
        RegistrationReport rpt = new RegistrationReport(regID);
        rvInnovativeResult.Report = rpt;
        rvInnovativeResult.DataBind();
    }
}