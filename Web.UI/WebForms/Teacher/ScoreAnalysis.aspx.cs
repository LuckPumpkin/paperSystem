using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using System.Text;
using System.Text.RegularExpressions;

public partial class WebForms_Teacher_ScoreAnalysis : System.Web.UI.Page
{
    int anaID;
    protected void Page_Load(object sender, EventArgs e)
    {
        anaID = Convert.ToInt32(Request.QueryString["anaID"].ToString());
    }
    protected void btnImport_Click(object sender, EventArgs e)
    {
        var files = Request.Files;
        try
        {
            for (int i = 0; i < files.Count; i++)
            {
                HttpPostedFile postedFile = files[i];
                string fileName = System.IO.Path.GetFileName(postedFile.FileName);
                string fileExtension = System.IO.Path.GetExtension(fileName);    //获取文件类型 
                if (fileExtension == ".xls" || fileExtension == ".xlsx")
                {
                    postedFile.SaveAs(Server.MapPath("~/xls/11.xls"));
                }
                else
                {
                    MsgBox.ShowErrorMessage("请导入正确Excel格式文件!");
                    return;
                }
            }
        }
        catch (Exception ex)
        {
            MsgBox.ShowErrorMessage(ex.Message);
            return;
        }
        string FilePath = Server.MapPath("~/xls/11.xls");
        DataTable Exceldt = GetExcelDatatable(FilePath, "mapTable");
        UpdateTableData(Exceldt);
    }
    public System.Data.DataTable GetExcelDatatable(string fileUrl, string table)
    {
        //office2007之前 仅支持.xls......const string cmdText = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source={0};Extended Properties='Excel 8.0;IMEX=1';"
        //支持.xls和.xlsx，即包括office2010等版本的   HDR=Yes代表第一行是标题，不是数据；
        const string cmdText = "Provider=Microsoft.Ace.OleDb.12.0;Data Source={0};Extended Properties='Excel 12.0; HDR=No; IMEX=1'";
        System.Data.DataTable dt = null;
        OleDbConnection conn = new OleDbConnection(string.Format(cmdText, fileUrl));
        try
        {
            if (conn.State == ConnectionState.Broken || conn.State == ConnectionState.Closed)
            {
                conn.Open();
            }
            System.Data.DataTable schemaTable = conn.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);
            //获取Excel的第一个Sheet名称
            string sheetName = schemaTable.Rows[0]["TABLE_NAME"].ToString().Trim();
            //查询sheet中的数据
            string strSql = "select * from [" + sheetName + "]";
            OleDbDataAdapter da = new OleDbDataAdapter(strSql, conn);
            DataSet ds = new DataSet();
            da.Fill(ds, table);
            dt = ds.Tables[0];
            return dt;
        }
        catch (Exception exc)
        {
            throw exc;
        }
        finally
        {
            conn.Close();
            conn.Dispose();
        }
    }
    protected void UpdateTableData(System.Data.DataTable Exceldt)
    {
        int less60 = 0;
        int In60_70 = 0;
        int In70_80 = 0;
        int In80_90 = 0;
        int more90 = 0;
        float max = 0;
        float min = 1000;
        float sum = 0;
        if (Exceldt.Columns.Count != 0 && Exceldt.Rows.Count != 0)
        {
            if (Exceldt.Columns.Count == 1) { 
            for (int i = 0; i < Exceldt.Rows.Count; i++)
            {
                if (HasChinese(Exceldt.Rows[i][0].ToString().Trim()))
                {
                    MsgBox.ShowErrorMessage("含有中文！");
                    return;
                }
                if (bolNum(Exceldt.Rows[i][0].ToString().Trim()))
                {
                    if (Convert.ToInt32(Exceldt.Rows[i][0].ToString().Trim()) < 60)
                    {
                        less60++;
                    }
                    else if (60 < Convert.ToInt32(Exceldt.Rows[i][0].ToString()) && Convert.ToInt32(Exceldt.Rows[i][0].ToString()) < 70)
                    {
                        In60_70++;
                    }
                    else if (70 < Convert.ToInt32(Exceldt.Rows[i][0].ToString()) && Convert.ToInt32(Exceldt.Rows[i][0].ToString()) < 80)
                    {
                        In70_80++;
                    }
                    else if (80 < Convert.ToInt32(Exceldt.Rows[i][0].ToString()) && Convert.ToInt32(Exceldt.Rows[i][0].ToString()) < 90)
                    {
                        In80_90++;
                    }
                    else more90++;
                    if (Convert.ToInt32(Exceldt.Rows[i][0].ToString().Trim()) > max)
                    {
                        max = Convert.ToInt32(Exceldt.Rows[i][0].ToString().Trim());
                    }
                    if (Convert.ToInt32(Exceldt.Rows[i][0].ToString().Trim()) < min)
                    {
                        min = Convert.ToInt32(Exceldt.Rows[i][0].ToString().Trim());
                    }
                    sum += Convert.ToInt32(Exceldt.Rows[i][0].ToString().Trim());
                    MsgBox.ShowMessage("导入成功！");
                }
                else
                {
                    MsgBox.ShowErrorMessage("输入非数据类型！");
                    return;
                }
            }
            }
            else
            {
                MsgBox.ShowErrorMessage("导入Excel为单列成绩，请修改格式后重新导入！");
                return;
            }
        }
        else
        {
            MsgBox.ShowErrorMessage("导入Excel为空，请重新导入！");
            return;
        }
        float aveScore = sum / Exceldt.Rows.Count;
        int ana_num = Exceldt.Rows.Count;
        Analysis ana = new Analysis();
        ana.UpdateScore(aveScore, ana_num, less60, In60_70, In70_80, In80_90, more90, max, min, anaID);
    }
    //判断是否为数字（48-57）
    protected bool bolNum(string temp)
    {
        for (int i = 0; i < temp.Length; i++)
        {
            //byte tempByte = Encoding.UTF8.GetBytes(temp[i].ToString());
            byte tempByte = Convert.ToByte(Convert.ToChar(temp[i].ToString()));
            if ((tempByte < 48) || (tempByte > 57))
                return false;
        }
        return true;
    }
    public bool HasChinese(string str)
    {
        return Regex.IsMatch(str, @"[\u4e00-\u9fa5]");
    }

}