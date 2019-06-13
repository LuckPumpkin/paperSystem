using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WebForms_Teacher_AllView : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            txtTeacherId.Value = Convert.ToString(Session["UserCode"]);
            User us = new User();
            txtAccount.Value = us.GetAccount(txtTeacherId.Value);
        }
    }
    protected void gvReg_RowCommand(object sender, GridViewCommandEventArgs e)
    {

        if (e.CommandName == "Registration")
        {
            int index = Convert.ToInt32(e.CommandArgument);
            string RegID = ((Label)gvReg.Rows[index].FindControl("lblRegID")).Text;
            popupRegistration.ContentUrl = "../Common/RegistrationReport.aspx?regID=" + RegID;
            popupRegistration.ShowOnPageLoad = true;
        }
    }
    
         protected void gvAnalysis_RowCommand(object sender, GridViewCommandEventArgs e)
    {

        if (e.CommandName == "Analysis")
        {
            int index = Convert.ToInt32(e.CommandArgument);
            string anaID = ((Label)gvAnalysis.Rows[index].FindControl("lblAnaID")).Text;
            popupRegistration.ContentUrl = "../Common/AnalysisReport.aspx?anaID=" + anaID;
            popupRegistration.ShowOnPageLoad = true;
        }
    }
         //protected void gvDetail_RowCommand(object sender, GridViewCommandEventArgs e)
         //{

         //    if (e.CommandName == "Detail_QuestionType")
         //    {
         //        int index = Convert.ToInt32(e.CommandArgument);
         //        string detID = ((Label)gvDetail.Rows[index].FindControl("lblDetID")).Text;
         //        popupRegistration.ContentUrl = "../Common/QuestiontypeReport.aspx?detID=" + detID;
         //        popupRegistration.ShowOnPageLoad = true;
         //    }
         //    if (e.CommandName == "Detail_Module")
         //    {
         //        int index = Convert.ToInt32(e.CommandArgument);
         //        string detID = ((Label)gvDetail.Rows[index].FindControl("lblDetID")).Text;
         //        popupRegistration.ContentUrl = "../Common/DetailReport.aspx?detID=" + detID;
         //        popupRegistration.ShowOnPageLoad = true;
         //    }
         //}
}