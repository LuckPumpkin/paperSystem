using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SysData = System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WebForms_DetailReport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        int detID = Convert.ToInt32(Request.QueryString["detID"].ToString());
      
       //Detail d = new Detail();
       // int detID = d.GetDetailID(regID);
        DetailReport rpt = new DetailReport(detID);
        rvDetail.Report = rpt;
        rvDetail.DataBind();
        
    }
}