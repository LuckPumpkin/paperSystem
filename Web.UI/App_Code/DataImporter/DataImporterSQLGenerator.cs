using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Text;

public class DataImporterSQLGenerator
{
  private Dictionary<string, FieldItem> FieldsDictionary;

  #region 构造函数

  public DataImporterSQLGenerator(Dictionary<string, FieldItem> FieldsDictionary)
  {
    this.FieldsDictionary = FieldsDictionary;
  }

  #endregion

  #region 生成用于插入的SqlCommand

  public SqlCommand GenerateInsertCommand(string TableName, List<string> fields)
  {
    StringBuilder sbFields = new StringBuilder();
    StringBuilder sbValues = new StringBuilder();

    for (int i = 0; i < fields.Count; i++)
    {
      sbFields.Append("[" + fields[i] + "]");
      sbValues.Append("@" + fields[i]);

      if (i < fields.Count - 1)
      {
        sbFields.Append(", ");
        sbValues.Append(", ");
      }
    }

    string sql = "INSERT INTO [" + TableName + "] (" + sbFields.ToString() + ") VALUES (" + sbValues.ToString() + ")";
    SqlCommand cmd = new SqlCommand(sql);

    foreach (string fieldName in fields)
      cmd.Parameters.Add(CreateSqlParameter(fieldName, "@" + fieldName));

    return cmd;
  }

  #endregion

  #region 根据主键判断某条记录是否存在

  public SqlCommand GenerateCheckExistCommand(string TableName, string keyFieldName)
  {
    string sql = string.Format("SELECT COUNT(*) AS cnt FROM [" + TableName + "] WHERE [{0}] = @{0}", keyFieldName);
    SqlCommand cmd = new SqlCommand(sql);
    cmd.Parameters.Add(CreateSqlParameter(keyFieldName, "@" + keyFieldName));

    return cmd;
  }

  #endregion

  #region 生成用于更新的SqlCommand

  public SqlCommand GenerateUpdateCommand(string TableName, string keyFieldName, List<string> fields, List<string> protectedFields, string UpdatableDataRange = "")
  {
    string sql = "UPDATE [" + TableName + "] SET ";

    StringBuilder sbFields = new StringBuilder();
    StringBuilder sbWhere = new StringBuilder();

    for (int i = 0; i < fields.Count; i++)
    {
      if (keyFieldName == fields[i]) continue;
      sbFields.Append(string.Format("[{0}] = @{0}, ", fields[i]));
    }

    sql += sbFields.ToString();
    if (sql.EndsWith(", "))
      sql = sql.Substring(0, sql.Length - 2);

    sbWhere.Append(string.Format("[{0}] = @{0}_origin AND ", keyFieldName));

    for (int i = 0; i < protectedFields.Count; i++)
      sbWhere.Append(string.Format("[{0}] = @{0}_origin AND ", protectedFields[i]));

    //-- 追加可更新数据的范围条件
    sbWhere.Append(UpdatableDataRange);

    sql += " WHERE " + sbWhere.ToString();
    if (sql.EndsWith("AND "))
      sql = sql.Substring(0, sql.Length - 4);

    SqlCommand cmd = new SqlCommand(sql);

    // 设置参数
    foreach (string fieldName in fields)
    {
      if (keyFieldName == fieldName) continue;
      cmd.Parameters.Add(CreateSqlParameter(fieldName, "@" + fieldName));
    }

    cmd.Parameters.Add(CreateSqlParameter(keyFieldName, "@" + keyFieldName + "_origin"));

    foreach (string fieldName in protectedFields)
      cmd.Parameters.Add(CreateSqlParameter(fieldName, "@" + fieldName + "_origin"));

    return cmd;
  }

  #endregion

  #region 查找引用字段的键值

  public static SqlCommand GenerateGetRefKeyCommand(string refTableName, string refKeyName, string refFieldName, SqlDbType refFieldType)
  {
    string sql = string.Format("SELECT TOP(1) [{0}] FROM [" + refTableName + "] WHERE [{1}] = @{1}", refKeyName, refFieldName);
    SqlCommand cmd = new SqlCommand(sql);
    SqlParameter sp = new SqlParameter("@" + refFieldName, refFieldType);
    sp.SourceColumn = refFieldName;
    cmd.Parameters.Add(sp);

    return cmd;
  }

  #endregion

  #region CreateSqlParameter

  private SqlParameter CreateSqlParameter(string colName, string paraName)
  {
    SqlParameter sp = new SqlParameter(paraName, FieldsDictionary[colName].Type);
    sp.SourceColumn = colName;
    return sp;
  }

  #endregion

}