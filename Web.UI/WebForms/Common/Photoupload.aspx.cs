using System;
using System.Data;
using System.Web;
using System.Text;
using System.Collections;
using System.IO;
using System.Diagnostics;
using System.Runtime.Serialization.Formatters.Binary;
using SysData = System.Data;

//using ICSharpCode.SharpZipLib.BZip2;
//using ICSharpCode.SharpZipLib.Zip;
//using ICSharpCode.SharpZipLib.Zip.Compression;
//using ICSharpCode.SharpZipLib.Zip.Compression.Streams;
//using ICSharpCode.SharpZipLib.GZip;
//using ICSharpCode.SharpZipLib.Checksums;
using System.IO.Compression;
using System.Linq;
using Ionic.Zip;
using ZipFile = Ionic.Zip.ZipFile;
public partial class WebForms_CollegeAdmin_Zipupload : System.Web.UI.Page
{
    
    protected void Page_Load(object sender, EventArgs e)
    {
       
        if (!Page.IsPostBack)
        {
            txtTeacherId.Value = Convert.ToString(Session["UserCode"]);
            User us = new User();
            Teacher te = new Teacher();
            txtAccount.Value = us.GetAccount(txtTeacherId.Value);
            SysData.DataTable tea = te.GetDataByAccount(txtAccount.Value);
            lbName.Text = tea.Rows[0]["Name"].ToString();
            lbSex.Text = tea.Rows[0]["Sex"].ToString();
            lbTel.Text = tea.Rows[0]["Tel"].ToString();
            showImage();
        }
        showImage();
    }

    protected void btnImport_Click(object sender, EventArgs e)
    {
        Teacher te = new Teacher();
        if (lbTel.Text == "")
        {
            MsgBox.ShowErrorMessage("请填写手机号码！！");
            return;
        }
        else
        {
            try
            {
                if (Savephoto() == true)
                {
                    //判断是否有该路径
                    string wantPath = Server.MapPath("~/SigImage/");
                    if (!Directory.Exists(wantPath))
                    {   //如果不存在就创建
                        Directory.CreateDirectory(wantPath);
                        this.files.SaveAs(Server.MapPath("~/SigImage/") + txtAccount.Value + ".png");
                        showImage();
                    }
                    else
                    {

                        this.files.SaveAs(Server.MapPath("~/SigImage/") + txtAccount.Value + ".png");
                        showImage();
                    }
                    te.UpdateTelByAccount(lbTel.Text, txtAccount.Value);
                    MsgBox.ShowMessage("信息更新成功！！");
                }
                else
                {
                    MsgBox.ShowErrorMessage("请上传png图片！！");
                    return;
                }
            }
            catch (Exception ex)
            {
                MsgBox.ShowErrorMessage(ex.Message);
            }
        }
    }
    private bool Savephoto()
    {
        bool filesValid = false;
        //文件上传路径
        string filePath = this.files.PostedFile.FileName;
        //获取文件名称
        string fileName = filePath.Substring(filePath.LastIndexOf("\\") + 1);

        if (this.files.HasFile)
        {
            //转换成小写形式
            string fileExtension = System.IO.Path.GetExtension(this.files.FileName).ToLower();
            string[] restricyExtension = { ".png" };
            //判断文件是否符合要求
            for (int i = 0; i < restricyExtension.Length; i++)
            {
                if (fileExtension == restricyExtension[i])
                {
                    filesValid = true;
                }
                else
                {
                    filesValid = false;
                }
            }
            //如果文件符合要求，调用SaveAS()方法上传，并显示相关信息
        }
        return filesValid;
    }
    public void showImage(){

        Random rand = new Random();
        if (File.Exists(@Server.MapPath("~/SigImage/") + txtAccount.Value + ".png"))
        {
            IPersonalCard.ImageUrl = Server.HtmlEncode(Request.ApplicationPath) + @"SigImage/" + txtAccount.Value + ".png" + "?" + rand.Next(1000).ToString();
        }
        else
        {
            IPersonalCard.ImageUrl = "";
        }
    }
}
