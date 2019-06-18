using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WebForms_PrintAdmin_OrderPrint : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        int PID = Convert.ToInt32(Request.QueryString["PID"].ToString());
        OrderReport rpt = new OrderReport(PID);
        rvOrderPrint.Report = rpt;
        rvOrderPrint.DataBind();
    }
}