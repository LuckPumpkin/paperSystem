using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.IO;

public partial class WebForms_SchoolAdmin_SResitMng : System.Web.UI.Page
{
    List<string> idlist = new List<string>();
    public bool idlistAdd(DataSet Exceldt)
    {
        idlist.Add("课程号");
        idlist.Add("补考人数");
        idlist.Add("取卷日期");
        if (Exceldt.Tables[0].Columns.Count != 0 && idlist.Count >= Exceldt.Tables[0].Columns.Count)
        {
            bool hasa = false;
            for (int i = 0; i < Exceldt.Tables[0].Columns.Count; i++)
            {

                string a = Exceldt.Tables[0].Columns[i].ToString();
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
    public DataSet ExecleDs(string filenameurl, string table)
    {
        string strConn = "Provider=Microsoft.Ace.OleDb.12.0;" + "data source=" + filenameurl + ";Extended Properties='Excel 12.0; HDR=YES; IMEX=1'";
        OleDbConnection conn = new OleDbConnection(strConn);
        OleDbDataAdapter odda = new OleDbDataAdapter("select * from [sheet1$]", conn);
        DataSet ds = new DataSet();
        odda.Fill(ds, table);
        return ds;
    }
    protected void btnDown_Click(object sender, EventArgs e)
    {
        string strResult = string.Empty;
        string strPath = Server.MapPath("~/xls/");
        string filename = "补考信息.xls";
        string strFile = string.Format(@"{0}\{1}", strPath, filename);
        if (strFile == "")
        {
            MsgBox.ShowErrorMessage("无下载模板，请联系系统管理员添加下载模板!");
        }
        else
        {
            try { 
            using (FileStream fs = new FileStream(strFile, FileMode.Open))
            {
                byte[] bytes = new byte[(int)fs.Length];
                fs.Read(bytes, 0, bytes.Length);
                fs.Close();
                Response.ContentType = "application/octet-stream";
                if (Request.UserAgent.ToLower().IndexOf("msie") > -1)
                    filename = Attachment.ToHexString(filename);

                //为了向客户端输出空格，需要在当客户端使用 Firefox 时特殊处理
                if (Request.UserAgent.ToLower().IndexOf("firefox") > -1)
                    Response.AddHeader("Content-Disposition", "attachment;filename=\"" + filename + "\"");
                else
                    Response.AppendHeader("Content-Disposition", "attachment; filename=" + HttpUtility.UrlEncode(filename, System.Text.Encoding.UTF8));
                Response.BinaryWrite(bytes);
                Response.Flush();
                MsgBox.ShowMessage("补考信息上传成功!");
            }
            }
            catch (Exception ex)
            {
                MsgBox.ShowErrorMessage(ex.Message);
            }
        }
    }
    protected void btnImport_Click(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection("Data Source=(local);Initial Catalog=PaperDB;Persist Security Info=True;Trusted_Connection=true");
        conn.Open();
        string Sqlstrl = " update Paper set flag=NULL,paper_state=NULL,paper_copyNum=NULL,getTime=NULL,submitTime= NULL,print_type=NULL,paper_uintPrice=NULL,whitePaper_unitPrice=NULL where ((flag like '补考') or (flag is null))";
        SqlCommand comd = new SqlCommand(Sqlstrl, conn);
        comd.ExecuteNonQuery();
        if (files.HasFile == false)
        {
            MsgBox.ShowErrorMessage("请您选择Excel文件!");
            return;//当无文件时,返回       
        }
        String serverPath = Server.MapPath(("~/") + files.FileName);
        files.SaveAs(serverPath);
        string error = null;
        string filename = files.FileName;                       //获取Execle文件名         
        DataSet dd = ExecleDs(serverPath, filename);
        if (idlistAdd(dd))
        {
            DataRow[] dr = dd.Tables[0].Select();                        //定义一个DataRow数组       
            int rowsnum = dd.Tables[0].Rows.Count;
            if (rowsnum == 0)
            {
                MsgBox.ShowErrorMessage("Excel表为空表,无数据!"); //当Excel表为空时,对用户进行提示      
            }
            else
            {

                int copy;
                string cno;
                DateTime gtime;
                int cid;
                for (int i = 0; i < dr.Length; i++)
                {
                    cno = dr[i][0].ToString();
                    try
                    {
                    Course co = new Course();
                    cid = co.GetIDByCourseNo(cno);
                    copy = Convert.ToInt32(dr[i][1].ToString());
                    gtime = Convert.ToDateTime(dr[i][2].ToString());
                    string updatestr = "update Paper set paper_state='试卷草稿',flag = '补考',paper_copyNum='" + copy + "',getTime='" + gtime + "' where (courseID='" + cid + "') and (flag is null)";
                    SqlCommand cmd = new SqlCommand(updatestr, conn);
                   
                        cmd.ExecuteNonQuery();
                    }
                    catch (MembershipCreateUserException ex) //捕捉异常                    
                    {
                        MsgBox.ShowErrorMessage("有不符合规定的字符串，请重新输入");
                    }
                }
                MsgBox.ShowMessage("导入成功");
                System.IO.File.Delete(serverPath);
                Response.Redirect("SResitMng.aspx");

            }
            conn.Close();
        }
        else
        {
            MsgBox.ShowErrorMessage("输入Excel内容格式不正确，请下载模板查看正确格式!");
            return;
        }
    }

}
