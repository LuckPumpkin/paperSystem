using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SysData = System.Data;
using System.Data;

/// <summary>
/// Summary description for Teacher
/// </summary>
public class Teacher
{
	public Teacher()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    public DataTable GetDataByAccount(string Account)
    {
        DSTeacherTableAdapters.TeacherTableAdapter helper = new DSTeacherTableAdapters.TeacherTableAdapter();
        return helper.GetDataByAccount(Account);
    }
    public void UpdateTelByAccount(string tel,string account)
    {
        DSTeacherTableAdapters.TeacherTableAdapter helper = new DSTeacherTableAdapters.TeacherTableAdapter();
        helper.UpdateTelByAccount(tel, account);
    }
    public void UpdateProByAccount(string account, string Pro)
    {
        DSTeacherTableAdapters.TeacherTableAdapter helper = new DSTeacherTableAdapters.TeacherTableAdapter();
        helper.UpdateProByAccount(Pro, account);
    }
    public void UpdateByUserCode(string account, string name, string college, string sex, string tel, string usercode)
    {
        DSTeacherTableAdapters.TeacherTableAdapter helper = new DSTeacherTableAdapters.TeacherTableAdapter();
        helper.UpdateTeacherByUserCode(account, name, college, sex, tel, usercode);
    }
    public string GetAccountBYName(string Name)
    {
        DSTeacherTableAdapters.TeacherTableAdapter helper = new DSTeacherTableAdapters.TeacherTableAdapter();
        return helper.GetAccountBYName(Name);
    }
    public string GetProByUserCode(string UserCode)
    {
        DSTeacherTableAdapters.TeacherTableAdapter helper = new DSTeacherTableAdapters.TeacherTableAdapter();
        return helper.GetProByUserCode(UserCode).ToString();
    }
    public string GetCollegeByUserCode(string UserCode)
    {
        DSTeacherTableAdapters.TeacherTableAdapter helper = new DSTeacherTableAdapters.TeacherTableAdapter();
        return helper.GetCollegeByUserCode(UserCode).ToString();
    }
    public string GetTeacherNameByAccount(string account)
    {
        DSTeacherTableAdapters.TeacherTableAdapter helper = new DSTeacherTableAdapters.TeacherTableAdapter();
        return helper.GetTeacherNameByAccount(account);
    }

    public string GetNameByUserCode(string UserCode)
    {
        DSTeacherTableAdapters.TeacherTableAdapter helper = new DSTeacherTableAdapters.TeacherTableAdapter();
        return helper.GetNameByUserCode(UserCode).ToString();
    }
    public void InsertTeacher(string account, string name, string college, string sex, string userCode)
    {
        DSTeacherTableAdapters.TeacherTableAdapter helper = new DSTeacherTableAdapters.TeacherTableAdapter();
        helper.InsertTeacher(account, name, college, sex, userCode);
    }

}