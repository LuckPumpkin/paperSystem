using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WebForms_PrintAdmin_PrintBill : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Label1.Text = "0";
        double sum = 0;
        if (gvOrder.Rows.Count >= 0)
        {
            for (int i = 0; i < gvOrder.Rows.Count; i++)
            {
                sum += Convert.ToDouble(gvOrder.Rows[i].Cells[14].Text);
            }
            Label1.Text = sum.ToString();
        }
        else if (gvOrder.Rows.Count < 0)
        {
            Label1.Text = "0";
        }

    }
    protected void gvOrder_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        gvOrder.DataBind();
        double sum = 0;
        if (gvOrder.Rows.Count >= 0)
        {
            for (int i = 0; i <= gvOrder.Rows.Count - 1; i++)
            {
                sum += Convert.ToDouble(gvOrder.Rows[i].Cells[14].Text);
            }
            Label1.Text = sum.ToString();
        }
        else if (gvOrder.Rows.Count < 0)
        {
            Label1.Text = "0";
        }


    }

    //导出为Excel
    protected void btnExcel_Click(object sender, EventArgs e)
    {
        string college = DropDownListCollege.SelectedValue.ToString();
        string filename;
        Response.ClearContent();
        Response.ContentType = "application/vnd.ms-excel";//确定类型
        if (college != "%") { 
           filename = college + "试卷结账账单.xls";
        }
        else
        {
           filename =  "全部学院试卷结账账单.xls";
        }
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