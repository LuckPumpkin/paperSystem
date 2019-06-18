using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WebForms_CollegeAdmin_CourseMng : System.Web.UI.Page
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
            Course co = new Course();
            string pro = cboType0.SelectedValue.ToString();
            for (i = 0; i < idList.Count; i++)
            {
                co.UpdateCourseProByID(Convert.ToInt32(idList[i].ToString()), pro);
             }
	    MsgBox.ShowMessage("修改成功！");
        }
        popupEdit.ShowOnPageLoad = false;
        gvExCourse.DataBind();
    }
}