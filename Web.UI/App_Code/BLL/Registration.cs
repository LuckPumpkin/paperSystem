using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Registration 的摘要说明
/// </summary>
public class Registration
{
	public Registration()
	{
		//
		// TODO: 在此处添加构造函数逻辑
		//
	}
    public System.Data.DataTable GetDataByCourseID(int courseID){
        DSRegistrationTableAdapters.RegistrationTableAdapter helper = new DSRegistrationTableAdapters.RegistrationTableAdapter();
        return helper.GetDataByCourseID(courseID);
    }
    public string GetTeacherPlanByReg(int regID)
    {
        DSRegistrationTableAdapters.RegistrationTableAdapter helper = new DSRegistrationTableAdapters.RegistrationTableAdapter();
        return helper.GetTeacherPlanByReg(regID);
    }
    public string GetDeptByReg(int regID)
    {
        DSRegistrationTableAdapters.RegistrationTableAdapter helper = new DSRegistrationTableAdapters.RegistrationTableAdapter();
        return helper.GetDeptByReg(regID);
    }
    public string GetPAorBByReg(int regID)
    {
        DSRegistrationTableAdapters.RegistrationTableAdapter helper = new DSRegistrationTableAdapters.RegistrationTableAdapter();
        return helper.GetPAorBByReg(regID);
    }
    
    public int GetCourseIDByRegID(int regID)
    {
        DSRegistrationTableAdapters.RegistrationTableAdapter helper = new DSRegistrationTableAdapters.RegistrationTableAdapter();
        return Convert.ToInt32(helper.GetCourseIDByRegID(regID));
    }
    public string GetCoursenoByRegID(int regID)
    {
        DSRegistrationTableAdapters.RegistrationTableAdapter helper = new DSRegistrationTableAdapters.RegistrationTableAdapter();
        return helper.GetCoursenoByRegID(regID);
    }



 public string GetCollegeTeacher(int regID)
    {
        DSRegistrationTableAdapters.RegistrationTableAdapter helper = new DSRegistrationTableAdapters.RegistrationTableAdapter();
        return helper.GetCollegeTeacher(regID);
    }
    public string GetProfessionTeacher(int regID)
    {
        DSRegistrationTableAdapters.RegistrationTableAdapter helper = new DSRegistrationTableAdapters.RegistrationTableAdapter();
        return helper.GetProfessionTeacher(regID);
    }
    public int GetRegistrationID(string courseNo)
    {
        DSRegistrationTableAdapters.RegistrationTableAdapter helper = new DSRegistrationTableAdapters.RegistrationTableAdapter();
        DSRegistration.RegistrationDataTable table = new DSRegistration.RegistrationDataTable();
        return Convert.ToInt32(helper.GetRegistrationIDByCourseNo(courseNo).ToString());
    }
    public int GetRegNum(string account)
    {
        DSRegistrationTableAdapters.RegistrationTableAdapter helper = new DSRegistrationTableAdapters.RegistrationTableAdapter();
        return Convert.ToInt32(helper.GetRegNum(account));
    }
    public int GetRegNumAduit(string pro)
    {
        DSRegistrationTableAdapters.RegistrationTableAdapter helper = new DSRegistrationTableAdapters.RegistrationTableAdapter();
        return Convert.ToInt32(helper.GetRegNumAduit(pro));
    }
    public int GetRegCoAduit(string College)
    {
        DSRegistrationTableAdapters.RegistrationTableAdapter helper = new DSRegistrationTableAdapters.RegistrationTableAdapter();
        return Convert.ToInt32(helper.GetRegCoAduit(College));
    }
    public void UpdateState(int state,int ID)
    {
        DSRegistrationTableAdapters.RegistrationTableAdapter helper = new DSRegistrationTableAdapters.RegistrationTableAdapter();
        helper.UpdateState(state, ID);
    }
    public void UpdateProRegistration(int ID,string audit)
    {
        DSRegistrationTableAdapters.RegistrationTableAdapter helper = new DSRegistrationTableAdapters.RegistrationTableAdapter();
        helper.UpdateProfessionAudit(audit, ID);
    }
    public void UpdateProRegistration2(int ID, string audit)
    {
        DSRegistrationTableAdapters.RegistrationTableAdapter helper = new DSRegistrationTableAdapters.RegistrationTableAdapter();
        helper.UpdateCollegeAudit(audit, ID);
    }
    public void UpdateTikuorZini(int ID, string t)
    {
        DSRegistrationTableAdapters.RegistrationTableAdapter helper = new DSRegistrationTableAdapters.RegistrationTableAdapter();
        helper.UpdateTikuorZini(t, ID);
    }
    public void DeleteAllReg()
    {
        DSRegistrationTableAdapters.RegistrationTableAdapter helper = new DSRegistrationTableAdapters.RegistrationTableAdapter();
        helper.DeleteAllRegistration();
    }

    public void UpdateTikuorZini(string regID, char p)
    {
        throw new NotImplementedException();
    }
    public void InsertReg(int courseID,int PaperID)
    {
        DSRegistrationTableAdapters.RegistrationTableAdapter helper = new DSRegistrationTableAdapters.RegistrationTableAdapter();
        helper.InsertRegistration(courseID,PaperID);
    }
    public void DeleteRegByCourseID(int courseID)
    {
        DSRegistrationTableAdapters.RegistrationTableAdapter helper = new DSRegistrationTableAdapters.RegistrationTableAdapter();
        helper.DeleteRegByCourseID(courseID);
    }
    public int GetStateByRegID(int regID)
    {
        DSRegistrationTableAdapters.RegistrationTableAdapter helper = new DSRegistrationTableAdapters.RegistrationTableAdapter();
        return Convert.ToInt16(helper.GetStateByRegID(regID));
    }
 public string GetTeacheroByRegID(int RegID)
    {
        DSRegistrationTableAdapters.RegistrationTableAdapter helper = new DSRegistrationTableAdapters.RegistrationTableAdapter();
        return helper.GetTeachernoByRegID(RegID).ToString();
    }

 public void UpdateStateByCourseID(int state, int ID)
 {
     DSRegistrationTableAdapters.RegistrationTableAdapter helper = new DSRegistrationTableAdapters.RegistrationTableAdapter();
     helper.UpdateStateByCourseID(state, ID);
 }
}