using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WebForms_SchoolAdministrator_CourseClassCollegeAttributeView : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    private void ExportGridViewForUTF8(GridView GridView, string filename)
    {
        string attachment = "attachment; filename=" + filename;
        Response.ClearContent();
        Response.Buffer = true;
        Response.AddHeader("content-disposition", attachment);
        Response.Charset = "UTF-8";
        Response.ContentEncoding = System.Text.Encoding.GetEncoding("UTF-8");
        Response.ContentType = "application/ms-excel";
        System.IO.StringWriter sw = new System.IO.StringWriter();
        HtmlTextWriter htw = new HtmlTextWriter(sw);
        GridView.RenderControl(htw);
        Response.Output.Write(sw.ToString());
        Response.Flush();
        Response.End();
    }

    protected void btnExport_Click1(object sender, EventArgs e)
    {
        if (gvExCourse.Rows.Count > 0)
        {
            gvExCourse.AllowPaging = false;
            gvExCourse.DataBind();
            ExportGridViewForUTF8(gvExCourse, DateTime.Now.ToShortDateString() + ".xls");
            gvExCourse.AllowPaging = true;
            gvExCourse.DataBind();
        }
        else
        {
            // obo.Common.MessageBox.Show(this, "没有数据可导出，请先查询数据!");
        }
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
        // Confirms that an HtmlForm control is rendered for
    }
}