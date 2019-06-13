using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WebForms_ProfessionAdmin_AnaTeacherAssign : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            txtTeacherID.Value = Convert.ToString(Session["UserCode"]);
            Teacher tea = new Teacher();
            txtPro.Value = tea.GetProByUserCode(txtTeacherID.Value);
        }
    }
    protected void gvExCourse_RowCommand(object sender, GridViewCommandEventArgs e)
    {

        if (e.CommandName == "TeacherEdit")
        {
            int index = Convert.ToInt32(e.CommandArgument);
            txtCourseNo.Value = ((Label)gvExCourse.Rows[index].FindControl("lblcourse_no")).Text;
            txtCourseSerial.Value = ((Label)gvExCourse.Rows[index].FindControl("lblcourse_serialno")).Text;
            cboCourseTeacher.DataBind();
            popupEdit.ShowOnPageLoad = true;
        }
    }
     protected void mnuToolBar_ItemClick(object source, DevExpress.Web.ASPxMenu.MenuItemEventArgs e)
    {
        Teacher t=new Teacher();
        string teachername= t.GetTeacherNameByAccount(cboCourseTeacher.SelectedValue);
        Course co = new Course();
        co.UpdateTeacherNoByExamCourse(cboCourseTeacher.SelectedValue, teachername, txtCourseNo.Value, txtCourseSerial.Value);
        popupEdit.ShowOnPageLoad = false;
        gvExCourse.DataBind();
    }
     protected void mnuToolBar_ItemClick1(object source, DevExpress.Web.ASPxMenu.MenuItemEventArgs e)
     {
         CourseTeacher ct = new CourseTeacher();
         for (int i = 0; i < gvExCourse.Rows.Count; i++)
         {
             txtCourseNo.Value = ((Label)gvExCourse.Rows[i].FindControl("lblcourse_no")).Text;
             txtCourseSerial.Value = ((Label)gvExCourse.Rows[i].FindControl("lblcourse_serialno")).Text;
             int n = ct.GetTeacherNumber(txtCourseNo.Value, txtCourseSerial.Value);
             if (n == 1)
             {
                 ct.UpdateExamTeachernoAndName(txtCourseNo.Value, txtCourseSerial.Value);
             }
             else
                 continue;
         }
         gvExCourse.DataBind();
         MsgBox.ShowMessage("指定成功");
     }
    
}