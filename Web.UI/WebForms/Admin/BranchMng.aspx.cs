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
        gvSysAdmin.DataBind();
        if (!Page.IsPostBack)
        {
            GenerateBranchTree();
        }
    }

    #region GenerateBranchTree

    private void GenerateBranchTree()
    {
        treeBranch.Nodes.Clear();
        Branch bs = new Branch();
        DataTable dt = bs.GetRootBranch();
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

    #region mnuMain ItemClick

    protected void mnuMain_ItemClick(object source, DevExpress.Web.ASPxMenu.MenuItemEventArgs e)
    {

        if (treeBranch.SelectedNode == null)
        {
            MsgBox.ShowErrorMessage("请先选择部门。");
            return;
        }

        switch (e.Item.Name)
        {
            case "DeleteItem":
                if (treeBranch.Nodes[0] != null && treeBranch.Nodes[0] == treeBranch.SelectedNode)
                    MsgBox.ShowErrorMessage("无法删除根部门！");
                else
                    DeleteItem();
                break;
            case "down":
                btnExcel_Click();
                break;

        }
    }

    #endregion

    #region mnuToolBar_ItemClick

    protected void mnuToolBar_ItemClick(object source, DevExpress.Web.ASPxMenu.MenuItemEventArgs e)
    {
        int branchId;
        string selectedNode = treeBranch.SelectedNode.ToString();
        try
        {
            switch (hdMode.Value)
            {
                case "AddChild":
                    AddChild(selectedNode);
                    break;
                case "InsertItem":
                    InsertItem(selectedNode);
                    break;
                case "Edit":
                    branchId = bs.GetBranchIdByBranchName(selectedNode);
                    bs.UpdateBranchName(branchId, txtBranchName.Text);
                    treeBranch.SelectedNode.Text = txtBranchName.Text;
                    MsgBox.ShowMessage("修改成功！！");
                    break;
            }
            popupEdit.ShowOnPageLoad = false;
        }
        catch (Exception ex)
        {
            MsgBox.ShowErrorMessage(ex.Message);
        }
    }

    #endregion
    private void AddChild(string selectedNode)
    {
        int branchId;
        TreeViewNode newNode;
        Branch bs = new Branch();
        TreeViewNode parentNode = treeBranch.SelectedNode;
        List<TreeViewNode> nodeList = new List<TreeViewNode>();
        foreach (TreeViewNode n in parentNode.Nodes)
            nodeList.Add(n);
        branchId = bs.GetBranchIdByBranchName(selectedNode) + getMillis() * 100;
        newNode = new TreeViewNode(txtBranchName.Text, branchId.ToString(), "../../images/branch_node.png");
        newNode.Expanded = true;
        if (nodeList.Count != 0)
        {
            if (!nodeList.Contains(newNode))
            {
                bs.InsertNewBranch(branchId, bs.GetBranchIdByBranchName(selectedNode), txtBranchName.Text);
                parentNode.Nodes.Add(newNode);
                MsgBox.ShowMessage("部门添加成功！");
            }
            else
            {
                MsgBox.ShowErrorMessage("已有此部门！");
                return;
            }
        }
        else
        {
            MsgBox.ShowErrorMessage("此部门不能添加下级部门！");
            return;
        }
    }
    #region InsertItem

    private void InsertItem(string selectedNode)
    {
        int branchId;
        TreeViewNode newNode;
        Branch bs = new Branch();
        TreeViewNode parentNode = treeBranch.SelectedNode.Parent;
        string selectedNodeValue = treeBranch.SelectedNode.Name;
        List<TreeViewNode> nodeList = new List<TreeViewNode>();
        foreach (TreeViewNode n in parentNode.Nodes)
            nodeList.Add(n);
        parentNode.Nodes.Clear();
        branchId = bs.GetBranchIdByBranchName(selectedNode) + getMillis() * 100;
        newNode = new TreeViewNode(txtBranchName.Text, branchId.ToString(), "../../images/branch_node.png");
        newNode.Expanded = true;
        if (!nodeList.Contains(newNode))
        {
            bs.InsertNewBranch(branchId, bs.GetBranchIdByBranchName(selectedNode), txtBranchName.Text);
            foreach (TreeViewNode n in nodeList)
            {
                if (n.Name == selectedNodeValue)
                {
                    parentNode.Nodes.Add(newNode);
                    parentNode.Nodes.Add(n);
                    treeBranch.SelectedNode = n;
                }
                else
                    parentNode.Nodes.Add(n);
            }
            MsgBox.ShowMessage("部门添加成功！");
        }
        else
        {
            MsgBox.ShowErrorMessage("已有此部门！");
            return;
        }
    }
    #endregion

    #region DeleteItem

    private void DeleteItem()
    {
        int branchId;
        try
        {
            branchId = bs.GetBranchIdByBranchName(treeBranch.SelectedNode.ToString());
            DataTable dtRoot = bs.GetRootBranch();
            DataTable dtChildren = bs.GetChildBranches(branchId);
            User us = new User();
            DataTable dtUsers = us.GetUsersByBranchId(branchId);

            if (dtChildren.Rows.Count > 0)
            {
                throw new Exception("当前部门尚有子部门存在，无法执行删除操作！");
            }
            else
                if (dtRoot.Rows[0]["ParentBranchID"] == null)
                {
                    throw new Exception("无法删除根部门！");
                }
                else
                    if (dtUsers.Rows.Count > 0)
                    {
                        throw new Exception("当前部门尚有用户存在，无法执行删除操作！");
                    }
                    else
                    {
                        bs.DeleteByBranchId(branchId);

                        TreeViewNode currentNode = treeBranch.SelectedNode;
                        TreeViewNode parentNode = treeBranch.SelectedNode.Parent;
                        bool isFirst = false, isLast = false;
                        if (currentNode == parentNode.Nodes[0])
                            isFirst = true;
                        if (currentNode == parentNode.Nodes[parentNode.Nodes.Count - 1])
                            isLast = true;
                        if (isFirst && isLast) //-- 这是唯一一个子节点，删除上自动选中父节点。
                        {
                            parentNode.Nodes.Remove(currentNode);
                            treeBranch.SelectedNode = parentNode;
                        }
                        else if (isLast)  //-- 这是最后一个节点，删除后，仍然选中最后一个节点
                        {
                            int cnt = parentNode.Nodes.Count;
                            parentNode.Nodes.Remove(currentNode);
                            treeBranch.SelectedNode = parentNode.Nodes[cnt - 2];
                        }
                        else  //-- 选中当前节点的下一个节点
                        {
                            int p = 0;
                            for (p = 0; p < parentNode.Nodes.Count; p++)
                                if (parentNode.Nodes[p] == currentNode)
                                    break;
                            parentNode.Nodes.Remove(currentNode);
                            treeBranch.SelectedNode = parentNode.Nodes[p];
                        }
                        MsgBox.ShowMessage("删除部门成功！");
                    }
        }
        catch (Exception ex)
        {
            MsgBox.ShowErrorMessage(ex.Message);
        }
    }

    #endregion
    public int getMillis()
    {
        string time = DateTime.Now.Second.ToString();
        return Convert.ToInt32(time);
    }
    protected void btnExcel_Click()
    {
        Response.ClearContent();
        Response.ContentType = "application/vnd.ms-excel";//确定类型
        string filename = "部门列表.xls";
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
    protected void btnExcel(object sender, EventArgs e)
    {
      string strResult = string.Empty;
      string strPath = Server.MapPath("~/xls/");
      string filename = "Branch.xls";
      string strFile = string.Format(@"{0}\{1}", strPath, filename);
      if (strFile == "")
      {
         MsgBox.ShowErrorMessage("无下载模板，请联系系统管理员添加下载模板!");
      }
      else { 
        using (FileStream fs = new FileStream(strFile, FileMode.Open))
        {
          byte[] bytes = new byte[(int)fs.Length];
          fs.Read(bytes, 0, bytes.Length);
          fs.Close();
          Response.ContentType = "application/octet-stream";
          if (Request.UserAgent.ToLower().IndexOf("msie") > -1)
              filename = Attachment.ToHexString(filename);

          //为了向客户端输出空格，需要在当客户端使用 Firefox 时特殊处理
          if (Request.UserAgent.ToLower().IndexOf("firefox") > -1)
              Response.AddHeader("Content-Disposition", "attachment;filename=\"" + filename + "\"");
          else
              Response.AppendHeader("Content-Disposition", "attachment; filename=" + HttpUtility.UrlEncode(filename, System.Text.Encoding.UTF8));
          Response.BinaryWrite(bytes);
          Response.Flush();
         }
      }

    }
    //此方法需要重写，否则报错
    public override void VerifyRenderingInServerForm(Control control)
    {

    }
    protected void btnImport_Click(object sender, EventArgs e)
    {
        var files = Request.Files;
        try
        {
            for (int i = 0; i < files.Count; i++)
            {
                HttpPostedFile postedFile = files[i];
                string fileName = System.IO.Path.GetFileName(postedFile.FileName);
                string fileExtension = System.IO.Path.GetExtension(fileName);    //获取文件类型 
                if (fileExtension == ".xls" || fileExtension == ".xlsx")
                {
                    postedFile.SaveAs(Server.MapPath("~/xls/11.xls"));
                }
                else
                {
                    MsgBox.ShowErrorMessage("请导入正确Excel格式文件!");
                    return;
                }
            }
        }
        catch (Exception ex)
        {
            MsgBox.ShowErrorMessage(ex.Message);
            return;
        }
        string FilePath = Server.MapPath("~/xls/11.xls");
        DataTable Exceldt = GetExcelDatatable(FilePath, "mapTable");
        UpdateTableData(Exceldt, "Branch");
    }
    public System.Data.DataTable GetExcelDatatable(string fileUrl, string table)
    {
        //office2007之前 仅支持.xls......const string cmdText = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source={0};Extended Properties='Excel 8.0;IMEX=1';"
        //支持.xls和.xlsx，即包括office2010等版本的   HDR=Yes代表第一行是标题，不是数据；
        const string cmdText = "Provider=Microsoft.Ace.OleDb.12.0;Data Source={0};Extended Properties='Excel 12.0; HDR=Yes; IMEX=1'";
        System.Data.DataTable dt = null;
        OleDbConnection conn = new OleDbConnection(string.Format(cmdText, fileUrl));
        try
        {
            if (conn.State == ConnectionState.Broken || conn.State == ConnectionState.Closed)
            {
                conn.Open();
            }
            System.Data.DataTable schemaTable = conn.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);
            //获取Excel的第一个Sheet名称
            string sheetName = schemaTable.Rows[0]["TABLE_NAME"].ToString().Trim();
            //查询sheet中的数据
            string strSql = "select * from [" + sheetName + "]";
            OleDbDataAdapter da = new OleDbDataAdapter(strSql, conn);
            DataSet ds = new DataSet();
            da.Fill(ds, table);
            dt = ds.Tables[0];
            return dt;
        }
        catch (Exception exc)
        {
            throw exc;
        }
        finally
        {
            conn.Close();
            conn.Dispose();
        }
    }
    protected void UpdateTableData(System.Data.DataTable Exceldt, string NameOfTable)
    {

        System.Data.DataTable Sqldt = new DataTable();//存放指定表的所有列名，并按照数据库原有的列顺序排列。。。
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["AppConnStr"].ToString());
        conn.Open();
        SqlCommand cmd = conn.CreateCommand();
        cmd.CommandText = "delete Teacher;delete UsersInRoles;delete [User];TRUNCATE TABLE UsersInRoles;delete " + NameOfTable + ";";
        cmd.ExecuteNonQuery();
        cmd.CommandText = "Select * FROM " + NameOfTable;
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        SqlCommandBuilder sqlCB = new SqlCommandBuilder(da);
        da.Fill(Sqldt);
        conn.Close();
        int ErrorCount = 0;
        try
        {
            SqlTransaction tran = null;//声明一个事务对象  
            conn.Open();
            using (tran = conn.BeginTransaction())
            {
                using (SqlBulkCopy copy = new SqlBulkCopy(conn, SqlBulkCopyOptions.Default, tran))
                {
                    copy.DestinationTableName = "[dbo].[" + NameOfTable + "]";      //指定服务器上目标表的名称  
                    //列名称对应起来
                    for (int i = 0; i < Exceldt.Columns.Count; i++)
                    {
                        copy.ColumnMappings.Add(Exceldt.Columns[i].ColumnName, Sqldt.Columns[i].ColumnName);
                    }
                    copy.WriteToServer(Exceldt);                                        //执行把DataTable中的数据写入DB  
                    tran.Commit();                                                      //提交事务                                   
                }
            }
        }
        catch (Exception e)
        {
            MsgBox.ShowErrorMessage(e.ToString());
            return;
        }

        MsgBox.ShowMessage("插入成功！");
        cmd.CommandText = "Insert into [User] values('4','3591','125','闫海波',null,null,null,null,'123',null,null,null,null,null,null,null,'男');insert into [Teacher] values('3591','闫海波','机关','男',null,'4',null,null);Insert into [UsersInRoles] values('1','4')";
        cmd.ExecuteNonQuery();
        conn.Close();

    }
}