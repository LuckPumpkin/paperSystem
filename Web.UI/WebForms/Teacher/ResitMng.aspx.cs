using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WebForms_Teacher_ResitMng : System.Web.UI.Page
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
    protected void gvResit_RowCommand(object sender, GridViewCommandEventArgs e)
    {

        if (e.CommandName == "ResitEdit")
        {
            int index = Convert.ToInt32(e.CommandArgument);
            string paperID = ((Label)gvResit.Rows[index].FindControl("lbpaperID")).Text;
            
            popupResit.ContentUrl = "../Teacher/ResitEdit.aspx?paperID=" + paperID;
            popupResit.ShowOnPageLoad = true;
        }
        if (e.CommandName == "Submit")
        {
             int index = Convert.ToInt32(e.CommandArgument);
             string paperID = ((Label)gvResit.Rows[index].FindControl("lbpaperID")).Text;
             txtPaperID.Value = ((Label)gvResit.Rows[index].FindControl("lbpaperID")).Text;
             string paper_num = ((Label)gvResit.Rows[index].FindControl("lb_paper_num")).Text;
             string whitePaper_num = ((Label)gvResit.Rows[index].FindControl("lb_whitePaper_num")).Text;
             string paper_copyNum = ((Label)gvResit.Rows[index].FindControl("lb_paper_copyNum")).Text;

             if (paper_num != "" && whitePaper_num != "" && paper_copyNum != "")
             {
                 if (isNumberic(paper_num.Trim()) && isNumberic(whitePaper_num.Trim()) && isNumberic(paper_copyNum.Trim()))
                 {
                     if (Convert.ToInt32(paper_num) <= 5 && Convert.ToInt32(whitePaper_num) <= 5)
                     {
                         try{
                         State s = new State();
                         Paper p = new Paper();
                         p.UpdateResitState1(Convert.ToInt32(paperID));
                         DateTime today = Convert.ToDateTime(DateTime.Now.ToShortDateString());
                          string connectionString = ConfigurationManager.ConnectionStrings["AppConnStr"].ToString();
            string strSQL = string.Format(

"UPDATE  Paper SET submitTime = '{0}' FROM Paper WHERE (Paper.ID = '{1}')", today, paperID);
            SqlConnection conn = new SqlConnection(connectionString);

            SqlCommand cmd = new SqlCommand(strSQL, conn);

            conn.Open();
            int result = (int)cmd.ExecuteScalar();
            conn.Close();
        }
        catch (Exception ex)
        {
            MsgBox.ShowErrorMessage("请填入格式正确的日期！");
        }

                         gvResit.DataBind();
                         MsgBox.ShowMessage("提交成功！");
                     }
                     else 
                     {
                         popupState.ShowOnPageLoad = true; 
                     }
                     //popupState.ShowOnPageLoad = false;
                     //gvResit.DataBind();
                 }
             }
             else 
             {
                 MsgBox.ShowErrorMessage("试卷信息填写有误！");
             
             } 
        }
    }
    protected void mnuToolBar_ItemClick(object source, DevExpress.Web.ASPxMenu.MenuItemEventArgs e)
    {           

                Paper paper = new Paper();
                DateTime today = Convert.ToDateTime(DateTime.Now.ToShortDateString());
                string connectionString = ConfigurationManager.ConnectionStrings["AppConnStr"].ToString();
                string strSQL = string.Format(

    "UPDATE  Paper SET submitTime = '{0}' FROM Paper WHERE (Paper.ID = '{1}')", today, txtPaperID.Value);
                SqlConnection conn = new SqlConnection(connectionString);

                SqlCommand cmd = new SqlCommand(strSQL, conn);

                conn.Open();
                int result = (int)cmd.ExecuteScalar();
                conn.Close();
                paper.UpdateResitState1(Convert.ToInt32(txtPaperID.Value));
                popupState.ShowOnPageLoad = false;              
                MsgBox.ShowMessage("提交成功！"); 
                gvResit.DataBind();
    }
    protected bool isNumberic(string message)
    {
        if (message != "" && Regex.IsMatch(message, @"^[0-9]+$"))
        {
            return true;
        }
        else
            return false;
    }
    protected void refresh_Click(object sender, EventArgs e)
    {
        gvResit.DataBind();
    }
}