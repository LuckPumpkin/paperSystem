using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Text.RegularExpressions;
using System.Web.UI.WebControls;
using System.Windows.Forms;

public partial class WebForms_Teacher_DetailEditB : System.Web.UI.Page
{
    string connectionString = ConfigurationManager.ConnectionStrings["AppConnStr"].ToString();
    string regID;
    protected void Page_Load(object sender, EventArgs e)
    {
        regID = Request.QueryString["regID"].ToString();
        GridView1.DataBind();
        GridView2.DataBind();
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

    //删除题型已通过
    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        int regID = Convert.ToInt32(Request.QueryString["regID"].ToString());
        Registration rs = new Registration();
        int id = Convert.ToInt32(regID);
        int state = rs.GetStateByRegID(id);
        if (state == 1)
        {
            deleteQtype(sender, e);
        }
        else if (state == 2)
        {
            deleteQtype(sender, e);
            rs.UpdateState(1, id);
        }
    }

    public void deleteQtype(object sender, GridViewDeleteEventArgs e)
    {
        string id = GridView1.DataKeys[e.RowIndex].Values[0].ToString();
        string strDel = "DELETE FROM Questiontype where QtypeID=" + id;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand(strDel, con);
        cmd.ExecuteNonQuery();
        con.Close();
        this.GridView1.DataBind();

    }


    //删除模块已通过
   
