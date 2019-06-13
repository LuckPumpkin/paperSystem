using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WebForms_Common_QuestiontypeReport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        int detID = Convert.ToInt32(Request.QueryString["detID"].ToString());
        Detail d = new Detail();
       // int detID = d.GetDetailID(regID);
        QuestiontypeReport rpt = new QuestiontypeReport(detID);
        rvQuestiontype.Report = rpt;
        rvQuestiontype.DataBind();
    }
}