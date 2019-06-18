using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WebForms_SchoolAdmin_RegView : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void gvCourse_RowCommand(object sender, GridViewCommandEventArgs e)
    {

        if (e.CommandName == "PaperRegistration")
        {
            int index = Convert.ToInt32(e.CommandArgument);
            string RegistrationID = ((Label)gvCourse.Rows[index].FindControl("lblRegistrationId")).Text;
            popupRegistration.ContentUrl = "../Common/RegistrationReport.aspx?regID=" + RegistrationID;
            popupRegistration.ShowOnPageLoad = true;
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        gvCourse.DataBind();

    }
}