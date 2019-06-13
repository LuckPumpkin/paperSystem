using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Xml.Linq;

using System.Web.Configuration;
using System.Data;
using System.Data.SqlClient;
using AjaxControlToolkit;
using System.Collections.Specialized;

/// <summary>
///CascadingService 的摘要说明
/// </summary>
[WebService(Namespace = "http://www.heuu.edu.cn/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
[System.Web.Script.Services.ScriptService]
public class CascadingService : System.Web.Services.WebService
{

    public CascadingService()
    {
        //如果使用设计的组件，请取消注释以下行 
        //InitializeComponent(); 
    }

    #region Get Cascade Student

    [WebMethod]
    public CascadingDropDownNameValue[] GetTeachingPlan(string knownCategoryValues, string category)
    {
        return GetCascadingDropDownNameValueByCheck(string.Format("select distinct teachingPlan from ExaminationCourse order by teachingPlan"));
    }

    [WebMethod]
    public CascadingDropDownNameValue[] GetCampusOfTeachingPlan(string knownCategoryValues, string category)
    {
        StringDictionary kv = CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues);
        if (!kv.ContainsKey("TeachingPlan"))
            return null;
        string sTeachingPlan = kv["TeachingPlan"];
        string sql = string.Format("SELECT DISTINCT class_campus FROM ExaminationCourse where teachingPlan='{0}'  ORDER BY  class_campus", sTeachingPlan);
        return GetCascadingDropDownNameValueByCheck(sql);
    }

    [WebMethod]
    public CascadingDropDownNameValue[] GetDeptOfCampus(string knownCategoryValues, string category)
    {
        StringDictionary kv = CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues);
        if (!kv.ContainsKey("TeachingPlan") || !kv.ContainsKey("Campus"))
            return null;

        string sTeachingPlan = kv["TeachingPlan"];
        string sCampus = kv["Campus"];


        string sql = string.Format("SELECT DISTINCT course_Dept FROM ExaminationCourse  WHERE (teachingPlan = '{0}') AND (class_campus = '{1}')  ORDER BY course_Dept", sTeachingPlan, sCampus);
        return GetCascadingDropDownNameValueByCheck(sql);
    }
    [WebMethod]
    
    #endregion


    #region Get Cascade CollegeAndProForExamCourse

    public CascadingDropDownNameValue[] GetCollege(string knownCategoryValues, string category)
    {
        return GetCascadingDropDownNameValue(string.Format("SELECT DISTINCT course_dept FROM ExaminationCourse ORDER BY course_dept"));
    }

    [WebMethod]
    public CascadingDropDownNameValue[] GetMajorOfCollege(string knownCategoryValues, string category)
    {
        StringDictionary kv = CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues);
        if (!kv.ContainsKey("College"))
            return null;

        string sCollege = kv["College"];

        string sql = string.Format("SELECT Branch.BranchName FROM Branch INNER JOIN Branch AS Branch_1 ON Branch.ParentBranchID = Branch_1.BranchID WHERE (Branch_1.BranchName LIKE '{0}')", sCollege);
        return GetCascadingDropDownNameValue(sql);
     }
    [WebMethod]

    #endregion


    #region Get Cascade CommonAndPrivate

    public CascadingDropDownNameValue[] GetCommonOrPrivate(string knownCategoryValues, string category)
    {
        string sql = string.Format("SELECT DISTINCT CommonOrPrivate FROM ExaminationCourse order by CommonOrPrivate");

        return GetCascadingDropDownNameValue(sql);
    }

    [WebMethod]
    public CascadingDropDownNameValue[] GetPrivateCollege(string knownCategoryValues, string category)
    {
        StringDictionary kv = CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues);
        if (!kv.ContainsKey("CommonOrPrivate"))
            return null;

        string sCommonOrPrivate = kv["CommonOrPrivate"];

        string sql = string.Format("if '{0}' like 'p' select distinct course_dept from ExaminationCourse", sCommonOrPrivate);
        return GetCascadingDropDownNameValue(sql);
    }
    [WebMethod]

    #endregion


    #region Private Function

    private static CascadingDropDownNameValue[] GetCascadingDropDownNameValue(string sql)
    {
        string connString = WebConfigurationManager.ConnectionStrings["AppConnStr"].ConnectionString;
        SqlConnection conn = new SqlConnection(connString);
        SqlDataAdapter da = new SqlDataAdapter(sql, conn);
        DataTable dt = new DataTable();
        da.Fill(dt);

        CascadingDropDownNameValue[] result = new CascadingDropDownNameValue[dt.Rows.Count];

        for (int i = 0; i < dt.Rows.Count; i++)
            result[i] = new CascadingDropDownNameValue(dt.Rows[i][0].ToString(), dt.Rows[i][0].ToString());

        return result;
    }
    private static CascadingDropDownNameValue[] GetCascadingDropDownNameValueByCheck(string sql)
    {
        string connString = WebConfigurationManager.ConnectionStrings["CheckConnStr"].ConnectionString;
        SqlConnection conn = new SqlConnection(connString);
        SqlDataAdapter da = new SqlDataAdapter(sql, conn);
        DataTable dt = new DataTable();
        da.Fill(dt);

        CascadingDropDownNameValue[] result = new CascadingDropDownNameValue[dt.Rows.Count];

        for (int i = 0; i < dt.Rows.Count; i++)
            result[i] = new CascadingDropDownNameValue(dt.Rows[i][0].ToString(), dt.Rows[i][0].ToString());

        return result;
    }
    private static CascadingDropDownNameValue[] GetCascadingDropDownNameValue(string sql, bool valueEqName)
    {
        string connString = WebConfigurationManager.ConnectionStrings["InnovationTrainingProgramDBConnectionString"].ConnectionString;
        SqlConnection conn = new SqlConnection(connString);
        SqlDataAdapter da = new SqlDataAdapter(sql, conn);
        DataTable dt = new DataTable();
        da.Fill(dt);

        CascadingDropDownNameValue[] result = new CascadingDropDownNameValue[dt.Rows.Count];

        for (int i = 0; i < dt.Rows.Count; i++)
        {
            if (valueEqName)
                result[i] = new CascadingDropDownNameValue(dt.Rows[i][0].ToString(), dt.Rows[i][0].ToString());
            else
                result[i] = new CascadingDropDownNameValue(dt.Rows[i][0].ToString(), dt.Rows[i][1].ToString());
        }

        return result;
    }

    #endregion

}

