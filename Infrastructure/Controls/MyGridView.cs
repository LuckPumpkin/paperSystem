using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Infrastructure.Controls
{
  public class MyGridView : GridView
  {
    public MyGridView()
    {
      this.CssClass = "dataTable";
      this.PagerStyle.CssClass = "pagerRow";
      this.HeaderStyle.CssClass = "FixedHeader";
      this.AlternatingRowStyle.CssClass = "alternateRow";
      this.EditRowStyle.CssClass = "highlightRow";
      this.SelectedRowStyle.CssClass = "selectedRow";

      this.PagerSettings.FirstPageText = "首页";
      this.PagerSettings.PreviousPageText = "上一页";
      this.PagerSettings.NextPageText = "下一页";
      this.PagerSettings.LastPageText = "尾页";
    }

    #region Override OnRowCreated

    protected override void OnRowCreated(GridViewRowEventArgs e)
    {
      base.OnRowCreated(e);
      if (e.Row.RowType == DataControlRowType.Pager)
        CreatePager(e.Row);
    }

    #endregion

    #region OnDataBound

    protected override void OnDataBound(EventArgs e)
    {
      base.OnDataBound(e);

      if (this.BottomPagerRow != null)
        CreatePager(this.BottomPagerRow);
    }

    #endregion

    #region CreatePager

    private void CreatePager(GridViewRow pagerRow)
    {
      pagerRow.Cells[0].Controls.Clear();
      TableCell c = pagerRow.Cells[0];

      Literal literal1 = new Literal();
      literal1.Text = "<div style=\"position: relative; float: left; margin: 3px 5px 0px 5px;\">";
      c.Controls.Add(literal1);

      LinkButton btnFirstPage = new LinkButton();
      btnFirstPage.ID = "LinkButtonFirstPage";
      btnFirstPage.CommandArgument = "First";
      btnFirstPage.CommandName = "Page";
      btnFirstPage.Enabled = (this.PageIndex != 0);
      btnFirstPage.Text = this.PagerSettings.FirstPageText;
      c.Controls.Add(btnFirstPage);

      Literal l1 = new Literal();
      l1.Text = " ";
      c.Controls.Add(l1);

      LinkButton btnPreviousPage = new LinkButton();
      btnPreviousPage.ID = "LinkButtonPreviousPage";
      btnPreviousPage.CommandArgument = "Prev";
      btnPreviousPage.CommandName = "Page";
      btnPreviousPage.Enabled = (this.PageIndex != 0);
      btnPreviousPage.Text = this.PagerSettings.PreviousPageText;
      c.Controls.Add(btnPreviousPage);

      Literal l2 = new Literal();
      l2.Text = " ";
      c.Controls.Add(l2);

      LinkButton btnNextPage = new LinkButton();
      btnNextPage.ID = "LinkButtonNextPage";
      btnNextPage.CommandArgument = "Next";
      btnNextPage.CommandName = "Page";
      btnNextPage.Enabled = (this.PageIndex != this.PageCount - 1);
      btnNextPage.Text = this.PagerSettings.NextPageText;
      c.Controls.Add(btnNextPage);

      Literal l3 = new Literal();
      l3.Text = " ";
      c.Controls.Add(l3);

      LinkButton btnLastPage = new LinkButton();
      btnLastPage.ID = "LinkButtonLastPage";
      btnLastPage.CommandArgument = "Last";
      btnLastPage.CommandName = "Page";
      btnLastPage.Enabled = (this.PageIndex != this.PageCount - 1);
      btnLastPage.Text = this.PagerSettings.LastPageText;
      c.Controls.Add(btnLastPage);

      Literal literal2 = new Literal();
      literal2.Text = "</div><div style=\"position: relative; float: right; margin: 0px 5px 0px 5px;\">页码：";
      c.Controls.Add(literal2);

      DropDownList ddlPage = new DropDownList();
      ddlPage.ID = "PageDropDownList";
      ddlPage.AutoPostBack = true;

      for (int i = 0; i < this.PageCount; i++)
      {
        int pageNumber = i + 1;
        ListItem item = new ListItem(pageNumber.ToString() + "/" + this.PageCount.ToString(), pageNumber.ToString());
        if (i == this.PageIndex)
          item.Selected = true;
        ddlPage.Items.Add(item);
      }

      ddlPage.SelectedIndexChanged += PageDropDownList_SelectedIndexChanged;
      c.Controls.Add(ddlPage);

      Literal literal3 = new Literal();
      literal3.Text = string.Format("&nbsp;&nbsp;({0}&nbsp;/&nbsp;{1})</div>", this.PageIndex + 1, this.PageCount);
      c.Controls.Add(literal3);
    }

    #endregion

    #region PageDropDownList_SelectedIndexChanged

    public static void PageDropDownList_SelectedIndexChanged(object sender, EventArgs e)
    {
      DropDownList list = sender as DropDownList;
      if (list == null) return;

      GridView gv = list.NamingContainer.NamingContainer as GridView;
      if (gv == null) return;

      gv.PageIndex = list.SelectedIndex;
      gv.DataBind();
    }

    #endregion

  }
}
