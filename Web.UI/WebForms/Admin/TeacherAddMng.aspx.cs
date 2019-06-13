using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WebForms_Admin_TeacherAddMng : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    class TeacherStruct
    {
        public string teacherno;
        public string teachername;
        public string college;
    }
    protected void mnuToolBar1_ItemClick(object source, DevExpress.Web.ASPxMenu.MenuItemEventArgs e)
    {
        List<TeacherStruct> idList = new List<TeacherStruct>();
        if (gvTeacher.Rows.Count != 0)
        {
            for (int i = 0; i < gvTeacher.Rows.Count; i++)
            {
                TeacherStruct t = new TeacherStruct();
                t.teacherno = ((Label)gvTeacher.Rows[i].FindControl("lblcourse_teacherno")).Text;
                t.teachername = ((Label)gvTeacher.Rows[i].FindControl("lblcourse_teachername")).Text;
                t.college = ((Label)gvTeacher.Rows[i].FindControl("lbcollege")).Text;
                idList.Add(t);
            }
        }
        for (int i = 0; i < idList.Count; i++)
        {
            User us = new User();
            Teacher te = new Teacher();
            Branch b = new Branch();
            //string Password = Membership.GeneratePassword(6, 2);
            string password = "123";
            try { 
            string userCode = Guid.NewGuid().ToString();
            us.InsertUser(userCode, idList[i].teacherno, idList[i].teachername, "", b.GetBranchIdByBranchName(idList[i].college), password, "", DateTime.Now, false, true, false);
            te.InsertTeacher(idList[i].teacherno, idList[i].teachername, idList[i].college, "", userCode);
            us.InsertUsersInRoles(userCode, "4");
            MsgBox.ShowMessage("补充教师数据导入成功！");
            }
            catch (Exception ex)
            {
                MsgBox.ShowErrorMessage(ex.Message);
            }
        }
        popupSaveTeacher.ShowOnPageLoad = false;
        gvTeacher.DataBind();
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        gvTeacher.DataBind();
    }
    protected void mnuMain_ItemClick(object source, DevExpress.Web.ASPxMenu.MenuItemEventArgs e)
    {
        popupSaveTeacher.ShowOnPageLoad = true;
    }
}