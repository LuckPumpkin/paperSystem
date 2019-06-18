using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

/// <summary>
/// Application 的摘要说明
/// </summary>
public class ApplicationUser
{
    public ApplicationUser()
	{
		//
		// TODO: 在此处添加构造函数逻辑
		//
	}
    public static string UserCode(string Account)
    {

        DSApplicationUserTableAdapters.UserTableAdapter user = new DSApplicationUserTableAdapters.UserTableAdapter();
        DSApplicationUser.UserDataTable UserTable = new DSApplicationUser.UserDataTable();
        user.Fill(UserTable);
        user.FillName(UserTable, Account);
        string UserId = Convert.ToString(user.GetName(Account));
        return UserId;       
    }
}