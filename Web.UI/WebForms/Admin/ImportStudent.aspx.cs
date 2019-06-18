using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data.SqlClient;
using SysData = System.Data;
using Microsoft.Office.Interop.Excel;
using System.Configuration;


public partial class WebForms_Admin_ImportStudent : System.Web.UI.Page
{
    private List<int> lst = new List<int>();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            List<FieldItem> initialFields = new List<FieldItem>();

            //-- 可用于导入的字段
            initialFields.Add(new FieldItem("Account", "工号", SqlDbType.NVarChar, 40, true, false));
            initialFields.Add(new FieldItem("Name", "姓名", SqlDbType.NVarChar, 20, true, false));
            initialFields.Add(new FieldItem("Sex", "性别", SqlDbType.NVarChar, 2, false, true));
            initialFields.Add(new FieldItem("College", "学院", SqlDbType.NVarChar, 50, false, true));
            initialFields.Add(new FieldItem("Tel", "电话", SqlDbType.NVarChar, 50, false, true));
            
            //initialFields.Add(new FieldItem("Profession", "专业", SqlDbType.NVarChar, 30, false, true));
            

            //-- 内部使用，不可导入
            initialFields.Add(new FieldItem("UserCode", "用户编号", SqlDbType.NVarChar, 40, false, false, false));

