using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

[Serializable]
public class FieldItem
{
  public string Name;
  public string Code;
  public SqlDbType Type;
  public int maxLength; 

  public bool CanBeKey;
  public bool CanUpdate;
  public bool Visible;

  public bool IsReferenceField = false;
  public string refTableName;
  public string refKeyName;
  public string refFieldName;
  public SqlDbType refFieldType;

  public FieldItem(string FieldName, string FieldCode, SqlDbType FieldType, int maxLength, bool CanBeKey, bool CanUpdate, bool Visible = true)
  {
    this.Name = FieldName;
    this.Code = FieldCode;
    this.Type = FieldType;
    this.maxLength = maxLength;
    this.CanBeKey = CanBeKey;
    this.CanUpdate = CanUpdate;
    this.Visible = Visible;
  }

  public void MarkReferenceField(string refTableName, string refKeyName, string refFieldName, SqlDbType refFieldType)
  {
    IsReferenceField = true;
    this.refTableName = refTableName;
    this.refKeyName = refKeyName;
    this.refFieldName = refFieldName;
    this.refFieldType = refFieldType;
  }
}