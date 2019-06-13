using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

public partial class WebForms_Admin_RolesMng : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void btnInsert_Click(object sender, EventArgs e)
    {
      string role = txtRole.Text;
      if (Roles.RoleExists(role))
      {
        MsgBox.ShowErrorMessage("该角色已经存在，无法添加！");
        PopupControl.ShowOnPageLoad = false;
        return;
      }

      Roles.CreateRole(role);
      gvRoles.DataBind();
      PopupControl.ShowOnPageLoad = false;
    }

    protected void gvRoles_RowCommand(object sender, GridViewCommandEventArgs e)
    {
      if (e.CommandName == "DeleteRole")
      {
        GridViewRow row = (GridViewRow)((Control)e.CommandSource).NamingContainer;
        string role = row.Cells[0].Text;
        if (Roles.GetUsersInRole(role).Length > 0)
        {
          MsgBox.ShowErrorMessage("该角色下还有用户，无法删除角色！");
          return;
        }

        Roles.DeleteRole(role);
        gvRoles.DataBind();
      }
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
      PopupControl.ShowOnPageLoad = true;
      txtRole.Text = "";
    }

    protected void btnCreateSysRoles_Click(object sender, EventArgs e)
    {
      if (!Roles.RoleExists("系统管理员"))
          Roles.CreateRole("系统管理员");

      if (!Roles.RoleExists("校级管理员"))
          Roles.CreateRole("校级管理员");

      if (!Roles.RoleExists("院级管理员"))
          Roles.CreateRole("院级管理员");

      if (!Roles.RoleExists("系级管理员"))
          Roles.CreateRole("系级管理员");

      if (!Roles.RoleExists("教师"))
          Roles.CreateRole("教师");

      if (!Roles.RoleExists("打印部"))
          Roles.CreateRole("打印部");
    

      gvRoles.DataBind();

      MsgBox.ShowMessage("角色创建成功！");
    }

    protected void ldsRoles_ContextCreating(object sender, LinqDataSourceContextEventArgs e)
    {
      //DSApplication.RolesRow row;
      //DSApplication dsApplication = new DSApplication();
      //string[] roles = Roles.GetAllRoles();

      //foreach (string role in roles)
      //{
      //  row = dsApplication.Roles.NewRolesRow();
      //  row.Role = role;
      //  dsApplication.Roles.AddRolesRow(row);
      //}

      //e.ObjectInstance = dsApplication;
    }
}