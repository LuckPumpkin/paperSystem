using System.Web.Security;
using System.Configuration.Provider;
using System.Collections.Specialized;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Diagnostics;
using System.Web;
using System.Globalization;

namespace Infrastructure.Authentication
{

  public sealed class SqlClientRoleProvider : RoleProvider
  {

    private string eventSource = "SqlClientRoleProvider";
    private string eventLog = "Application";
    private string exceptionMessage = "An exception occurred. Please check the Event Log.";

    private ConnectionStringSettings pConnectionStringSettings;
    private string connectionString;
    private string applicationID = "";

    #region System.Web.Security.RoleProvider properties.

    public override string ApplicationName
    {
      get { throw new NotSupportedException(); }
      set { throw new NotSupportedException(); }
    }

    //
    // If false, exceptions are thrown to the caller. If true,
    // exceptions are written to the event log.
    //
    private bool pWriteExceptionsToEventLog = false;

    public bool WriteExceptionsToEventLog
    {
      get { return pWriteExceptionsToEventLog; }
      set { pWriteExceptionsToEventLog = value; }
    }

    #endregion

    #region System.Configuration.Provider.ProviderBase.Initialize

    public override void Initialize(string name, NameValueCollection config)
    {

      //-- Initialize values from web.config.
      if (config == null)
        throw new ArgumentNullException("config");

      if (name == null || name.Length == 0)
        name = "SqlClientRoleProvider";

      if (String.IsNullOrEmpty(config["description"]))
      {
        config.Remove("description");
        config.Add("description", "Microsoft SQL Server Client Role Provider");
      }

      if (!String.IsNullOrEmpty(config["applicationID"]))
        applicationID = config["applicationID"];

      // Initialize the abstract base class.
      base.Initialize(name, config);

      if (config["writeExceptionsToEventLog"] != null)
      {
        if (config["writeExceptionsToEventLog"].ToUpper() == "TRUE")
        {
          pWriteExceptionsToEventLog = true;
        }
      }

      //-- Initialize SqlConnection.
      pConnectionStringSettings = ConfigurationManager.ConnectionStrings[config["connectionStringName"]];

      if (pConnectionStringSettings == null || pConnectionStringSettings.ConnectionString.Trim() == "")
      {
        throw new ProviderException("Connection string cannot be blank.");
      }

      connectionString = pConnectionStringSettings.ConnectionString;
    }

    #endregion

    private string GetRoleIdByRoleName(string rolename)
    {
      string roleId = "";

      SqlConnection conn = new SqlConnection(connectionString);
      SqlCommand cmd = new SqlCommand("SELECT RoleId FROM Roles WHERE RoleName = @Rolename ", conn);

      cmd.Parameters.Add("@Rolename", SqlDbType.NVarChar, 30).Value = rolename;     

      try
      {
        conn.Open();
        roleId = (string)cmd.ExecuteScalar();
        conn.Close();
      }
      catch
      {
      }

      return roleId;
    }

    #region RoleProvider.AddUsersToRoles

    public override void AddUsersToRoles(string[] usernames, string[] rolenames)
    {
      foreach (string rolename in rolenames)
      {
        if (!RoleExists(rolename))
        {
          throw new ProviderException("没有找到角色“" + rolename + "”");
        }
      }

      foreach (string rolename in rolenames)
      {
        foreach (string username in usernames)
        {
          if (username.Contains(","))
          {
            throw new ArgumentException("用户编号不能包含半角逗号。");
          }

          if (IsUserInRole(username, rolename))
          {
            throw new ProviderException("用户已经拥有该角色。");
          }
        }
      }


      SqlConnection conn = new SqlConnection(connectionString);
      SqlCommand cmd = new SqlCommand("INSERT INTO UsersInRoles (UserCode, RoleId) Values(@UserId, @RoleId)", conn);

      SqlParameter userParm = cmd.Parameters.Add("@UserId", SqlDbType.NVarChar, 40);
      SqlParameter roleParm = cmd.Parameters.Add("@RoleId", SqlDbType.NVarChar, 40);

      SqlTransaction tran = null;

      try
      {
        conn.Open();
        tran = conn.BeginTransaction();
        cmd.Transaction = tran;

        foreach (string rolename in rolenames)
        {
          string roleId = GetRoleIdByRoleName(rolename);
          foreach (string userId in usernames)
          {
            userParm.Value = userId;
            roleParm.Value = roleId;
            cmd.ExecuteNonQuery();
          }
        }

        tran.Commit();
      }
      catch (SqlException e)
      {
        try
        {
          tran.Rollback();
        }
        catch { }


        if (WriteExceptionsToEventLog)
        {
          WriteToEventLog(e, "AddUsersToRoles");
        }
        else
        {
          throw e;
        }
      }
      finally
      {
        conn.Close();
      }
    }

