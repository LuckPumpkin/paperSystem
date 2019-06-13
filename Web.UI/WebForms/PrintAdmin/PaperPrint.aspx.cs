using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;


public partial class WebForms_PrintAdmin_PaperPrint : System.Web.UI.Page
{
     public static string papid;
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    //送印操作 
    protected void gvOrder_RowCommand(object sender, GridViewCommandEventArgs e)
    {

        if (e.CommandName == "print")
        {
            int index = Convert.ToInt32(e.CommandArgument);
            string PiD = ((Label)gvOrder.Rows[index].FindControl("lbPid")).Text;
            popupEditCourseAttribute.ShowOnPageLoad = true;
            papid = PiD;
        }
    }
    
    protected void mnuToolBar_ItemClick2(object source, DevExpress.Web.ASPxMenu.MenuItemEventArgs e)
    {

        string audit = paperStandard.SelectedValue;
        string sord = SingleOrDouble.SelectedValue;
        Paper paper = new Paper();
        string state = paper.GetPaperStateByPaperID(Convert.ToInt32(papid));
        if (state == "试卷待送印")
        {
            paper.UpdatePaperStandardByPapaerID(audit, Convert.ToInt32(papid));
            paper.UpdatePaperSingleOrDoubleByPaperID(sord, Convert.ToInt32(papid));
            paper.UpdatePaperState1(Convert.ToInt32(papid));
            popupOrder.ContentUrl = "../PrintAdmin/OrderPrint.aspx?PID=" + papid;
            popupOrder.ShowOnPageLoad = true;
            popupEditCollege.ShowOnPageLoad = false;
            popupEditCourseAttribute.ShowOnPageLoad = false;
        }
        else
        {
            popupEditCourseAttribute.ShowOnPageLoad = false;
            MsgBox.ShowMessage("有记录不符合要求，请重新确定！");
        }
        gvOrder.DataBind();
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        gvOrder.DataBind();
    }
    protected void CheckBox_CheckedChanged(object sender, EventArgs e)
    {
        if (gvOrder.Rows.Count != 0)
        {
            if (CheckBox.Checked == true)
            {
                for (int i = 0; i < gvOrder.Rows.Count; i++)
                {
                    (gvOrder.Rows[i].FindControl("CheckBox") as CheckBox).Checked = true;
                }
            }
            else
            {
                for (int i = 0; i < gvOrder.Rows.Count; i++)
                {
                    (gvOrder.Rows[i].FindControl("CheckBox") as CheckBox).Checked = false;
                }
            }
        }
    }
    protected void mnuToolBar_ItemClick(object source, DevExpress.Web.ASPxMenu.MenuItemEventArgs e)
    {
        List<string> idList = new List<string>();
        if (gvOrder.Rows.Count != 0)
        {
            for (int i = 0; i < gvOrder.Rows.Count; i++)
            {
                if (((CheckBox)gvOrder.Rows[i].FindControl("CheckBox")).Checked == true)
                {
                    string s = ((Label)gvOrder.Rows[i].FindControl("lbPid")).Text;
                    idList.Add(s);
                }
            }
        }
        if (idList.Count == 0)
        {
            popupEditCollege.ShowOnPageLoad = false;
            PopupControljiezhagn.ShowOnPageLoad = false;
            PopupControlshenhe.ShowOnPageLoad = false;
            MsgBox.ShowErrorMessage("请选择！");
        }
    }
    //撤销送印 
    protected void mnuToolBar_ItemClick1(object source, DevExpress.Web.ASPxMenu.MenuItemEventArgs e)
    {
        List<string> idList = new List<string>();
        if (gvOrder.Rows.Count != 0)
        {
            for (int i = 0; i < gvOrder.Rows.Count; i++)
            {
                if (((CheckBox)gvOrder.Rows[i].FindControl("CheckBox")).Checked == true)
                {
                    string s = ((Label)gvOrder.Rows[i].FindControl("lbPid")).Text;
                    idList.Add(s);
                }
            }
        }
        if (idList.Count == 0)
        {
            popupEditCollege.ShowOnPageLoad = false;
            PopupControljiezhagn.ShowOnPageLoad = false;
            PopupControlshenhe.ShowOnPageLoad = false;
            MsgBox.ShowErrorMessage("请选择！");
        }
        else
        {
            Paper paper = new Paper();
            for (int i = 0; i < idList.Count; i++)
            {
                int s = Convert.ToInt32(idList[i]);
                string state = paper.GetPaperStateByPaperID(s);
                if (state == "试卷待结账")
                {
                    popupEditCollege.ShowOnPageLoad = false;
                    paper.UpdatePrintState0(s);
                }
                else
                {
                    popupEditCollege.ShowOnPageLoad = false;
                    PopupControljiezhagn.ShowOnPageLoad = false;
                    PopupControlshenhe.ShowOnPageLoad = false;
                    MsgBox.ShowMessage("有记录不符合要求，请重新确定！");
                    break;
                }
            }
        }
        popupEditCollege.ShowOnPageLoad = false;
        gvOrder.DataBind();
    }
    //结账操作
    protected void mnuToolBar_ItemClickjiezhang(object source, DevExpress.Web.ASPxMenu.MenuItemEventArgs e)
    {
        List<string> idList = new List<string>();
        if (gvOrder.Rows.Count != 0)
        {
            for (int i = 0; i < gvOrder.Rows.Count; i++)
            {
                if (((CheckBox)gvOrder.Rows[i].FindControl("CheckBox")).Checked == true)
                {
                    string s = ((Label)gvOrder.Rows[i].FindControl("lbPid")).Text;
                    idList.Add(s);
                }
            }
        }
        if (idList.Count == 0)
        {
            popupEditCollege.ShowOnPageLoad = false;
            PopupControljiezhagn.ShowOnPageLoad = false;
            PopupControlshenhe.ShowOnPageLoad = false;
            MsgBox.ShowErrorMessage("请选择！");
        }
        else
        {
            Paper paper = new Paper();
            for (int i = 0; i < idList.Count; i++)
            {
                int s = Convert.ToInt32(idList[i]);
                string state = paper.GetPaperStateByPaperID(s);
                if (state == "试卷待送印")
                {
                    PopupControljiezhagn.ShowOnPageLoad = false;
                    MsgBox.ShowMessage("有记录不符合要求，请重新确定！");
                }
                else
                {
                    PopupControljiezhagn.ShowOnPageLoad = false;
                    paper.UpdatePaperState2(s);
                }
            }
        }
        PopupControljiezhagn.ShowOnPageLoad = false;
        gvOrder.DataBind();

    }
    
    
    //撤销审核操作
    protected void mnuToolBar_ItemClickshenhe(object source, DevExpress.Web.ASPxMenu.MenuItemEventArgs e)
    {
        List<string> idList = new List<string>();
        if (gvOrder.Rows.Count != 0)
        {
            for (int i = 0; i < gvOrder.Rows.Count; i++)
            {
                if (((CheckBox)gvOrder.Rows[i].FindControl("CheckBox")).Checked == true)
                {
                    string s = ((Label)gvOrder.Rows[i].FindControl("lbPid")).Text;
                    idList.Add(s);
                }
            }
        }
        if (idList.Count == 0)
        {
            popupEditCollege.ShowOnPageLoad = false;
            PopupControljiezhagn.ShowOnPageLoad = false;
            PopupControlshenhe.ShowOnPageLoad = false;
            MsgBox.ShowErrorMessage("请选择！");
        }
        else
        {
            Paper paper = new Paper();
            for (int i = 0; i < idList.Count; i++)
            {
                int s = Convert.ToInt32(idList[i]);
                string state = paper.GetPaperStateByPaperID(s);
                int printed =paper.GetprintedByPaperID(s);
                if (state != "试卷待送印" && printed != 1)
                {
                    PopupControlshenhe.ShowOnPageLoad = false;
                    MsgBox.ShowMessage("有记录不符合要求，请重新确定！");
                }
                else
                {
                    PopupControlshenhe.ShowOnPageLoad = false;
                    paper.UpdateshenheState(s);
                }
            }
        }
        PopupControlshenhe.ShowOnPageLoad = false;
        gvOrder.DataBind();

    }

}