    protected void GridView2_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        int regID = Convert.ToInt32(Request.QueryString["regID"].ToString());
        Registration rs = new Registration();
        int id = Convert.ToInt32(regID);
        int state = rs.GetStateByRegID(id);
        if (state == 1)
        {
            deleteModule(sender, e);
        }
        else if (state == 2)
        {
            deleteModule(sender, e);
            rs.UpdateState(1, id);
        }
    }
    public void deleteModule(object sender, GridViewDeleteEventArgs e)
    {
        string id = GridView2.DataKeys[e.RowIndex].Values[0].ToString();
        string strDel = "DELETE FROM Module where ModuleID=" + id;
        SqlConnection con = new SqlConnection(connectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand(strDel, con);
        cmd.ExecuteNonQuery();
        con.Close();
        this.GridView2.DataBind();
    }



    //“新增题型”按钮功能
    protected void AddQuestion_Click(object sender, EventArgs e)
    {
        PopupControl1.ShowOnPageLoad = true;
    }
    //“新增模块”按钮功能
    protected void AddModule_Click(object sender, EventArgs e)
    {
        PopupControl2.ShowOnPageLoad = true;
    }
    //插入题型
    protected void QtypeInsert_Click(object sender, EventArgs e)
    {
        int regID = Convert.ToInt32(Request.QueryString["regID"].ToString());
        Registration rs = new Registration();
        int id = Convert.ToInt32(regID);
        int state = rs.GetStateByRegID(id);
        if (state == 1)
        {
            insertQtype(sender, e);
        }
        else if (state == 2)
        {
            insertQtype(sender, e);
            rs.UpdateState(1, id);
        }
    }
    public void insertQtype(object sender, EventArgs e)
    {
        int regID = Convert.ToInt32(Request.QueryString["regID"].ToString());
        Detail d = new Detail();
        int detailID = d.getDetailID(regID);
        string qtype = Textbox0.Text;
        string quanity = TextBox1.Text;
        string score = TextBox2.Text;
        if (isNumberic(quanity) && isNumberic(score))
        {
            string strInsert = string.Format("insert into Questiontype(qtypeName,quantity,score,DetailID)"
                + "values ('{0}','{1}','{2}','{3}')", qtype, quanity, score, detailID);
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand(strInsert, con);
            cmd.ExecuteNonQuery();
            con.Close();
            this.GridView1.DataBind();
            GridView1.DataBind();
            TextBox1.BorderColor = System.Drawing.Color.White;
            TextBox2.BorderColor = System.Drawing.Color.White;
            PopupControl1.ShowOnPageLoad = false;
        }
        else
        {
            MsgBox.ShowMessage("有不符合规定字符串，请重新输入！");
            for (int i = 0; i < 2; i++)
            {
                if (!isNumberic(quanity)) TextBox1.BorderColor = System.Drawing.Color.Red;
                if (!isNumberic(score)) TextBox2.BorderColor = System.Drawing.Color.Red;
            }
            return;
        }
    
    } 
    //插入模块
    protected void ModuleInsert_Click(object sender, EventArgs e)
    {  
        int regID = Convert.ToInt32(Request.QueryString["regID"].ToString());
        Registration rs = new Registration();
        int id = Convert.ToInt32(regID);
        int state = rs.GetStateByRegID(id);
        if(state == 1){
            insertModule(sender,e);      
        }else if(state == 2){
            insertModule(sender, e);
            rs.UpdateState(1,id);
        }
    }
    public void insertModule(object sender, EventArgs e)
    {
        int regID = Convert.ToInt32(Request.QueryString["regID"].ToString());
        Detail d = new Detail();
        int detailID = d.getDetailID(regID);
        string k1 = TextBox3.Text;
        string k2 = TextBox4.Text;
        string k3 = TextBox5.Text;
        string s1 = TextBox6.Text;
        string s2 = TextBox7.Text;
        string s3 = TextBox8.Text;
        string c1 = TextBox9.Text;
        string c2 = TextBox10.Text;
        string c3 = TextBox11.Text;
        string i1 = TextBox12.Text;
        string i2 = TextBox13.Text;
        string i3 = TextBox14.Text;
        string modulename = TextBox15.Text;
        

        if (isNumberic(k1) && isNumberic(k2) && isNumberic(k3) && isNumberic(s1) && isNumberic(s2) && isNumberic(s3) && isNumberic(c1) && isNumberic(c2) && isNumberic(c3) && isNumberic(i1) && isNumberic(i2) && isNumberic(i3))
        {
            if ((int.Parse(k1) +int.Parse(k2)  + int.Parse(k3)+int.Parse(s1) + int.Parse(s2) + int.Parse(s3)+int.Parse(c1) + int.Parse(c2) + int.Parse(c3)+int.Parse(i1)+int.Parse(i2)+ int.Parse(i3))==0)
            {
                MsgBox.ShowMessage("总分值不能为0，请重新输入！");
            }
            else { 
            string strInsert = string.Format("insert into Module(knowledge1,knowledge2,knowledge3,skill1,skill2,skill3,conprehensive1,conprehensive2,conprehensive3,innovation1,innovation2,innovation3,mouduleName,DetailID)"
            + "values ('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{9}','{10}','{11}','{12}','{13}')", k1, k2, k3, s1, s2, s3, c1, c2, c3, i1, i2, i3, modulename, detailID);
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand(strInsert, con);
            cmd.ExecuteNonQuery();
            con.Close();
            GridView2.DataBind();
            TextBox3.BorderColor = System.Drawing.Color.White;
            TextBox4.BorderColor = System.Drawing.Color.White;
            TextBox5.BorderColor = System.Drawing.Color.White;
            TextBox6.BorderColor = System.Drawing.Color.White;
            TextBox7.BorderColor = System.Drawing.Color.White;
            TextBox8.BorderColor = System.Drawing.Color.White;
            TextBox9.BorderColor = System.Drawing.Color.White;
            TextBox10.BorderColor = System.Drawing.Color.White;
            TextBox11.BorderColor = System.Drawing.Color.White;
            TextBox12.BorderColor = System.Drawing.Color.White;
            TextBox13.BorderColor = System.Drawing.Color.White;
            TextBox14.BorderColor = System.Drawing.Color.White;
            PopupControl2.ShowOnPageLoad = false;
            }
        }
        else
        {
            MsgBox.ShowMessage("有不符合规定字符串，请重新输入！");
            for (int i = 0; i < 12; i++)
            {
                if (!isNumberic(k1)) TextBox3.BorderColor = System.Drawing.Color.Red;
                if (!isNumberic(k2)) TextBox4.BorderColor = System.Drawing.Color.Red;
                if (!isNumberic(k3)) TextBox5.BorderColor = System.Drawing.Color.Red;
                if (!isNumberic(s1)) TextBox6.BorderColor = System.Drawing.Color.Red;
                if (!isNumberic(s2)) TextBox7.BorderColor = System.Drawing.Color.Red;
                if (!isNumberic(s3)) TextBox8.BorderColor = System.Drawing.Color.Red;
                if (!isNumberic(c1)) TextBox9.BorderColor = System.Drawing.Color.Red;
                if (!isNumberic(c2)) TextBox10.BorderColor = System.Drawing.Color.Red;
                if (!isNumberic(c3)) TextBox11.BorderColor = System.Drawing.Color.Red;
                if (!isNumberic(i1)) TextBox12.BorderColor = System.Drawing.Color.Red;
                if (!isNumberic(i2)) TextBox13.BorderColor = System.Drawing.Color.Red;
                if (!isNumberic(i3)) TextBox14.BorderColor = System.Drawing.Color.Red;
            }
            return;
        }
    
    }












}









