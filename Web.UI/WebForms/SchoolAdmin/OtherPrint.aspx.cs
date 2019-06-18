using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;

public partial class WebForms_SchoolAdmin_OtherPrint : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            txtTeacherId.Value = Convert.ToString(Session["UserCode"]);
            User us = new User();
            txtTeacher.Value = us.GetName(txtTeacherId.Value);
            txtCollege.Value = "教务处";
        }
    }
    protected void btnNew_Click(object sender, EventArgs e)
    {
        popupEdit.ShowOnPageLoad = true;
    }
    protected void mnuToolBar1_ItemClick(object source, DevExpress.Web.ASPxMenu.MenuItemEventArgs e)
    {
        try { 
        string Name = txtName.Text.Trim().ToString();
        string College = "教务处";
        int pageNum = Convert.ToInt32(txtpageNum.Text.Trim());
        int printNum = Convert.ToInt32(txtPrintNum.Text.Trim());
        string paper = dropaper.SelectedValue.ToString();
        string printColor = droprintColor.SelectedValue.ToString();
        string paperSize = dropaperSize.SelectedValue.ToString();
        string SingleOrDouble = droSingleOrDouble.SelectedValue.ToString();
        string bindMethod = drobindMethod.SelectedValue.ToString();
        string cover = drocover.SelectedValue.ToString();
        OtherPtint ot = new OtherPtint();
        ot.InsertQuery(Name, College, pageNum, printNum, paper, printColor, paperSize, SingleOrDouble, bindMethod, cover);
        MsgBox.ShowMessage("保存成功！！");
        popupEdit.ShowOnPageLoad = false;
        popupEdit1.ShowOnPageLoad = false;
        gvDetail.DataBind();
            }
            catch (Exception ex)
            {
                MsgBox.ShowErrorMessage(ex.Message);
                return;
            }
    }
    protected void mnuToolBar_ItemClick(object source, DevExpress.Web.ASPxMenu.MenuItemEventArgs e)
    {
        try { 
        string Name = txtName1.Text.Trim().ToString();
        string College = txtCollege.Value.Trim().ToString();
        int pageNum = Convert.ToInt32(txtpageNum1.Text.Trim());
        int printNum = Convert.ToInt32(txtPrintNum1.Text.Trim());
        string paper = dropaper1.SelectedValue.ToString();
        string printColor = droprintColor1.SelectedValue.ToString();
        string paperSize = dropaperSize1.SelectedValue.ToString();
        string SingleOrDouble = droSingleOrDouble1.SelectedValue.ToString();
        string bindMethod = drobindMethod1.SelectedValue.ToString();
        string cover = drocover1.SelectedValue.ToString();
        OtherPtint ot = new OtherPtint();
        ot.UpdateQuery(Name, College, pageNum, printNum, paper, printColor, paperSize, SingleOrDouble, bindMethod, cover, Convert.ToInt32(txtID.Value));
        MsgBox.ShowMessage("修改成功！！");
        popupEdit1.ShowOnPageLoad = false;
        popupEdit.ShowOnPageLoad = false;
        gvDetail.DataBind();
        }
            catch (Exception ex)
            {
                MsgBox.ShowErrorMessage(ex.Message);
                return;
            }
    }
    protected void gvDetail_RowCommand(object sender, GridViewCommandEventArgs e)
    {

        if (e.CommandName == "PrintEdit")
        {
            int index = Convert.ToInt32(e.CommandArgument);
            txtID.Value = ((Label)gvDetail.Rows[index].FindControl("lbOrderID")).Text;
            txtName1.Text = ((Label)gvDetail.Rows[index].FindControl("lbName")).Text;
            txtpageNum1.Text = ((Label)gvDetail.Rows[index].FindControl("lbpageNum")).Text; ;
            txtPrintNum1.Text = ((Label)gvDetail.Rows[index].FindControl("lbprintNum")).Text; ;
            dropaper1.SelectedValue = ((Label)gvDetail.Rows[index].FindControl("lbpaper")).Text; ;
            droprintColor1.SelectedValue = ((Label)gvDetail.Rows[index].FindControl("lbprintColor")).Text; ;
            dropaperSize1.SelectedValue = ((Label)gvDetail.Rows[index].FindControl("lbpaperSize")).Text; ;
            droSingleOrDouble1.SelectedValue = ((Label)gvDetail.Rows[index].FindControl("lbSingleOrDouble")).Text; ;
            drobindMethod1.SelectedValue = ((Label)gvDetail.Rows[index].FindControl("lbbindMethod")).Text; ;
            drocover1.SelectedValue = ((Label)gvDetail.Rows[index].FindControl("lbcover")).Text;
            popupEdit.ShowOnPageLoad = false;
            popupEdit1.ShowOnPageLoad = true;
        }
        if (e.CommandName == "Submit")
        {
            OtherPtint ot = new OtherPtint();
            saveTime(sender, e);
            gvDetail.DataBind();
            int index = Convert.ToInt32(e.CommandArgument);

            try {
            txtID.Value = ((Label)gvDetail.Rows[index].FindControl("lbOrderID")).Text;
            ot.UpdateQuery1(txtTeacher.Value, Convert.ToInt32(txtID.Value));
            MsgBox.ShowMessage("提交成功！");
            gvDetail.DataBind();
            }
            catch (Exception ex)
            {
                MsgBox.ShowErrorMessage(ex.Message);
                return;
            }
        }
    }
    protected void saveTime(object sender, GridViewCommandEventArgs e)
    {
        // 存储交付日期
        try
        {
            int index = Convert.ToInt32(e.CommandArgument);
            txtID.Value = ((Label)gvDetail.Rows[index].FindControl("lbOrderID")).Text;
            DateTime time = Convert.ToDateTime(((TextBox)gvDetail.Rows[index].FindControl("Time")).Text);
            DateTime today = Convert.ToDateTime(DateTime.Now.ToShortDateString());
            string connectionString = ConfigurationManager.ConnectionStrings["AppConnStr"].ToString();
            string strSQL = string.Format(
"UPDATE  OtherPtint SET  getTime = '{0}',subTime = '{1}' FROM OtherPtint WHERE (ID = '{2}')", time, today, txtID.Value);
            SqlConnection conn = new SqlConnection(connectionString);
            SqlCommand cmd = new SqlCommand(strSQL, conn);
            conn.Open();
            int result = (int)cmd.ExecuteScalar();
            conn.Close();
        }
        catch (Exception ex)
        {
            MsgBox.ShowErrorMessage("请填入格式正确的日期！");
            return;
        }


    }
}