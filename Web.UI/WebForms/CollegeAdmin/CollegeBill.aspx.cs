using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

public partial class WebForms_CollegeAdmin_CollegeBill : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            txtTeacherId.Value = Convert.ToString(Session["UserCode"]);
            User us = new User();
            txtAccount.Value = us.GetAccount(txtTeacherId.Value);
            txtBranch.Value = us.GetCollege(txtTeacherId.Value);
        }
        double sum = 0;
        if (gvOrder.Rows.Count >= 0)
        {
            for (int i = 0; i <= gvOrder.Rows.Count - 1 ; i++)
            {
                sum += Convert.ToDouble(gvOrder.Rows[i].Cells[13].Text);
            }
            Label1.Text = sum.ToString();
        }
        else if (gvOrder.Rows.Count < 0)
        {
            Label1.Text = "0";
        }
    }
    protected void btnExcel_Click(object sender, EventArgs e)
    {
        Response.ClearContent();
        Response.ContentType = "application/vnd.ms-excel";//确定类型
        var filename = txtBranch.Value + "试卷结账账单.xls";
        if (Request.UserAgent.ToLower().IndexOf("msie") > -1)
            filename = Attachment.ToHexString(filename);
        //为了向客户端输出空格，需要在当客户端使用 Firefox 时特殊处理
        if (Request.UserAgent.ToLower().IndexOf("firefox") > -1)
            Response.AddHeader("Content-Disposition", "attachment;filename=\"" + filename + "\"");
        else
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + HttpUtility.UrlEncode(filename, System.Text.Encoding.UTF8)); // 下载后的文件名，一定带拓展名（例：.xls）
        StringWriter sw = new StringWriter();
        HtmlTextWriter htw = new HtmlTextWriter(sw);
        gvOrder.RenderControl(htw);
        Response.Write("<meta http-equiv=\"content-type\" content=\"application/vnd.ms-excel; charset=utf-8\"/>" + sw.ToString());
        Response.End();

    }
    //此方法需要重写，否则报错
    public override void VerifyRenderingInServerForm(Control control)
    {

    }

}