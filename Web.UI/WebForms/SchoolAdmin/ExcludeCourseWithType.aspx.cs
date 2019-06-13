using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class WebForms_SchoolAdministrator_ExcludeCourseWithType : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }
    protected void LinkButtonSearch_Click(object sender, EventArgs e)
    {
        DynamicDataSource();
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
            string excludeType = cboType0.SelectedValue.Trim();
            for (i = 0; i < idList.Count; i++)
            {
                ex.ExamUpdateTypeByID(excludeType, Convert.ToInt32(idList[i].ToString()));
            }
        }
        popupEdit.ShowOnPageLoad = false;
        DynamicDataSource();
        gvExCourse.DataBind();
        CheckBox.Checked = false;
    }
    protected void DynamicDataSource()
    {
        string sql;
        sql = ("select * from [ExaminationCourse] where class_campus like '" + cboSchool.SelectedValue.Trim() + "'").ToString();
        if (cboType.SelectedItem != null)
        {
            switch (cboType.SelectedValue.Trim())
            {
                case "":
                    sql = "";
                    break;
                case "%":
                    break;
                default:
                    sql = (sql + " and " + cboType.SelectedValue.Trim()).ToString();
                    break;
            }
        }
        if (chkIsNull.Checked == true && chkIsNotNull.Checked == false)
            sql = sql + " and type is null";
        else if (chkIsNull.Checked == false && chkIsNotNull.Checked == true)
            sql = sql + " and type is not null";

        sdsExCourse.SelectCommand = sql;
    }
}