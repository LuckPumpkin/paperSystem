using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WebForms_CollegeAdmin_OtherPrint : System.Web.UI.Page
{
     public static string papid;
    OtherPtint ot= new OtherPtint();
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
            ot.UpdateState1(Convert.ToInt32(PiD));
            popupOrder.ContentUrl = "../PrintAdmin/OrderPrint1.aspx?PID=" + PiD;
            popupOrder.ShowOnPageLoad = true;
        }
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
            MsgBox.ShowErrorMessage("请选择！");
        }
        else
        {
            
            for (int i = 0; i < idList.Count; i++)
            {
                int s = Convert.ToInt32(idList[i]);
                string state = ot.getStateByID(s);
                if (state == "待结账")
                {
                    popupEditCollege.ShowOnPageLoad = false;
                    ot.UpdateStateByID(s);
                    MsgBox.ShowMessage("撤销送印成功！");
                }
                else
                {
                    popupEditCollege.ShowOnPageLoad = false;
                    PopupControljiezhagn.ShowOnPageLoad = false;
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
            MsgBox.ShowErrorMessage("请选择！");
        }
        else
        {
            for (int i = 0; i < idList.Count; i++)
            {
                int s = Convert.ToInt32(idList[i]);
                string state = ot.getStateByID(s);
                if (state == "待送印")
                {
                    PopupControljiezhagn.ShowOnPageLoad = false;
                    MsgBox.ShowMessage("有记录不符合要求，请重新确定！");
                }
                else
                {
                    PopupControljiezhagn.ShowOnPageLoad = false;
                    decimal pr = ot.getSingleOrDo(s)=="单面"?Convert.ToDecimal(0.15):Convert.ToDecimal(0.20);
                    var bind = ot.getBingprint(s);
                    decimal dr = Convert.ToDecimal(0.00);
                    switch(bind){
                        case "骑马订黑白":
                            dr = Convert.ToDecimal(6);
                            break;
                        case "骑马订彩印":
                            dr = Convert.ToDecimal(10);
                            break;
                        case "胶订黑白":
                            dr = Convert.ToDecimal(10);
                            break;
                        case "胶订彩色":
                            dr = Convert.ToDecimal(15);
                            break;
                    }
                    ot.UpdateTotal(pr, dr, s);
                    ot.UpdateState2(s);
                    MsgBox.ShowMessage("结账成功！");
                }
            }
        }
        PopupControljiezhagn.ShowOnPageLoad = false;
        gvOrder.DataBind();

    }
}