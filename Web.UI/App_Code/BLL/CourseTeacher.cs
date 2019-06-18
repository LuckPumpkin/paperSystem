using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using SysData = System.Data;
using System.Configuration;


/// <summary>
/// Summary description for CourseTeacher
/// </summary>
public class CourseTeacher
{
	public CourseTeacher()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    public void DeleteAllCourseTeacher()
    {
        DSCourseTeacherTableAdapters.CourseTeacherTableAdapter helper = new DSCourseTeacherTableAdapters.CourseTeacherTableAdapter();
        helper.DeleteAllCourseTeacher();
    }
    public void DeleteAllCourseSeriesTeacher()
    {
        DSCourseTeacherTableAdapters.CourseSeriesTeacherTableAdapter helper = new DSCourseTeacherTableAdapters.CourseSeriesTeacherTableAdapter();
        helper.DeleteAll();
    }
    public void DeleteAllCourseClass()
    {
        DSCourseTeacherTableAdapters.CourseClassTableAdapter helper = new DSCourseTeacherTableAdapters.CourseClassTableAdapter();
        helper.DeleteAllCourseClass();
    }
    public void DeleteAllCourseSeriesClass()
    {
        DSCourseTeacherTableAdapters.CourseSeriesClassTableAdapter helper = new DSCourseTeacherTableAdapters.CourseSeriesClassTableAdapter();
        helper.DeleteAllCourseSeriesClass();
    }
    public void AddCourseSeriesTeacher(string course_no,string course_series,string course_teacherno,string course_teachername)
    {
        DSCourseTeacherTableAdapters.CourseSeriesTeacherTableAdapter helper = new DSCourseTeacherTableAdapters.CourseSeriesTeacherTableAdapter();
        helper.InsertCourseSeriesTeacher(course_no, course_series, course_teacherno, course_teachername);
    }
    public void AddCourseSeriesClass(string course_no, string course_series, string course_class)
    {
        DSCourseTeacherTableAdapters.CourseSeriesClassTableAdapter helper = new DSCourseTeacherTableAdapters.CourseSeriesClassTableAdapter();
        helper.InsertCourseSeriesClass(course_no, course_series, course_class);
    }
    public void AddCourseTeacher(string course_no, string course_teacherno, string course_teachername)
    {
        DSCourseTeacherTableAdapters.CourseTeacherTableAdapter helper = new DSCourseTeacherTableAdapters.CourseTeacherTableAdapter();
        helper.InsertCourseTeacher(course_no, course_teacherno, course_teachername);
    }
    public void AddCourseClass(string course_no, string course_class)
    {
        DSCourseTeacherTableAdapters.CourseClassTableAdapter helper = new DSCourseTeacherTableAdapters.CourseClassTableAdapter();
        helper.InsertCourseClass(course_no, course_class);
    }
    public SysData.DataTable GetOtherTeacher(string course_no,string course_series)
    {
        DSCourseTeacherTableAdapters.CourseSeriesTeacherTableAdapter helper = new DSCourseTeacherTableAdapters.CourseSeriesTeacherTableAdapter();
        return helper.GetDataOutsideSerial(course_no, course_series);
    }
    public void UpdateCourseSeriesTeacher(string course_no, string course_series, string course_teacherno, string course_teachername,string course_teacherno1)
    {
        DSCourseTeacherTableAdapters.CourseSeriesTeacherTableAdapter helper = new DSCourseTeacherTableAdapters.CourseSeriesTeacherTableAdapter();
        helper.UpdateCourseSeriesTeacher(course_teacherno, course_teachername,course_no, course_series,course_teacherno1);
    }
    public void UpdateCourseSeriesClass(string course_no, string course_series, string course_class,string cclass)
    {
        DSCourseTeacherTableAdapters.CourseSeriesClassTableAdapter helper = new DSCourseTeacherTableAdapters.CourseSeriesClassTableAdapter();
        helper.UpdateCourseSeriesClass(course_class, course_no, course_series,cclass);
    }
    public void UpdateCourseTeacher(string course_no, string course_teacherno, string course_teachername,string course_teacherno1)
    {
        DSCourseTeacherTableAdapters.CourseTeacherTableAdapter helper = new DSCourseTeacherTableAdapters.CourseTeacherTableAdapter();
        helper.UpdateCourrseTeacher(course_teacherno, course_teachername,course_no,course_teacherno1);
    }
    public void UpdateCourseTeacherno(string course_no)
    {
        DSCourseTeacherTableAdapters.CourseTeacherTableAdapter helper = new DSCourseTeacherTableAdapters.CourseTeacherTableAdapter();
        helper.UpdateCourseTeacherno(course_no);
    }
    public void UpdateExamTeachernoAndName(string course_no, string course_series)
    {
        DSCourseTeacherTableAdapters.CourseSeriesTeacherTableAdapter helper = new DSCourseTeacherTableAdapters.CourseSeriesTeacherTableAdapter();
        helper.UpdateExamTeachernoAndName(course_no,course_series);
    }
    public void UpdateCourseClass(string course_no, string course_class)
    {
        DSCourseTeacherTableAdapters.CourseClassTableAdapter helper = new DSCourseTeacherTableAdapters.CourseClassTableAdapter();
        helper.UpdateCourseClass(course_class, course_no);
    }
    public void DeleteCourseSeriesTeacher(string course_no, string course_series, string course_teacherno)
    {
        DSCourseTeacherTableAdapters.CourseSeriesTeacherTableAdapter helper = new DSCourseTeacherTableAdapters.CourseSeriesTeacherTableAdapter();
        helper.DeleteCourseSeriesTeacher( course_no, course_series,course_teacherno);
    }
    public void DeleteCourseSeriesClass(string course_no, string course_series, string course_class)
    {
        DSCourseTeacherTableAdapters.CourseSeriesClassTableAdapter helper = new DSCourseTeacherTableAdapters.CourseSeriesClassTableAdapter();
        helper.DeleteCourseSeriesClass(course_no, course_series, course_class);
    }
    public void DeleteCourseTeacher(string course_no, string course_teacherno)
    {
        DSCourseTeacherTableAdapters.CourseTeacherTableAdapter helper = new DSCourseTeacherTableAdapters.CourseTeacherTableAdapter();
        helper.DeleteCourseTeacher( course_no, course_teacherno);
    }
    public void DeleteCourseClass(string course_no, string course_class)
    {
        DSCourseTeacherTableAdapters.CourseClassTableAdapter helper = new DSCourseTeacherTableAdapters.CourseClassTableAdapter();
        helper.DeleteCourseClass(course_no, course_class);
    }
    public SysData.DataTable GetTeacherByCoursenoAndSeriesno(string course_no,string course_seriesno)
    {
        DSCourseTeacherTableAdapters.CourseSeriesTeacherTableAdapter helper = new DSCourseTeacherTableAdapters.CourseSeriesTeacherTableAdapter();
        return helper.GetTeacherByCourseNoAndSeriesNo(course_no, course_seriesno);
    }
    public SysData.DataTable GetClassByCoursenoAndSeriesno(string course_no, string course_seriesno)
    {
        DSCourseTeacherTableAdapters.CourseSeriesClassTableAdapter helper = new DSCourseTeacherTableAdapters.CourseSeriesClassTableAdapter();
        return helper.GetClassByCourseNoAndSeriesNo(course_no, course_seriesno);
    }
    public void DeleteByCoursenoAndSeriesno(string course_no, string course_seriesno)
    {
        DSCourseTeacherTableAdapters.CourseSeriesTeacherTableAdapter helper = new DSCourseTeacherTableAdapters.CourseSeriesTeacherTableAdapter();
        helper.DeleteByCoursenoAndSeriesno(course_no, course_seriesno);
    }
    public void DeleteByCoursenoAndSeries(string course_no, string course_seriesno)
    {
        DSCourseTeacherTableAdapters.CourseSeriesClassTableAdapter helper = new DSCourseTeacherTableAdapters.CourseSeriesClassTableAdapter();
        helper.DeleteByCoursenoAndSeries(course_no, course_seriesno);
    }
    public int GetTeacherNum(string course_no)
    {
        DSCourseTeacherTableAdapters.CourseTeacherTableAdapter helper = new DSCourseTeacherTableAdapters.CourseTeacherTableAdapter();
        return Convert.ToInt32(helper.GetTeacherNum(course_no));
    }
    public int GetTeacherNumber(string course_no, string course_series)
    {
        DSCourseTeacherTableAdapters.CourseSeriesTeacherTableAdapter helper = new DSCourseTeacherTableAdapters.CourseSeriesTeacherTableAdapter();
        return Convert.ToInt32(helper.GetTeacherNumber(course_no,course_series));
    }
    public SysData.DataTable GetExamByCoursenoSeriesnoTeacherno(string course_no, string course_series,string teacherno)
    {
        DSCourseTeacherTableAdapters.CourseSeriesTeacherTableAdapter helper = new DSCourseTeacherTableAdapters.CourseSeriesTeacherTableAdapter();
        return helper.GetExamByCoursenoSeriesnoTeacherno(course_no, course_series, teacherno);
    }
    public SysData.DataTable GetExamByCoursenoSeriesnoClass(string course_no, string course_series, string course_class)
    {
        DSCourseTeacherTableAdapters.CourseSeriesClassTableAdapter helper = new DSCourseTeacherTableAdapters.CourseSeriesClassTableAdapter();
        return helper.GetExamByCoursenoSeriesnoClass(course_no, course_series, course_class);
    }
    public SysData.DataTable GetCourseByCoursenoClass(string course_no, string course_class)
    {
        DSCourseTeacherTableAdapters.CourseClassTableAdapter helper = new DSCourseTeacherTableAdapters.CourseClassTableAdapter();
        return helper.GetCourseByCoursenoClass(course_no, course_class);
    }
    public SysData.DataTable GetCourseByCoursenoTeacherno(string course_no, string teacherno)
    {
        DSCourseTeacherTableAdapters.CourseTeacherTableAdapter helper = new DSCourseTeacherTableAdapters.CourseTeacherTableAdapter();
        return helper.GetCourseByCoursenoTeacherno(course_no, teacherno);
    }
    public SysData.DataTable GetExamByCoursenoTeacherno(string course_no, string teacherno)
    {
        DSCourseTeacherTableAdapters.CourseSeriesTeacherTableAdapter helper = new DSCourseTeacherTableAdapters.CourseSeriesTeacherTableAdapter();
        return helper.GetExamByCoursenoTeacherno(course_no, teacherno);
    }
    public SysData.DataTable GetExamByCoursenoClass(string course_no, string course_class)
    {
        DSCourseTeacherTableAdapters.CourseSeriesClassTableAdapter helper = new DSCourseTeacherTableAdapters.CourseSeriesClassTableAdapter();
        return helper.GetExamByCoursenoClass(course_no, course_class);
    }
}