using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using SysData = System.Data;
using System.Configuration;
public partial class WebForms_SchoolAdmin_CourseAdd : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnInsert_Click(object sender, EventArgs e)
    {
        try
        {
            Course co = new Course();
            SysData.DataTable examCourse = new SysData.DataTable();
            examCourse = co.GetExCourseTeacher(txtCourseNo.Text, txtCourseSeriesNo.Text);
            if (examCourse.Rows.Count == 0)
            {
                if (cboCourseDept.SelectedValue=="")
                {
                    MsgBox.ShowErrorMessage("开课学院不能为空!");
                    return;
                }
                co.InsertExamCourse("2017-2018学年春(两学期)", cboCourseDept.SelectedValue, txtCourseNo.Text, txtCourseName.Text, txtCourseSeriesNo.Text, cboCourseType.SelectedValue, cboCourseAttribute.SelectedValue, "曹妃甸校区", cboCommonOrPrivate.SelectedValue, cboPrivateCollege.SelectedValue);
                SysData.DataTable course = new SysData.DataTable();
                course = co.GetCourse(txtCourseNo.Text);
                int examCourseID = co.GetIDByCoursenoAndSeriesno(txtCourseNo.Text, txtCourseSeriesNo.Text);
                if (course.Rows.Count == 0)
                {
                    co.InsertCourse("2017-2018学年春(两学期)", cboCourseDept.SelectedValue, txtCourseNo.Text, txtCourseName.Text, cboCourseType.SelectedValue, cboCourseAttribute.SelectedValue, "曹妃甸校区", cboCommonOrPrivate.SelectedValue, cboPrivateCollege.SelectedValue, cboCoursePro.SelectedValue);
                    int courseID = co.GetIDByCourseNo(txtCourseNo.Text);
                    Paper pa = new Paper();
                    pa.InsertPaperA(courseID);
                    pa.InsertPaperB(courseID);
                    Registration reg = new Registration();
                    reg.InsertReg(courseID,Convert.ToInt32(pa.GetPaperIDByCourseID(courseID).Rows[0]["ID"].ToString()));
                    reg.InsertReg(courseID, Convert.ToInt32(pa.GetPaperIDByCourseID(courseID).Rows[1]["ID"].ToString()));
                    Detail de = new Detail();
                    de.InsertDetail(courseID, Convert.ToInt32(pa.GetPaperIDByCourseID(courseID).Rows[0]["ID"].ToString()));
                    de.InsertDetail(courseID, Convert.ToInt32(pa.GetPaperIDByCourseID(courseID).Rows[1]["ID"].ToString()));
                    Analysis ana = new Analysis();
                    ana.InsertAnalysis(examCourseID);
                }
                else
                {
                    Paper pa = new Paper();
                    Analysis ana = new Analysis();
                    ana.InsertAnalysis(examCourseID);
                }
                MsgBox.ShowMessage("添加成功！");
            }
            else
            {
                MsgBox.ShowErrorMessage("该课程已经存在！");
            }
            
        }
        catch (Exception ex)
        {
            MsgBox.ShowErrorMessage(ex.Message);
            return;
        }
    }
}