    #endregion

    #region RoleProvider.CreateRole

    public override void CreateRole(string rolename)
    {
      if (rolename.Contains(","))
      {
        throw new ArgumentException("角色名不能包含半角逗号。");
      }

      if (RoleExists(rolename))
      {
        throw new ProviderException("角色名已经存在。");
      }

      SqlConnection conn = new SqlConnection(connectionString);
      SqlCommand cmd = new SqlCommand("INSERT INTO Roles (RoleId, RoleName) Values(@RoleId, @Rolename)", conn);

      cmd.Parameters.Add("@RoleId", SqlDbType.NVarChar, 40).Value = Guid.NewGuid().ToString();
      cmd.Parameters.Add("@Rolename", SqlDbType.NVarChar, 30).Value = rolename;
   

      try
      {
        conn.Open();
        cmd.ExecuteNonQuery();
      }
      catch (SqlException e)
      {
        if (WriteExceptionsToEventLog)
        {
          WriteToEventLog(e, "CreateRole");
        }
        else
        {
          throw e;
        }
      }
      finally
      {
        conn.Close();
      }
    }

    #endregion

    #region RoleProvider.DeleteRole

    public override bool DeleteRole(string rolename, bool throwOnPopulatedRole)
    {
      if (!RoleExists(rolename))
      {
        throw new ProviderException("角色不存在。");
      }

      if (throwOnPopulatedRole && GetUsersInRole(rolename).Length > 0)
      {
        throw new ProviderException("无法删除一个正在被使用的角色。");
      }

      SqlConnection conn = new SqlConnection(connectionString);
      SqlCommand cmd = new SqlCommand("DELETE FROM Roles WHERE RoleName = @Rolename ", conn);
      cmd.Parameters.Add("@Rolename", SqlDbType.NVarChar, 30).Value = rolename;

      SqlCommand cmd2 = new SqlCommand("DELETE FROM UsersInRoles WHERE RoleId = @RoleId", conn);
      cmd2.Parameters.Add("@RoleId", SqlDbType.NVarChar, 40).Value = GetRoleIdByRoleName(rolename);
   

      SqlTransaction tran = null;

      try
      {
        conn.Open();
        tran = conn.BeginTransaction();
        cmd.Transaction = tran;
        cmd2.Transaction = tran;

        cmd2.ExecuteNonQuery();
        cmd.ExecuteNonQuery();

        tran.Commit();
      }
      catch (SqlException e)
      {
        try
        {
          tran.Rollback();
        }
        catch { }


        if (WriteExceptionsToEventLog)
        {
          WriteToEventLog(e, "DeleteRole");

          return false;
        }
        else
        {
          throw e;
        }
      }
      finally
      {
        conn.Close();
      }

      return true;
    }

    #endregion

    #region RoleProvider.GetAllRoles

    public override string[] GetAllRoles()
    {
      string tmpRoleNames = "";

      SqlConnection conn = new SqlConnection(connectionString);
      SqlCommand cmd = new SqlCommand("SELECT RoleName FROM Roles", conn);
   
      SqlDataReader reader = null;

      try
      {
        conn.Open();

        reader = cmd.ExecuteReader();

        while (reader.Read())
        {
          tmpRoleNames += reader.GetString(0) + ",";
        }
      }
      catch (SqlException e)
      {
        if (WriteExceptionsToEventLog)
        {
          WriteToEventLog(e, "GetAllRoles");
        }
        else
        {
          throw e;
        }
      }
      finally
      {
        if (reader != null) { reader.Close(); }
        conn.Close();
      }

      if (tmpRoleNames.Length > 0)
      {
        // Remove trailing comma.
        tmpRoleNames = tmpRoleNames.Substring(0, tmpRoleNames.Length - 1);
        return tmpRoleNames.Split(',');
      }

      return new string[0];
    }

