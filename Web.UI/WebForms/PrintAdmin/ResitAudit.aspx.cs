using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WebForms_PrintAdmin_ResitAudit : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void CheckBox_CheckedChanged(object sender, EventArgs e)
    {
        if (gvCourse.Rows.Count != 0)
        {
            if (CheckBox.Checked == true)
            {
                for (int i = 0; i < gvCourse.Rows.Count; i++)
                {
                    (gvCourse.Rows[i].FindControl("CheckBox") as CheckBox).Checked = true;
                }
            }
            else
            {
                for (int i = 0; i < gvCourse.Rows.Count; i++)
                {
                    (gvCourse.Rows[i].FindControl("CheckBox") as CheckBox).Checked = false;
                }
            }
        }
    }

    protected void gvCourse_RowCommand(object sender, GridViewCommandEventArgs e)
    {

        if (e.CommandName == "PDF")
        {
            int index = Convert.ToInt32(e.CommandArgument);
            //string regID = ((Label)gvCourse.Rows[index].FindControl("lblregID")).Text;
            string course_teacherno = ((Label)gvCourse.Rows[index].FindControl("lbTeacher")).Text;
            string course_no = ((Label)gvCourse.Rows[index].FindControl("lblCourseNo")).Text;
            string course_dept = ((Label)gvCourse.Rows[index].FindControl("lbcourse_dept")).Text;
            string teachingplan = ((Label)gvCourse.Rows[index].FindControl("lbteacherplan")).Text;
            string type = ((Label)gvCourse.Rows[index].FindControl("lbpapertype")).Text;

            popupPDF.ContentUrl = "../PrintAdmin/paperPDF.aspx?teachingPlan=" + teachingplan + "&course_dept=" + course_dept
                + "&course_teacherno=" + course_teacherno + "&course_no=" + course_no + "&type=" + type;

            popupPDF.ShowOnPageLoad = true;
        }
    }

    protected void mnuMain_ItemClick(object source, DevExpress.Web.ASPxMenu.MenuItemEventArgs e)
    {
        List<string> idList = new List<string>();
        if (gvCourse.Rows.Count != 0)
        {
            for (int i = 0; i < gvCourse.Rows.Count; i++)
            {
                if (((CheckBox)gvCourse.Rows[i].FindControl("CheckBox")).Checked == true)
                {
                    string s = ((Label)gvCourse.Rows[i].FindControl("lbPaperID")).Text;
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
            popupAuditEdit.ShowOnPageLoad = true;
        }
    }

    protected void mnuToolBar_ItemClick(object source, DevExpress.Web.ASPxMenu.MenuItemEventArgs e)
    {
        List<string> idList = new List<string>();
        if (gvCourse.Rows.Count != 0)
        {
            for (int i = 0; i < gvCourse.Rows.Count; i++)
            {
                if (((CheckBox)gvCourse.Rows[i].FindControl("CheckBox")).Checked == true)
                {
                    //int ss = Convert.ToInt32(((Label)gvCourse.Rows[i].FindControl("lblPaperID")).Text);
                    string s = ((Label)gvCourse.Rows[i].FindControl("lbPaperID")).Text;
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
           
            Paper paper = new Paper();
            State st = new State();
            int stateID = st.GetPostStateID("试卷印刷部待审", "试卷印刷部审核" + DropDownList2.SelectedValue.ToString());
            for (i = 0; i < idList.Count; i++)
            {
                //获取当前记录的PaperID
                int s =Convert.ToInt32(((Label)gvCourse.Rows[i].FindControl("lbPaperID")).Text);
                string state = st.GetPostStateName(stateID);
                if (stateID == 1)
                {
                    paper.UpdateEReadedByPID(s);
                }
                paper.UpdatePaperStateByPaperID(state, s);
            }
        }
        popupAuditEdit.ShowOnPageLoad = false;
        gvCourse.DataBind();
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        gvCourse.DataBind();
    }
   
}