using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SysData = System.Data;

/// <summary>
/// Summary description for ExaminationCourse
/// </summary>
public class ExaminationCourse
{
	public ExaminationCourse()
	{

    }
    public bool UpdateCommonOrPrivateByView()
    {
        DSExaminationCourseTableAdapters.ExaminationCourseTableAdapter helper =new DSExaminationCourseTableAdapters.ExaminationCourseTableAdapter();
        helper.UpdateCommonOrPrivateByView();
        return true;
    }
    public bool UpdatePrivateCollegeByView()
    {
        DSExaminationCourseTableAdapters.ExaminationCourseTableAdapter helper = new DSExaminationCourseTableAdapters.ExaminationCourseTableAdapter();
        helper.UpdatePrivateCollegeByView();
        return true;
    }
    public bool UpdatePrivateCollegeByID(int ID,string College)
    {
        DSExaminationCourseTableAdapters.ExaminationCourseTableAdapter helper = new DSExaminationCourseTableAdapters.ExaminationCourseTableAdapter();
        helper.UpdatePrivateCollegeByID(College,ID);
        return true;
    }
    public bool UpdateCommonOrPrivateByID(int ID, string PrivateOrCommon)
    {
        DSExaminationCourseTableAdapters.ExaminationCourseTableAdapter helper = new DSExaminationCourseTableAdapters.ExaminationCourseTableAdapter();
        helper.UpdateCommonOrPrivateByID(PrivateOrCommon,ID);
        return true;
    }
    public bool SetCommonOPrivateAsNull()
    {
        DSExaminationCourseTableAdapters.ExaminationCourseTableAdapter helper = new DSExaminationCourseTableAdapters.ExaminationCourseTableAdapter();
        helper.SetCommonPrivateAsNull();
        return true;
    }
    public SysData.DataTable GetPriCom()
    {
        DSExaminationCourseTableAdapters.ExaminationCourseTableAdapter helper = new DSExaminationCourseTableAdapters.ExaminationCourseTableAdapter();
        return helper.GetPriCom();
    }
    public SysData.DataTable GetAllData()
    {
        DSExaminationCourseTableAdapters.ExaminationCourseTableAdapter helper = new DSExaminationCourseTableAdapters.ExaminationCourseTableAdapter();
        return helper.GetAllData();
    }
    public SysData.DataTable GetExam(string course_name)
    {
        DSExaminationCourseTableAdapters.ExaminationCourseTableAdapter helper = new DSExaminationCourseTableAdapters.ExaminationCourseTableAdapter();
        return helper.GetExam(course_name);
    }
    public void UpdateC(string course_name)
    {
        DSExaminationCourseTableAdapters.ExaminationCourseTableAdapter helper = new DSExaminationCourseTableAdapters.ExaminationCourseTableAdapter();
        helper.UpdateC(course_name);
    }
    public void Updatep()
    {
        DSExaminationCourseTableAdapters.ExaminationCourseTableAdapter helper = new DSExaminationCourseTableAdapters.ExaminationCourseTableAdapter();
        helper.Updatep();
    }
    public void UpdateTypeByCoursenum(string coursenum)
    {
        DSExaminationCourseTableAdapters.ExaminationCourseTableAdapter helper = new DSExaminationCourseTableAdapters.ExaminationCourseTableAdapter();
        helper.UpdateTypeByCoursenum(coursenum);
    }
    
}