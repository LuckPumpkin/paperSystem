using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WebForms_ProfessionAdmin_RegTeacherAssign : System.Web.UI.Page
{
    Course co = new Course();
    Paper pa = new Paper();
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
            //sdsCourseTeacher.SelectCommand = "SELECT course_teacherno FROM CourseTeacher WHERE (course_no LIKE '"+txtCourseNo.Value+"')"
            cboCourseTeacher.DataBind();
            popupEdit.ShowOnPageLoad = true;   
        }
        if (e.CommandName == "PaperAorB_Edit")
        {
            const string a = "A";
            const string b = "B";
            int index = Convert.ToInt32(e.CommandArgument);
            txtCourseNo.Value = ((Label)gvExCourse.Rows[index].FindControl("lblcourse_no")).Text;
            txtAorB.Value = ((Label)gvExCourse.Rows[index].FindControl("lbflag")).Text;
            int coid = co.GetIDByCourseNo(txtCourseNo.Value);
            if (txtAorB.Value == "A")
            {
                pa.UpdateFlagNull(coid,a);
                pa.UpdateFlag(coid,b);
                gvExCourse.DataBind();
            }
            else {
                pa.UpdateFlagNull(coid, b);
                pa.UpdateFlag(coid,a);
                gvExCourse.DataBind();
            }
            gvExCourse.DataBind();
        }
    }
    protected void mnuToolBar_ItemClick(object source, DevExpress.Web.ASPxMenu.MenuItemEventArgs e)
    {

        co.UpdateTeacherByCourseNo(cboCourseTeacher.SelectedValue, txtCourseNo.Value);
        popupEdit.ShowOnPageLoad = false;
        gvExCourse.DataBind();
    }
    protected void mnuToolBar_ItemClick1(object source, DevExpress.Web.ASPxMenu.MenuItemEventArgs e)
    {
        CourseTeacher ct = new CourseTeacher();
        for (int i = 0; i < gvExCourse.Rows.Count; i++)
        {
            txtCourseNo.Value = ((Label)gvExCourse.Rows[i].FindControl("lblcourse_no")).Text;
            int n = ct.GetTeacherNum(txtCourseNo.Value);
            if (n == 1)
            {
                ct.UpdateCourseTeacherno(txtCourseNo.Value);
            }
            else
                continue;
        }
        gvExCourse.DataBind();
        MsgBox.ShowMessage("指定成功");
    }

}