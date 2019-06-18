using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public static class ListBoxExtentions
{
  public static void MoveUp(this ListBox listBox)
  {
    ListItem tmp;
    ListItem[] tmpItems = new ListItem[listBox.Items.Count];

    for (int i = 0; i < listBox.Items.Count; i++)
      tmpItems[i] = listBox.Items[i];

    for (int i = 0; i < tmpItems.Length; i++)
    {
      //-- 第一项无法向上移动。
      if (i == 0)
        continue;

      if (tmpItems[i].Selected && tmpItems[i - 1].Selected)
        continue;

      if (tmpItems[i].Selected)
      {
        tmp = tmpItems[i - 1];
        tmpItems[i - 1] = tmpItems[i];
        tmpItems[i] = tmp;
      }
    }

    listBox.Items.Clear();
    for (int i = 0; i < tmpItems.Length; i++)
      listBox.Items.Add(tmpItems[i]);
  }

  public static void MoveDown(this ListBox listBox)
  {
    ListItem tmp;
    ListItem[] tmpItems = new ListItem[listBox.Items.Count];

    for (int i = 0; i < listBox.Items.Count; i++)
      tmpItems[i] = listBox.Items[i];

    for (int i = tmpItems.Length - 1; i >= 0; i--)
    {
      //-- 最后一项无法向下移动。
      if (i == tmpItems.Length - 1)
        continue;

      if (tmpItems[i].Selected && tmpItems[i + 1].Selected)
        continue;

      if (tmpItems[i].Selected)
      {
        tmp = tmpItems[i + 1];
        tmpItems[i + 1] = tmpItems[i];
        tmpItems[i] = tmp;
      }
    }

    listBox.Items.Clear();
    for (int i = 0; i < tmpItems.Length; i++)
      listBox.Items.Add(tmpItems[i]);
  }
}