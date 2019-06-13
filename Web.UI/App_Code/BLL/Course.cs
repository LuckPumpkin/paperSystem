using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using SysData = System.Data;
using System.Configuration;

/// <summary>
/// Summary description for Course
/// </summary>
public class Course
{
    public Course()
    {

    }

    public SysData.DataTable GetDataByPrco()
    {
        DSCourseTableAdapters.ExaminationCourseTableAdapter helper = new DSCourseTableAdapters.ExaminationCourseTableAdapter();
        return helper.GetDataByPrco();
    }
    public SysData.DataTable GetDataFromView()
    {
        DSCourseTableAdapters.CourseTableAdapter helper = new DSCourseTableAdapters.CourseTableAdapter();
        return helper.GetDataFromView();
    }
    public SysData.DataTable GetAllExamID()
    {
        DSCourseTableAdapters.ExaminationCourseTableAdapter helper = new DSCourseTableAdapters.ExaminationCourseTableAdapter();
        return helper.GetAllExamID();
    }
    public SysData.DataTable GetAllCourseID()
    {
        DSCourseTableAdapters.CourseTableAdapter helper = new DSCourseTableAdapters.CourseTableAdapter();
        return helper.GetAllCourseID();
    }
    public SysData.DataTable GetExamCourseByID(int ID)
    {
        DSCourseTableAdapters.ExaminationCourseTableAdapter helper = new DSCourseTableAdapters.ExaminationCourseTableAdapter();
        return helper.GetExamCourseByID(ID);
    }
    public SysData.DataTable GetAllCourseTeacher()
    {
        DSCourseTableAdapters.CourseTableAdapter helper = new DSCourseTableAdapters.CourseTableAdapter();
        return helper.GetAllCourseTeacher();
    }
    public SysData.DataTable GetAllClass()
    {
        DSCourseTableAdapters.CourseTableAdapter helper = new DSCourseTableAdapters.CourseTableAdapter();
        return helper.GetAllClass();
    }
    public SysData.DataTable GetAllSeriesClass()
    {
        DSCourseTableAdapters.ExaminationCourseTableAdapter helper = new DSCourseTableAdapters.ExaminationCourseTableAdapter();
        return helper.GetAllSeriesClass();
    }
    public SysData.DataTable GetCourse(string course_no)
    {
        DSCourseTableAdapters.CourseTableAdapter helper = new DSCourseTableAdapters.CourseTableAdapter();
        return helper.GetCourse(course_no);
    }
    public SysData.DataTable GetAllExCourseTeacher()
    {
        DSCourseTableAdapters.ExaminationCourseTableAdapter helper = new DSCourseTableAdapters.ExaminationCourseTableAdapter();
        return helper.GetAllExCourseTeacher();
    }
    public SysData.DataTable GetExCourseTeacher(string course_no, string course_seriesno)
    {
        DSCourseTableAdapters.ExaminationCourseTableAdapter helper = new DSCourseTableAdapters.ExaminationCourseTableAdapter();
        return helper.GetExamCourse(course_no, course_seriesno);
    }
    public void UpdateExamCourse()
    {
        DSCourseTableAdapters.ExaminationCourseTableAdapter helper = new DSCourseTableAdapters.ExaminationCourseTableAdapter();
        helper.UpdateExamCourse();
    }
    public void DeleteAll()
    {
        DSCourseTableAdapters.CourseTableAdapter helper = new DSCourseTableAdapters.CourseTableAdapter();
        helper.DeleteAll();
    }
    public void UpdateTeacherByCourseNo(string teacherno, string course_no)
    {
        DSCourseTableAdapters.CourseTableAdapter helper = new DSCourseTableAdapters.CourseTableAdapter();
        helper.UpdateTeacherNoByCourseNo(teacherno, course_no);
    }
    public void UpdateCourseProByID(int ID, string pro)
    {
        DSCourseTableAdapters.CourseTableAdapter helper = new DSCourseTableAdapters.CourseTableAdapter();
        helper.UpdateCourseProByID(pro, ID);
    }
    public void InsertExamCourse(string teachingPlan, string course_dept, string course_no, string course_name, string course_serialno, string course_type, string course_attribute, string course_campus, string CommonOrPrivate, string PrivateCollege)
    {
        DSCourseTableAdapters.ExaminationCourseTableAdapter helper = new DSCourseTableAdapters.ExaminationCourseTableAdapter();
        helper.InsertExaminatrionCourse(teachingPlan, course_dept, course_no, course_name, course_serialno, course_type, course_attribute, course_campus, CommonOrPrivate, PrivateCollege);
    }
    public void InsertCourse(string teachingPlan, string course_dept, string course_no, string course_name, string course_type, string course_attribute, string course_campus, string CommonOrPrivate, string PrivateCollege, string course_profession)
    {
        DSCourseTableAdapters.CourseTableAdapter helper = new DSCourseTableAdapters.CourseTableAdapter();
        helper.InsertCourse(course_no, teachingPlan, course_dept, course_name, course_type, course_attribute, course_campus, CommonOrPrivate, PrivateCollege, course_profession);
    }
    public int GetIDByCourseNo(string course_no)
    {
        DSCourseTableAdapters.CourseTableAdapter helper = new DSCourseTableAdapters.CourseTableAdapter();
        return Convert.ToInt32(helper.GetIDByCourseNo(course_no).ToString());
    }
    public int GetIDByCoursenoAndSeriesno(string course_no, string course_seriesno)
    {
        DSCourseTableAdapters.ExaminationCourseTableAdapter helper = new DSCourseTableAdapters.ExaminationCourseTableAdapter();
        return Convert.ToInt32(helper.GetIDByCoursenoAndSeriesno(course_no, course_seriesno).ToString());
    }
    public void UpdateExamCourseByID(string course_dept, string course_no, string course_name, string course_serialno, string course_type, string course_attribute, string CommonOrPrivate, string PrivateCollege, int Original_ID)
    {
        DSCourseTableAdapters.ExaminationCourseTableAdapter helper = new DSCourseTableAdapters.ExaminationCourseTableAdapter();
        helper.UpdateExamCourseByID(course_dept, course_no, course_name, course_serialno, course_type, course_attribute, CommonOrPrivate, PrivateCollege, Original_ID);
    }
    public void UpdateCourseByCourseNo(string course_dept, string course_no, string course_name, string course_type, string course_attribute, string CommonOrPrivate, string PrivateCollege, string course_profession)
    {
        DSCourseTableAdapters.CourseTableAdapter helper = new DSCourseTableAdapters.CourseTableAdapter();
        helper.UpdateCourseByCourseNo(course_no, course_dept, course_name, course_type, course_attribute, CommonOrPrivate, PrivateCollege, course_profession);
    }
    public void DeleteCourseByID(int courseID)
    {
        DSCourseTableAdapters.CourseTableAdapter helper = new DSCourseTableAdapters.CourseTableAdapter();
        helper.DeleteCourseByID(courseID);
    }
    public void DeleteExamCourseByID(int examCourseID)
    {
        DSCourseTableAdapters.ExaminationCourseTableAdapter helper = new DSCourseTableAdapters.ExaminationCourseTableAdapter();
        helper.DeleteExamCourseByID(examCourseID);
    }
    public SysData.DataTable GetExamCourseByCourseNo(string course_no)
    {
        DSCourseTableAdapters.ExaminationCourseTableAdapter helper = new DSCourseTableAdapters.ExaminationCourseTableAdapter();
        return helper.GetExamCourseByCourseNo(course_no);
    }
    public SysData.DataTable GetExamByCoursenoSeriesnoOutsideID(string course_no, string seriesno, int ID)
    {
        DSCourseTableAdapters.ExaminationCourseTableAdapter helper = new DSCourseTableAdapters.ExaminationCourseTableAdapter();
        return helper.GetExamByCoursenoSeriesnoOutsideID(course_no, seriesno, ID);
    }
    public void UpdateTeacherNoByExamCourse(string teacherno, string teachername, string course_no, string course_serialno)
    {
        DSCourseTableAdapters.ExaminationCourseTableAdapter helper = new DSCourseTableAdapters.ExaminationCourseTableAdapter();
        helper.UpdateTeacherNoByExamCourse(teacherno, teachername, course_no, course_serialno);
    }

}