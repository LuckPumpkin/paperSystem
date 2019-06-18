using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using SysData = System.Data;
using System.Configuration;

/// <summary>
/// Paper 的摘要说明
/// </summary>
public class Paper
{
	public Paper()
	{
		//
		// TODO: 在此处添加构造函数逻辑
		//
	}


    public int GetPaperCopyNum(int paperID)
    {
        DSPaperTableAdapters.PaperTableAdapter helper = new DSPaperTableAdapters.PaperTableAdapter();
        return Convert.ToInt32(helper.GetPaperCopyNum(paperID));
    }
    public void UpdateResitState1(int paperID)
    {
        DSPaperTableAdapters.PaperTableAdapter helper = new DSPaperTableAdapters.PaperTableAdapter();
        helper.UpdateResitState1(paperID);
    }
    public void UpdateReadedByID(int ID)
    {
        DSPaperTableAdapters.PaperTableAdapter helper = new DSPaperTableAdapters.PaperTableAdapter();
        helper.UpdateReadedByID(ID);
    }
    public void UpdateFlag(int ID,string AorB)
    {
        DSPaperTableAdapters.PaperTableAdapter helper = new DSPaperTableAdapters.PaperTableAdapter();
        helper.UpdateFlag(ID, AorB);
    }
    public void UpdateFlagNull(int ID, string AorB)
    {
        DSPaperTableAdapters.PaperTableAdapter helper = new DSPaperTableAdapters.PaperTableAdapter();
        helper.UpdateFlagNull(ID,AorB);
    }
    public int GetPaperNum()
    {
        DSPaperTableAdapters.PaperTableAdapter helper = new DSPaperTableAdapters.PaperTableAdapter();
        return Convert.ToInt32(helper.GetPaperNum().ToString());
    }
    public int GetResNum(string account)
    {
        DSPaperTableAdapters.PaperTableAdapter helper = new DSPaperTableAdapters.PaperTableAdapter();
        return Convert.ToInt32(helper.GetResNum(account).ToString());
    }
    public int GetPaperIDByCourseAndPaper(string courseNo,string paper)
    {
        DSPaperTableAdapters.PaperTableAdapter helper = new DSPaperTableAdapters.PaperTableAdapter();
        return Convert.ToInt32(helper.GetPaperIDByCourseAndPaper(paper, courseNo).ToString());
    }
    public int GetBothReadedByCourseID(int courseID,string AorB)
    {
        DSPaperTableAdapters.PaperTableAdapter helper = new DSPaperTableAdapters.PaperTableAdapter();
        return Convert.ToInt32(helper.GetBothReadedByCourseID(courseID, AorB).ToString());
    }
    public int GetPaperIDByRegistration(int RegID)
    {
        DSPaperTableAdapters.PaperTableAdapter helper = new DSPaperTableAdapters.PaperTableAdapter();
        return Convert.ToInt32(helper.GetPaperIDByRegistration(RegID).ToString());
    }
    public int GetReadedByRegID(int RegID)
    {
        DSPaperTableAdapters.PaperTableAdapter helper = new DSPaperTableAdapters.PaperTableAdapter();
        return Convert.ToInt32(helper.GetReadedByRegID(RegID).ToString());
    }
    public void InitialReadedByRegID(int RegID)
    {
        DSPaperTableAdapters.PaperTableAdapter helper = new DSPaperTableAdapters.PaperTableAdapter();
        helper.InitialReadedByRegID(RegID);
    }
    public void DeleteAllPaper()
    {
        DSPaperTableAdapters.PaperTableAdapter helper = new DSPaperTableAdapters.PaperTableAdapter();
        helper.DeleteAllPaper();
    }

    public SysData.DataTable GetAllPaperIDCourseID()
    {
        DSPaperTableAdapters.PaperTableAdapter helper = new DSPaperTableAdapters.PaperTableAdapter();
        return helper.GetAllPaperIDCourseID();
    }
    public SysData.DataTable GetPaperIDByCourseID(int courseID)
    {
        DSPaperTableAdapters.PaperTableAdapter helper = new DSPaperTableAdapters.PaperTableAdapter();
        return helper.GetPaperIDByCourseID(courseID);
    }
    public SysData.DataTable GetPaperIDByCourseNO(string course_no)
    {
        DSPaperTableAdapters.PaperTableAdapter helper = new DSPaperTableAdapters.PaperTableAdapter();
        return helper.GetPaperIDByCourseNo(course_no);
    }

