using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SysData = System.Data;


public partial class WebForms_Admin_AssignTask : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void LtnRegAssign_Click(object sender, EventArgs e)
    {
        try
        {
            //清空各表
            Course co = new Course();
            Registration reg = new Registration();
            Paper pa = new Paper();
            Detail de = new Detail();
            CourseTeacher ct = new CourseTeacher();
            Analysis ana = new Analysis();
            Signature si = new Signature();
            //si.DeleteALLSignature();
            reg.DeleteAllReg();
            de.DeleteAllModule();
            de.DeleteAllQuestiontype();
            de.DeleteAllDetail();
            ana.DeleteAllAnalysis();
            pa.DeleteAllPaper();
            co.DeleteAll();
            co.UpdateExamCourse();
            ct.DeleteAllCourseTeacher();
            ct.DeleteAllCourseSeriesTeacher();
            ct.DeleteAllCourseClass();
            ct.DeleteAllCourseSeriesClass();



            //Course初始化
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["AppConnStr"].ToString());
            conn.Open();
            SqlCommand selectCMD = new SqlCommand("select * from Course", conn);
            SqlCommand insertCMD = new SqlCommand("insert into Course(course_no,course_teacherno1,course_teacher,course_class,teachingPlan,course_dept,course_name,course_type,course_attribute,class_campus,CommonOrPrivate,PrivateCollege,course_teacherno,course_profession) values(@course_no,@course_teacherno1,@course_teacher,@course_class,@teachingPlan,@course_dept,@course_name,@course_type,@course_attribute,@class_campus,@CommonOrPrivate,@PrivateCollege,@course_teacherno,@course_profession)", conn);
            SqlParameter course_teacherno1, course_teacher, course_class, teachingPlan, course_dept, course_name, course_type, course_attribute, class_campus, CommonOrPrivate, PrivateCollege, course_teacherno, course_profession;
            course_teacherno1 = new SqlParameter("@course_teacherno1", "course_teacherno1");
            course_teacher = new SqlParameter("@course_teacher", "course_teacher");
            course_class = new SqlParameter("@course_class", "course_class");
            teachingPlan = new SqlParameter("@teachingPlan", "teachingPlan");
            course_dept = new SqlParameter("@course_dept", "course_dept");
            course_type = new SqlParameter("@course_type", "course_type");
            course_attribute = new SqlParameter("@course_attribute", "course_attribute");
            class_campus = new SqlParameter("@class_campus", "class_campus");
            CommonOrPrivate = new SqlParameter("@CommonOrPrivate", "CommonOrPrivate");
            PrivateCollege = new SqlParameter("@PrivateCollege", "PrivateCollege");
            course_name = new SqlParameter("@course_name", "course_name");
            course_teacherno = new SqlParameter("@course_teacherno", "course_teacherno");
            course_profession = new SqlParameter("@course_profession", "course_profession");
            course_teacherno1.SourceVersion = SysData.DataRowVersion.Current;
            course_teacher.SourceVersion = SysData.DataRowVersion.Current;
            course_class.SourceVersion = SysData.DataRowVersion.Current;
            teachingPlan.SourceVersion = SysData.DataRowVersion.Current;
            course_dept.SourceVersion = SysData.DataRowVersion.Current;
            course_type.SourceVersion = SysData.DataRowVersion.Current;
            course_attribute.SourceVersion = SysData.DataRowVersion.Current;
            class_campus.SourceVersion = SysData.DataRowVersion.Current;
            CommonOrPrivate.SourceVersion = SysData.DataRowVersion.Current;
            PrivateCollege.SourceVersion = SysData.DataRowVersion.Current;
            course_name.SourceVersion = SysData.DataRowVersion.Current;
            course_teacherno.SourceVersion = SysData.DataRowVersion.Current;
            course_profession.SourceVersion = SysData.DataRowVersion.Current;
            insertCMD.Parameters.AddRange(new SqlParameter[] { course_teacherno1, course_teacher, course_class, teachingPlan, course_dept, course_name, course_type, course_attribute, class_campus, CommonOrPrivate, PrivateCollege, course_teacherno, course_profession });
            SysData.DataTable dt = new SysData.DataTable();
            SqlDataAdapter sda = new SqlDataAdapter(selectCMD);
            sda.Fill(dt);
            SysData.DataTable dtCourse = co.GetDataFromView();
            for (int i = 0; i < dtCourse.Rows.Count; i++)
            {
                SysData.DataRow dr = dt.NewRow();
                dr["course_no"] = dtCourse.Rows[i]["course_no"].ToString();
                dr["course_teacherno1"] = dtCourse.Rows[i]["TeacherAccount"].ToString();
                dr["course_teacher"] = dtCourse.Rows[i]["teacherName"].ToString();
                dr["course_class"] = dtCourse.Rows[i]["class"].ToString();
                dr["teachingPlan"] = dtCourse.Rows[i]["teachingPlan"].ToString();
                dr["course_dept"] = dtCourse.Rows[i]["course_dept"].ToString();
                dr["course_name"] = dtCourse.Rows[i]["course_name"].ToString();
                dr["course_type"] = dtCourse.Rows[i]["course_type"].ToString();
                dr["course_attribute"] = dtCourse.Rows[i]["course_attribute"].ToString();
                dr["class_campus"] = dtCourse.Rows[i]["class_campus"].ToString();
                dr["CommonOrPrivate"] = dtCourse.Rows[i]["CommonOrPrivate"].ToString();
                dr["PrivateCollege"] = dtCourse.Rows[i]["PrivateCollege"].ToString();
                //dr["course_teacherno"] = dtCourse.Rows[i]["teacherNo"].ToString();
                dr["course_profession"] = dtCourse.Rows[i]["Profession"].ToString();
                dt.Rows.Add(dr);
            }
            SqlCommandBuilder scb = new SqlCommandBuilder(sda);
            sda.Update(dt);
            dt.AcceptChanges();

            //Paper初始化
            selectCMD = new SqlCommand("select * from Paper", conn);
            insertCMD = new SqlCommand("insert into Paper(courseID,[paper_AorB],flag,readed,printed) values(@courseID,@paperAorB,@flag,@readed,@printed)", conn);
            SqlParameter paperAorB;
            paperAorB = new SqlParameter("@paperAorB", "paperAorB");
            paperAorB.SourceVersion = SysData.DataRowVersion.Current;
            SqlParameter readed;
            readed = new SqlParameter("@readed", "readed");
            readed.SourceVersion = SysData.DataRowVersion.Current;
            SqlParameter flag;
            flag = new SqlParameter("@flag", "flag");
            flag.SourceVersion = SysData.DataRowVersion.Current;
            insertCMD.Parameters.AddRange(new SqlParameter[] { paperAorB, flag, readed });
            dt = new SysData.DataTable();
            sda = new SqlDataAdapter(selectCMD);
            sda.Fill(dt);
            dtCourse = co.GetAllCourseID();
            for (int i = 0; i < dtCourse.Rows.Count; i++)
            {
                SysData.DataRow dr = dt.NewRow();
                dr["courseID"] = dtCourse.Rows[i]["ID"].ToString();
                dr["paper_AorB"] = "A";
                dr["readed"] = 0;
                dr["flag"] = "考试";
                dr["printed"] = 0;
                dt.Rows.Add(dr);
                dr = dt.NewRow();
                dr["courseID"] = dtCourse.Rows[i]["ID"].ToString();
                dr["paper_AorB"] = "B";
                dr["readed"] = 0;
                //dr["flag"] = "补考";
                dr["printed"] = 0;
                dt.Rows.Add(dr);
            }
            scb = new SqlCommandBuilder(sda);
            sda.Update(dt);
            dt.AcceptChanges();


            //Registration初始化
            selectCMD = new SqlCommand("select * from Registration", conn);
            insertCMD = new SqlCommand("insert into Registration(courseID,PaperID,state,examMothed,examTime,TiKuorZiNi,coverage,expectTime,expectScore,examPercent)" +
            "values(@courseID,@PaperID,@state,@examMothed,@examTime,@TiKuorZiNi,@coverage,@expectTime,@expectScore,@examPercent)", conn);
            SqlParameter state, PaperID,courseID, examMothed, examTime, TiKuorZiNi, coverage, expectTime, expectScore, examPercent;
            courseID = new SqlParameter("@courseID", "courseID");
            PaperID = new SqlParameter("@PaperID", "PaperID");
            state = new SqlParameter("@state", "state");
            examMothed = new SqlParameter("@examMothed", "examMothed");
            examTime = new SqlParameter("@examTime", "examTime");
            TiKuorZiNi = new SqlParameter("@TiKuorZiNi", "TiKuorZiNi");
            coverage = new SqlParameter("@coverage", "coverage");
            expectTime = new SqlParameter("@expectTime", "expectTime");
            expectScore = new SqlParameter("@expectScore", "expectScore");
            examPercent = new SqlParameter("@examPercent", "examPercent");

            courseID.SourceVersion = SysData.DataRowVersion.Current;
            PaperID.SourceVersion = SysData.DataRowVersion.Current;
            state.SourceVersion = SysData.DataRowVersion.Current;
            examMothed.SourceVersion = SysData.DataRowVersion.Current;
            examTime.SourceVersion = SysData.DataRowVersion.Current;
            TiKuorZiNi.SourceVersion = SysData.DataRowVersion.Current;
            coverage.SourceVersion = SysData.DataRowVersion.Current;
            expectTime.SourceVersion = SysData.DataRowVersion.Current;
            expectScore.SourceVersion = SysData.DataRowVersion.Current;
            examPercent.SourceVersion = SysData.DataRowVersion.Current;

            insertCMD.Parameters.AddRange(new SqlParameter[] {PaperID, courseID, state, examMothed, examTime, TiKuorZiNi, coverage, expectTime, expectScore, examPercent });
            dt = new SysData.DataTable();
            sda = new SqlDataAdapter(selectCMD);
            sda.Fill(dt);
            dtCourse = pa.GetAllPaperIDCourseID();
            for (int i = 0; i < dtCourse.Rows.Count; i++)
            {
                SysData.DataRow dr = dt.NewRow();
                dr["courseID"] = dtCourse.Rows[i]["courseID"].ToString();
                dr["PaperID"] = dtCourse.Rows[i]["ID"].ToString();
                dr["state"] = "1";
                dr["examMothed"] = "闭卷";
                dr["examTime"] = "第   教学周周  第  节--第  节";
                dr["TiKuorZiNi"] = "自拟";
                dr["coverage"] = "基本知识、基础理论所占比例：    % \n知识运用能力的测验所占比例：    % \n 参考资料、课外阅读内容所占比例：  %";
                dr["expectTime"] = "预计中等学生完成答卷所需时间（分钟）：";
                dr["expectScore"] = "预计考绩分布：优  %;良  %;中等  %;及格  %;不及格  %";
                dr["examPercent"] = "本次考核占学期总成绩的比例：    %";
                dt.Rows.Add(dr);
            }
            scb = new SqlCommandBuilder(sda);
            sda.Update(dt);
            dt.AcceptChanges();


            


            //Detail初始化
            selectCMD = new SqlCommand("select * from Detail", conn);
            insertCMD = new SqlCommand("insert into Detail(courseID,PaperID) values(@courseID,@PaperID)", conn);
            dt = new SysData.DataTable();
            sda = new SqlDataAdapter(selectCMD);
            sda.Fill(dt);
            dtCourse = pa.GetAllPaperIDCourseID();
            for (int i = 0; i < dtCourse.Rows.Count; i++)
            {
                SysData.DataRow dr = dt.NewRow();
                dr["courseID"] = dtCourse.Rows[i]["courseID"].ToString();
                dr["PaperID"] = dtCourse.Rows[i]["ID"].ToString();
                dt.Rows.Add(dr);
                dr = dt.NewRow();
            }
            scb = new SqlCommandBuilder(sda);
            sda.Update(dt);
            dt.AcceptChanges();


            //打散数据，插入CourseTeacher            
            selectCMD = new SqlCommand("select * from CourseTeacher", conn);
            insertCMD = new SqlCommand("insert into CourseTeacher(course_no,course_teacherno) values(@course_no,@course_teacherno)", conn);
            SqlParameter course_no;
            course_no = new SqlParameter("@course_no", "course_no");
            course_no.SourceVersion = SysData.DataRowVersion.Current;
            insertCMD.Parameters.AddRange(new SqlParameter[] { course_no });
            dt = new SysData.DataTable();
            sda = new SqlDataAdapter(selectCMD);
            sda.Fill(dt);

            SysData.DataTable dtCourseTeacher = co.GetAllCourseTeacher();
            for (int i = 0; i < dtCourseTeacher.Rows.Count; i++)
            {
                string classStr = dtCourseTeacher.Rows[i]["course_teacherno1"].ToString();
                String[] temp = classStr.Split(new Char[2] { ';', ',' });
                temp = temp.Distinct<string>().ToArray();
                string classStr1 = dtCourseTeacher.Rows[i]["course_teacher"].ToString();
                String[] temp1 = classStr1.Split(new Char[2] { ';', ',' });
                temp1 = temp1.Distinct<string>().ToArray();
                for (int j = 0; j < temp.Length; j++)
                {
                    if (temp[j] != "")
                    {
                        SysData.DataRow dr = dt.NewRow();
                        dr["course_no"] = dtCourseTeacher.Rows[i]["course_no"].ToString();
                        dr["course_teacherno"] = temp[j].Trim();
                        dr["course_teachername"] = temp1[j].Trim();
                        dt.Rows.Add(dr);
                    }
                }
            }
            scb = new SqlCommandBuilder(sda);
            sda.Update(dt);
            dt.AcceptChanges();


            //打散数据，插入CourseSeriesTeacher            
            selectCMD = new SqlCommand("select * from CourseSeriesTeacher", conn);
            insertCMD = new SqlCommand("insert into CourseSeriesTeacher(course_no,course_seriesno,course_teacherno,course_teachername) values(@course_no,@course_seriesno,@course_teacherno,@course_teachername)", conn);
            SqlParameter course_seriesno;
            course_seriesno = new SqlParameter("@course_seriesno", "course_seriesno");
            course_seriesno.SourceVersion = SysData.DataRowVersion.Current;
            insertCMD.Parameters.AddRange(new SqlParameter[] { course_seriesno });
            dt = new SysData.DataTable();
            sda = new SqlDataAdapter(selectCMD);
            sda.Fill(dt);

            SysData.DataTable dtExCourseTeacher = co.GetAllExCourseTeacher();
            for (int i = 0; i < dtExCourseTeacher.Rows.Count; i++)
            {
                string classStr = dtExCourseTeacher.Rows[i]["teacherAccount"].ToString();
                String[] temp = classStr.Split(new Char[2] { ';', ',' });
                temp = temp.Distinct<string>().ToArray();
                string classStr1 = dtExCourseTeacher.Rows[i]["teacherName"].ToString();
                String[] temp1 = classStr1.Split(new Char[2] { ';', ',' });
                temp1 = temp1.Distinct<string>().ToArray();
                for (int j = 0; j < temp.Length; j++)
                {
                    if (temp[j] != "")
                    {
                        if (temp.Length == temp1.Length)
                        {
                            SysData.DataRow dr = dt.NewRow();
                            dr["course_no"] = dtExCourseTeacher.Rows[i]["course_no"].ToString();
                            dr["course_seriesno"] = dtExCourseTeacher.Rows[i]["course_serialno"].ToString();
                            dr["course_teacherno"] = temp[j].Trim();
                            dr["course_teachername"] = temp1[j].Trim();
                            dt.Rows.Add(dr);
                        }
                        else
                        {
                            MsgBox.ShowErrorMessage(dtExCourseTeacher.Rows[i]["course_no"].ToString());
                        }

                    }
                }
            }
            scb = new SqlCommandBuilder(sda);
            sda.Update(dt);
            dt.AcceptChanges();


           


            //打散数据，插入CourseClass            
            selectCMD = new SqlCommand("select * from CourseClass", conn);
            insertCMD = new SqlCommand("insert into CourseClass(course_no,course_class) values(@course_no,@course_class)", conn);
            //SqlParameter course;
            course_no = new SqlParameter("@course_no", "course_no");
            course_no.SourceVersion = SysData.DataRowVersion.Current;
            insertCMD.Parameters.AddRange(new SqlParameter[] { course_no });
            dt = new SysData.DataTable();
            sda = new SqlDataAdapter(selectCMD);
            sda.Fill(dt);

            SysData.DataTable dtCourseClass = co.GetAllClass();

            for (int i = 0; i < dtCourseClass.Rows.Count; i++)
            {
                string classStr = dtCourseClass.Rows[i]["course_class"].ToString();
                String[] temp = classStr.Split(new Char[2] { ';', ',' });
                temp = temp.Distinct<string>().ToArray();
                for (int j = 0; j < temp.Length; j++)
                {   
                    if (temp[j] != "")
                    {
                        SysData.DataRow dr = dt.NewRow();
                        dr["course_no"] = dtCourseClass.Rows[i]["course_no"].ToString();
                        dr["course_class"] = temp[j].Trim();
                        dt.Rows.Add(dr);
                    }
                }

            }
            scb = new SqlCommandBuilder(sda);
            sda.Update(dt);
            dt.AcceptChanges();


             //打散数据，插入CourseSeriesClassTeacher            
            selectCMD = new SqlCommand("select * from CourseSeriesClass", conn);
            insertCMD = new SqlCommand("insert into CourseSeriesClass(course_no,course_seriesno,course_class) values(@course_no,@course_seriesno,@course_class)", conn);
            //SqlParameter course;
            course_seriesno = new SqlParameter("@course_seriesno", "course_seriesno");
            course_seriesno.SourceVersion = SysData.DataRowVersion.Current;
            insertCMD.Parameters.AddRange(new SqlParameter[] { course_seriesno });
            dt = new SysData.DataTable();
            sda = new SqlDataAdapter(selectCMD);
            sda.Fill(dt);

            SysData.DataTable dtCourseSeriesClass = co.GetAllSeriesClass();
            for (int i = 0; i < dtCourseSeriesClass.Rows.Count; i++)
            {
                string classStr = dtCourseSeriesClass.Rows[i]["class_class"].ToString();
                String[] temp = classStr.Split(new Char[2] { ';', ',' });
                temp = temp.Distinct<string>().ToArray();
                for (int j = 0; j < temp.Length; j++)
                {
                    if (temp[j] != "")
                    {
                        
                       
                            SysData.DataRow dr = dt.NewRow();
                            dr["course_no"] = dtCourseSeriesClass.Rows[i]["course_no"].ToString();
                            dr["course_seriesno"] = dtCourseSeriesClass.Rows[i]["course_serialno"].ToString();
                            dr["course_class"] = temp[j].Trim();
                            dt.Rows.Add(dr);
                    }
                        else
                        {
                            MsgBox.ShowErrorMessage(dtCourseSeriesClass.Rows[i]["course_no"].ToString());
                        }

                    }
               
            }
            scb = new SqlCommandBuilder(sda);
            sda.Update(dt);
            dt.AcceptChanges();


            //初始化Signature
            selectCMD = new SqlCommand("select * from Signature", conn);
            insertCMD = new SqlCommand("insert into Signature(College,Profession) values(@College,@Profession)", conn);
            SqlParameter College, Profession;
            College = new SqlParameter("@College", "College");
            Profession = new SqlParameter("@Profession", "Profession");
            College.SourceVersion = SysData.DataRowVersion.Current;
            Profession.SourceVersion = SysData.DataRowVersion.Current;
            insertCMD.Parameters.AddRange(new SqlParameter[] { College, Profession });
            dt = new SysData.DataTable();
            sda = new SqlDataAdapter(selectCMD);
            sda.Fill(dt);

            SysData.DataTable dtSignature = si.GetDataByCollege();
            for (int i = 0; i < dtSignature.Rows.Count; i++)
            {
                SysData.DataRow dr = dt.NewRow();
                dr["College"] = dtSignature.Rows[i]["college"].ToString();
                dr["Profession"] = dtSignature.Rows[i]["profession"].ToString();
                dt.Rows.Add(dr);
            }
            scb = new SqlCommandBuilder(sda);
            sda.Update(dt);
            dt.AcceptChanges();
            
            //Analysis初始化
            selectCMD = new SqlCommand("select * from Analysis", conn);
            insertCMD = new SqlCommand("insert into Analysis(ExaminationCourseID,state) values(@ExaminationCourseID,@state)", conn);
            SqlParameter ExaminationCourseID;
            ExaminationCourseID = new SqlParameter("@ExaminationCourseID", "ExaminationCourseID");
            ExaminationCourseID.SourceVersion = SysData.DataRowVersion.Current;
            insertCMD.Parameters.AddRange(new SqlParameter[] { ExaminationCourseID });
            dt = new SysData.DataTable();
            sda = new SqlDataAdapter(selectCMD);
            sda.Fill(dt);
            dtCourse = co.GetAllExamID();
            for (int i = 0; i < dtCourse.Rows.Count; i++)
            {
                SysData.DataRow dr = dt.NewRow();
                dr["ExaminationCourseID"] = dtCourse.Rows[i]["ID"].ToString();
                dr["state"] = "11";
                dt.Rows.Add(dr);
                dr = dt.NewRow();
            }
            scb = new SqlCommandBuilder(sda);
            //执行更新
            //dt.PrimaryKey = new DataColumn[] { dt.Columns["ID"] };
            sda.Update(dt);
            dt.AcceptChanges();

            conn.Close();
            MsgBox.ShowMessage("任务分配成功！");
        }
        catch (Exception ex)
        {
            MsgBox.ShowErrorMessage("请先进行导入课程表进行课程数据初始化！");
            return;
        }
    }
}