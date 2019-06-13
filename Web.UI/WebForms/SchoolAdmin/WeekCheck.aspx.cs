using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using SysData=System.Data;
using Microsoft.Office.Interop.Excel;
using System.Configuration;

public partial class WebForms_SchoolAdministrator_WeekCheck : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected int CourseWeek(string timeStr)
    {
        int max = int.MinValue;
        if(timeStr !="")
        {
            string maxTeachingWeek = "17";
            //-- 周五5 - 6节（2,6,10-12周上）、周五1 - 2节（1-3,5-7,10-17周上）、周四3 - 4节（2,6,10,12周上）
            string[] segments = timeStr.Split(new char[] { '、' });
            foreach (string segment in segments)
            {
                //-- 周五5 - 6节（2,6,10-12周上）
                string sweeks = segment.Substring(segment.IndexOf("（"));
                sweeks = sweeks.Replace("全周上课", maxTeachingWeek);
                sweeks = sweeks.Replace("第", "");
                sweeks = sweeks.Replace("周", "");
                sweeks = sweeks.Replace("上", "");
                sweeks = sweeks.Replace("（", "");
                sweeks = sweeks.Replace("）", "");
                //-- 2,6,10-12
                sweeks = sweeks.Replace(")", "");
                string[] weeks = sweeks.Split(new char[] { ',', '-', '－' ,'('}, StringSplitOptions.RemoveEmptyEntries);

                foreach (string week in weeks)
                {
                    if (max < int.Parse(week))
                        max = int.Parse(week);
                }
            }
        }
        return max;
    }
    protected void ProcessWeek()
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["CheckConnStr"].ToString());
        conn.Open();
        SqlCommand selectCMD = new SqlCommand("select * from Process", conn);
        SysData.DataTable dt = new SysData.DataTable();
        SqlDataAdapter sda = new SqlDataAdapter(selectCMD);
        sda.Fill(dt);

        for (int i = 0; i < dt.Rows.Count; i++)
        {
            string s = dt.Rows[i]["remark"].ToString();
            string c = dt.Rows[i]["class"].ToString().Trim();
            int index = s.IndexOf("考试");
            if (index > 0)
            {
                string tag = s.Substring(index - 4, 2);
                dt.Rows[i]["tagRemark"] = tag;
                for (int j = 1; j < 25; j++)
                {
                    string columnName = j.ToString();
                    string weekStr = dt.Rows[i][columnName].ToString();
                    if (weekStr.Contains(tag))
                    {
                        dt.Rows[i]["ExamWeek"] = j.ToString();
                    }
                }
            }   
        }
        SqlCommandBuilder scb = new SqlCommandBuilder(sda);
        //执行更新
        dt.PrimaryKey = new SysData.DataColumn[] { dt.Columns["ID"] };
        sda.Update(dt);
        //使DataTable保存更新
        dt.AcceptChanges();
        conn.Close();
    }

    
    

    protected void btnComputeCourseWeek_Click(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["CheckConnStr"].ToString());
        conn.Open();
        SqlCommand selectCMD = new SqlCommand("select * from Week_Course_Class", conn);
        SysData.DataTable dt = new SysData.DataTable();
        SqlDataAdapter sda = new SqlDataAdapter(selectCMD);
        sda.Fill(dt);

        for (int i = 0; i < dt.Rows.Count; i++)
        {
            if (dt.Rows[i]["class_time"] != null)
            {
                dt.Rows[i]["course_week"] = CourseWeek(dt.Rows[i]["class_time"].ToString().Trim());
            }
        }
        SqlCommandBuilder scb = new SqlCommandBuilder(sda);
        //执行更新
        dt.PrimaryKey = new SysData.DataColumn[] { dt.Columns["ID"] };
        sda.Update(dt);
        //使DataTable保存更新
        dt.AcceptChanges();
        conn.Close();
        gvExCourse.DataBind();
    }
    protected void btnRefreshPress_Click(object sender, EventArgs e)
    {
        ProcessWeek();
    }
    protected void btnComputeClassWeek_Click(object sender, EventArgs e)
    {
        Week wk = new Week();
        wk.UpdateClassWeekByProcess();
        gvExCourse.DataBind();
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        gvExCourse.DataBind();
    }

    //判断是否为数字（48-57）
    protected bool bolNum(string temp)
    {
        for(int i=0;i<temp.Length;i++)
        {
            byte tempByte = Convert.ToByte(temp[i]);
            if ((tempByte < 48) || (tempByte > 57))
                return false;
        }
        return true;
    }
    class countClass
    {
        public int week;
        public int count;
    }; 
    protected void btnComputeTestWeek_Click(object sender, EventArgs e)
    {
        Week wk = new Week();
        SysData.DataTable dtWeek = wk.SelectAllWeek();
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["CheckConnStr"].ToString());
        conn.Open();
        SqlCommand selectCMD = new SqlCommand("select * from ExaminationCourse where type is null", conn);
        SysData.DataTable dt = new SysData.DataTable();
        SqlDataAdapter sda = new SqlDataAdapter(selectCMD);
        sda.Fill(dt);

        for (int i = 0; i < dt.Rows.Count; i++)
        {
            List<countClass> list = new List<countClass>();
            for(int j=0;j<dtWeek.Rows.Count;j++)
            {
                if(dtWeek.Rows[j]["course_num"].ToString().Trim()==dt.Rows[i]["course_num"].ToString().Trim() && dtWeek.Rows[j]["class_week"]!=DBNull.Value && bolNum((dtWeek.Rows[j]["class_week"].ToString().Trim())))
                {
                    bool flag = true;
                    for (int m = 0; m < list.Count; m++)
                    {
                        if (list[m].week == Convert.ToInt32(dtWeek.Rows[j]["class_week"].ToString().Trim()))
                        {
                            flag = false;
                            list[m].count = list[m].count + 1;
                        }
                    }
                    if (flag)
                    {
                        countClass c = new countClass();
                        c.week = Convert.ToInt32(dtWeek.Rows[j]["class_week"].ToString().Trim());
                        c.count = 1;
                        list.Add(c);
                    }
                }
            }
            int maxCount=-1;
            int maxWeek=-1;
            for(int n =0;n<list.Count;n++)
            {
                if(list[n].count>maxCount)
                {
                    maxCount=list[n].count;
                    maxWeek=list[n].week;
                }
            }
            dt.Rows[i]["test_week"] = maxWeek;
        }
        SqlCommandBuilder scb = new SqlCommandBuilder(sda);
        //执行更新
        dt.PrimaryKey = new SysData.DataColumn[] { dt.Columns["ID"] };
        sda.Update(dt);
        //使DataTable保存更新
        dt.AcceptChanges();
        conn.Close();
        wk.UpdateTestWeekByExamCourse();
        wk.UpdateTestWeekByClassWeekIsNull();
        gvExCourse.DataBind();
    }

    private void ExportGridViewForUTF8(GridView GridView, string filename)
    {
        string attachment = "attachment; filename=" + filename;
        Response.ClearContent();
        Response.Buffer = true;
        Response.AddHeader("content-disposition", attachment);
        Response.Charset = "UTF-8";
        Response.ContentEncoding = System.Text.Encoding.GetEncoding("UTF-8");
        Response.ContentType = "application/ms-excel";
        System.IO.StringWriter sw = new System.IO.StringWriter();
        HtmlTextWriter htw = new HtmlTextWriter(sw);
        GridView.RenderControl(htw);
        Response.Output.Write(sw.ToString());
        Response.Flush();
        Response.End();
    }

    protected void btnExport_Click1(object sender, EventArgs e)
    {
        if (gvExCourse.Rows.Count > 0)
        {
            gvExCourse.AllowPaging = false;
            gvExCourse.DataBind();
            ExportGridViewForUTF8(gvExCourse, DateTime.Now.ToShortDateString() + ".xls");
            gvExCourse.AllowPaging = true;
            gvExCourse.DataBind();
        }
        else
        {
            // obo.Common.MessageBox.Show(this, "没有数据可导出，请先查询数据!");
        }
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
        // Confirms that an HtmlForm control is rendered for
    }

}