    public void UpdatePaperStandardByPapaerID(string standard, int paperID)
    {
        DSPaperTableAdapters.PaperTableAdapter helper = new DSPaperTableAdapters.PaperTableAdapter();
        helper.UpdatePaperStandardByPapaerID(standard, paperID);
    }
    //试卷送印 状态为试卷待送印 printed=0
    public void UpdatePrintState0(int paperID)
    {
        DSPaperTableAdapters.PaperTableAdapter helper = new DSPaperTableAdapters.PaperTableAdapter();
        helper.UpdatePrintState0(paperID);
    }
    //更新试卷印刷审核状态
    public void UpdatePaperState(int regID)
    {
        DSPaperTableAdapters.PaperTableAdapter helper = new DSPaperTableAdapters.PaperTableAdapter();
        helper.UpdatePaperState(regID);
    }
    //撤销送印
    public void UpdatePaperState1(int paperID)
    {
        DSPaperTableAdapters.PaperTableAdapter helper = new DSPaperTableAdapters.PaperTableAdapter();
        helper.UpdatePaperState1(paperID);
    }
    //结账操作
    public void UpdatePaperState2(int paperID)
    {
        DSPaperTableAdapters.PaperTableAdapter helper = new DSPaperTableAdapters.PaperTableAdapter();
        helper.UpdatePaperState2(paperID);
    }

    public string GetPaperStateByPaperID(int paperID)
    {
        DSPaperTableAdapters.PaperTableAdapter helper = new DSPaperTableAdapters.PaperTableAdapter();
        return helper.GetPaperStateByPaperID(paperID);
    }

    public void UpdatePaperStateByPaperID(string PaperState, int paperID)
    {
        DSPaperTableAdapters.PaperTableAdapter helper = new DSPaperTableAdapters.PaperTableAdapter();
        helper.UpdatePaperStateByPaperID(PaperState, paperID);
    }
    public void UpdatePaperSingleOrDoubleByPaperID(string SingleOrDouble, int paperID)
    {
        DSPaperTableAdapters.PaperTableAdapter helper = new DSPaperTableAdapters.PaperTableAdapter();
        helper.UpdateQuerySingleOrDouble(SingleOrDouble, paperID);
    }
    public void InsertPaperA(int courseID)
    {
        DSPaperTableAdapters.PaperTableAdapter helper = new DSPaperTableAdapters.PaperTableAdapter();
        helper.InsertPaperA(courseID);
    }
    public void InsertPaperB(int courseID)
    {
        DSPaperTableAdapters.PaperTableAdapter helper = new DSPaperTableAdapters.PaperTableAdapter();
        helper.InsertPaperB(courseID);
    }
    public void DeletePaperByCourseID(int courseID)
    {
        DSPaperTableAdapters.PaperTableAdapter helper = new DSPaperTableAdapters.PaperTableAdapter();
        helper.DeletePaperByCourseID(courseID);
    }

    public int GetPaperIDByregID(int regID)
    {
        DSPaperTableAdapters.PaperTableAdapter helper = new DSPaperTableAdapters.PaperTableAdapter();
        return Convert.ToInt32(helper.GetPaperIDByregID(regID));
    }

    public void UpdateExitReaded(int regID)
    {
        DSPaperTableAdapters.PaperTableAdapter helper = new DSPaperTableAdapters.PaperTableAdapter();
        helper.UpdateExitReaded(regID);
    }

    public void UpdateEReadedByPID(int paperID)
    {
        DSPaperTableAdapters.PaperTableAdapter helper = new DSPaperTableAdapters.PaperTableAdapter();
        helper.UpdateEReadedByPID(paperID);
    }
    public int GetprintedByPaperID(int paperID)
    {
        DSPaperTableAdapters.PaperTableAdapter helper = new DSPaperTableAdapters.PaperTableAdapter();
        return Convert.ToInt32(helper.GetprintedByPaperID(paperID));
    }

    public void UpdateshenheState(int paperID)
    {
        DSPaperTableAdapters.PaperTableAdapter helper = new DSPaperTableAdapters.PaperTableAdapter();
        helper.UpdateshenheState(paperID);
    }

    public void UpdatepaperstateByCourseID(string paperstate, int courseID)
    {
        DSPaperTableAdapters.PaperTableAdapter helper = new DSPaperTableAdapters.PaperTableAdapter();
        helper.UpdatepaperstateByCourseID(paperstate,courseID);
    }


}