            ImportStudent.InitDataImporter("Teacher", "教师", initialFields);

        }

        ImportStudent.InsertCommandGenerating += StudentDataImporter_InsertCommandGenerating;
        ImportStudent.InsertCommandGenerated += StudentDataImporter_InsertCommandGenerated;
        ImportStudent.DataInserting += StudentDataImporter_DataInserting;
        ImportStudent.DataUpdating += StudentDataImporter_DataUpdating;
        ImportStudent.DataImportProgress += StudentDataImporter_DataImportProgress;
    }
    protected void btnExcel_Click(object sender, EventArgs e)
    {
        Response.ClearContent();
        Response.ContentType = "application/vnd.ms-excel";//确定类型
        string filename = "教师信息.xls";
        if (Request.UserAgent.ToLower().IndexOf("msie") > -1)
            filename = Attachment.ToHexString(filename);
        //为了向客户端输出空格，需要在当客户端使用 Firefox 时特殊处理
        if (Request.UserAgent.ToLower().IndexOf("firefox") > -1)
            Response.AddHeader("Content-Disposition", "attachment;filename=\"" + filename + "\"");
        else
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + HttpUtility.UrlEncode(filename, System.Text.Encoding.UTF8)); // 下载后的文件名，一定带拓展名（例：.xls）
        StringWriter sw = new StringWriter();
        HtmlTextWriter htw = new HtmlTextWriter(sw);
        gvSysAdmin.RenderControl(htw);
        Response.Write("<meta http-equiv=\"content-type\" content=\"application/vnd.ms-excel; charset=utf-8\"/>" + sw.ToString());
        Response.End();

    }
    private void StudentDataImporter_DataImportProgress(object sender, DataImportProgressEventArgs e)
    {

        switch (e.EventType)
        {
            case DataImportProgressEventType.Begin:
                lst = new List<int>();
                for (int i = 1; i <= 100; i++)
                    if (i % 5 == 0 || i <= 3)
                        lst.Add(i);
                beginProgress();
                break;
            case DataImportProgressEventType.SetProgress:
                if (lst.Contains(e.Progress))
                {
                    setProgress(e.Progress);
                    lst.Remove(e.Progress);
                }
                break;
            case DataImportProgressEventType.Complete:
                finishProgress();
                break;
            case DataImportProgressEventType.Info:
                setInfo(e.Message);
                break;
            case DataImportProgressEventType.Error:
                setErrorMsg(e.Message);
                break;
        }
    }

    void StudentDataImporter_DataUpdating(object sender, DataImportEventArgs e)
    {
        string Account, UserCode, Name;
        if (!e.fieldValues.ContainsKey("Account"))
            return;

        Account = e.fieldValues["Account"].ToString();
        UserCode = ImportStudents.GetUserIdBySno(Account);

        if (e.fieldValues.ContainsKey("Name"))
        {
            Name = e.fieldValues["Name"].ToString();
            ImportStudents.UpdateUserName(Name, UserCode);
        }
    }

    void StudentDataImporter_InsertCommandGenerating(object sender, SqlGenerateEventArgs e)
    {
        e.fields.Add("UserCode");
    }

    void StudentDataImporter_InsertCommandGenerated(object sender, SqlGenerateEventArgs e)
    {
        e.fields.Remove("UserCode");
    }

    void StudentDataImporter_DataInserting(object sender, DataImportEventArgs e)
    {
        string UserCode, UserNum, Name, College, Sex,Tel;
        bool IsAvailable, IsDelete, IsLockOut;
        DateTime UserCreateTime = DateTime.Now;
        //string Password = Membership.GeneratePassword(6, 2);
        string Password = "123";
        UserCode = Guid.NewGuid().ToString();
        e.fieldValues.Add("UserCode", UserCode);
        UserNum = e.fieldValues["Account"].ToString();
        if (e.fieldValues.ContainsKey("Name"))
            Name = e.fieldValues["Name"].ToString();
        else
            Name = "";
        if (e.fieldValues.ContainsKey("Sex"))
            Sex = e.fieldValues["Sex"].ToString();
        else
            Sex = "";
        if (e.fieldValues.ContainsKey("College"))
            College = e.fieldValues["College"].ToString();
        else
            College = "";
        if (e.fieldValues.ContainsKey("Tel"))
            Tel = e.fieldValues["Tel"].ToString();
        else
            Tel = "";
        
        IsAvailable = true;
        IsDelete = false;
        IsLockOut = false;
        int BranchID = Convert.ToInt32(ImportStudents.GetBranchIDbyBranchName(College));
        ImportStudents.AddUser(UserCode, UserNum, Name, Password, IsLockOut, IsDelete, IsAvailable, UserCreateTime,Sex,BranchID);
        ImportStudents.AddUserInRoles("4", UserCode);
    }
    protected void btnInitial_Click(object sender, EventArgs e)
    {
        try { 
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["AppConnStr"].ToString());
        conn.Open();
        SqlCommand cmd = conn.CreateCommand();
        cmd.CommandText = "delete Teacher;delete UsersInRoles;delete [User];TRUNCATE TABLE UsersInRoles;Insert into [User] values('4','3591','125','闫海波',null,null,null,null,'123',null,null,null,null,null,null,null,'男');insert into [Teacher] values('3591','闫海波','机关','男',null,'4',null,null);Insert into [UsersInRoles] values('1','4')";
        cmd.ExecuteNonQuery();
        MsgBox.ShowMessage("用户数据初始化成功！");
        conn.Close();
        }
        catch(Exception ex)
        {
            MsgBox.ShowErrorMessage(ex.Message);
        }
    }


    #region ProgressProcess

    private void beginProgress()
    {
        //根据ProgressBar.htm显示进度条界面
        string templateFileName = Server.MapPath("ProgressBar.htm");
        StreamReader reader = new StreamReader(@templateFileName, System.Text.Encoding.GetEncoding("GB2312"));
        string html = reader.ReadToEnd();
        reader.Close();
        Response.Write(html);
        Response.Flush();
    }

    private void setProgress(int percent)
    {
        string jsBlock = "<script>SetPorgressBar('" + percent.ToString() + "'); </script>\r\n";
        Response.Write(jsBlock);
        Response.Flush();
    }

    private void finishProgress()
    {
        string jsBlock = "<script>SetCompleted();</script>\r\n";
        Response.Write(jsBlock);
        Response.Flush();
    }

    private void setInfo(string Message)
    {
        string jsBlock = string.Format("<p>{0}</p>\r\n", Message);
        Response.Write(jsBlock);
        Response.Write("<p><a href='Default.aspx'>返回</a></p>");
        Response.Write("\r\n</body>\r\n</html>");
        Response.Flush();
        Response.End();
    }

    private void setErrorMsg(string Message)
    {
        Response.Write(Message);
        Response.Write("\r\n</body>\r\n</html>");
        Response.Flush();
        Response.End();
    }

    #endregion
    public override void VerifyRenderingInServerForm(Control control)
    {

    }
}