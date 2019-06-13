using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WebForms_Teacher_AnalysisMng : System.Web.UI.Page
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
    protected void gvCourse_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "AnalysisEdit")
        {
            int index = Convert.ToInt32(e.CommandArgument);
            string analysisID = ((Label)gvCourse.Rows[index].FindControl("lblanalysisId")).Text;
            popupAnalysis.ShowOnPageLoad = true;
            popupAnalysis.ContentUrl = "../Teacher/AnalysisEdit.aspx?anaID=" + analysisID;
        }
        if (e.CommandName == "AnalysisReport")
        {
            int index = Convert.ToInt32(e.CommandArgument);
            string analysisID = ((Label)gvCourse.Rows[index].FindControl("lblanalysisId")).Text;
            DSAnalysisTableAdapters.AnalysisTableAdapter helper = new DSAnalysisTableAdapters.AnalysisTableAdapter();
            DSAnalysis.AnalysisDataTable table = new DSAnalysis.AnalysisDataTable();
            helper.FillByID(table, Convert.ToInt32(analysisID.ToString()));
            if (table.Rows[0]["num_less60"].ToString() != "")
            {
                popupAnalysis.ShowOnPageLoad = true;
                popupAnalysis.ContentUrl = "../Common/AnalysisReport.aspx?anaID=" + analysisID;
            }
            else
            {
                MsgBox.ShowErrorMessage("没有成绩！");
            }
        }
        if (e.CommandName == "ScoreUpload")
        {
            int index = Convert.ToInt32(e.CommandArgument);
            string analysisID = ((Label)gvCourse.Rows[index].FindControl("lblanalysisId")).Text;
            popupAnalysis.ShowOnPageLoad = true;
            popupAnalysis.ContentUrl = "../Teacher/ScoreAnalysis.aspx?anaID=" + analysisID;
        }
        if (e.CommandName == "Submit")
        {
            int index = Convert.ToInt32(e.CommandArgument);
            string analysisID = ((Label)gvCourse.Rows[index].FindControl("lblanalysisId")).Text;
            State s = new State();
            DSAnalysisTableAdapters.AnalysisTableAdapter helper = new DSAnalysisTableAdapters.AnalysisTableAdapter();
            DSAnalysis.AnalysisDataTable table = new DSAnalysis.AnalysisDataTable();
            helper.FillByID(table,Convert.ToInt32(analysisID.ToString()));
            Analysis ana = new Analysis();
            if (table.Rows[0]["num_less60"].ToString() != "") { 
            ana.UpdateState(s.GetPostStateID("试卷分析草稿", "提交"), Convert.ToInt32(analysisID));
            gvCourse.DataBind();
            MsgBox.ShowMessage("提交成功！");
            }
            else
            {
                MsgBox.ShowErrorMessage("没有成绩！");
            }
        }
        
    }
}