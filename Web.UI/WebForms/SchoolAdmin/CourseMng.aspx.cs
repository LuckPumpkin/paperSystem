using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using SysData = System.Data;
using System.Configuration;

public partial class WebForms_SchoolAdmin_CourseMng : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }
    protected void gvCourse_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "EditTeacher")
        {
            int index = Convert.ToInt32(e.CommandArgument);
            string course_no = ((Label)gvExCourse.Rows[index].FindControl("lblcourse_no")).Text;
            string course_seriesno = ((Label)gvExCourse.Rows[index].FindControl("lblcourse_seriesno")).Text;
            popupEdit.ContentUrl = "../SchoolAdmin/CourseTeacherEdit.aspx?course_no=" + course_no + "&&course_seriesno=" + course_seriesno;
            popupEdit.ShowOnPageLoad = true;
            gvExCourse.DataBind();
        }
        if (e.CommandName == "EditCourse")
        {
            int index = Convert.ToInt32(e.CommandArgument);
            string ID = ((Label)gvExCourse.Rows[index].FindControl("lblID")).Text;
            popupEdit.ContentUrl = "../SchoolAdmin/CourseEdit.aspx?ID=" + ID;
            popupEdit.ShowOnPageLoad = true;
            gvExCourse.DataBind();
        }
        if (e.CommandName == "EditClass")
        {
            int index = Convert.ToInt32(e.CommandArgument);
            string course_no = ((Label)gvExCourse.Rows[index].FindControl("lblcourse_no")).Text;
            string course_seriesno = ((Label)gvExCourse.Rows[index].FindControl("lblcourse_seriesno")).Text;
            popupEdit.ContentUrl = "../SchoolAdmin/CourseClassEdit.aspx?course_no=" + course_no + "&&course_seriesno=" + course_seriesno;
            popupEdit.ShowOnPageLoad = true;
            gvExCourse.DataBind();
        }
        if (e.CommandName == "DeleteCourse")
        {
            int index = Convert.ToInt32(e.CommandArgument);
            txtExamCourseID.Value = ((Label)gvExCourse.Rows[index].FindControl("lblID")).Text;
            txtCourseNo.Value = ((Label)gvExCourse.Rows[index].FindControl("lblcourse_no")).Text;
            txtCourse_seriesno.Value = ((Label)gvExCourse.Rows[index].FindControl("lblcourse_seriesno")).Text;
            popupMsg.ShowOnPageLoad = true;
            // gvExCourse.DataBind();
        }
    }
    protected void mnuMsg_ItemClick(object source, DevExpress.Web.ASPxMenu.MenuItemEventArgs e)
    {
        //删除课程
        try
        {
            Analysis ana = new Analysis();
            ana.DeleteAnalysisByExamCourseID(Convert.ToInt32(txtExamCourseID.Value));
            Course co = new Course();
            co.DeleteExamCourseByID(Convert.ToInt32(txtExamCourseID.Value));
            CourseTeacher ct = new CourseTeacher();
            SysData.DataTable teacher = ct.GetTeacherByCoursenoAndSeriesno(txtCourseNo.Value, txtCourse_seriesno.Value);
            ct.DeleteByCoursenoAndSeriesno(txtCourseNo.Value, txtCourse_seriesno.Value);//删除CourseSeriesTeacher表数据
            for (int i = 0; i < teacher.Rows.Count; i++)//删除CourseTeacher表数据，需要检查教师
            {
                SysData.DataTable teacher1 = ct.GetExamByCoursenoTeacherno(txtCourseNo.Value, teacher.Rows[i]["course_teacherno"].ToString());
                if (teacher1.Rows.Count == 0)
                {
                    ct.DeleteCourseTeacher(txtCourseNo.Value, teacher.Rows[i]["course_teacherno"].ToString());
                }
            }
            SysData.DataTable dt = co.GetExamCourseByCourseNo(txtCourseNo.Value);
            if (dt.Rows.Count == 0)//如果该课程号对应的没有其他课序号了，则删除Course表及其他各表
            {
                Paper pa = new Paper();
                Registration reg = new Registration();
                Detail de = new Detail();
                int courseID = Convert.ToInt32(co.GetIDByCourseNo(txtCourseNo.Value).ToString());
                reg.DeleteRegByCourseID(courseID);
                SysData.DataTable detID = de.GetDetailByCID(courseID);
                if (detID.Rows.Count != 0) { 
                    for(int i=0;i< detID.Rows.Count;i++){
                        int dID = Convert.ToInt32(detID.Rows[i]["DetailID"].ToString());
                        de.DeleteModuleByDetailID(dID);
                        de.DeleteQbyDetailID(dID);
                    }
                }
                de.DeleteDetailByCourseID(courseID);
                pa.DeletePaperByCourseID(courseID);
                co.DeleteCourseByID(courseID);
            }
            popupMsg.ShowOnPageLoad = false;
            MsgBox.ShowMessage("已删除！");
            gvExCourse.DataBind();

        }
        catch(Exception ex)
        {
            MsgBox.ShowErrorMessage(ex.Message);
        }
        
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        gvExCourse.DataBind();
    }
    protected void mnuMain_ItemClick1(object source, DevExpress.Web.ASPxMenu.MenuItemEventArgs e)
    {
        if (e.Item.Name == "Add")
        {
            popupAdd.ContentUrl = "../SchoolAdmin/CourseAdd.aspx";
            popupAdd.ShowOnPageLoad = true;
            gvExCourse.DataBind();
        }
        if (e.Item.Name == "shuaxin")
        {
            gvExCourse.DataBind();
            MsgBox.ShowMessage("刷新成功！");
        }
    }
}