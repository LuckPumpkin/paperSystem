using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WebForms_PrintAdmin_paperPDF : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string teachingPlan = Request.QueryString["teachingPlan"].ToString();
        string course_dept = Request.QueryString["course_dept"].ToString();
        string course_teacherno = Request.QueryString["course_teacherno"].ToString();
        string course_no = Request.QueryString["course_no"].ToString();
        string type = Request.QueryString["type"].ToString();
        Priview(teachingPlan, course_dept, course_teacherno, course_no, type);

    }
    public void Priview(string teachingPlan, string course_dept, string course_teacherno, string course_no, string type)
    {
        Response.ContentType = "Application/pdf";
        string fileName = Server.MapPath("~/Downloads/" + teachingPlan + "_" + course_dept + "_" + course_teacherno + "_" + course_no + "_" + type + "卷.pdf");
        //Response.AddHeader("content-disposition", "filename=" + fileName);
        Response.WriteFile(fileName);
        Response.End();
    }


}