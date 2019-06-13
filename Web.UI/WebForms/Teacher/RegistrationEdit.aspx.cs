using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Text.RegularExpressions;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web;
using DevExpress.Web.ASPxEditors;

public partial class WebForms_Teacher_RegistrationEdit : System.Web.UI.Page
{
    string regID;
    string courseID;

    protected void Page_Load(object sender, EventArgs e)
    {
        regID = Request.QueryString["regID"].ToString();
        Registration rs = new Registration();
        courseID = rs.GetCourseIDByRegID(Convert.ToInt32(regID)).ToString();
        if (!IsPostBack)
        {
            FVRegistrationEdit.DataBind();
            string examTime = ((Label)FVRegistrationEdit.FindControl("lbExamTime")).Text.Trim();
            string coverage = ((Label)FVRegistrationEdit.FindControl("lbCoverage")).Text.Trim();
            string expectScore = ((Label)FVRegistrationEdit.FindControl("lbExpectScore")).Text.Trim();
            string expectTime = ((Label)FVRegistrationEdit.FindControl("lbExpectTime")).Text.Trim();
            string examPercent = ((Label)FVRegistrationEdit.FindControl("lbExamPercent")).Text.Trim();
            string TiKuorZiNi = ((Label)FVRegistrationEdit.FindControl("lbTiKuorZiNi")).Text.Trim();
            string examMothed = ((Label)FVRegistrationEdit.FindControl("lbExamMothed")).Text.Trim();
            if (TiKuorZiNi!="") ((DropDownList)FVRegistrationEdit.FindControl("DropDownList1")).Items.FindByText(TiKuorZiNi).Selected = true;
            if (examMothed!="") ((DropDownList)FVRegistrationEdit.FindControl("DropDownList2")).Items.FindByText(examMothed).Selected = true;
            string q1 = getNums(examTime, 0), q2 = getNums(examTime, 1), q3 = getNums(examTime, 2), q4 = getNums(examTime, 3);
            if (q1.Trim().Length != 0) ((DropDownList)FVRegistrationEdit.FindControl("DropDownList3")).Items.FindByText(q1).Selected = true;
            if (q2.Trim().Length != 0) ((DropDownList)FVRegistrationEdit.FindControl("DropDownList4")).Items.FindByText(q2).Selected = true;
            if (q3.Trim().Length != 0) ((DropDownList)FVRegistrationEdit.FindControl("DropDownList5")).Items.FindByText(q3).Selected = true;
            if (q4.Trim().Length != 0) ((DropDownList)FVRegistrationEdit.FindControl("DropDownList6")).Items.FindByText(q4).Selected = true;
           ((ASPxEdit)this.FVRegistrationEdit.FindControl("txt_5")).Value = getNum(coverage, 0).Trim();
           ((ASPxEdit)this.FVRegistrationEdit.FindControl("txt_6")).Value = getNum(coverage, 1).Trim();
           ((ASPxEdit)this.FVRegistrationEdit.FindControl("txt_7")).Value = getNum(coverage, 2).Trim();
           ((ASPxEdit)this.FVRegistrationEdit.FindControl("txt_8")).Value = expectTime.Split(new char[1] { '：' })[1].Trim();
           ((ASPxEdit)this.FVRegistrationEdit.FindControl("txt_9")).Value = getNumm(expectScore, 0).Trim();
           ((ASPxEdit)this.FVRegistrationEdit.FindControl("txt_10")).Value = getNumm(expectScore, 1).Trim();
           ((ASPxEdit)this.FVRegistrationEdit.FindControl("txt_11")).Value = getNumm(expectScore, 2).Trim();
           ((ASPxEdit)this.FVRegistrationEdit.FindControl("txt_12")).Value = getNumm(expectScore, 3).Trim();
           ((ASPxEdit)this.FVRegistrationEdit.FindControl("txt_13")).Value = getNumm(expectScore, 4).Trim();
           ((ASPxEdit)this.FVRegistrationEdit.FindControl("txt_14")).Value = getNum(examPercent, 0).Trim();
        }
    }
    public void save(object sender, EventArgs e)
    {
        try
        {
            SqlDataSource1.UpdateCommand = "RegPaper";
            SqlDataSource1.UpdateCommandType = SqlDataSourceCommandType.StoredProcedure;
            SqlDataSource1.UpdateParameters.Clear();
            SqlDataSource1.UpdateParameters.Add("RegID", TypeCode.String, regID);
            SqlDataSource1.UpdateParameters.Add("courseID", TypeCode.String, courseID);
            // SqlDataSource1.UpdateParameters.Add("courseID", TypeCode.String, courseID);
            ASPxEdit txtGrade = (ASPxEdit)this.FVRegistrationEdit.FindControl("txtGrade");
            ASPxEdit txtProfession = (ASPxEdit)this.FVRegistrationEdit.FindControl("txtProfession");
            string txtExamMothed = ((DropDownList)FVRegistrationEdit.FindControl("DropDownList2")).SelectedItem.Text;
            ASPxEdit txtstuNum = (ASPxEdit)this.FVRegistrationEdit.FindControl("txtstuNum");
            ASPxEdit txtExamLength = (ASPxEdit)this.FVRegistrationEdit.FindControl("txtExamLength");
            ASPxEdit txtPaper_num = (ASPxEdit)this.FVRegistrationEdit.FindControl("txtPaper_num");
            ASPxEdit txtpaper_copyNum = (ASPxEdit)this.FVRegistrationEdit.FindControl("txtpaper_copyNum");
            ASPxEdit txtWhitePaper_num = (ASPxEdit)this.FVRegistrationEdit.FindControl("txtWhitePaper_num");
            string s1 = ((DropDownList)FVRegistrationEdit.FindControl("DropDownList3")).SelectedItem.Text;
            string s2 = ((DropDownList)FVRegistrationEdit.FindControl("DropDownList4")).SelectedItem.Text;
            string s3 = ((DropDownList)FVRegistrationEdit.FindControl("DropDownList5")).SelectedItem.Text;
            string s4 = ((DropDownList)FVRegistrationEdit.FindControl("DropDownList6")).SelectedItem.Text;
            string ExamTime = "第" + s1 + "教学周周" + s2 + "第" + s3 + "节——第" + s4 + "节";
            ASPxEdit a1 = (ASPxEdit)this.FVRegistrationEdit.FindControl("txt_5");
            ASPxEdit a2 = (ASPxEdit)this.FVRegistrationEdit.FindControl("txt_6");
            ASPxEdit a3 = (ASPxEdit)this.FVRegistrationEdit.FindControl("txt_7");
            string Coverage = "基础知识基础理论所占比例：" + a1.Value.ToString() + "%;\n知识运用能力的测验所占比例：" + a2.Value.ToString() + "%;\n参考资料、课外阅读内容所占比例：" + a3.Value.ToString() + "%";
            ASPxEdit b1 = (ASPxEdit)this.FVRegistrationEdit.FindControl("txt_8");
            ASPxEdit c1 = (ASPxEdit)this.FVRegistrationEdit.FindControl("txt_9");
            ASPxEdit c2 = (ASPxEdit)this.FVRegistrationEdit.FindControl("txt_10");
            ASPxEdit c3 = (ASPxEdit)this.FVRegistrationEdit.FindControl("txt_11");
            ASPxEdit c4 = (ASPxEdit)this.FVRegistrationEdit.FindControl("txt_12");
            ASPxEdit c5 = (ASPxEdit)this.FVRegistrationEdit.FindControl("txt_13");
            string ExpectScore = "预计成绩分布：优" + c1.Value.ToString() + "%;良" + c2.Value.ToString() + "%;中等" + c3.Value.ToString() + "%;及格" + c4.Value.ToString() + "%;不及格" + c5.Value.ToString() + "%";
            ASPxEdit d1 = (ASPxEdit)this.FVRegistrationEdit.FindControl("txt_14");
            string ExamPercent = "本次考核占学期总成绩的比例：" + d1.Value.ToString() + "%";
            string ExpectTime = "预计中等学生完成答卷所需时间（分钟）：" + b1.Value.ToString();
            SqlDataSource1.UpdateParameters.Add("grade", TypeCode.String, txtGrade.Value.ToString());
            SqlDataSource1.UpdateParameters.Add("profession", TypeCode.String, txtProfession.Value.ToString());
            SqlDataSource1.UpdateParameters.Add("ExamMothed", TypeCode.String, txtExamMothed);
            SqlDataSource1.UpdateParameters.Add("stuNum", TypeCode.String, txtstuNum.Value.ToString());
            SqlDataSource1.UpdateParameters.Add("ExamLength", TypeCode.String, txtExamLength.Value.ToString());
            SqlDataSource1.UpdateParameters.Add("ExamTime", TypeCode.String, ExamTime);
            SqlDataSource1.UpdateParameters.Add("Paper_num", TypeCode.String, txtPaper_num.Value.ToString());
            SqlDataSource1.UpdateParameters.Add("Paper_copyNum", TypeCode.String, txtpaper_copyNum.Value.ToString());
            SqlDataSource1.UpdateParameters.Add("WhitePaper_num", TypeCode.String, txtWhitePaper_num.Value.ToString());
            SqlDataSource1.UpdateParameters.Add("Coverage", TypeCode.String, Coverage);
            SqlDataSource1.UpdateParameters.Add("ExpectTime", TypeCode.String, ExpectTime);//预计时间
            SqlDataSource1.UpdateParameters.Add("ExpectScore", TypeCode.String, ExpectScore);//预计考试分数
            SqlDataSource1.UpdateParameters.Add("ExamPercent", TypeCode.String, ExamPercent);//考核占比
            SqlDataSource1.Update();
            string tiku = ((DropDownList)FVRegistrationEdit.FindControl("DropDownList1")).SelectedItem.Text;
            Registration rg = new Registration();
            rg.UpdateTikuorZini(Convert.ToInt32(regID), tiku);
            MsgBox.ShowMessage("保存成功！");
        }
        catch (Exception ex)
        {
            MsgBox.ShowErrorMessage(ex.Message);
        }
    }

    protected void UpdateButton_Click(object sender, EventArgs e)
    {
        Registration rs = new Registration();
        int id = Convert.ToInt32(regID);
        int state = rs.GetStateByRegID(id);
        if (state == 1)
        {
            save(sender, e);
        }
        else if (state == 2)
        {
            save(sender, e);
            rs.UpdateState(1, id);
        }
    }
    public string getNum(string str, int i)
    {
        string[] sArray = str.Split(new char[3] { '：', ':', '%' });
        return sArray[2 * i + 1];
    }
    public string getNumm(string str, int i)
    {
        string[] sArray = str.Split(new string[] { "优", "良", "等","格", "%"}, StringSplitOptions.RemoveEmptyEntries);
        return sArray[2 * i + 1];
    }
    public string getNums(string str, int i)
    {
        string[] sArray = str.Split(new string[] { "第", "教", "周", "节" }, StringSplitOptions.RemoveEmptyEntries);
        if (i == 0 || i == 1) return sArray[2 * i];
        else return sArray[2 * i - 1];
    }
}