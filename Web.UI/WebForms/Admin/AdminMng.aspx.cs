using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using SysData = System.Data;
using System.Web.UI.WebControls;
using System.Web.Security;

public partial class WebForms_Admin_AdminMng : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        LabelAdmin.Text = "系统管理员";
        gvSysAdmin.DataBind();
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        LabelAdmin.Text = DropDownUser.SelectedItem.Value;
        gvSysAdmin.DataBind();
    }

    protected void gvSysAdmin_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "DeleteAdmin")
        {
                int index = Convert.ToInt32(e.CommandArgument);
                LabelAdmin.Text = DropDownUser.SelectedItem.Value;
                gvSysAdmin.DataBind();
                txtUserID.Value = ((Label)gvSysAdmin.Rows[index].FindControl("lbUserCode")).Text;
                popupMsg.ShowOnPageLoad = true;
                gvSysAdmin.DataBind();
        }
    }
    protected void mnuMsg_ItemClick(object source, DevExpress.Web.ASPxMenu.MenuItemEventArgs e)
    {
        //删除管理员
        try
        {
            User us = new User();
            LabelAdmin.Text = DropDownUser.SelectedItem.Value;
            us.DeleteByUserCode(txtUserID.Value, LabelAdmin.Text);
            popupMsg.ShowOnPageLoad = false;
            MsgBox.ShowMessage("已删除！");
            gvSysAdmin.DataBind();

        }
        catch (Exception ex)
        {
            MsgBox.ShowErrorMessage(ex.Message);
        }
        
    }
    protected void Addadmin(object sender, EventArgs e)
    {
        LabelAdmin.Text = DropDownUser.SelectedItem.Value;
        popupSelectTeacher.ContentUrl = "../Admin/AddTeacher.aspx?roleName=" + LabelAdmin.Text;
        popupSelectTeacher.ShowOnPageLoad = true;
    }
}