using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SysData = System.Data;

public partial class WebForms_SchoolAdmin_CourseClassEdit : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void gvExCourse_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "EditClass")
        {
            int index = Convert.ToInt32(e.CommandArgument);
            txtCourse_no.Value = ((Label)gvExCourse.Rows[index].FindControl("lblcourse_no")).Text;
            txtCourse_seriesno.Value = ((Label)gvExCourse.Rows[index].FindControl("lbcourse_seriesno")).Text;
            txtCourse_class.Value = ((Label)gvExCourse.Rows[index].FindControl("lbcourse_class")).Text;
            txtClass0.Text = "";
            popupEdit.ShowOnPageLoad = true;
            gvExCourse.DataBind();
        }
        if (e.CommandName == "DeleteClass")
        {
            int index = Convert.ToInt32(e.CommandArgument);
            txtCourse_no.Value = ((Label)gvExCourse.Rows[index].FindControl("lblcourse_no")).Text;
            txtCourse_seriesno.Value = ((Label)gvExCourse.Rows[index].FindControl("lbcourse_seriesno")).Text;
            txtCourse_class.Value = ((Label)gvExCourse.Rows[index].FindControl("lbcourse_class")).Text;
            CourseTeacher ct = new CourseTeacher();
            ct.DeleteCourseSeriesClass(txtCourse_no.Value, txtCourse_seriesno.Value, txtCourse_class.Value);
            SysData.DataTable couse_class = ct.GetExamByCoursenoClass(txtCourse_no.Value, txtCourse_class.Value);
            if (couse_class.Rows.Count == 0)
            {
                ct.DeleteCourseTeacher(txtCourse_no.Value, txtCourse_class.Value);
            }
           gvExCourse.DataBind();
        }
    }


    //增加
    protected void mnuAdd_ItemClick(object source, DevExpress.Web.ASPxMenu.MenuItemEventArgs e)
    {
        CourseTeacher ct = new CourseTeacher();
        string course_no = Request.QueryString["course_no"];
        string course_seriesno = Request.QueryString["course_seriesno"];
        string course_class = txtClass.Text.Trim();
        if (ct.GetExamByCoursenoSeriesnoClass(course_no, course_seriesno, course_class).Rows.Count == 0)
        {
            ct.AddCourseSeriesClass(course_no, course_seriesno, course_class);
           if (ct.GetCourseByCoursenoClass(course_no, course_class).Rows.Count == 0)
            {
                ct.AddCourseClass(course_no, course_class);
            }
            gvExCourse.DataBind();
            popupAdd.ShowOnPageLoad = false;
        }
        else
        {
            popupAdd.ShowOnPageLoad = false;
            MsgBox.ShowErrorMessage("该班级已存在！");
        }

    }
    //替换
    protected void mnuEdit_ItemClick(object source, DevExpress.Web.ASPxMenu.MenuItemEventArgs e)
    {
        CourseTeacher ct = new CourseTeacher();
        string course_no = Request.QueryString["course_no"];
        string course_seriesno = Request.QueryString["course_seriesno"];
        string course_class = txtClass0.Text.Trim();
        if (ct.GetExamByCoursenoSeriesnoClass(course_no, course_seriesno, course_class).Rows.Count == 0)
        {
            ct.UpdateCourseSeriesClass(course_no, course_seriesno, course_class, txtCourse_class.Value);
            if (ct.GetExamByCoursenoClass(course_no, course_class).Rows.Count == 0)
            {
                ct.DeleteCourseClass(course_no, course_class);
            }
            if (ct.GetCourseByCoursenoClass(course_no, course_class).Rows.Count == 0)
            {
                ct.AddCourseClass(course_no, course_class);
            }
            gvExCourse.DataBind();
            popupEdit.ShowOnPageLoad = false;
            MsgBox.ShowMessage("已保存！");
        }
        else
        {
            gvExCourse.DataBind();
            popupEdit.ShowOnPageLoad = false;
            MsgBox.ShowErrorMessage("此班级已存在！");
        }
        ct.UpdateCourseSeriesClass(course_no, course_seriesno, course_class, txtCourse_class.Value);
        SysData.DataTable otherteacher = ct.GetOtherTeacher(course_no, course_seriesno);
        //bool flag1 = true;
        //for (int i = 0; i < otherteacher.Rows.Count; i++)
        //{
        //    if (otherteacher.Rows[i]["course_teacherno"].ToString() == course_teacherno)
        //        flag1 = false;
        //}
        //bool flag2 = true;
        //for (int i = 0; i < otherteacher.Rows.Count; i++)
        //{
        //    if (otherteacher.Rows[i]["course_teacherno"].ToString() == txtCourse_teacherno.Value)
        //        flag2 = false;
        //}
        //if (flag1 && flag2) ct.UpdateCourseTeacher(course_no, course_teacherno, course_teachername, txtCourse_teacherno.Value);
        //else if (flag1 && !flag2) ct.AddCourseTeacher(course_no, course_teacherno, course_teachername);
        //else if (!flag1 && flag2) ct.DeleteCourseTeacher(course_no, txtCourse_teacherno.Value);
        gvExCourse.DataBind();
        popupEdit.ShowOnPageLoad = false;
    }
}