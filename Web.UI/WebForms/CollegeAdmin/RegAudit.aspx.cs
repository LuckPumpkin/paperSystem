using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WebForms_CollegeAdmin_RegAudit : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
           txtTeacherID.Value = Convert.ToString(Session["UserCode"]);
           User us = new User();
           txtAccount.Value = us.GetAccount(txtTeacherID.Value).ToString();
           txtCollege.Value = us.GetCollege(txtTeacherID.Value).ToString(); 
        } 
    }
    protected void gvCourse_RowCommand(object sender, GridViewCommandEventArgs e)
    {

        if (e.CommandName == "PDF")
        {
            int index = Convert.ToInt32(e.CommandArgument);
            string regID = ((Label)gvCourse.Rows[index].FindControl("lblregID")).Text;
            popupPDF.ContentUrl = "../Common/RegistrationReport.aspx?regID=" + regID;
            popupPDF.ShowOnPageLoad = true;
        }
    }
}