    #endregion

    #region RoleProvider.GetRolesForUser

    public override string[] GetRolesForUser(string username)
    {
      string tmpRoleNames = "";

      SqlConnection conn = new SqlConnection(connectionString);
      SqlCommand cmd = new SqlCommand("SELECT   Roles.RoleName FROM UsersInRoles INNER JOIN Roles ON UsersInRoles.RoleId = Roles.RoleId WHERE UserCode = @UserId", conn);

      cmd.Parameters.Add("@UserId", SqlDbType.NVarChar, 40).Value = username;    

      SqlDataReader reader = null;

      try
      {
        conn.Open();

        reader = cmd.ExecuteReader();

        while (reader.Read())
        {
          tmpRoleNames += reader.GetString(0) + ",";
        }
      }
      catch (SqlException e)
      {
        if (WriteExceptionsToEventLog)
        {
          WriteToEventLog(e, "GetRolesForUser");
        }
        else
        {
          throw e;
        }
      }
      finally
      {
        if (reader != null) { reader.Close(); }
        conn.Close();
      }

      if (tmpRoleNames.Length > 0)
      {
        // Remove trailing comma.
        tmpRoleNames = tmpRoleNames.Substring(0, tmpRoleNames.Length - 1);
        return tmpRoleNames.Split(',');
      }

      return new string[0];
    }

    #endregion

    #region RoleProvider.GetUsersInRole

    public override string[] GetUsersInRole(string rolename)
    {
      string tmpUserNames = "";
      string roleId = GetRoleIdByRoleName(rolename);

      SqlConnection conn = new SqlConnection(connectionString);
      SqlCommand cmd = new SqlCommand("SELECT UserCode FROM UsersInRoles WHERE RoleId = @RoleId", conn);

      cmd.Parameters.Add("@RoleId", SqlDbType.NVarChar, 40).Value = roleId;

      SqlDataReader reader = null;

      try
      {
        conn.Open();

        reader = cmd.ExecuteReader();

        while (reader.Read())
        {
          tmpUserNames += reader.GetString(0) + ",";
        }
      }
      catch (SqlException e)
      {
        if (WriteExceptionsToEventLog)
        {
          WriteToEventLog(e, "GetUsersInRole");
        }
        else
        {
          throw e;
        }
      }
      finally
      {
        if (reader != null) { reader.Close(); }
        conn.Close();
      }

      if (tmpUserNames.Length > 0)
      {
        // Remove trailing comma.
        tmpUserNames = tmpUserNames.Substring(0, tmpUserNames.Length - 1);
        return tmpUserNames.Split(',');
      }

      return new string[0];
    }

    #endregion

    #region RoleProvider.IsUserInRole

    public override bool IsUserInRole(string username, string rolename)
    {
      bool userIsInRole = false;

      string roleId = GetRoleIdByRoleName(rolename);

      SqlConnection conn = new SqlConnection(connectionString);
      SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM UsersInRoles WHERE UserCode = @UserId AND RoleId = @RoleId", conn);

      cmd.Parameters.Add("@UserId", SqlDbType.NVarChar, 40).Value = username;
      cmd.Parameters.Add("@RoleId", SqlDbType.NVarChar, 40).Value = roleId;

      try
      {
        conn.Open();

        int numRecs = (int)cmd.ExecuteScalar();

        if (numRecs > 0)
        {
          userIsInRole = true;
        }
      }
      catch (SqlException e)
      {
        if (WriteExceptionsToEventLog)
        {
          WriteToEventLog(e, "IsUserInRole");
        }
        else
        {
          throw e;
        }
      }
      finally
      {
        conn.Close();
      }

      return userIsInRole;
    }

    #endregion

    #region RoleProvider.RemoveUsersFromRoles

