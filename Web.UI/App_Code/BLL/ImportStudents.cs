using System;
using System.Collections.Generic;
using System.Web;
using System.Data;

public class ImportStudents
{
    public static void AddUser(string UserId, string UserNum, string Name, string Password, bool IsLockOut, bool IsDelete, bool IsAvailable, DateTime UserCreateTime, string Sex, int BranchID)
  {
    DSImportStudentsTableAdapters.ImportStudentsAdapter helper = new DSImportStudentsTableAdapters.ImportStudentsAdapter();
    helper.AddUser(UserId, UserNum, Name, Password, IsLockOut, IsAvailable, IsDelete, UserCreateTime, Sex, BranchID);
  }

  public static string GetUserIdBySno(string Sno)
  {
    DSImportStudentsTableAdapters.ImportStudentsAdapter helper = new DSImportStudentsTableAdapters.ImportStudentsAdapter();
    return helper.GetUserIDBySno(Sno).ToString();
  }
  public static void UpdateUserName( string Name, string UserId)
  {
    DSImportStudentsTableAdapters.ImportStudentsAdapter helper = new DSImportStudentsTableAdapters.ImportStudentsAdapter();
    helper.UpdateUserName(Name, UserId);
  }

  public static string GetRoleIdByRoleName(string RoleName)
  {
      DSImportStudentsTableAdapters.ImportStudentsAdapter helper = new DSImportStudentsTableAdapters.ImportStudentsAdapter();
      return helper.GetRoleIdByRoleName(RoleName).ToString();
  }

  public static void AddUserInRoles(string RoleId, string UserCode)
  {
      DSImportStudentsTableAdapters.ImportStudentsAdapter helper = new DSImportStudentsTableAdapters.ImportStudentsAdapter();
      helper.AddUserInRoles(RoleId, UserCode);
  }
  public static string GetBranchIDbyBranchName(string BranchName)
  {
      DSImportStudentsTableAdapters.ImportStudentsAdapter helper = new DSImportStudentsTableAdapters.ImportStudentsAdapter();
      return helper.GetBranchIDbyBranchName(BranchName).ToString();
  }
  
  
}