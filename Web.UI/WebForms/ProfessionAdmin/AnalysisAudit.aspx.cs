using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.IO;

public partial class WebForms_ProfessionAdmin_AnalysisAudit1 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {

            txtTeacherID.Value = Convert.ToString(Session["UserCode"]);
            Teacher tea = new Teacher();
            txtPro.Value = tea.GetProByUserCode(txtTeacherID.Value);
            gvCourse.DataBind();
        }
    }

    protected void CheckBox_CheckedChanged(object sender, EventArgs e)
    {
        if (gvCourse.Rows.Count != 0)
        {
            if (CheckBox.Checked == true)
            {
                for (int i = 0; i < gvCourse.Rows.Count; i++)
                {
                    (gvCourse.Rows[i].FindControl("CheckBox") as CheckBox).Checked = true;
                }
            }
            else
            {
                for (int i = 0; i < gvCourse.Rows.Count; i++)
                {
                    (gvCourse.Rows[i].FindControl("CheckBox") as CheckBox).Checked = false;
                }
            }
        }
    }

    protected void mnuToolBar_ItemClick(object source, DevExpress.Web.ASPxMenu.MenuItemEventArgs e)
    {
        List<string> idList = new List<string>();
        if (gvCourse.Rows.Count != 0)
        {
            for (int i = 0; i < gvCourse.Rows.Count; i++)
            {
                if (((CheckBox)gvCourse.Rows[i].FindControl("CheckBox")).Checked == true)
                {
                    string s = ((Label)gvCourse.Rows[i].FindControl("lblanalysisId")).Text;
                    idList.Add(s);
                }
            }
        }
        if (idList.Count == 0)
        {
            MsgBox.ShowErrorMessage("请选择！");
        }
        else
        {
            int i;
            Analysis ana = new Analysis();
            State st = new State();
            int state = st.GetPostStateID("试卷分析系待审", "试卷分析系审核" + DropDownList2.SelectedValue.ToString());
            for (i = 0; i < idList.Count; i++)
            {
                ana.UpdateProAnalysis(Convert.ToInt32(idList[i].ToString()), txtAudit.Text);
                ana.UpdateState(state, Convert.ToInt32(idList[i].ToString()));
            }

        }
        popupAuditEdit.ShowOnPageLoad = false;
        gvCourse.DataBind();
    }
    protected void gvCourseall_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Download")
        {
            int index = Convert.ToInt32(e.CommandArgument);
            txtCourseNo.Value = ((Label)gvCourse.Rows[index].FindControl("lblCourseNo")).Text;
            txtAccount.Value = ((Label)gvCourse.Rows[index].FindControl("lblTeacher")).Text;
            Download("A");
        }
        if (e.CommandName == "DownloadB")
        {
            int index = Convert.ToInt32(e.CommandArgument);
            txtCourseNo.Value = ((Label)gvCourse.Rows[index].FindControl("lblCourseNo")).Text;
            txtAccount.Value = ((Label)gvCourse.Rows[index].FindControl("lblTeacher")).Text;
            Download("B");
        }
        if (e.CommandName == "PaperAnalysis")
        {
            int index = Convert.ToInt32(e.CommandArgument);
            string AnalysisID = ((Label)gvCourse.Rows[index].FindControl("lblanalysisId")).Text;
            popupRegistration.ContentUrl = "../Common/AnalysisReport.aspx?anaID=" + AnalysisID;
            popupRegistration.ShowOnPageLoad = true;
        }
    }
    protected void Download(string type)
    {
        try
        {
            string physicalFileName = Server.MapPath("/Downloads/" + txtAccount.Value + "/" + txtCourseNo.Value + "/" + type + "卷.pdf");
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


    protected void mnuMain_ItemClick(object source, DevExpress.Web.ASPxMenu.MenuItemEventArgs e)
    {
        List<string> idList = new List<string>();
        if (gvCourse.Rows.Count != 0)
        {
            for (int i = 0; i < gvCourse.Rows.Count; i++)
            {
                if (((CheckBox)gvCourse.Rows[i].FindControl("CheckBox")).Checked == true)
                {
                    string s = ((Label)gvCourse.Rows[i].FindControl("lblanalysisID")).Text;
                    idList.Add(s);
                }
            }
        }
        if (idList.Count == 0)
        {
            MsgBox.ShowErrorMessage("请选择！");
        }
        else
        {
            popupAuditEdit.ShowOnPageLoad = true;
        }
    }
}