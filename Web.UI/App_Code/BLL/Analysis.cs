using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Analysis 的摘要说明
/// </summary>
public class Analysis
{
	public Analysis()
	{
		//
		// TODO: 在此处添加构造函数逻辑
		//
	}
    public int Select1(string college)
    {
        DSAnalysisTableAdapters.AnalysisTableAdapter helper = new DSAnalysisTableAdapters.AnalysisTableAdapter();
        return Convert.ToInt32(helper.Select1(college));
    }
    public int ScalarQuery1(string college)
    {
        DSAnalysisTableAdapters.AnalysisTableAdapter helper = new DSAnalysisTableAdapters.AnalysisTableAdapter();
        return Convert.ToInt32(helper.ScalarQuery1(college));
    }
    public int GetAnaNum(string account)
    {
        DSAnalysisTableAdapters.AnalysisTableAdapter helper = new DSAnalysisTableAdapters.AnalysisTableAdapter();
        return Convert.ToInt32(helper.GetAnaNum(account));
    }
    public int GetAnaNumAd(string pro)
    {
        DSAnalysisTableAdapters.AnalysisTableAdapter helper = new DSAnalysisTableAdapters.AnalysisTableAdapter();
        return Convert.ToInt32(helper.GetAnaNumAd(pro));
    }

    public void UpdateScore(float aveScore, int ana_num, int num_less60, int num_60_70, int num_70_80, int num_80_90, int num_more90, float maxScor, float minScore, int ID)
    {
        DSAnalysisTableAdapters.AnalysisTableAdapter helper = new DSAnalysisTableAdapters.AnalysisTableAdapter();
        helper.UpdateScore(aveScore,ana_num, num_less60, num_60_70, num_70_80, num_80_90, num_more90, maxScor, minScore,ID);
    }
    public void UpdateState(int state, int ID)
    {
        DSAnalysisTableAdapters.AnalysisTableAdapter helper = new DSAnalysisTableAdapters.AnalysisTableAdapter();
        helper.UpdateState(state, ID);
    }
    public void UpdateProAnalysis(int ID, string audit)
    {
        DSRegistrationTableAdapters.RegistrationTableAdapter helper = new DSRegistrationTableAdapters.RegistrationTableAdapter();
        helper.UpdateProfessionAudit(audit, ID);
    }
    public void DeleteAllAnalysis()
    {
        DSAnalysisTableAdapters.AnalysisTableAdapter helper = new DSAnalysisTableAdapters.AnalysisTableAdapter();
        helper.DeleteAllAnalysis();
    }
    public void InsertAnalysis(int ExamID)
    {
        DSAnalysisTableAdapters.AnalysisTableAdapter helper = new DSAnalysisTableAdapters.AnalysisTableAdapter();
        helper.InsertAnalysis(ExamID);
    }
    public void DeleteAnalysisByExamCourseID(int ExamID)
    {
        DSAnalysisTableAdapters.AnalysisTableAdapter helper = new DSAnalysisTableAdapters.AnalysisTableAdapter();
        helper.DeleteAnalysisByExamCourseID(ExamID);
    }
}