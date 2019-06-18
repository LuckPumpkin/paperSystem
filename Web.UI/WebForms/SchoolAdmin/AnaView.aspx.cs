using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WebForms_SchoolAdmin_AnaView : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void gvCourse_RowCommand(object sender, GridViewCommandEventArgs e)
    {

        if (e.CommandName == "PaperAnalysis")
        {
            int index = Convert.ToInt32(e.CommandArgument);
            string AnalysisID = ((Label)gvCourse.Rows[index].FindControl("lblanalysisId")).Text;
            popupAnalysis.ContentUrl = "../Common/AnalysisReport.aspx?anaID=" + AnalysisID;
            popupAnalysis.ShowOnPageLoad = true;
        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        gvCourse.DataBind();

    }
}