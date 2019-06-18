using iTextSharp.text;
using iTextSharp.text.pdf;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WebForms_PrintAdmin_PaperAudit : System.Web.UI.Page
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
        int index = Convert.ToInt32(e.CommandArgument);
        string course_teacherno = ((Label)gvCourse.Rows[index].FindControl("lbTeacher")).Text;
        string course_no = ((Label)gvCourse.Rows[index].FindControl("lblCourseNo")).Text;
        string course_dept = ((Label)gvCourse.Rows[index].FindControl("lbcourse_dept")).Text;
        string teachingplan = ((Label)gvCourse.Rows[index].FindControl("lbteacherplan")).Text;
        string type = ((Label)gvCourse.Rows[index].FindControl("lbpapertype")).Text;
        string newFileName = (teachingplan + "_" + course_dept + "_" + course_teacherno + "_" + course_no + "_" + type + "卷.pdf");
        string path = ("../Downloads/").ToString();
        string pdfPath = path + newFileName;
        if (e.CommandName == "PDF")
        {  
            popupPDF.ContentUrl = "/../pdf.js/web/viewer.html?file=/../"+pdfPath;
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
                    string s = ((Label)gvCourse.Rows[i].FindControl("lblregID")).Text;
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
                    string s = ((Label)gvCourse.Rows[i].FindControl("lbcourseID")).Text; 
                    //string s = ((Label)gvCourse.Rows[i].FindControl("lblregID")).Text;
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
            Registration reg = new Registration();
            Paper paper = new Paper();
            State st = new State();
            int stateID = st.GetPostStateID("试卷印刷部待审", "试卷印刷部审核" + DropDownList2.SelectedValue.ToString());
            for (i = 0; i < idList.Count; i++)
            {               
                ////获取当前记录的PaperID
                //int s = Convert.ToInt32(idList[i]);
                //int ss = paper.GetPaperIDByregID(s);  
                //int courseID = reg.GetCourseIDByRegID(s);
                

                //reg.UpdateState(stateID, Convert.ToInt32(idList[i].ToString()));
                //string state = st.GetPostStateName(stateID);
                //string regid = ((Label)gvCourse.Rows[i].FindControl("lblregID")).Text;
                //if (stateID == 1)
                //{
                //    paper.UpdateExitReaded(Convert.ToInt32(regid));
                //}

                //paper.UpdatePaperStateByPaperID(state, ss);

                //获取当前记录的PaperID
                int courseID = Convert.ToInt32(idList[i]);
                //int s = Convert.ToInt32(idList[i]);
                //int ss = paper.GetPaperIDByregID(courseID);
                //int courseID = reg.GetCourseIDByRegID(s);
                //reg.UpdateState(stateID, Convert.ToInt32(idList[i].ToString()));
                reg.UpdateStateByCourseID(stateID, Convert.ToInt32(idList[i].ToString()));
                string state = st.GetPostStateName(stateID);
                string regid = ((Label)gvCourse.Rows[i].FindControl("lblregID")).Text;
                if (stateID == 1)
                {
                    paper.UpdateExitReaded(Convert.ToInt32(regid));
                }

                paper.UpdatepaperstateByCourseID(state, courseID);

            }

        }
        popupAuditEdit.ShowOnPageLoad = false;
        gvCourse.DataBind();
    }
}
