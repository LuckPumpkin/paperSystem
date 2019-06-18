using Microsoft.Office.Interop.Word;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Web;
using System.Text;
using System.Configuration;
using SysData = System.Data;
using System.Data.SqlClient;
using O2S.Components.PDFRender4NET;
using System.Drawing;
using System.Drawing.Imaging;
using iTextSharp.text;
using iTextSharp.text.pdf;




public partial class WebForms_ProfessionAdmin_PaperCheck : System.Web.UI.Page
{
    public string account;
    public string courseNo;
    public string paper;
    public string teachplan;
    public string coursedept;

    protected void Page_Load(object sender, EventArgs e)
    {
        account = Request.QueryString["account"].ToString();
        courseNo = Request.QueryString["courseNo"].ToString();
        paper = Request.QueryString["paper"].ToString();
        teachplan = Request.QueryString["teachingplan"].ToString();
        coursedept = Request.QueryString["coursedept"].ToString();
        string sfileName = Server.MapPath("~/Downloads/" + account + "/" + courseNo + "/" + paper + "卷.pdf");
        string ofileName = Server.MapPath("~/PDFImages/" + account + "/" + courseNo + "/" + paper + "/");
        ASPxImageSlider1.ImageSourceFolder = "~/PDFImages/" + account + "/" + courseNo + "/" + paper + "/";
    }

    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        Paper p = new Paper();
        int paperID=p.GetPaperIDByCourseAndPaper(courseNo, paper);
        p.UpdateReadedByID(paperID);
        Console.Write(Label1.Text="已查阅!");
    }
   
    
}