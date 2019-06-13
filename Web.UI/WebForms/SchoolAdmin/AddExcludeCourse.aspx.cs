using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class WebForms_SchoolAdministrator_AddExcludeCourse : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
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

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        int n = 0;
        int m = 0;
        if (gvExCourse.Rows.Count != 0)
        {
            for (int i = 0; i < gvExCourse.Rows.Count; i++)
            {
                if (((CheckBox)gvExCourse.Rows[i].FindControl("CheckBox")).Checked == true)
                {
                    n = n + 1;
                    Exclude ex = new Exclude();
                    int s =Convert.ToInt32(((Label)gvExCourse.Rows[i].FindControl("ID")).Text);
                    DataRow dr = ex.SelectByID(s).Rows[0];
                    if (ex.CountByCourseNum(dr["course_num"].ToString()) == 0)
                    {
                        ex.AddExcludeCourse(dr);
                        m = m + 1;
                    }
                }
            }
        }
        MsgBox.ShowMessage("共选中"+n.ToString()+"门课程，成功添加"+m.ToString()+"门课程");
        CheckBox.Checked = false;
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
                ex.ExamUpdateTypeByID(excludeType, Convert.ToInt32(idList[i]));
            }
        }
        popupEdit.ShowOnPageLoad = false;
        gvExCourse.DataBind();
    }
}