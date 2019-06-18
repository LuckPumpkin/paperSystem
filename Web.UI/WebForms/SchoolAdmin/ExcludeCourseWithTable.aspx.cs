using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WebForms_SchoolAdministrator_ExcludeCourseWithTable : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }
    
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        GridViewRow row = (GridViewRow)((sender as LinkButton).NamingContainer);
        int ID = Convert.ToInt32((row.FindControl("ID") as Label).Text.ToString());
        Exclude ex = new Exclude();
        ex.DeleteByID(ID);
        gvExCourse.DataBind();
    }
    
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        popupAdd.ContentUrl = "AddExcludeCourse.aspx";
        popupAdd.ShowOnPageLoad = true; 
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        gvExCourse.DataBind();
    }
    protected void CheckBox_CheckedChanged(object sender, EventArgs e)
    {
        if (gvExCourse.Rows.Count != 0)
        {
            if (CheckBox.Checked == true)
            {
                for (int i = 0; i < gvExCourse.Rows.Count; i++)
                {
                    (gvExCourse.Rows[i].FindControl("CheckBox") as CheckBox).Checked = true;
                }
            }
            else
            {
                for (int i = 0; i < gvExCourse.Rows.Count; i++)
                {
                    (gvExCourse.Rows[i].FindControl("CheckBox") as CheckBox).Checked = false;
                }
            }
        }
    }
    protected void btnExclued_Click(object sender, EventArgs e)
    {
        Exclude ex = new Exclude();
        int n = ex.UpdateByExcludeCourse();
        MsgBox.ShowMessage("一共更新了"+n.ToString()+"门课程！");
    }
    protected void mnuToolBar_ItemClick(object source, DevExpress.Web.ASPxMenu.MenuItemEventArgs e)
    {

        List<string> idList = new List<string>();
        if (gvExCourse.Rows.Count != 0)
        {
            for (int i = 0; i < gvExCourse.Rows.Count; i++)
            {
                if (((CheckBox)gvExCourse.Rows[i].FindControl("CheckBox")).Checked == true)
                {
                    string s = ((Label)gvExCourse.Rows[i].FindControl("ID")).Text;
                    idList.Add(s);
                }
            }
        }
        if (idList.Count == 0)
        {
            MsgBox.ShowErrorMessage("请选择！");
        }
        else
        {
            int i;
            Exclude ex = new Exclude();
            string excludeType = cboType.SelectedValue.Trim();
            for (i = 0; i < idList.Count; i++)
            {
                ex.ExcludeUpdateTypeByID(excludeType, Convert.ToInt32(idList[i].ToString()));
            }
        }
        popupEdit.ShowOnPageLoad = false;
        gvExCourse.DataBind();
    }
}