using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.UI.HtmlControls;
using System.Text;
using System.Configuration;
using System.Data.SqlClient;
using SysData = System.Data;
using System.Data.OleDb;
using DevExpress.Web.ASPxTreeView;
using System.IO;

public partial class WebForms_Admin_BranchMng : System.Web.UI.Page
{
    Branch bs = new Branch();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            txtTeacherID.Value = Convert.ToString(Session["UserCode"]);
            User us = new User();
            Branch b = new Branch();
            txtAccount.Value = us.GetAccount(txtTeacherID.Value).ToString();
            txtCollege.Value = us.GetCollege(txtTeacherID.Value).ToString();
            txtPbrID.Value = b.GetBranchIdByBranchName(txtCollege.Value).ToString();
            gvSysAdmin.DataBind();
            GenerateBranchTree(txtCollege.Value);
        }
    }
    protected void btnExcel_Click(object sender, EventArgs e)
    {
        Response.ClearContent();
        Response.ContentType = "application/vnd.ms-excel";//确定类型
        string filename = txtCollege.Value+"院系列表.xls";
        if (Request.UserAgent.ToLower().IndexOf("msie") > -1)
            filename = Attachment.ToHexString(filename);
        //为了向客户端输出空格，需要在当客户端使用 Firefox 时特殊处理
        if (Request.UserAgent.ToLower().IndexOf("firefox") > -1)
            Response.AddHeader("Content-Disposition", "attachment;filename=\"" + filename + "\"");
        else
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + HttpUtility.UrlEncode(filename, System.Text.Encoding.UTF8)); // 下载后的文件名，一定带拓展名（例：.xls）
        StringWriter sw = new StringWriter();
        HtmlTextWriter htw = new HtmlTextWriter(sw);
        gvSysAdmin.RenderControl(htw);
        Response.Write("<meta http-equiv=\"content-type\" content=\"application/vnd.ms-excel; charset=utf-8\"/>" + sw.ToString());
        Response.End();

    }
    //此方法需要重写，否则报错
    public override void VerifyRenderingInServerForm(Control control)
    {

    }

    #region GenerateBranchTree

    private void GenerateBranchTree(string college)
    {
        treeBranch.Nodes.Clear();
        int bid = bs.GetBranchIdByBranchName(college);
        DataTable dt = bs.GetBranchByBranchId(bid);
        DataRow b = dt.Rows[0];
        TreeViewNode root = new TreeViewNode(b["BranchName"].ToString(), b["BranchId"].ToString(), "../../images/branch_home.png");
        root.Expanded = true;
        treeBranch.Nodes.Add(root);
        treeBranch.SelectedNode = root;
        FillChildNodes(root);
    }

    protected void FillChildNodes(TreeViewNode node)
    {
        Branch bs = new Branch();
        DataTable dt = bs.GetChildBranches(Convert.ToInt32(node.Name));
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            TreeViewNode childNode = new TreeViewNode(dt.Rows[i]["BranchName"].ToString(), dt.Rows[i]["BranchId"].ToString(), "../../images/branch_node.png");
            node.Nodes.Add(childNode);
            FillChildNodes(childNode);
        }
    }
    #endregion
}