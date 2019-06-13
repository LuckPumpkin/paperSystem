using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WebForms_CollegeAdmin_ReView : System.Web.UI.Page
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
    protected void gvCourse_RowCommand(object sender, GridViewCommandEventArgs e)
    {

        if (e.CommandName == "PDF")
        {
            int index = Convert.ToInt32(e.CommandArgument);
            //string regID = ((Label)gvCourse.Rows[index].FindControl("lblregID")).Text;
            string course_teacherno = ((Label)gvCourse.Rows[index].FindControl("lbTeacher")).Text;
            string course_no = ((Label)gvCourse.Rows[index].FindControl("lblCourseNo")).Text;
            string course_dept = ((Label)gvCourse.Rows[index].FindControl("lbcourse_dept")).Text;
            string teachingplan = ((Label)gvCourse.Rows[index].FindControl("lbteacherplan")).Text;
            string type = ((Label)gvCourse.Rows[index].FindControl("lbpapertype")).Text;
            string newFileName = (teachingplan + "_" + course_dept + "_" + course_teacherno + "_" + course_no + "_" + type + "卷.pdf");
            string path = ("../Downloads/").ToString();
            string pdfPath = path + newFileName;
            popupPDF.ContentUrl = "/../pdf.js/web/viewer.html?file=/../" + pdfPath; 

            popupPDF.ShowOnPageLoad = true;
            gvCourse.Rows[index].Cells[4].Text = "已查看";                
        }
    }
}