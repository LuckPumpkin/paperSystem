using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WebForms_CollegeAdmin_ProfessionAdminMng : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            txtTeacherID.Value = Convert.ToString(Session["UserCode"]);
            User us = new User();
            txtCollege.Value = us.GetCollege(txtTeacherID.Value).ToString();
        }
    }

    protected void MgvTeacher_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Choose")
        {
            int i = Convert.ToInt32(e.CommandArgument);
            string UserCode = MgvTeacher.DataKeys[i].Value.ToString();
            try
            {
                Roles.AddUserToRole(UserCode, "系级管理员");
                MgvTeacher.DataBind();
            }
            catch (Exception ex)
            {
                MsgBox.ShowErrorMessage(ex.Message);
            }
            MgvSelectTeacher.DataBind();
        }
    }
    protected void MgvSelectTeacher_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "DeleteProMnger")
        {
            int i = Convert.ToInt32(e.CommandArgument);
            string UserCode = MgvSelectTeacher.DataKeys[i].Value.ToString();
            try
            {
                User us = new User();
                us.DeleteByUserCode(UserCode, "系级管理员");
                MgvTeacher.DataBind();
                MgvSelectTeacher.DataBind();
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