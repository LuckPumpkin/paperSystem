using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WebForms_Admin_Paramter : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string ID;
             
        gvParameter.DataBind();

    }
    protected void gvCourse_RowCommand(object sender,GridViewCommandEventArgs e)
    {
        if (e.CommandName == "xiugai")
        {
            int index = Convert.ToInt32(e.CommandArgument);
            txtID.Value = ((Label)gvParameter.Rows[index].FindControl("lbID")).Text;
            txtparaName.Text = ((Label)gvParameter.Rows[index].FindControl("lbName")).Text;
            txtpareValue.Text = ((Label)gvParameter.Rows[index].FindControl("lbpara")).Text;
            popupSaveParameter.ShowOnPageLoad = true;
        }

    }
    protected void mnuToolBar1_ItemClick(object source, DevExpress.Web.ASPxMenu.MenuItemEventArgs e)
    {
        int id = Convert.ToInt32(txtID.Value);
        float para = Convert.ToSingle(txtpareValue.Text);
        Parameter p = new Parameter();
        p.UpdateParaValue(para,id);
        popupSaveParameter.ShowOnPageLoad = false;
        gvParameter.DataBind();
        MsgBox.ShowMessage("修改成功！");
    }
}