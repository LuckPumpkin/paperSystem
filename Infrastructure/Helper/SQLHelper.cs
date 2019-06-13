using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public class SQLHelper
{
  public static string DBConnectionString = ConfigurationManager.ConnectionStrings["AppConnStr"].ConnectionString;
  public static SqlConnection conn = new SqlConnection(DBConnectionString);

  #region Constructor

  static SQLHelper()
  {
  }

  #endregion

  #region GetDataTable

  public static DataTable GetDataTable(string sSql)
  {
    SqlDataAdapter da = new SqlDataAdapter(sSql, conn);
    DataSet ds = new DataSet();
    da.Fill(ds);
    return ds.Tables[0];
  }

   /**********************ByShen***************************/
  public static DataTable GetDataTable(string sSql, params SqlParameter[] paras)
  {
      using (SqlCommand cmd = conn.CreateCommand())
      {
          cmd.CommandText = sSql;
          cmd.Parameters.Clear();
          cmd.Parameters.AddRange(paras);
          using (SqlDataAdapter da = new SqlDataAdapter(cmd))
          {
              DataTable dt = new DataTable();
              da.Fill(dt);
              return dt;
          }
      }

  }

  #endregion

  #region RunScalar, RunNonQuery

  public static object RunScalar(SqlCommand cmd)
  {
    SqlConnection conn = new SqlConnection(DBConnectionString);
    cmd.Connection = conn;
    conn.Open();
    object result = cmd.ExecuteScalar();
    conn.Close();

    return result;
  }

  public static int RunNonQuery(SqlCommand cmd)
  {
    SqlConnection conn = new SqlConnection(DBConnectionString);
    cmd.Connection = conn;
    conn.Open();
    int result = cmd.ExecuteNonQuery();
    conn.Close();

    return result;
  }

  public static object RunScalar(string SqlCmd)
  {
    SqlConnection conn = new SqlConnection(DBConnectionString);
    SqlCommand cmd = new SqlCommand(SqlCmd, conn);
    conn.Open();
    object result = cmd.ExecuteScalar();
    conn.Close();

    return result;
  }


  public static int RunNonQuery(string SqlCmd)
  {
    SqlConnection conn = new SqlConnection(DBConnectionString);
    SqlCommand cmd  = new SqlCommand(SqlCmd, conn); 
    conn.Open();
    int result = cmd.ExecuteNonQuery();
    conn.Close();

    return result;
  }

  #endregion

  #region ExecStoreProc

  public static void ExecStoreProc(string ProcName)
  {
    SqlCommand cmd = conn.CreateCommand();
    cmd.CommandType = CommandType.StoredProcedure;
    cmd.CommandText = ProcName;

    try
    {
      conn.Open();
      cmd.ExecuteNonQuery();
    }
    catch (Exception e)
    {
      throw e;
    }
    finally
    {
      conn.Close();
    }
  }

  public static DataTable ExecStoreProc(string ProcName, SqlParameter sp)
  {
    SqlConnection conn = new SqlConnection(DBConnectionString);
    SqlCommand cmd = conn.CreateCommand();
    cmd.Parameters.Add(sp);
    cmd.CommandType = CommandType.StoredProcedure;
    cmd.CommandText = ProcName;

    SqlDataAdapter da = new SqlDataAdapter(cmd);
    DataSet ds = new DataSet();
    da.Fill(ds);
    if (ds.Tables.Count > 0)
      return ds.Tables[0];
    else
      return null;
  }

  #endregion
 
  #region 在事务中执行命令组

  public static void RunCommandsInTransaction(List<SqlCommand> cmds)
  {
    using (SqlConnection conn = new SqlConnection(DBConnectionString))
    {
      conn.Open();
      SqlTransaction tx = conn.BeginTransaction();

      try
      {
        foreach (SqlCommand cmd in cmds)
        {
          cmd.Connection = conn;
          cmd.Transaction = tx;
          cmd.ExecuteNonQuery();
        }
        tx.Commit();
      }
      catch (Exception e)
      {
        tx.Rollback();
        throw e;
      }
      finally
      {
        conn.Close();
      }
    }
  }

  #endregion

}