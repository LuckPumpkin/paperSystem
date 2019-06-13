using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using SysData = System.Data;
using System.Web.Security;
using DevExpress.Web.ASPxTabControl;

public partial class Content : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        divSchool.Attributes.Add("style", "display:none");
        divTeacher.Attributes.Add("style", "display:none");
        divProfession.Attributes.Add("style", "display:none");
        divCollege.Attributes.Add("style", "display:none");
        divPrint.Attributes.Add("style", "display:none");
        divDefault.Attributes.Add("style", "display:none");
        Registration reg = new Registration();
        Analysis ana = new Analysis();
        Paper p = new Paper();
        User us = new User();
        Teacher tea = new Teacher();
        if (!Page.IsPostBack)
        { }
            string UserCode = Convert.ToString(Session["UserCode"]);//UserCode
            string UserID = us.GetAccount(UserCode);
            SysData.DataTable dtRole = us.GetRoleName(UserCode);//角色 
            txtCollege.Value = us.GetCollege(UserCode).ToString();
            List<string> idList = new List<string>();
            if (dtRole.Rows.Count != 0)
            {
                for (int i = 0; i < dtRole.Rows.Count; i++)
                {
                    string s = dtRole.Rows[i]["RoleName"].ToString();
                    idList.Add(s);
                }
            }
            if (!(idList.Contains("教师")) && !(idList.Contains("系级管理员")) && !(idList.Contains("院级管理员")) && !(idList.Contains("打印部")) && !(idList.Contains("校级管理员")))
            {
                divDefault.Attributes.Add("style", "display:none");
            }
            if (idList.Contains("教师"))
            {
                int a1 = reg.GetRegNum(UserID);
                int a2 = ana.GetAnaNum(UserID);
                int a3 = p.GetResNum(UserID);
                divTeacher.Attributes["style"] = "display:''";
                if (a1 == 0 && a2 == 0 && a3==0)
                {
                    divTeacher.InnerText = "★无未提交任务！";
                    divTeacher.Attributes["style"] = "font-size: medium;"; 
                }
                if (a1 != 0 && a2 == 0 && a3==0)
                {
                    lbreg.Text = Convert.ToString(a1);
                    (divTeacher.FindControl("p2")).Visible = false;
                    (divTeacher.FindControl("p6")).Visible = false;
                }
                if (a1 == 0 && a2 != 0 && a3==0)
                {
                    (divTeacher.FindControl("p1")).Visible = false;
                    lbana.Text = Convert.ToString(a2);
                    (divTeacher.FindControl("p6")).Visible = false;
                }
                if (a1 == 0 && a2 == 0 && a3 != 0)
                {
                    (divTeacher.FindControl("p1")).Visible = false;
                    (divTeacher.FindControl("p2")).Visible = false;
                    lbres.Text = Convert.ToString(a3);   
                }
                if (a1 != 0 && a2 != 0 && a3 == 0)
                {
                    lbreg.Text = Convert.ToString(a1);
                    lbana.Text = Convert.ToString(a2);
                    (divTeacher.FindControl("p6")).Visible = false;
                }
                if (a1 != 0 && a2 == 0 && a3 != 0)
                {
                    lbreg.Text = Convert.ToString(a1);
                    (divTeacher.FindControl("p2")).Visible = false;
                    lbres.Text = Convert.ToString(a3);
                }
                if (a1 == 0 && a2 != 0 && a3 != 0)
                {
                    (divTeacher.FindControl("p1")).Visible = false;
                    lbana.Text = Convert.ToString(a2);
                    lbres.Text = Convert.ToString(a3);
                }
                if (a1 != 0 && a2 != 0 && a3 !=0)
                {
                    lbreg.Text = Convert.ToString(a1);
                    lbana.Text = Convert.ToString(a2);
                    lbres.Text = Convert.ToString(a3);
                }
            }
            if (idList.Contains("系级管理员"))
            {
                divProfession.Attributes["style"] = "display:''";
                txtPro.Value = tea.GetProByUserCode(UserCode);
                int b1 = reg.GetRegNumAduit(txtPro.Value);
                int b2 = ana.GetAnaNumAd(txtPro.Value);
                int b3 = ana.ScalarQuery1(txtPro.Value);
                if (b3 != 0)
                {
                    (divProfession.FindControl("p8")).Visible = true;
                    lbanaii.Text = Convert.ToString(b3);
                 }
                if (b1 == 0 && b2 == 0)
                {
                    divProfession.InnerText = "★无未审核任务！";
                    divProfession.Attributes["style"] = "font-size: medium;"; 
                }
                if (b1 != 0 && b2 == 0)
                {
                    lbredaduit.Text = Convert.ToString(b1);
                    (divProfession.FindControl("p4")).Visible = false;
                }
                if (b1 == 0 && b2 != 0)
                {
                    (divProfession.FindControl("p3")).Visible = false;
                    lbanaaduit.Text = Convert.ToString(b2);
                } if (b1 != 0 && b2 != 0)
                {
                    lbredaduit.Text = Convert.ToString(b1);
                    lbanaaduit.Text = Convert.ToString(b2);
                }
            }
            if (idList.Contains("院级管理员"))
            {
                int c1 = ana.Select1(txtCollege.Value);
                int c = reg.GetRegCoAduit(txtCollege.Value);
                divCollege.Attributes["style"] = "display:''";
                if (c != 0 && c1 !=0)
                {
                    lbregaduit.Text = Convert.ToString(c);
                    lbanai.Text = Convert.ToString(c1);
                }
                if (c != 0 && c1 == 0)
                {
                    lbregaduit.Text = Convert.ToString(c);
                    (divCollege.FindControl("p7")).Visible = false;
                }
                if (c == 0 && c1 != 0)
                {
                    lbanai.Text = Convert.ToString(c1);
                    (divCollege.FindControl("p5")).Visible = false;
                }
                if(c==0 && c1 ==0)
                {
                    divCollege.InnerText = "★无未审核任务！本学院无试卷未分析任务！！";
                    divCollege.Attributes["style"] = "font-size: medium;"; 
                }
            }
            if (idList.Contains("打印部"))
            {
                int d = p.GetPaperNum();
                divPrint.Attributes["style"] = "display:''";
                if (d!= 0)
                {
                    lbpaper.Text = Convert.ToString(d);
                }
                else
                {
                    divPrint.InnerText = "★无未打印样卷！";
                    divPrint.Attributes["style"] = "font-size: medium;"; 
                }
            }
             if (idList.Contains("校级管理员"))
            {
                 divSchool.Attributes["style"] = "display:'block'";
            }
    }
    protected void Show_Click(object sender, EventArgs e)
    {
        popupTeacherDetail.ContentUrl="/../WebForms/Common/anaDetail.aspx?College=" + txtCollege.Value;
        popupTeacherDetail.ShowOnPageLoad = true;
    }
}                         