using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WebForms_SchoolAdmin_DetailView : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void gvCourse_RowCommand(object sender, GridViewCommandEventArgs e)
    {

        if (e.CommandName == "PaperDetail")
        {
            int index = Convert.ToInt32(e.CommandArgument);
            string DetailID = ((Label)gvCourse.Rows[index].FindControl("lblDetailID")).Text;
            popupDetail.ContentUrl = "../Common/DetailReport.aspx?detID=" + DetailID;
            popupDetail.ShowOnPageLoad = true;
        }

        if (e.CommandName == "PaperDet")
        {
            int index = Convert.ToInt32(e.CommandArgument);
            string DetailID = ((Label)gvCourse.Rows[index].FindControl("lblDetailID")).Text;
            popupDetail.ContentUrl = "../Common/QuestiontypeReport.aspx?detID=" + DetailID;
            popupDetail.ShowOnPageLoad = true;
        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        gvCourse.DataBind();

    }
}