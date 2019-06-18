using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WebForms_Common_AnalysisReport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        int anaID = Convert.ToInt32(Request.QueryString["anaID"].ToString());
        DSAnalysisTableAdapters.AnalysisTableAdapter helper = new DSAnalysisTableAdapters.AnalysisTableAdapter();
        DSAnalysis.AnalysisDataTable table = new DSAnalysis.AnalysisDataTable();
        helper.FillByID(table, anaID);
        Analysis ana = new Analysis();
        if(table.Rows[0]["num_less60"].ToString()!="")
        {
            AnalysisReport rpt = new AnalysisReport(Convert.ToDouble(table.Rows[0]["num_less60"].ToString()), Convert.ToDouble(table.Rows[0]["num_60_70"].ToString()), Convert.ToDouble(table.Rows[0]["num_70_80"].ToString()), Convert.ToDouble(table.Rows[0]["num_80_90"].ToString()), Convert.ToDouble(table.Rows[0]["num_more90"].ToString()), anaID);
            rvAnalysis.Report = rpt;
            rvAnalysis.DataBind();
        }
        else
        {
            MsgBox.ShowErrorMessage("没有成绩！");
        }
        
    }
}