    public override void RemoveUsersFromRoles(string[] usernames, string[] rolenames)
    {
      foreach (string rolename in rolenames)
      {
        if (!RoleExists(rolename))
        {
          throw new ProviderException("角色名没有找到。");
        }
      }

      foreach (string username in usernames)
      {
        foreach (string rolename in rolenames)
        {
          if (!IsUserInRole(username, rolename))
          {
            throw new ProviderException("用户不在角色中。");
          }
        }
      }


      SqlConnection conn = new SqlConnection(connectionString);
      SqlCommand cmd = new SqlCommand("DELETE FROM UsersInRoles WHERE UserCode = @UserId AND RoleId = @RoleId", conn);

      SqlParameter userParm = cmd.Parameters.Add("@UserId", SqlDbType.NVarChar, 40);
      SqlParameter roleParm = cmd.Parameters.Add("@RoleId", SqlDbType.NVarChar, 40);

      SqlTransaction tran = null;

      try
      {
        conn.Open();
        tran = conn.BeginTransaction();
        cmd.Transaction = tran;

        foreach (string rolename in rolenames)
        {
          string roleId = GetRoleIdByRoleName(rolename);

          foreach (string userId in usernames)
          {
            userParm.Value = userId;
            roleParm.Value = roleId;
            cmd.ExecuteNonQuery();
          }
        }

        tran.Commit();
      }
      catch (SqlException e)
      {
        try
        {
          tran.Rollback();
        }
        catch { }


        if (WriteExceptionsToEventLog)
        {
          WriteToEventLog(e, "RemoveUsersFromRoles");
        }
        else
        {
          throw e;
        }
      }
      finally
      {
        conn.Close();
      }
    }

    #endregion

    #region RoleProvider.RoleExists

    public override bool RoleExists(string rolename)
    {
      bool exists = false;

      SqlConnection conn = new SqlConnection(connectionString);
      SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Roles WHERE RoleName = @Rolename", conn);

      cmd.Parameters.Add("@Rolename", SqlDbType.NVarChar, 30).Value = rolename;
   

      try
      {
        conn.Open();

        int numRecs = (int)cmd.ExecuteScalar();

        if (numRecs > 0)
        {
          exists = true;
        }
      }
      catch (SqlException e)
      {
        if (WriteExceptionsToEventLog)
        {
          WriteToEventLog(e, "RoleExists");
        }
        else
        {
          throw e;
        }
      }
      finally
      {
        conn.Close();
      }

      return exists;
    }

    #endregion

    #region RoleProvider.FindUsersInRole

    public override string[] FindUsersInRole(string rolename, string usernameToMatch)
    {
      SqlConnection conn = new SqlConnection(connectionString);

      string roleId = GetRoleIdByRoleName(rolename);

      SqlCommand cmd = new SqlCommand("SELECT UserCode FROM UsersInRoles WHERE RoleId = @RoleId", conn);
      cmd.Parameters.Add("@RoleId", SqlDbType.VarChar, 40).Value = roleId;

      string tmpUserNames = "";
      SqlDataReader reader = null;

      try
      {
        conn.Open();

        reader = cmd.ExecuteReader();

        while (reader.Read())
        {
          tmpUserNames += reader.GetString(0) + ",";
        }
      }
      catch (SqlException e)
      {
        if (WriteExceptionsToEventLog)
        {
          WriteToEventLog(e, "FindUsersInRole");
        }
        else
        {
          throw e;
        }
      }
      finally
      {
        if (reader != null) { reader.Close(); }

        conn.Close();
      }

      if (tmpUserNames.Length > 0)
      {
        // Remove trailing comma.
        tmpUserNames = tmpUserNames.Substring(0, tmpUserNames.Length - 1);
        return tmpUserNames.Split(',');
      }

      return new string[0];
    }

    #endregion

    #region WriteToEventLog

    //   A helper function that writes exception detail to the event log. Exceptions
    // are written to the event log as a security measure to avoid private database
    // details from being returned to the browser. If a method does not return a status
    // or boolean indicating the action succeeded or failed, a generic exception is also 
    // thrown by the caller.
    private void WriteToEventLog(SqlException e, string action)
    {
      //EventLog log = new EventLog();
      //log.Source = eventSource;
      //log.Log = eventLog;

      string message = "";

      message += "Source: "+ eventSource + "\n\n";
      message += "Log: " + eventLog + "\n\n";
      message += "Message: " + exceptionMessage + "\n\n";
      message += "Action: " + action + "\n\n";
      message += "Exception: " + e.ToString();

      //log.WriteEntry(message);
    }

    #endregion

  }
}