using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UserControls_MoverList : System.Web.UI.UserControl
{

  #region innerClass

  [Serializable]
  protected class SerializableListItem
  {
    public string Text;
    public string Value;
    public bool Selected;

    public SerializableListItem(string Text, string Value, bool Selected)
    {
      this.Text = Text;
      this.Value = Value;
      this.Selected = Selected;
    }
  }

  #endregion

  protected List<SerializableListItem> items = null;

  #region 属性

  public ListItemCollection LeftItems
  {
    get
    {
      return lstLeft.Items;
    }
  }

  public ListItemCollection RightItems
  {
    get
    {
      return lstRight.Items;
    }
  }

  #endregion

  #region Page_Load

  protected void Page_Load(object sender, EventArgs e)
  {
    if (ViewState["__MoverListInitItems"] != null)
      items = ViewState["__MoverListInitItems"] as List<SerializableListItem>;
  }

  #endregion

  #region InitMoverList

  public void InitMoverList(List<ListItem> items)
  {
    List<SerializableListItem> sItems = new List<SerializableListItem>();
    foreach (ListItem item in items)
      sItems.Add(new SerializableListItem(item.Text, item.Value, item.Selected));

    ViewState["__MoverListInitItems"] = sItems;
    this.items = sItems;

    foreach (ListItem item in items)
      lstLeft.Items.Add(item);
  }

  #endregion

  #region MoveUp、MoveDown、MoveRight、MoveRightAll、MoveLeft、MoveLeftAll 按钮事件

  protected void btnMoveUp_Click(object sender, EventArgs e)
  {
    MoveUp();
  }

  protected void btnMoveDown_Click(object sender, EventArgs e)
  {
    MoveDown();
  }

  protected void btnMoveRight_Click(object sender, EventArgs e)
  {
    MoveRight();
  }

  protected void btnMoveRightAll_Click(object sender, EventArgs e)
  {
    MoveRightAll();
  }

  protected void btnMoveLeft_Click(object sender, EventArgs e)
  {
    MoveLeft();
  }

  protected void btnMoveLeftAll_Click(object sender, EventArgs e)
  {
    MoveLeftAll();
  }

  #endregion

  #region MoveUp

  public void MoveUp()
  {
    lstRight.MoveUp();
  }

  #endregion

  #region MoveDown

  public void MoveDown()
  {
    lstRight.MoveDown();
  }

  #endregion

  #region MoveRight

  public void MoveRight()
  {
    List<ListItem> tmpList = new List<ListItem>();

    foreach (ListItem item in lstLeft.Items)
    {
      if (item.Selected)
        lstRight.Items.Add(item);
      else
        tmpList.Add(item);
    }

    lstLeft.Items.Clear();
    foreach (ListItem item in tmpList)
      lstLeft.Items.Add(item);
  }

  #endregion

  #region MoveRightAll

  public void MoveRightAll()
  {
    foreach (ListItem item in lstLeft.Items)
      lstRight.Items.Add(item);

    lstLeft.Items.Clear();
  }

  #endregion

  #region MoveLeft

  public void MoveLeft()
  {
    List<ListItem> tmpList = new List<ListItem>();
    foreach (ListItem item in lstRight.Items)
      if (!item.Selected)
        tmpList.Add(item);

    lstRight.Items.Clear();
    lstLeft.Items.Clear();

    foreach (ListItem item in tmpList)
      lstRight.Items.Add(item);

    foreach (SerializableListItem item in items)
    {
      if (lstRight.Items.FindByValue(item.Value) == null)
      {
        ListItem tmpItem = new ListItem(item.Text, item.Value);
        tmpItem.Selected = item.Selected;
        lstLeft.Items.Add(tmpItem);
      }
    }
  }

  #endregion

  #region MoveLeftAll

  public void MoveLeftAll()
  {
    lstRight.Items.Clear();
    lstLeft.Items.Clear();

    foreach (SerializableListItem item in items)
    {
      ListItem tmpItem = new ListItem(item.Text, item.Value);
      tmpItem.Selected = item.Selected;
      lstLeft.Items.Add(tmpItem);
    }
  }

  #endregion

}