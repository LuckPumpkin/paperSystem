using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using SysData = System.Data;
using System.Configuration;

public partial class WebForms_SchoolAdmin_CourseTeacherEdit : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void gvExCourse_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "EditTeacher")
        {
            int index = Convert.ToInt32(e.CommandArgument);
            txtCourse_no.Value = ((Label)gvExCourse.Rows[index].FindControl("lblcourse_no")).Text;
            txtCourse_seriesno.Value = ((Label)gvExCourse.Rows[index].FindControl("lbcourse_seriesno")).Text;
            txtCourse_teacherno.Value = ((Label)gvExCourse.Rows[index].FindControl("lbcourse_teacherno")).Text;
            txtCourse_teachername.Value = ((Label)gvExCourse.Rows[index].FindControl("lbcourse_teachername")).Text;
            txtTeacherName0.Text = txtCourse_teachername.Value;
            txtTeacherNo0.Text = txtCourse_teacherno.Value;
            popupEdit.ShowOnPageLoad = true;
            gvExCourse.DataBind();
        }
        if (e.CommandName == "DeleteTeacher")
        {
            int index = Convert.ToInt32(e.CommandArgument);
            txtCourse_no.Value = ((Label)gvExCourse.Rows[index].FindControl("lblcourse_no")).Text;
            txtCourse_seriesno.Value = ((Label)gvExCourse.Rows[index].FindControl("lbcourse_seriesno")).Text;
            txtCourse_teacherno.Value = ((Label)gvExCourse.Rows[index].FindControl("lbcourse_teacherno")).Text;
            CourseTeacher ct = new CourseTeacher();
            ct.DeleteCourseSeriesTeacher(txtCourse_no.Value, txtCourse_seriesno.Value, txtCourse_teacherno.Value);
            SysData.DataTable teacher = ct.GetExamByCoursenoTeacherno(txtCourse_no.Value, txtCourse_teacherno.Value);
            if(teacher.Rows.Count==0)
            {
                ct.DeleteCourseTeacher(txtCourse_no.Value, txtCourse_teacherno.Value);
            }
            gvExCourse.DataBind();
        }
    }

    
    //替换
    protected void mnuAdd_ItemClick(object source, DevExpress.Web.ASPxMenu.MenuItemEventArgs e)
    {
        CourseTeacher ct = new CourseTeacher();
        string course_no = Request.QueryString["course_no"];
        string course_seriesno = Request.QueryString["course_seriesno"];
        string course_teacherno = txtTeacherNo.Text.Trim();
        string course_teachername = txtTeacherName.Text.Trim();
        if(ct.GetExamByCoursenoSeriesnoTeacherno(course_no,course_seriesno,course_teacherno).Rows.Count==0)
        {
            ct.AddCourseSeriesTeacher(course_no, course_seriesno, course_teacherno, course_teachername);
            if(ct.GetCourseByCoursenoTeacherno(course_no,course_teacherno).Rows.Count==0)
            {
                ct.AddCourseTeacher(course_no, course_teacherno, course_teachername);
            }
            gvExCourse.DataBind();
            popupAdd.ShowOnPageLoad = false;
        }
        else
        {
            popupAdd.ShowOnPageLoad = false;
            MsgBox.ShowErrorMessage("该教师已存在！");
        }
        
    }
    protected void mnuEdit_ItemClick(object source, DevExpress.Web.ASPxMenu.MenuItemEventArgs e)
    {
        CourseTeacher ct = new CourseTeacher();
        string course_no = Request.QueryString["course_no"];
        string course_seriesno = Request.QueryString["course_seriesno"];
        string course_teacherno = txtTeacherNo0.Text.Trim();
        string course_teachername = txtTeacherName0.Text.Trim();
        if(ct.GetExamByCoursenoSeriesnoTeacherno(course_no,course_seriesno,course_teacherno).Rows.Count==0)
        {
            ct.UpdateCourseSeriesTeacher(course_no, course_seriesno, course_teacherno, course_teachername, txtCourse_teacherno.Value);
            if(ct.GetExamByCoursenoTeacherno(course_no,txtCourse_teacherno.Value).Rows.Count==0)
            {
                ct.DeleteCourseTeacher(course_no, txtCourse_teacherno.Value);
            }
            if(ct.GetCourseByCoursenoTeacherno(course_no,course_teacherno).Rows.Count==0)
            {
                ct.AddCourseTeacher(course_no, course_teacherno, course_teachername);
            }
            gvExCourse.DataBind();
            popupEdit.ShowOnPageLoad = false;
            MsgBox.ShowMessage("已保存！");
        }
        else
        {
            gvExCourse.DataBind();
            popupEdit.ShowOnPageLoad = false;
            MsgBox.ShowErrorMessage("此教师已存在！");
        }
        ct.UpdateCourseSeriesTeacher(course_no, course_seriesno, course_teacherno, course_teachername, txtCourse_teacherno.Value);
        SysData.DataTable otherteacher = ct.GetOtherTeacher(course_no, course_seriesno);
        bool flag1 = true;
        for (int i = 0; i < otherteacher.Rows.Count; i++)
        {
            if (otherteacher.Rows[i]["course_teacherno"].ToString() == course_teacherno)
                flag1 = false;
        }
        bool flag2 = true;
        for (int i = 0; i < otherteacher.Rows.Count; i++)
        {
            if (otherteacher.Rows[i]["course_teacherno"].ToString() == txtCourse_teacherno.Value)
                flag2 = false;
        }
        if (flag1 && flag2) ct.UpdateCourseTeacher(course_no, course_teacherno, course_teachername, txtCourse_teacherno.Value);
        else if (flag1 && !flag2) ct.AddCourseTeacher(course_no, course_teacherno, course_teachername);
        else if (!flag1 && flag2) ct.DeleteCourseTeacher(course_no, txtCourse_teacherno.Value);
        gvExCourse.DataBind();
        popupEdit.ShowOnPageLoad = false;
    }
}