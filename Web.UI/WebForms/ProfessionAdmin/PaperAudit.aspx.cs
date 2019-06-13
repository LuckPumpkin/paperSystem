using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.IO;
//using Microsoft.Office.Interop.Word;
using System.Diagnostics;
using System.Text;
using System.Configuration;
using SysData = System.Data;
using O2S.Components.PDFRender4NET;
using System.Drawing;
using System.Drawing.Imaging;
using iTextSharp.text;
using iTextSharp.text.pdf;
using System.Collections.Generic;


public partial class WebForms_ProfessionAdmin_A : System.Web.UI.Page
{
    Registration rs = new Registration();
    Paper p = new Paper();
    State st = new State();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            txtTeacherID.Value = Convert.ToString(Session["UserCode"]);
            Teacher tea = new Teacher();
            txtPro.Value = tea.GetProByUserCode(txtTeacherID.Value);
        }
    }
    protected void gvCourse_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Read")
        {
            int index = Convert.ToInt32(e.CommandArgument);
            txtCourseNo.Value = ((Label)gvCourse.Rows[index].FindControl("lblCourse_no")).Text;
            txtAccount.Value = ((Label)gvCourse.Rows[index].FindControl("lblTeacher")).Text;
            txtAorB.Value = ((Label)gvCourse.Rows[index].FindControl("lbAorB")).Text;
            txtTeachingPlan.Value = ((Label)gvCourse.Rows[index].FindControl("lbTeachingPlan")).Text;
            txtCourseDept.Value = ((Label)gvCourse.Rows[index].FindControl("lbCourseDept")).Text;
            popupRegistration.ContentUrl = "../ProfessionAdmin/PaperCheck.aspx?account=" + txtAccount.Value + "&courseNo=" + txtCourseNo.Value + "&paper=" + txtAorB.Value + "&teachingplan=" + txtTeachingPlan.Value + "&coursedept=" + txtCourseDept.Value;
            popupRegistration.ShowOnPageLoad = true;

        }
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
            string regID = ((Label)gvCourse.Rows[index].FindControl("lblregID")).Text;
            popupRegistration.ContentUrl = "../Common/DetailReport.aspx?detID=" + regID;
            popupRegistration.ShowOnPageLoad = true;
        }
        if (e.CommandName == "PrintQuestiontype")
        {
            int index = Convert.ToInt32(e.CommandArgument);
            string regID = ((Label)gvCourse.Rows[index].FindControl("lblregID")).Text;
            popupRegistration.ContentUrl = "../Common/QuestiontypeReport.aspx?detID=" + regID;
            popupRegistration.ShowOnPageLoad = true;
        }
       
        if (e.CommandName == "Audit")
        {
            int index = Convert.ToInt32(e.CommandArgument);
            txtCourseID.Value = ((Label)gvCourse.Rows[index].FindControl("lblCourseID")).Text;
            txtRegID.Value = ((Label)gvCourse.Rows[index].FindControl("lblregID")).Text;
            txtCourseNo.Value = ((Label)gvCourse.Rows[index].FindControl("lblCourse_no")).Text;
            txtAccount.Value = ((Label)gvCourse.Rows[index].FindControl("lblTeacher")).Text;
            txtAorB.Value = ((Label)gvCourse.Rows[index].FindControl("lbAorB")).Text;
            txtTeachingPlan.Value = ((Label)gvCourse.Rows[index].FindControl("lbTeachingPlan")).Text;
            txtCourseDept.Value = ((Label)gvCourse.Rows[index].FindControl("lbCourseDept")).Text;
            Paper p = new Paper();
            //int both = p.GetBothReadedByCourseID(Convert.ToInt32(txtCourseID.Value), txtAorB.Value);
            popupAuditEdit.ShowOnPageLoad = true;
            //if(both >= 1)
            //{
            //    popupAuditEdit.ShowOnPageLoad = true;
            //}
            //else
            //{
            //    MsgBox.ShowErrorMessage("请查阅试卷！");
            //}
        }
    }
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
    protected void mnuMain_ItemClick(object source, DevExpress.Web.ASPxMenu.MenuItemEventArgs e)
    {
        List<string> idList = new List<string>();
        if (gvCourse.Rows.Count != 0)
        {
            for (int i = 0; i < gvCourse.Rows.Count; i++)
            {
                if (((CheckBox)gvCourse.Rows[i].FindControl("CheckBox")).Checked == true)
                {
                    string s = ((Label)gvCourse.Rows[i].FindControl("lblCourseID")).Text;
                    DataTable a = rs.GetDataByCourseID(Convert.ToInt32(s));
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
    protected void mnuToolBar_ItemClick1(object source, DevExpress.Web.ASPxMenu.MenuItemEventArgs e)
    {
        List<string> idList = new List<string>();
        if (gvCourse.Rows.Count != 0)
        {
            for (int i = 0; i < gvCourse.Rows.Count; i++)
            {
                if (((CheckBox)gvCourse.Rows[i].FindControl("CheckBox")).Checked == true)
                {
                    string s = ((Label)gvCourse.Rows[i].FindControl("lblCourseID")).Text;
                    DataTable a = rs.GetDataByCourseID(Convert.ToInt32(s));
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
            int state = st.GetPostStateID("试卷系待审", DropDownList2.SelectedValue.ToString());
            for (i = 0; i < idList.Count; i++)
            {
                if (state == 1)
                {
                    p.UpdateExitReaded(Convert.ToInt32(Convert.ToInt32(idList[i].ToString())));
                }
                try { 
                //p.UpdatePaperStateByPaperID("试卷印刷部待审",Convert.ToInt32(idList[i].ToString()));
                rs.UpdateProRegistration(Convert.ToInt32(idList[i].ToString()), txtAudit.Text);
                rs.UpdateState(state, Convert.ToInt32(idList[i].ToString()));
                gvCourse.DataBind();
                //隐藏试卷签字功能
                //string account=txtAccount.Value;  
                //string courseNo=txtCourseNo.Value;
                //string paper= txtAorB.Value;
                //string teachplan=txtTeachingPlan.Value;
                //string coursedept = txtCourseDept.Value;
                //string newFileName = (teachplan + "_" + coursedept + "_" + account + "_" + courseNo + "_" + paper + "卷.pdf");
                //string newFileName1 = (teachplan + "_" + coursedept + "_" + account + "_" + courseNo + "_" + paper + "卷1.pdf");
                //string path = ("~/Downloads/").ToString();
                //string destPhysicalFile = Server.MapPath(path + newFileName);
                //string destPhysicalFile1 = Server.MapPath(path + newFileName1);
                //Registration re = new Registration();
                //Signature si = new Signature();
                //string proSig = si.GetByCourseno(courseNo).Rows[0]["ProfessionSignature"].ToString();
                //string proImg = Server.MapPath("~/SigImage/" + proSig + ".png");
                //AddSignature(destPhysicalFile, destPhysicalFile1, proImg, 129, 574);
                //File.Delete(destPhysicalFile);
                popupAuditEdit.ShowOnPageLoad = false;
                MsgBox.ShowMessage("提交成功！");
                    }catch(Exception ex){
                        MsgBox.ShowErrorMessage(ex.Message);
                    }
            }
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