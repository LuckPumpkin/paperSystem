using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WebForms_SchoolAdmin_SSignMng : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void gvExCourse_RowCommand(object sender, GridViewCommandEventArgs e)
    {

        if (e.CommandName == "SignEdit")
        {
            int index = Convert.ToInt32(e.CommandArgument);
            txtCollege.Value = ((Label)gvExCourse.Rows[index].FindControl("lbcollege")).Text;
            //sdsCourseTeacher.SelectCommand = "SELECT course_teacherno FROM CourseTeacher WHERE (course_no LIKE '"+txtCourseNo.Value+"')"
            cbocollege.DataBind();
            popupEdit.ShowOnPageLoad = true;
        }
    }
    protected void mnuToolBar_ItemClick(object source, DevExpress.Web.ASPxMenu.MenuItemEventArgs e)
    {
        Teacher te = new Teacher();
        Signature si = new Signature();
        string ac = te.GetAccountBYName(cbocollege.SelectedValue);
        si.UpdateColBYCo(ac,txtCollege.Value);
        popupEdit.ShowOnPageLoad = false;
        gvExCourse.DataBind();
    }
}