using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WebForms_CollegeAdmin_CSignMng : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            txtTeacherID.Value = Convert.ToString(Session["UserCode"]);
            User us = new User();
            txtCollege.Value = us.GetCollege(txtTeacherID.Value).ToString();
        }
    }
    protected void gvExCourse_RowCommand(object sender, GridViewCommandEventArgs e)
    {

        if (e.CommandName == "SignEdit")
        {
            int index = Convert.ToInt32(e.CommandArgument);
            txtPro.Value = ((Label)gvExCourse.Rows[index].FindControl("lbPro")).Text;
            //sdsCourseTeacher.SelectCommand = "SELECT course_teacherno FROM CourseTeacher WHERE (course_no LIKE '"+txtCourseNo.Value+"')"
            cboProfession.DataBind();
            popupEdit.ShowOnPageLoad = true;
        }
    }
    protected void mnuToolBar_ItemClick(object source, DevExpress.Web.ASPxMenu.MenuItemEventArgs e)
    {

        Teacher te = new Teacher();
        Signature si = new Signature();
        string pr = te.GetAccountBYName(cboProfession.SelectedValue);
        si.UpdateProsBYColl(pr,txtCollege.Value, txtPro.Value);
        popupEdit.ShowOnPageLoad = false;
        gvExCourse.DataBind();
    }
    protected void mnuToolBar_ItemClick1(object source, DevExpress.Web.ASPxMenu.MenuItemEventArgs e)
    {
        //CourseTeacher ct = new CourseTeacher();
        //for (int i = 0; i < gvExCourse.Rows.Count; i++)
        //{
        //    txtCourseNo.Value = ((Label)gvExCourse.Rows[i].FindControl("lblcourse_no")).Text;
        //    int n = ct.GetTeacherNum(txtCourseNo.Value);
        //    if (n == 1)
        //    {
        //        ct.UpdateCourseTeacherno(txtCourseNo.Value);
        //    }
        //    else
        //        continue;
        //}
        //gvExCourse.DataBind();
        //MsgBox.ShowMessage("指定成功");
    }
}