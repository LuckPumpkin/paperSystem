using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

/// <summary>
/// Week 的摘要说明
/// </summary>
public class Week
{
	public Week()
	{
	}

    public bool UpdateTagRemarkByClassOfProcess(string tag, string c)
    {
        DSWeekTableAdapters.ProcessTableAdapter helper = new DSWeekTableAdapters.ProcessTableAdapter();
        helper.UpdateTagRemarkByClass(tag, c);
        return true;
    }
    public string SelectTimeByIDOfWeek(int ID)
    {
        DSWeekTableAdapters.Week_Course_ClassTableAdapter helper = new DSWeekTableAdapters.Week_Course_ClassTableAdapter();
        return helper.SelectTimeByID(ID).ToString();
    }
    public bool UpdateWeekOfProcess(string week, string c)
    {
        DSWeekTableAdapters.ProcessTableAdapter helper = new DSWeekTableAdapters.ProcessTableAdapter();
        helper.UpdateWeekByClass(week, c);
        return true;
    }
    public DataTable SelectAllProcess()
    {
        DSWeekTableAdapters.ProcessTableAdapter helper = new DSWeekTableAdapters.ProcessTableAdapter();
        return helper.SelectAllProcess();
    }
    public DataTable SelectAllWeek()
    {
        DSWeekTableAdapters.Week_Course_ClassTableAdapter helper = new DSWeekTableAdapters.Week_Course_ClassTableAdapter();
        return helper.SelectAllWeek();
    }
    public DataRow SelectByIDOfWeek(int ID)
    {
        DSWeekTableAdapters.Week_Course_ClassTableAdapter helper = new DSWeekTableAdapters.Week_Course_ClassTableAdapter();
        DataTable dt = helper.SelectByID(ID);
        DataRow dr = dt.Rows[0];
        return dr;
    }

    public bool UpdateWeekOfWeek( string course_week,int ID)
    {
        DSWeekTableAdapters.Week_Course_ClassTableAdapter helper = new DSWeekTableAdapters.Week_Course_ClassTableAdapter();
        helper.UpdateWeekOfWeek(course_week,ID);
        return true;
    }
    public bool UpdateCourseWeekOfWeek(string course_week, int ID)
    {
        DSWeekTableAdapters.Week_Course_ClassTableAdapter helper = new DSWeekTableAdapters.Week_Course_ClassTableAdapter();
        helper.UpdateCourseWeek(course_week, ID);
        return true;
    }
    public bool UpdateTestWeekByExamCourse()
    {
        DSWeekTableAdapters.Week_Course_ClassTableAdapter helper = new DSWeekTableAdapters.Week_Course_ClassTableAdapter();
        helper.UpdateTestweekByExamCourse();
        return true;
    }
    public  void UpdateClassWeekByProcess()
    {
        DSWeekTableAdapters.Week_Course_ClassTableAdapter helper = new DSWeekTableAdapters.Week_Course_ClassTableAdapter();
        helper.UpdateClassWeekByProcess();
    }
    public void UpdateTestWeekByClassWeekIsNull()
    {
        DSWeekTableAdapters.Week_Course_ClassTableAdapter helper = new DSWeekTableAdapters.Week_Course_ClassTableAdapter();
        helper.UpdateTestWeekByClassWeekIsNull();
    }
    public string SelectWeekByClassOfProcess(string class_class)
    {
        DSWeekTableAdapters.ProcessTableAdapter helper = new DSWeekTableAdapters.ProcessTableAdapter();
        if (helper.SelectWeekByClassWithProcess(class_class) != null)
            return helper.SelectWeekByClassWithProcess(class_class).ToString();
        else
            return "";
    }
    public bool DeleteWeekCourseClass()
    {
        DSWeekTableAdapters.Week_Course_ClassTableAdapter helper = new DSWeekTableAdapters.Week_Course_ClassTableAdapter();
        helper.DeleteAll();
        return true;
    }
}