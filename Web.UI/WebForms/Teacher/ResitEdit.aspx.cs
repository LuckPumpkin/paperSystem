using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Text.RegularExpressions;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WebForms_Teacher_ResitEdit : System.Web.UI.Page
{
    string paperID;
    int temp;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        TextBox Paper_copynum;

        paperID = Request.QueryString["paperID"].ToString();
        Paper p = new Paper();
       temp = p.GetPaperCopyNum(Convert.ToInt32(paperID));
      
    }


    public void lbtnClick(object sender,EventArgs e)
    {
        TextBox Paper_num = (TextBox)this.FVResitEdit.FindControl("txtPaper_num");
        TextBox paper_copyNum = (TextBox)this.FVResitEdit.FindControl("txtpaper_copyNum");
        TextBox WhitePaper_num = (TextBox)this.FVResitEdit.FindControl("txtWhitePaper_num");
        
        string p1 = Paper_num.Text.Trim();
        string p2 = paper_copyNum.Text.Trim();
        string w = WhitePaper_num.Text.Trim();

        if(!isNumberic(p1) || !isNumberic(p2) || !isNumberic(w))
        {
            MsgBox.ShowErrorMessage("请输入数字类型！");
        }

        if(Convert.ToInt16(temp) > Convert.ToInt16(p2))
        {
            MsgBox.ShowErrorMessage("试卷份数只能大于原始值！");
        }
        else { 
        DateTime now = DateTime.Now;
        string connectionString = ConfigurationManager.ConnectionStrings["AppConnStr"].ToString();
        string strUpdate = string.Format("Update Paper set paper_num='{0}',paper_copyNum='{1}',WhitePaper_num='{2}',submitTime='{3}' where ID='{4}'"
, p1, p2, w, now, paperID);
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand(strUpdate, con);
        cmd.ExecuteNonQuery();
        con.Close();
        Label1.Text = "保存成功";
        }
    }
    protected bool isNumberic(string message)
    {
        if (message != "" && Regex.IsMatch(message, @"^[0-9]+$"))
        {
            return true;
        }
        else
            return false;
    }
   
}