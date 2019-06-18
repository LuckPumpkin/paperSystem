using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WebForms_Admin_AddTeacher : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            txtRoleName.Value = Request.QueryString["roleName"].ToString();
            //txtRoleName.Value = "校级管理员";
            User us = new User();
            txtRoleId.Value = us.GetRid(txtRoleName.Value);
            MgvTeacher.DataBind();
        }
        
    }
    
    protected void MgvTeacher_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if(e.CommandName =="Choose")
        {
            int i = Convert.ToInt32(e.CommandArgument);
            string UserCode = MgvTeacher.DataKeys[i].Value.ToString();
            try
            {

                Roles.AddUserToRole(UserCode, txtRoleName.Value);
                MgvTeacher.DataBind();
            }
            catch (Exception ex)
            {
                MsgBox.ShowErrorMessage(ex.Message);
            }

        }
    }
    protected void LBSearch_Click(object sender, EventArgs e)
    {
        MgvTeacher.DataBind();
    }
}