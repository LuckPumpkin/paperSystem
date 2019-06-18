using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using SysData = System.Data;
using System.Configuration;

public partial class WebForms_SchoolAdmin_CourseEdit : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {
            Course co = new Course();
            SysData.DataTable dtCourse = co.GetExamCourseByID(Convert.ToInt32(Request.QueryString["ID"]));
            //初始化
            this.CascadingDropDown1.SelectedValue = dtCourse.Rows[0]["course_dept"].ToString();
            this.CascadingDropDown2.SelectedValue = dtCourse.Rows[0]["course_profession"].ToString();
            this.CascadingDropDown3.SelectedValue = dtCourse.Rows[0]["CommonOrPrivate"].ToString();
            this.CascadingDropDown4.SelectedValue = dtCourse.Rows[0]["PrivateCollege"].ToString();
            this.cboCourseAttribute.SelectedValue = dtCourse.Rows[0]["course_attribute"].ToString();
            this.cboCourseType.SelectedValue = dtCourse.Rows[0]["course_type"].ToString();
            txtCourseNo.Text = dtCourse.Rows[0]["course_no"].ToString();
            txtCourseSeriesNo.Text = dtCourse.Rows[0]["course_serialno"].ToString();
            txtCourseName.Text = dtCourse.Rows[0]["course_name"].ToString();
        }
    }


    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            string examCourseID, course_no, course_seriesno, course_name, course_dept, course_type, course_attribute, CommonOrPrivate, PrivateCollege, course_profession;
            examCourseID = Request.QueryString["ID"];
            course_no = txtCourseNo.Text;
            course_seriesno = txtCourseSeriesNo.Text;
            course_name = txtCourseName.Text;
            course_dept = this.cboCourseDept.SelectedValue;
            course_type = cboCourseType.SelectedValue;
            course_attribute = cboCourseAttribute.SelectedValue;
            CommonOrPrivate = this.cboCommonOrPrivate.SelectedValue;
            PrivateCollege = this.cboPrivateCollege.SelectedValue;
            course_profession = this.cboCoursePro.SelectedValue;
            Course co = new Course();
            if(co.GetExamByCoursenoSeriesnoOutsideID(course_no,course_seriesno,Convert.ToInt32(examCourseID)).Rows.Count==0)
            {
                co.UpdateExamCourseByID(course_dept, course_no, course_name, course_seriesno, course_type, course_attribute, CommonOrPrivate, PrivateCollege, Convert.ToInt32(Request.QueryString["ID"]));
                co.UpdateCourseByCourseNo(course_dept, course_no, course_name, course_type, course_attribute, CommonOrPrivate, PrivateCollege, course_profession);
                MsgBox.ShowMessage("已更新！");
            }
            else
            {
                MsgBox.ShowErrorMessage("数据已存在！");
            }
            
        }
        catch (Exception ex)
        {
            MsgBox.ShowErrorMessage(ex.Message);
            return;
        }
        

    }
}