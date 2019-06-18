using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.IO;
using O2S.Components.PDFRender4NET;
using System.Drawing;
using System.Drawing.Imaging;
using System.Configuration;

public partial class WebForms_Teacher_HistoryView : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            txtTeacherId.Value = Convert.ToString(Session["UserCode"]);
            User us = new User();
            txtAccount.Value = us.GetAccount(txtTeacherId.Value);
        }
    }
    protected void gvRegistration_RowCommand(object sender, GridViewCommandEventArgs e)
    {

        
        if (e.CommandName == "RegReport")
        {
            int index = Convert.ToInt32(e.CommandArgument);
            string regID = ((Label)gvRegistration.Rows[index].FindControl("lbregID")).Text;
            popupRegistration.ContentUrl = "../Common/RegistrationReport.aspx?regID=" + regID;
            popupRegistration.ShowOnPageLoad = true;
        }
        if (e.CommandName == "DetailReport")
        {
            int index = Convert.ToInt32(e.CommandArgument);
            string regID = ((Label)gvRegistration.Rows[index].FindControl("lbregID")).Text;
            popupRegistration.ContentUrl = "../Common/DetailReport.aspx?regID=" + regID;
            popupRegistration.ShowOnPageLoad = true;
        }
        if (e.CommandName == "QuestiontypeReport")
        {
            int index = Convert.ToInt32(e.CommandArgument);
            string regID = ((Label)gvRegistration.Rows[index].FindControl("lbregID")).Text;
            popupRegistration.ContentUrl = "../Common/QuestiontypeReport.aspx?regID=" + regID;
            popupRegistration.ShowOnPageLoad = true;
        }
        
        if (e.CommandName == "PaperDownloadA")
        {
            int index = Convert.ToInt32(e.CommandArgument);
            txtCourseNo.Value = ((Label)gvRegistration.Rows[index].FindControl("lblcourse_no")).Text;
            Download("A");
        }
        if (e.CommandName == "PaperDownloadB")
        {
            int index = Convert.ToInt32(e.CommandArgument);
            txtCourseNo.Value = ((Label)gvRegistration.Rows[index].FindControl("lblcourse_no")).Text;
            Download("B");
        }
    }
    protected void gvAnalysis_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "AnalysisReport")
        {
            int index = Convert.ToInt32(e.CommandArgument);
            string analysisID = ((Label)gvAnalysis.Rows[index].FindControl("lblanalysisId")).Text;
            popupRegistration.ShowOnPageLoad = true;
            popupRegistration.ContentUrl = "../Common/AnalysisReport.aspx?anaID=" + analysisID;
        }

    }
    protected void Download(string type)
    {
        try
        {
            string physicalFileName = Server.MapPath("~/Downloads/" + txtAccount.Value + "/" + txtCourseNo.Value + "/" + type + "卷.pdf");
            string ext = Path.GetExtension(physicalFileName);
            string fileName = type + "卷.pdf";

            if (!File.Exists(physicalFileName))
                Response.Redirect("../Common/Error.aspx?ErrorMsgID=1");
            else
            {
                Response.Clear();
                Response.ContentType = Attachment.GetMimeType(ext);

                //当客户端使用IE时，对其进行编码；
                //使用 ToHexString 代替传统的 UrlEncode()；
                if (Request.UserAgent.ToLower().IndexOf("msie") > -1)
                    fileName = Attachment.ToHexString(fileName);

                //为了向客户端输出空格，需要在当客户端使用 Firefox 时特殊处理
                if (Request.UserAgent.ToLower().IndexOf("firefox") > -1)
                    Response.AddHeader("Content-Disposition", "attachment;filename=\"" + fileName + "\"");
                else
                    Response.AppendHeader("Content-Disposition", "attachment; filename=" + fileName);

                Response.TransmitFile(physicalFileName);
                Response.End();
            }
        }
        catch (Exception ex)
        {
            MsgBox.ShowErrorMessage(ex.Message);
        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        gvRegistration.DataBind();
    }
}