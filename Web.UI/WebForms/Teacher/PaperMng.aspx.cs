using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.IO;
using O2S.Components.PDFRender4NET;
using System.Drawing;
using System.Drawing.Imaging;
using System.Configuration;
using System.Text;
using System.IO;
using iTextSharp.text;
using iTextSharp.text.pdf;
using SysData = System.Data;


public partial class WebForms_Teacher_PaperMng : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            txtTeacherId.Value = Convert.ToString(Session["UserCode"]);
            User us = new User();
            txtAccount.Value = us.GetAccount(txtTeacherId.Value);
        }
    }

    //protected void gvDetail_RowCommand(object sender, GridViewCommandEventArgs e)
    //{
    //    if (e.CommandName == "DetailEdit")
    //    {
    //        int index = Convert.ToInt32(e.CommandArgument);
    //        string detID = ((Label)gvDetail.Rows[index].FindControl("lbdetailID")).Text;
    //        popupRegistration.ContentUrl = "../Teacher/DetailEdit.aspx?detID=" + detID;
    //        popupRegistration.ShowOnPageLoad = true;
    //    }
    //    if (e.CommandName == "DetailReport")
    //    {   Detail d=new Detail();
    //        int index = Convert.ToInt32(e.CommandArgument);
    //        string detID = ((Label)gvDetail.Rows[index].FindControl("lbdetailID")).Text;
    //        if (d.GetModuleNumByDetID(Convert.ToInt32(detID)) == 0)
    //        {
    //            MsgBox.ShowErrorMessage("请编辑明细表1！");
    //        }else{
    //        popupRegistration.ContentUrl = "../Common/DetailReport.aspx?detID=" + detID;
    //        popupRegistration.ShowOnPageLoad = true;
    //        }
    //    }
    //    if (e.CommandName == "QuestiontypeReport")
    //    {
    //        Detail d = new Detail();
    //        int index = Convert.ToInt32(e.CommandArgument);
    //        string detID = ((Label)gvDetail.Rows[index].FindControl("lbdetailID")).Text;
    //        if (d.GetQNumByDetID(Convert.ToInt32(detID)) == 0)
    //        {
    //            MsgBox.ShowErrorMessage("请编辑明细表2！");
    //        }
    //        else
    //        {
    //            popupRegistration.ContentUrl = "../Common/QuestiontypeReport.aspx?detID=" + detID;
    //            popupRegistration.ShowOnPageLoad = true;
    //        }
    //    }

    //}
    protected void gvCourse_RowCommand(object sender, GridViewCommandEventArgs e)
    {

        if (e.CommandName == "RegEdit")
        {
            int index = Convert.ToInt32(e.CommandArgument);
            string regID = ((Label)gvCourse.Rows[index].FindControl("lbregID")).Text;
            popupRegistration.ContentUrl = "../Teacher/RegistrationEdit.aspx?regID=" + regID;
            popupRegistration.ShowOnPageLoad = true;
        }
        
        //if (e.CommandName == "DetailEditB")
        //{
        //    int index = Convert.ToInt32(e.CommandArgument);
        //    string regID = ((Label)gvCourse.Rows[index].FindControl("lbregID")).Text;
        //    string RegID = (Convert.ToInt32(regID) + 1).ToString();
        //    popupRegistration.ContentUrl = "../Teacher/DetailEditB.aspx?regID=" + RegID;
        //    popupRegistration.ShowOnPageLoad = true;
        //}
        if (e.CommandName == "RegReport")
        {
            int index = Convert.ToInt32(e.CommandArgument);
            string regID = ((Label)gvCourse.Rows[index].FindControl("lbregID")).Text;
            popupRegistration.ContentUrl = "../Common/RegistrationReport.aspx?regID=" + regID;
            popupRegistration.ShowOnPageLoad = true;
        }
       
        if (e.CommandName == "PaperUploadA")
        {
            int index = Convert.ToInt32(e.CommandArgument);
            txtCourseNo.Value = ((Label)gvCourse.Rows[index].FindControl("lblcourse_no")).Text;
            txtTeachingPlan.Value = ((Label)gvCourse.Rows[index].FindControl("lbTeachingPlan")).Text;
            txtCourseDept.Value = ((Label)gvCourse.Rows[index].FindControl("lbCourseDept")).Text;
            int regID = Convert.ToInt32(((Label)gvCourse.Rows[index].FindControl("lbregID")).Text);
            txtAorB.Value = "A";
            Registration rs = new Registration();
            popupUpload.ShowOnPageLoad = true;
        }
        if (e.CommandName == "PaperUploadB")
        {
            int index = Convert.ToInt32(e.CommandArgument);
            txtCourseNo.Value = ((Label)gvCourse.Rows[index].FindControl("lblcourse_no")).Text;
            txtTeachingPlan.Value = ((Label)gvCourse.Rows[index].FindControl("lbTeachingPlan")).Text;
            txtCourseDept.Value = ((Label)gvCourse.Rows[index].FindControl("lbCourseDept")).Text;
            int regID = Convert.ToInt32(((Label)gvCourse.Rows[index].FindControl("lbregID")).Text);
            txtAorB.Value = "B";
            Registration rs = new Registration();
            popupUpload.ShowOnPageLoad = true;
        }
        if (e.CommandName == "PaperDownloadA")
        {
            int index = Convert.ToInt32(e.CommandArgument);
            txtCourseNo.Value = ((Label)gvCourse.Rows[index].FindControl("lblcourse_no")).Text;
            txtTeachingPlan.Value = ((Label)gvCourse.Rows[index].FindControl("lbTeachingPlan")).Text;
            txtCourseDept.Value = ((Label)gvCourse.Rows[index].FindControl("lbCourseDept")).Text;
            Download("A");
        }
        if (e.CommandName == "PaperDownloadB")
        {
            int index = Convert.ToInt32(e.CommandArgument);
            txtCourseNo.Value = ((Label)gvCourse.Rows[index].FindControl("lblcourse_no")).Text;
            txtTeachingPlan.Value = ((Label)gvCourse.Rows[index].FindControl("lbTeachingPlan")).Text;
            txtCourseDept.Value = ((Label)gvCourse.Rows[index].FindControl("lbCourseDept")).Text;
            Download("B");
        }
        if (e.CommandName == "Submit")
        {
            Course co = new Course();
            Detail d=new Detail(); 
            saveTime(sender, e);
            gvCourse.DataBind();
            int index = Convert.ToInt32(e.CommandArgument);
            txtCourseNo.Value = ((Label)gvCourse.Rows[index].FindControl("lblcourse_no")).Text;
            txtTeachingPlan.Value = ((Label)gvCourse.Rows[index].FindControl("lbTeachingPlan")).Text;
            txtCourseDept.Value = ((Label)gvCourse.Rows[index].FindControl("lbCourseDept")).Text;
            int regID = Convert.ToInt32(((Label)gvCourse.Rows[index].FindControl("lbregID")).Text);
            int PaperCopyNum = 0;
            if (((Label)gvCourse.Rows[index].FindControl("lbpapercopynum")).Text != "")
                PaperCopyNum = Convert.ToInt32(((Label)gvCourse.Rows[index].FindControl("lbpapercopynum")).Text);
            DateTime today = Convert.ToDateTime(DateTime.Now.ToShortDateString());
            Paper pa = new Paper();
            int cID = co.GetIDByCourseNo(txtCourseNo.Value);
            SysData.DataTable dt = d.GetDetailByCID(cID);
            try
            {
                //string physicalFileNameA = Server.MapPath("~/Downloads/" + txtTeachingPlan.Value + "_" + txtCourseDept.Value + "_" + txtAccount.Value + "_" + txtCourseNo.Value + "_" + "A卷.pdf");
                //string physicalFileNameB = Server.MapPath("~/Downloads/" + txtTeachingPlan.Value + "_" + txtCourseDept.Value + "_" + txtAccount.Value + "_" + txtCourseNo.Value + "_" + "B卷.pdf");

                //判断试卷是否已上传
                //if (!File.Exists(physicalFileNameA))
                //    MsgBox.ShowErrorMessage("有试卷未提交！");
                //else if (!File.Exists(physicalFileNameB))
                //    MsgBox.ShowErrorMessage("有试卷未提交！");
                //else if (PaperCopyNum == 0)
                //{
                //    MsgBox.ShowMessage("请填写试卷份数！");
                //}
                //else if (Convert.ToInt32(dt.Rows[0]["Mnum"].ToString()) == 0 && Convert.ToInt32(dt.Rows[0]["Qnum"].ToString()) == 0)
                //{
                //    MsgBox.ShowErrorMessage("请编辑A卷细目表");

                //}
                //else if (Convert.ToInt32(dt.Rows[1]["Mnum"].ToString()) == 0 && Convert.ToInt32(dt.Rows[1]["Qnum"].ToString()) == 0)
                //{
                //    MsgBox.ShowErrorMessage("请编辑B卷细目表");
                //}
                //隐藏试卷是否上传判断
                if (PaperCopyNum == 0)
                {
                    MsgBox.ShowMessage("请填写试卷份数！");
                }
                //else if (Convert.ToInt32(dt.Rows[0]["Mnum"].ToString()) == 0 && Convert.ToInt32(dt.Rows[0]["Qnum"].ToString()) == 0)
                //{
                //    MsgBox.ShowErrorMessage("请编辑A卷细目表");

                //}
                //else if (Convert.ToInt32(dt.Rows[1]["Mnum"].ToString()) == 0 && Convert.ToInt32(dt.Rows[1]["Qnum"].ToString()) == 0)
                //{
                //    MsgBox.ShowErrorMessage("请编辑B卷细目表");
                //}
                //试卷份数在0--500份，对日期进行控制
                else if (PaperCopyNum > 0 && PaperCopyNum < 500)
                {
                    DateTime time = Convert.ToDateTime(((TextBox)gvCourse.Rows[index].FindControl("Time")).Text);
                    if (time == null)
                    {
                        MsgBox.ShowMessage("请填写交付日期！");
                    }
                    else
                    {
                        time = Convert.ToDateTime(((TextBox)gvCourse.Rows[index].FindControl("Time")).Text);
                        TimeSpan ts = time.Subtract(today);
                        // int t = Convert.ToInt32(ts);
                        //计算1月1日--1月4日为3天
                        TimeSpan santian = Convert.ToDateTime("1-4") - Convert.ToDateTime("1-1");
                        if (ts < santian)
                        {
                            MsgBox.ShowErrorMessage("请选择3天后的日期!");
                        }
                        else
                        {

                            saveTime(sender, e);
                            State s = new State();
                            Registration rs = new Registration();
                            rs.UpdateState(s.GetPostStateID("试卷草稿", "提交"), regID);
                            rs.UpdateState(s.GetPostStateID("试卷草稿", "提交"), regID+1);
                            gvCourse.DataBind();
                            MsgBox.ShowMessage("提交成功！");
                        }
                    }
                }
                //判断试卷份数是否>500,>500则交付日期填写5 天以后
                else if (PaperCopyNum >= 500)
                {
                    DateTime time = Convert.ToDateTime(((TextBox)gvCourse.Rows[index].FindControl("Time")).Text);
                    if (time == null)
                    {
                        MsgBox.ShowErrorMessage("请填写交付日期！");
                    }
                    else
                    {
                        time = Convert.ToDateTime(((TextBox)gvCourse.Rows[index].FindControl("Time")).Text);
                        TimeSpan ts = time.Subtract(today);
                        // int t = Convert.ToInt32(ts);
                        //计算1月1日--1月6日为5天
                        TimeSpan wutian = Convert.ToDateTime("1-6") - Convert.ToDateTime("1-1");
                        if (ts < wutian)
                        {
                            MsgBox.ShowMessage("您要打印的试卷份数大于500份，   请选择5天后的日期!");
                        }
                        else
                        {

                            saveTime(sender, e);
                            State s = new State();
                            Registration rs = new Registration();
                            rs.UpdateState(s.GetPostStateID("试卷院待审", "提交"), regID);
                            gvCourse.DataBind();
                            MsgBox.ShowMessage("提交成功！");
                        }
                    }
                }
                //初始化Paper表的readed属性
                else if (pa.GetReadedByRegID(regID) > 0)
                {
                    pa.InitialReadedByRegID(regID);
                }
                else
                {
                    saveTime(sender, e);
                    State s = new State();
                    Registration rs = new Registration();
                    rs.UpdateState(s.GetPostStateID("试卷草稿", "提交"), regID);
                    gvCourse.DataBind();
                    MsgBox.ShowMessage("提交成功！");
                }
            }
            catch (Exception ex)
            {
                MsgBox.ShowErrorMessage("请填写正确的日期！");
            }
        }
    }

    protected void saveTime(object sender, GridViewCommandEventArgs e)
    {
        //存储交付日期
        try
        {
            int index = Convert.ToInt32(e.CommandArgument);
            txtCourseNo.Value = ((Label)gvCourse.Rows[index].FindControl("lblcourse_no")).Text;
            txtCourseID.Value = ((Label)gvCourse.Rows[index].FindControl("lbcourseID")).Text;
            DateTime time = Convert.ToDateTime(((TextBox)gvCourse.Rows[index].FindControl("Time")).Text);
            DateTime today = Convert.ToDateTime(DateTime.Now.ToShortDateString());
            string connectionString = ConfigurationManager.ConnectionStrings["AppConnStr"].ToString();
            string strSQL = string.Format(

"UPDATE  Paper SET  getTime = '{0}',submitTime = '{1}' FROM Paper INNER JOIN Course ON Paper.courseID = Course.ID INNER JOIN Registration INNER JOIN State ON Registration.state = State.ID ON Course.ID = Registration.courseID WHERE (Course.ID = '{2}')", time, today, txtCourseID.Value);
            SqlConnection conn = new SqlConnection(connectionString);

            SqlCommand cmd = new SqlCommand(strSQL, conn);

            conn.Open();
            int result = (int)cmd.ExecuteScalar();
            conn.Close();
        }
        catch (Exception ex)
        {
            MsgBox.ShowErrorMessage("请填入格式正确的日期！");
        }


    }

    //将pdf文件转换成image
    public static void ConvertPDF2Image(string pdfInputPath, string imageOutputPath)
    {
        PDFFile pdfFile = PDFFile.Open(pdfInputPath);
        //判断是否存在文件夹，若不存在则创建该文件夹
        if (!Directory.Exists(imageOutputPath))
        {
            Directory.CreateDirectory(imageOutputPath);
        }
        //删除该文件夹内容
        DeleteFolder(imageOutputPath);
        // start to convert each page
        for (int i = 1; i <= pdfFile.PageCount; i++)
        {
            Bitmap pageImage = pdfFile.GetPageImage(i - 1, 500);
            pageImage.Save(imageOutputPath + "0" + i.ToString() + ".jpg", System.Drawing.Imaging.ImageFormat.Jpeg);
            pageImage.Dispose();
        }
        pdfFile.Dispose();
    }

    //删除文件夹下的文件，但不删除该文件夹
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



    protected void Download(string type)
    {
        try
        {
            string physicalFileName = Server.MapPath("~/Downloads/" + txtTeachingPlan.Value + "_" + txtCourseDept.Value + "_" + txtAccount.Value + "_" + txtCourseNo.Value + "_" + type + "卷.pdf");
            string ext = Path.GetExtension(physicalFileName);
            string fileName = txtTeachingPlan.Value + "_" + txtCourseDept.Value + "_" + txtAccount.Value + "_" + txtCourseNo.Value + "_" + type + "卷.pdf";

            if (!File.Exists(physicalFileName))
                Response.Redirect("../Common/Error.aspx?ErrorMsgID=1");
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


    protected void LBUpFile_Click(object sender, EventArgs e)
    {
        if (!FileUpload1.HasFile)
            return;
        //string Vicpath = Server.MapPath("~/Downloads/" + txtAccount.Value + "/" + txtCourseNo.Value).ToString();
        //System.IO.Directory.CreateDirectory(Vicpath);
        string fileName = FileUpload1.FileName;
        string ext = Path.GetExtension(fileName);
        if (ext.ToLower() == ".pdf")
        {
            string newFileName = (txtTeachingPlan.Value + "_" + txtCourseDept.Value + "_" + txtAccount.Value + "_" + txtCourseNo.Value + "_" + txtAorB.Value + "卷").ToString() + ext;
            string path = ("~/Downloads/").ToString();
            string destPhysicalFile = Server.MapPath(path + newFileName);
            FileUpload1.SaveAs(destPhysicalFile);
            MsgBox.ShowMessage("导入成功!");
            string sfileName = Server.MapPath("~/Downloads/" + txtTeachingPlan.Value + "_" + txtCourseDept.Value + "_" + txtAccount.Value + "_" + txtCourseNo.Value + "_" + txtAorB.Value + "卷.pdf");
            string ofileName = Server.MapPath("~/PDFImages/" + txtAccount.Value + "/" + txtCourseNo.Value + "/" + txtAorB.Value + "/");
            ConvertPDF2Image(sfileName, ofileName);
            popupUpload.ShowOnPageLoad = false;
        }
        else
        {
            MsgBox.ShowErrorMessage("请导入pdf格式文件!");
            return;
        }
    }



    protected void LBDownFile_Click(object sender, EventArgs e)
    {
        string physicalFileName = Server.MapPath("~/Downloads/试卷模板.docx");
        string fileName = "试卷模板.docx";

        if (!File.Exists(physicalFileName))
            Response.Redirect("../Common/Error.aspx?ErrorMsgID=1");
        else
        {
            Response.Clear();

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
    protected void refresh_Click(object sender, EventArgs e)
    {
        gvCourse.DataBind();
    }
}