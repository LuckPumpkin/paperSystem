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

public partial class WebForms_Admin_ImportTestTable : System.Web.UI.Page
{
    List<string> idlist = new List<string>();
    public bool idlistAdd(System.Data.DataTable Exceldt)
    {
        idlist.Add("教学计划");
        idlist.Add("开课学院");
        idlist.Add("课程号");
        idlist.Add("课程名");
        idlist.Add("课序号");
        idlist.Add("课程类型");
        //idlist.Add("考试类型");
        idlist.Add("教师号");
        idlist.Add("教师");
        idlist.Add("专业课所属学院");
        idlist.Add("公共课或专业课");
        idlist.Add("班级");
        idlist.Add("课程属性");
        idlist.Add("校区");
        if (Exceldt.Columns.Count != 0 && idlist.Count >= Exceldt.Columns.Count)
        {
            bool hasa = false;
            for (int i = 0; i < Exceldt.Columns.Count; i++)
            {
                string a = Exceldt.Columns[i].ColumnName;
                if (idlist.Contains(a))
                {
                    hasa = true;
                    continue;
                }
                else
                {
                    hasa = false;
                    break;
                }
            }
            return hasa;
        }
        else
        {
            return false;
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {

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
        UpdateTableData(Exceldt, cboDocumentType.SelectedValue.Trim());
    }
    public System.Data.DataTable GetExcelDatatable(string fileUrl, string table)
    {
        //office2007之前 仅支持.xls......const string cmdText = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source={0};Extended Properties='Excel 8.0;IMEX=1';"
        //支持.xls和.xlsx，即包括office2010等版本的   HDR=Yes代表第一行是标题，不是数据；
        const string cmdText = "Provider=Microsoft.Ace.OleDb.12.0;Data Source={0};Extended Properties='Excel 12.0; HDR=Yes; IMEX=1'";
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
    protected void UpdateTableData(System.Data.DataTable Exceldt, string NameOfTable)
    {

        System.Data.DataTable Sqldt = new DataTable();//存放指定表的所有列名，并按照数据库原有的列顺序排列。。。
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["AppConnStr"].ToString());
        conn.Open();
        SqlCommand cmd = conn.CreateCommand();
        cmd.CommandText = "delete " + NameOfTable;
        Analysis a = new Analysis();
        a.DeleteAllAnalysis();
        cmd.ExecuteNonQuery();
        cmd.CommandText = "Select * FROM " + NameOfTable;
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        SqlCommandBuilder sqlCB = new SqlCommandBuilder(da);
        da.Fill(Sqldt);
        conn.Close();
            try
            {

                SqlTransaction tran = null;//声明一个事务对象  
                conn.Open();
                using (tran = conn.BeginTransaction())
                {
                    using (SqlBulkCopy copy = new SqlBulkCopy(conn, SqlBulkCopyOptions.Default, tran))
                    {
                        copy.DestinationTableName = "[dbo].[" + NameOfTable + "]";      //指定服务器上目标表的名称  
                        //列名称对应起来
                        for (int i = 0; i < Exceldt.Columns.Count; i++)
                        {
                            copy.ColumnMappings.Add(Exceldt.Columns[i].ColumnName, Sqldt.Columns[i + 1].ColumnName);
                        }
                        copy.WriteToServer(Exceldt);                                        //执行把DataTable中的数据写入DB  
                        tran.Commit();                                                      //提交事务                                   
                    }
                }

            }
            catch (Exception e)
            {
                MsgBox.ShowErrorMessage(e.ToString());
                return;
            }

            MsgBox.ShowMessage("插入成功！");
            conn.Close();
        }
    protected void btnDownloadModel_Click(object sender, EventArgs e)
    {
        try
        {
            //string physicalFileName = Server.MapPath("~/xls/11.xls");
            string physicalFileName = Server.MapPath("~/xls/" + cboDocumentType.SelectedItem.Text.Trim() + ".xls");
            string ext = Path.GetExtension(physicalFileName);
            string fileName = cboDocumentType.SelectedItem.Text.Trim() + ext;

            if (!File.Exists(physicalFileName))
                MsgBox.ShowErrorMessage("无下载模板，请联系系统管理员添加下载模板!");
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
    protected void btnInitial_Click(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["AppConnStr"].ToString());
        conn.Open();
        SqlCommand cmd = conn.CreateCommand();
        cmd.CommandText = "delete Module;delete Questiontype;delete Detail;delete Registration;delete Analysis;delete Paper;delete Course;delete ExaminationCourse;TRUNCATE TABLE Module;TRUNCATE TABLE Questiontype;DBCC CHECKIDENT ('dbo.Detail', RESEED, 0) ;TRUNCATE TABLE Registration;TRUNCATE TABLE Analysis;DBCC CHECKIDENT ('dbo.Paper', RESEED, 0) ;DBCC CHECKIDENT ('dbo.ExaminationCourse', RESEED, 0) ;DBCC CHECKIDENT ('dbo.Course', RESEED, 0) ;";
        try
        {
            cmd.ExecuteNonQuery();
        }
        catch (Exception ex)
        {
            MsgBox.ShowErrorMessage(ex.Message);
        }
        MsgBox.ShowMessage("课程数据初始化成功！");
        conn.Close();
    }
}