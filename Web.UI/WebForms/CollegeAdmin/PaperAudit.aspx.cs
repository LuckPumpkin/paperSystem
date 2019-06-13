using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.IO;
using iTextSharp.text.pdf;
using SysData = System.Data;

public partial class WebForms_ProfessionAdmin_PaperAudit : System.Web.UI.Page
{
    Paper p = new Paper();
    Registration reg = new Registration();
    State st = new State();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            txtTeacherID.Value = Convert.ToString(Session["UserCode"]);
            User us =new User();
            txtCollege.Value = us.GetCollege(txtTeacherID.Value).ToString();
        }
    }
    //全选
    protected void CheckBox_CheckedChanged(object sender, EventArgs e)
    {
        if (gvCourse.Rows.Count != 0)
        {
            if (CheckBox.Checked == true)
            {
                for (int i = 0; i < gvCourse.Rows.Count; i++)
                {
                    (gvCourse.Rows[i].FindControl("CheckBox") as CheckBox).Checked = true;
                }
            }
            else
            {
                for (int i = 0; i < gvCourse.Rows.Count; i++)
                {
                    (gvCourse.Rows[i].FindControl("CheckBox") as CheckBox).Checked = false;
                }
            }
        }
    }
    protected void mnuToolBar_ItemClick(object source, DevExpress.Web.ASPxMenu.MenuItemEventArgs e)
    {
        
        List<string> idList = new List<string>();
        if (gvCourse.Rows.Count != 0)
        {
            for (int i = 0; i < gvCourse.Rows.Count; i++)
            {
                if (((CheckBox)gvCourse.Rows[i].FindControl("CheckBox")).Checked == true)
                {
                    string s = ((Label)gvCourse.Rows[i].FindControl("lbcourseID")).Text;
                    DataTable a = reg.GetDataByCourseID(Convert.ToInt32(s));
                    for (int j = 0; j < a.Rows.Count; j++)
                    {
                        string b = a.Rows[j]["ID"].ToString();
                        idList.Add(b);
                    }
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
            int state = st.GetPostStateID("试卷学院待审", "试卷学院审核" + DropDownList2.SelectedValue.ToString());
            for (i = 0; i < idList.Count; i++)
            {
                if (state == 1)
                {
                    p.UpdateExitReaded(Convert.ToInt32(Convert.ToInt32(idList[i].ToString())));
                }
                try { 
               // int cid = reg.GetCourseIDByRegID(Convert.ToInt32(idList[i].ToString()));
               // State s = new State();
               // string sta = s.UpdateStateByStateID(state);
               // p.UpdatepaperstateByCourseID(sta,cid);
                p.UpdatePaperStateByPaperID("试卷印刷部待审",Convert.ToInt32(idList[i].ToString()));
                reg.UpdateProRegistration2(Convert.ToInt32(idList[i].ToString()), txtAudit.Text);
                reg.UpdateState(state, Convert.ToInt32(idList[i].ToString()));
                //隐藏试卷签字功能
                //string account = reg.GetTeacheroByRegID(Convert.ToInt32(idList[i].ToString()));
                //string courseNo = reg.GetCoursenoByRegID(Convert.ToInt32(idList[i].ToString()));
                //string paper = reg.GetPAorBByReg(Convert.ToInt32(idList[i].ToString()));
                //string teachplan = reg.GetTeacherPlanByReg(Convert.ToInt32(idList[i].ToString()));
                //string coursedept = reg.GetDeptByReg(Convert.ToInt32(idList[i].ToString()));
                //string newFileName = (teachplan + "_" + coursedept + "_" + account + "_" + courseNo + "_" + paper + "卷1.pdf");
                //string newFileName1 = (teachplan + "_" + coursedept + "_" + account + "_" + courseNo + "_" + paper + "卷.pdf");
                //string path = ("~/Downloads/").ToString();
                //string destPhysicalFile = Server.MapPath(path + newFileName);
                //string destPhysicalFile1 = Server.MapPath(path + newFileName1);
                //Registration re = new Registration();
                //Signature si = new Signature();
                //string colSig = si.GetByCourseno(courseNo).Rows[0]["CollegeSignature"].ToString();
                //string proImg = Server.MapPath("~/SigImage/" + colSig + ".png");
                //AddSignature(destPhysicalFile, destPhysicalFile1, proImg, 359, 574);
                //File.Delete(destPhysicalFile);
                MsgBox.ShowMessage("提交成功！");
                }
                catch(Exception ex)
                {
                    MsgBox.ShowErrorMessage(ex.Message);
                }
            }

        }
        popupAuditEdit.ShowOnPageLoad = false;
        gvCourse.DataBind();
    }
    protected void gvCourse_RowCommand(object sender, GridViewCommandEventArgs e)
    {
       
        if (e.CommandName == "PrintRegistration")
        {
            int index = Convert.ToInt32(e.CommandArgument);
            string regID = ((Label)gvCourse.Rows[index].FindControl("lblregID")).Text;
            popupRegistration.ContentUrl = "../Common/RegistrationReport.aspx?regID=" + regID;
            popupRegistration.ShowOnPageLoad = true;
        }
        if (e.CommandName == "PrintDetail")
        {
            int index = Convert.ToInt32(e.CommandArgument);
            string detID = ((Label)gvCourse.Rows[index].FindControl("lblregID")).Text;
            popupRegistration.ContentUrl = "../Common/DetailReport.aspx?detID=" + detID;
            popupRegistration.ShowOnPageLoad = true;
        }
        if (e.CommandName == "PrintQuestiontype")
        {
            int index = Convert.ToInt32(e.CommandArgument);
            string regID = ((Label)gvCourse.Rows[index].FindControl("lblregID")).Text;
            popupRegistration.ContentUrl = "../Common/QuestiontypeReport.aspx?detID=" + regID;
            popupRegistration.ShowOnPageLoad = true;
        }
    }
    

    protected void mnuMain_ItemClick(object source, DevExpress.Web.ASPxMenu.MenuItemEventArgs e)
    {
        List<string> idList = new List<string>();
        if (gvCourse.Rows.Count != 0)
        {
            for (int i = 0; i < gvCourse.Rows.Count; i++)
            {
                if (((CheckBox)gvCourse.Rows[i].FindControl("CheckBox")).Checked == true)
                {
                    string s = ((Label)gvCourse.Rows[i].FindControl("lbcourseID")).Text;
                    DataTable a = reg.GetDataByCourseID(Convert.ToInt32(s));
                    for (int j = 0; j < a.Rows.Count; j++)
                    {
                        string b = a.Rows[j]["ID"].ToString();
                        idList.Add(b);
                    }
                }
            }
        }
        if (idList.Count == 0)
        {
            MsgBox.ShowErrorMessage("请选择！");
            //popupAuditEdit.ShowOnPageLoad = false;
        }
        else
        {
            popupAuditEdit.ShowOnPageLoad = true;
        }
    }
    public static void DeleteFolder(string dir)
    {
        foreach (string d in Directory.GetFileSystemEntries(dir))
        {
            if (File.Exists(d))
            {
                FileInfo fi = new FileInfo(d);
                if (fi.Attributes.ToString().IndexOf("ReadOnly") != -1)
                    fi.Attributes = FileAttributes.Normal;
                File.Delete(d);//直接删除其中的文件  
            }
            else
            {
                DirectoryInfo d1 = new DirectoryInfo(d);
                if (d1.GetFiles().Length != 0)
                {
                    DeleteFolder(d1.FullName);////递归删除子文件夹
                }
                Directory.Delete(d);
            }
        }
    }
    protected void AddSignature(string oldP, string newP, string imP, int x, int y)
    {
        using (Stream inputPdfStream = new FileStream(oldP, FileMode.Open, FileAccess.Read, FileShare.Read))
        using (Stream inputImageStream = new FileStream(imP, FileMode.Open, FileAccess.Read, FileShare.Read))
        using (Stream outputPdfStream = new FileStream(newP, FileMode.Create, FileAccess.Write, FileShare.None))
        {
            var reader = new PdfReader(inputPdfStream);
            var stamper = new PdfStamper(reader, outputPdfStream);
            var pdfContentByte = stamper.GetOverContent(1);
            iTextSharp.text.Image image = iTextSharp.text.Image.GetInstance(inputImageStream);
            image.ScalePercent(40);
            image.SetAbsolutePosition(x, y);
            pdfContentByte.AddImage(image);
            stamper.Close();
        }
    }
}