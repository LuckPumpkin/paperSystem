using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using SysData = System.Data;
using System.Configuration;
using System.IO;
using System.Data;
using System.Data.OleDb;

public partial class WebForms_SchoolAdministrator_CommonPrivateMng : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }


    protected void btnRefresh_Click(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["CheckConnStr"].ToString());
        conn.Open();
        //插入Week_Course_Class表，将Class大散
        Week wk = new Week();
        wk.DeleteWeekCourseClass();
        ExaminationCourse exam = new ExaminationCourse();
        exam.SetCommonOPrivateAsNull();
        SqlCommand selectCMD = new SqlCommand("select * from Week_Course_Class", conn);
        SqlCommand insertCMD = new SqlCommand("insert into Week_Course_Class(course_num,course_serialNum,course_name,class_time,class_class) values(@course_num,@course_serialNum,@course_name,@class_time,@class_class)", conn);
        SqlParameter course_num, course_serialNum, course_name, class_time, class_class;
        course_num = new SqlParameter("@course_num", "course_num");
        course_serialNum = new SqlParameter("@course_serialNum", "course_serialNum");
        course_name = new SqlParameter("@course_name", "course_name");
        class_time = new SqlParameter("@class_time", "class_time");
        class_class = new SqlParameter("@class_class", "class_class");
        course_num.SourceVersion = SysData.DataRowVersion.Current;
        course_serialNum.SourceVersion = SysData.DataRowVersion.Current;
        course_name.SourceVersion = SysData.DataRowVersion.Current;
        class_time.SourceVersion = SysData.DataRowVersion.Current;
        class_class.SourceVersion = SysData.DataRowVersion.Current;
        insertCMD.Parameters.AddRange(new SqlParameter[] { course_num, course_serialNum, course_name, class_time, class_class });
        SysData.DataTable dt = new SysData.DataTable();
        SqlDataAdapter sda = new SqlDataAdapter(selectCMD);
        sda.Fill(dt);

        Exclude ex = new Exclude();
        SysData.DataTable dtExam = ex.SelectCourseWithTypeIsNull();
        for (int i = 0; i < dtExam.Rows.Count; i++)
        {
            string classStr = dtExam.Rows[i]["class_class"].ToString();
            classStr = classStr.Replace("j", "");
            String[] temp = classStr.Split(new Char[] { ',' });
            for (int j = 0; j < temp.Length; j++)
            {
                if (temp[j] != "")
                {
                    SysData.DataRow dr = dt.NewRow();
                    dr["course_num"] = dtExam.Rows[i]["course_num"].ToString();
                    dr["course_serialNum"] = dtExam.Rows[i]["course_serialNum"].ToString();
                    dr["course_name"] = dtExam.Rows[i]["course_name"].ToString();
                    dr["class_time"] = dtExam.Rows[i]["class_time"].ToString();
                    dr["class_class"] = temp[j].Trim();
                    dr["class_campus"] = dtExam.Rows[i]["class_campus"].ToString();
                    dt.Rows.Add(dr);
                }
            }
        }
        SqlCommandBuilder scb = new SqlCommandBuilder(sda);
        //执行更新
        //dt.PrimaryKey = new DataColumn[] { dt.Columns["ID"] };
        sda.Update(dt);
        //使DataTable保存更新
        dt.AcceptChanges();
        conn.Close();
        //将视图View_CommonOrPrivate的结果导入ExaminationCourse
        SysData.DataTable Pricom = exam.GetPriCom();
        //exam.UpdateCommonOrPrivateByView();
        //exam.UpdatePrivateCollegeByView();
        for (int i = 0;i < Pricom.Rows.Count; i++)
        {
            string course_n = Pricom.Rows[i]["course_name"].ToString() + "%";
           SysData.DataTable dttexam = exam.GetExam(course_n);
           if(dttexam.Rows.Count!=0){
             exam.UpdateC(course_n);
           }
        }
        exam.Updatep();
        exam.UpdatePrivateCollegeByView();
        gvExCourse.DataBind();
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        gvExCourse.DataBind();
    }
    protected void CheckBox_CheckedChanged(object sender, EventArgs e)
    {
        if (gvExCourse.Rows.Count != 0)
        {
            if (CheckBox.Checked == true)
            {
                for (int i = 0; i < gvExCourse.Rows.Count; i++)
                {
                    (gvExCourse.Rows[i].FindControl("CheckBox") as CheckBox).Checked = true;
                }
            }
            else
            {
                for (int i = 0; i < gvExCourse.Rows.Count; i++)
                {
                    (gvExCourse.Rows[i].FindControl("CheckBox") as CheckBox).Checked = false;
                }
            }
        }
    }
    protected void mnuToolBar_ItemClick(object source, DevExpress.Web.ASPxMenu.MenuItemEventArgs e)
    {

        List<string> idList = new List<string>();
        if (gvExCourse.Rows.Count != 0)
        {
            for (int i = 0; i < gvExCourse.Rows.Count; i++)
            {
                if (((CheckBox)gvExCourse.Rows[i].FindControl("CheckBox")).Checked == true)
                {
                    string s = ((Label)gvExCourse.Rows[i].FindControl("ID")).Text;
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
            ExaminationCourse exam = new ExaminationCourse();
            string PrivateOrCommon = cboType.SelectedValue.Trim();
            for (i = 0; i < idList.Count; i++)
            {
                exam.UpdateCommonOrPrivateByID(Convert.ToInt32(idList[i]), PrivateOrCommon);
            }
        }
        popupEditCourseAttribute.ShowOnPageLoad = false;
        gvExCourse.DataBind();
    }


    protected void mnuToolBar_ItemClick1(object source, DevExpress.Web.ASPxMenu.MenuItemEventArgs e)
    {
        List<string> idList = new List<string>();
        if (gvExCourse.Rows.Count != 0)
        {
            for (int i = 0; i < gvExCourse.Rows.Count; i++)
            {
                if (((CheckBox)gvExCourse.Rows[i].FindControl("CheckBox")).Checked == true)
                {
                    string s = ((Label)gvExCourse.Rows[i].FindControl("ID")).Text;
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
            ExaminationCourse exam = new ExaminationCourse();
            string PrivateCollege = cboType0.SelectedValue.Trim();
            for (i = 0; i < idList.Count; i++)
            {
                exam.UpdatePrivateCollegeByID(Convert.ToInt32(idList[i]), PrivateCollege);
            }
        }
        popupEditCollege.ShowOnPageLoad = false;
        gvExCourse.DataBind();
    }


    //private void ExportGridViewForUTF8(GridView GridView, string filename)
    //{
    //    string attachment = "attachment; filename=" + filename;
    //    Response.ClearContent();
    //    Response.Buffer = true;
    //    Response.AddHeader("content-disposition", attachment);
    //    Response.Charset = "UTF-8";
    //    Response.ContentEncoding = System.Text.Encoding.GetEncoding("UTF-8");
    //    Response.ContentType = "application/ms-excel";
    //    System.IO.StringWriter sw = new System.IO.StringWriter();
    //    HtmlTextWriter htw = new HtmlTextWriter(sw);
    //    GridView.RenderControl(htw);
    //    Response.Output.Write(sw.ToString());
    //    Response.Flush();
    //    Response.End();
    //}



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
        UpdateTableData1(Exceldt,"ExaminationCourse");

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
    protected void btnExcel_Click(object sender, EventArgs e)
    {
        Response.ClearContent();
        Response.ContentType = "application/vnd.ms-excel";//确定类型
        string filename = "排查后课程数据.xls";
        if (Request.UserAgent.ToLower().IndexOf("msie") > -1)
            filename = Attachment.ToHexString(filename);
        //为了向客户端输出空格，需要在当客户端使用 Firefox 时特殊处理
        if (Request.UserAgent.ToLower().IndexOf("firefox") > -1)
            Response.AddHeader("Content-Disposition", "attachment;filename=\"" + filename + "\"");
        else
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + HttpUtility.UrlEncode(filename, System.Text.Encoding.UTF8)); // 下载后的文件名，一定带拓展名（例：.xls）
        StringWriter sw = new StringWriter();
        HtmlTextWriter htw = new HtmlTextWriter(sw);
        gvExCourse.RenderControl(htw);
        Response.Write("<meta http-equiv=\"content-type\" content=\"application/vnd.ms-excel; charset=utf-8\"/>" + sw.ToString());
        Response.End();

    }
    protected void btnExport_Click(object sender, EventArgs e)
    {
        try
        {
            //string physicalFileName = Server.MapPath("~/xls/11.xls");
            string physicalFileName = Server.MapPath("~/xls/" + "考试安排" + ".xls");
            string ext = Path.GetExtension(physicalFileName);
            string fileName = "考试安排"+ ext;

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
   public static DataTable GetGridDataTable(GridView grid)
      {
           DataTable dt = new DataTable();
           DataColumn dc;//创建列 
           DataRow dr; //创建行 
            //构造列 
           for (int i = 0; i < grid.Columns.Count-1; i++)
           {
               dc = new DataColumn();
               dc.ColumnName = grid.Columns[i+1].HeaderText;
               dt.Columns.Add(dc);
           }
           //构造行 
             for (int i = 1; i < grid.Rows.Count; i++)
            {
               dr = dt.NewRow();
               for (int j = 0; j < grid.Columns.Count-1; j++)
               {
                   dr[j] = grid.Rows[i].Cells[j + 1].Text.Trim() == "&nbsp;" ? "校管" : grid.Rows[i].Cells[j + 1].Text;
               }
               dt.Rows.Add(dr);
           }
             return dt;
      }
    protected void UpdateTableData1(System.Data.DataTable Exceldt, string NameOfTable)
    {
        ExaminationCourse ex = new ExaminationCourse();
        //DataTable exam = ex.GetAllData();
        try
        {
           for (int i = 0; i < Exceldt.Rows.Count; i++)
            {
                string a = Exceldt.Rows[i]["课程号"].ToString();
                ex.UpdateTypeByCoursenum(a);  
            }
           MsgBox.ShowMessage("初始化类型成功！");
        }
        catch (Exception e)
        {
            MsgBox.ShowErrorMessage(e.ToString());
            return;
        }
        
    }
    protected void btnExport_Click1(object sender, EventArgs e)
    {
        if (gvExCourse.Rows.Count > 0)
        {
            gvExCourse.AllowPaging = false;
            gvExCourse.DataBind();
            DataTable Exceldt = GetGridDataTable(gvExCourse);
            UpdateTableData(Exceldt, "ExaminationCourse");
            gvExCourse.AllowPaging = true;
            gvExCourse.DataBind();
        }
        else
        {
            MsgBox.ShowErrorMessage("没有数据可导出，请先查询数据!");
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
            MsgBox.ShowMessage("课程数据初始化成功！");
        }
        catch (Exception ex)
        {
            MsgBox.ShowErrorMessage(ex.Message);
        }
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
        // Confirms that an HtmlForm control is rendered for
    }
}