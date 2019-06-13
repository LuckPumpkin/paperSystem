using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SysData=System.Data;
using System.Data;

/// <summary>
/// User 的摘要说明
/// </summary>
public class User
{
	public User()
	{
		//
		// TODO: 在此处添加构造函数逻辑
		//
	}
    public bool AuthenticateUser(string username,string  password, out string userId)
    {
        DSUserTableAdapters.UserTableAdapter helper = new DSUserTableAdapters.UserTableAdapter();
        DSUser.UserDataTable table = new DSUser.UserDataTable();
        helper.Fill(table, username, password);
        if(table .Rows .Count ==0)
        {
            userId = "";
            return false;
        }
        else
        {
            userId = table.Rows[0]["UserCode"].ToString();
            return true;

        }
    }
    public bool ChangePasword(string UserCode, string OldePassword, string NewPassword)
    {
        DSUserTableAdapters.UserTableAdapter helper = new DSUserTableAdapters.UserTableAdapter();
        DSUser.UserDataTable table = new DSUser.UserDataTable();
        helper.FillPsw(table, UserCode);

        string Psw = table.Rows[0]["Password"].ToString();
        if (Psw.Equals(OldePassword))
        {
            helper.UpdatePasword(NewPassword, UserCode);
            return true;
        }
        else
        {
            return false;
        }


    }

    public int GetBranchID(string UserCode)
    {
        DSUserTableAdapters.UserTableAdapter helper = new DSUserTableAdapters.UserTableAdapter();
        DSUser.UserDataTable table = new DSUser.UserDataTable();
        helper.FillPsw(table, UserCode);
        int i = 0;
        if(table .Rows .Count !=0)
        {
            i = Convert.ToInt32(table.Rows[0]["BranchID"].ToString());
        }
        return i;
    }

    public string GetName(string UserCode)
    {
        DSUserTableAdapters.UserTableAdapter helper = new DSUserTableAdapters.UserTableAdapter();
        DSUser.UserDataTable table = new DSUser.UserDataTable();
        helper.FillPsw(table, UserCode);
        string name = string.Empty;
        if (table.Rows.Count != 0)
        {
            name = table.Rows[0]["Name"].ToString();
        }
        return name;
    }

    public string GetRid(string Rname)
    {
        DSUserTableAdapters.RolesTableAdapter helper = new DSUserTableAdapters.RolesTableAdapter();
        DSUser.RolesDataTable  table = new DSUser.RolesDataTable();
        helper.Fill(table, Rname);
        return table.Rows[0]["RoleId"].ToString();
    }
    public string GetAccount(string userCode)
    {
        DSUserTableAdapters.UserTableAdapter helper = new DSUserTableAdapters.UserTableAdapter();
        return helper.GetAccount(userCode);
    }
    public string GetCollege(string UserCode)
    {
        DSUserTableAdapters.UserTableAdapter helper = new DSUserTableAdapters.UserTableAdapter();
        DSUser.UserDataTable table = new DSUser.UserDataTable();
        helper.FillCollege(table, UserCode);
        string college = string.Empty;
        if (table.Rows.Count != 0)
        {
            college = table.Rows[0]["College"].ToString();
        }
        return college;
    }
    public DataTable GetUsersByBranchId(int BranchId)
    {
        DSUserTableAdapters.UserTableAdapter helper = new DSUserTableAdapters.UserTableAdapter();
        return helper.GetUsersByBranchId(BranchId);
    }
    public void DeleteByUserCode(string userCode,string roleName)
    {
        DSUserTableAdapters.UsersInRolesTableAdapter helper = new DSUserTableAdapters.UsersInRolesTableAdapter();
        helper.DeleteByUserCode(roleName, userCode);
    }
    public void InsertUser(string userCode, string account,string name,string sex,int branchID,string password,string tel,DateTime createTime,bool isDelete,bool isAvailable,bool isLockOut)
    {
        DSUserTableAdapters.UserTableAdapter helper = new DSUserTableAdapters.UserTableAdapter();
        helper.InsertUser(account, userCode, password, branchID, name,tel,sex,createTime,isDelete,isAvailable,isLockOut);
    }
    public void InsertUsersInRoles(string userCode, string roleId)
    {
        DSUserTableAdapters.UsersInRolesTableAdapter helper = new DSUserTableAdapters.UsersInRolesTableAdapter();
        helper.InsertUsersInRoles(roleId, userCode);
    }
    public void UpdateUser(string account, int branchID,string name,string tel,string sex,string userCode)
    {
        DSUserTableAdapters.UserTableAdapter helper = new DSUserTableAdapters.UserTableAdapter();
        helper.UpdateUserByUserCode(account, branchID, name, tel, sex,userCode);
    }

    public SysData.DataTable GetRoleName(string UserID)
    {
        DSUserTableAdapters.UsersInRolesTableAdapter helper = new DSUserTableAdapters.UsersInRolesTableAdapter();
        return helper.GetRoleName(UserID);
    }
}