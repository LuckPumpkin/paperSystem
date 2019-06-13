using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// ImportExamCourse 的摘要说明
/// </summary>
public class ImportExamCourse
{
    public void InsertExamCourse(int ID,string teachingPlan, string course_dept, string course_num, string course_name, string course_serialNum, string course_type, string test_type, string course_teacher, string course_credit, string totalHours_teaching, string totalHours_experiment, string totalHours_pratice, string totalHours_computer, string totalHours_outsideClass, string totalHours, string class_capacity, string class_remainder, string total_studentNum, string selected_studentNum, string class_time, string class_location, string class_class, string course_attribute, string class_campus)
    {
        DSImportExamCourseTableAdapters.ExaminationCourseTableAdapter helper = new DSImportExamCourseTableAdapters.ExaminationCourseTableAdapter();
        helper.InsertExamCourse(ID,teachingPlan, course_dept, course_num, course_name, course_serialNum, course_type, test_type, course_teacher,course_credit, totalHours_teaching, totalHours_experiment, totalHours_pratice, totalHours_computer,totalHours_outsideClass, totalHours, class_capacity, class_remainder, total_studentNum, selected_studentNum, class_time,class_location, class_class, course_attribute, class_campus);
    }
    public int GetExamId(string course_num, string course_serialNum)
    {
        DSImportExamCourseTableAdapters.ExaminationCourseTableAdapter helper = new DSImportExamCourseTableAdapters.ExaminationCourseTableAdapter();
        return Convert.ToInt32(helper.GetExamId(course_num, course_serialNum).ToString());
    }
    public void UpdateById(string course_name, int ID)
    {
        DSImportExamCourseTableAdapters.ExaminationCourseTableAdapter helper = new DSImportExamCourseTableAdapters.ExaminationCourseTableAdapter();
        helper.UpdateByID(course_name, ID);
    }
}