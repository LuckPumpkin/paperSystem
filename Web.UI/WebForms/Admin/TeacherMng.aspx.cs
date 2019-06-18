using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WebForms_Admin_TeacherMng : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void gvTeacher_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "EditTeacher")
        {
            int index = Convert.ToInt32(e.CommandArgument);
            Branch bran = new Branch();
            txtAccount.Text = ((Label)gvTeacher.Rows[index].FindControl("lblAccount")).Text;
            txtName.Text = ((Label)gvTeacher.Rows[index].FindControl("lblName")).Text;
            cboCollege.SelectedValue = bran.GetBranchIdByBranchName(((Label)gvTeacher.Rows[index].FindControl("lblCollege")).Text).ToString();
            cboSex.SelectedValue = ((Label)gvTeacher.Rows[index].FindControl("lblSex")).Text;
            txtTel.Text = ((Label)gvTeacher.Rows[index].FindControl("lblTel")).Text;
            txtUserCode.Value = ((Label)gvTeacher.Rows[index].FindControl("lblUserCode")).Text;
            popupSaveTeacher.ShowOnPageLoad = true;
        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {

    }
    protected void mnuToolBar1_ItemClick(object source, DevExpress.Web.ASPxMenu.MenuItemEventArgs e)
    {
        User us = new User();
        Teacher te = new Teacher();
        us.UpdateUser(txtAccount.Text, Convert.ToInt32(cboCollege.SelectedValue), txtName.Text, txtTel.Text, cboSex.SelectedValue, txtUserCode.Value);
        te.UpdateByUserCode(txtAccount.Text, txtName.Text, cboCollege.SelectedItem.ToString(), cboSex.SelectedValue,txtTel.Text, txtUserCode.Value);
        popupSaveTeacher.ShowOnPageLoad = false;
        gvTeacher.DataBind();
    }
}