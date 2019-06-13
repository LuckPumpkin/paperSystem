using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

public class SQLTypeConverter
{

  #region Sql Server数据类型（如：varchar）转换为SqlDbType类型

  public static SqlDbType SqlTypeString2SqlDbType(string sqlTypeString)
  {
    SqlDbType dbType = SqlDbType.Variant;//默认为Object

    switch (sqlTypeString)
    {
      case "int":
        dbType = SqlDbType.Int;
        break;
      case "varchar":
        dbType = SqlDbType.VarChar;
        break;
      case "bit":
        dbType = SqlDbType.Bit;
        break;
      case "datetime":
        dbType = SqlDbType.DateTime;
        break;
      case "decimal":
        dbType = SqlDbType.Decimal;
        break;
      case "float":
        dbType = SqlDbType.Float;
        break;
      case "image":
        dbType = SqlDbType.Image;
        break;
      case "money":
        dbType = SqlDbType.Money;
        break;
      case "ntext":
        dbType = SqlDbType.NText;
        break;
      case "nvarchar":
        dbType = SqlDbType.NVarChar;
        break;
      case "smalldatetime":
        dbType = SqlDbType.SmallDateTime;
        break;
      case "smallint":
        dbType = SqlDbType.SmallInt;
        break;
      case "text":
        dbType = SqlDbType.Text;
        break;
      case "bigint":
        dbType = SqlDbType.BigInt;
        break;
      case "binary":
        dbType = SqlDbType.Binary;
        break;
      case "char":
        dbType = SqlDbType.Char;
        break;
      case "nchar":
        dbType = SqlDbType.NChar;
        break;
      case "numeric":
        dbType = SqlDbType.Decimal;
        break;
      case "real":
        dbType = SqlDbType.Real;
        break;
      case "smallmoney":
        dbType = SqlDbType.SmallMoney;
        break;
      case "sql_variant":
        dbType = SqlDbType.Variant;
        break;
      case "timestamp":
        dbType = SqlDbType.Timestamp;
        break;
      case "tinyint":
        dbType = SqlDbType.TinyInt;
        break;
      case "uniqueidentifier":
        dbType = SqlDbType.UniqueIdentifier;
        break;
      case "varbinary":
        dbType = SqlDbType.VarBinary;
        break;
      case "xml":
        dbType = SqlDbType.Xml;
        break;
    }
    return dbType;
  }

  #endregion

  #region 将字符串解析为指定类型值

  public static object Parse(string fieldValue, SqlDbType sqlDbType, int maxLength = 0)
  {
    try
    {
      switch (sqlDbType)
      {
        case SqlDbType.Money:
        case SqlDbType.SmallMoney:
        case SqlDbType.Decimal:
          return Decimal.Parse(fieldValue);

        case SqlDbType.Float:
          return Double.Parse(fieldValue);
        case SqlDbType.Int:
          return Int32.Parse(fieldValue);
        case SqlDbType.BigInt:
          return Int64.Parse(fieldValue);
        case SqlDbType.Bit:
          return Boolean.Parse(fieldValue);
        case SqlDbType.Real:
          return Single.Parse(fieldValue);
        case SqlDbType.SmallDateTime:
          return DateTime.Parse(fieldValue);
        case SqlDbType.SmallInt:
          return Int16.Parse(fieldValue);
        case SqlDbType.TinyInt:
          return Int16.Parse(fieldValue);

        case SqlDbType.Char:
        case SqlDbType.NChar:
        case SqlDbType.NText:
        case SqlDbType.NVarChar:
        case SqlDbType.Text:
        case SqlDbType.VarChar:
          {
            string s = fieldValue.Trim();
            if (maxLength != 0 && s.Length > maxLength)
              throw new Exception();
            return fieldValue.Trim();
          }

        case SqlDbType.DateTime:
          {
            if (fieldValue.Split(new char[] { '-' }, StringSplitOptions.RemoveEmptyEntries).Length == 3)
              return DateTime.Parse(fieldValue);
            return null;
          }

        case SqlDbType.UniqueIdentifier:
          return new Guid(fieldValue);

        case SqlDbType.Timestamp:
        case SqlDbType.Binary:
        case SqlDbType.Udt://自定义的数据类型
        case SqlDbType.VarBinary:
        case SqlDbType.Variant:
        case SqlDbType.Xml:
        case SqlDbType.Image:
          return null;

        default:
          return null;
      }
    }
    catch
    {
      throw new Exception(string.Format("字段解析失败，字段类型：{0}，待解析值{1}", sqlDbType.ToString(), fieldValue));
    }
  }

  #endregion

}