using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;

/// <summary>
/// Exclude 的摘要说明
/// </summary>
public class Exclude
{
	public Exclude()
	{
	}

    public bool ExamUpdateTypeByID(string type,  int ID)
    {
        DSExcludeTableAdapters.ExaminationCourseTableAdapter helper = new DSExcludeTableAdapters.ExaminationCourseTableAdapter();
        if(type=="")
        {
            helper.UpdateTypeNULLByID(ID);
        }
        else
        {
            helper.UpdateTypeByID(type, ID);
        }
        return true;
    }
    public bool ExcludeUpdateTypeByID(string type, int ID)
    {
        DSExcludeTableAdapters.ExcludeCourseTableAdapter helper = new DSExcludeTableAdapters.ExcludeCourseTableAdapter();
        if (type == "")
        {
            helper.UpdateTypeNULLByID(ID);
        }
        else
        {
            helper.UpdateTypeByID(type, ID);
        }
        return true;
    }
    public bool DeleteByID(int ID)
    {
        DSExcludeTableAdapters.ExcludeCourseTableAdapter helper = new DSExcludeTableAdapters.ExcludeCourseTableAdapter();
        helper.DeleteByID(ID);
        return true;
    }
    public int UpdateByExcludeCourse()
    {
        DSExcludeTableAdapters.ExaminationCourseTableAdapter helper = new DSExcludeTableAdapters.ExaminationCourseTableAdapter();
        return helper.UpdateByExcludeCourse();
    }
    public string SelectTimeByID(int ID)
    {
        DSExcludeTableAdapters.ExaminationCourseTableAdapter helper = new DSExcludeTableAdapters.ExaminationCourseTableAdapter();
        return helper.SelectTimeByID(ID).ToString();
    }
    public int CountByCourseNum(string courseNum)
    {
        DSExcludeTableAdapters.ExcludeCourseTableAdapter helper = new DSExcludeTableAdapters.ExcludeCourseTableAdapter();
        return Convert.ToInt32(helper.ScalarByCourseNum(courseNum));
    }
    public bool AddExcludeCourse(DataRow dr)
    {
        string s = dr["teachingPlan"].ToString();
        DSExcludeTableAdapters.ExcludeCourseTableAdapter helper = new DSExcludeTableAdapters.ExcludeCourseTableAdapter();
        string strNum = dr["course_num"].ToString();
        if (CountByCourseNum(strNum) == 0)
        {
            helper.InsertExcludeCourse(dr["type"].ToString(),dr["course_num"].ToString(), dr["course_name"].ToString() );
        }
            return true;
    }

    public DataTable SelectByID(int ID)
    {
        DSExcludeTableAdapters.ExaminationCourseTableAdapter helper = new DSExcludeTableAdapters.ExaminationCourseTableAdapter();
        return  helper.SelectByID(ID);
    }
    public DataTable SelectAllExamCourse()
    {
        DSExcludeTableAdapters.ExaminationCourseTableAdapter helper = new DSExcludeTableAdapters.ExaminationCourseTableAdapter();
        return  helper.SelectAllExamCourse();
    }
    public DataTable SelectCourseWithTypeIsNull()
    {
        DSExcludeTableAdapters.ExaminationCourseTableAdapter helper = new DSExcludeTableAdapters.ExaminationCourseTableAdapter();
        return helper.SelectCourseWithTypeIsNull();
    }
    
}