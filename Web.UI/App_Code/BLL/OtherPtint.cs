using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// OtherPtint 的摘要说明
/// </summary>
public class OtherPtint
{
	public OtherPtint()
	{
		//
		// TODO: 在此处添加构造函数逻辑
		//
	}
    public void InsertQuery(string Name, string College, int pageNum, int printNum, string paper, string printColor, string paperSize, string SingleOrDouble, string bindMethod, string cover)
    {
        OtherPrintTableAdapters.OtherPtintTableAdapter helper = new OtherPrintTableAdapters.OtherPtintTableAdapter();
        helper.InsertQuery(Name, College, pageNum, printNum, paper, printColor, paperSize, SingleOrDouble, bindMethod, cover);
    }
    public void UpdateQuery(string Name, string College, int pageNum, int printNum, string paper, string printColor, string paperSize, string SingleOrDouble, string bindMethod, string cover,int ID)
    {
        OtherPrintTableAdapters.OtherPtintTableAdapter helper = new OtherPrintTableAdapters.OtherPtintTableAdapter();
        helper.UpdateQuery(Name, College, pageNum, printNum, paper, printColor, paperSize, SingleOrDouble, bindMethod, cover,ID);
    }
    public void UpdateStateByID(int ID)
    {
        OtherPrintTableAdapters.OtherPtintTableAdapter helper = new OtherPrintTableAdapters.OtherPtintTableAdapter();
        helper.UpdateStateByID(ID);
    }
    public void UpdateQuery1(string name,int ID)
    {
        OtherPrintTableAdapters.OtherPtintTableAdapter helper = new OtherPrintTableAdapters.OtherPtintTableAdapter();
        helper.UpdateQuery1(name,ID);
    }
    public void UpdateState1(int ID)
    {
        OtherPrintTableAdapters.OtherPtintTableAdapter helper = new OtherPrintTableAdapters.OtherPtintTableAdapter();
        helper.UpdateState1(ID);
    }
    public void UpdateState2(int ID)
    {
        OtherPrintTableAdapters.OtherPtintTableAdapter helper = new OtherPrintTableAdapters.OtherPtintTableAdapter();
        helper.UpdateState2(ID);
    }
    public string getStateByID(int ID)
    {
        OtherPrintTableAdapters.OtherPtintTableAdapter helper = new OtherPrintTableAdapters.OtherPtintTableAdapter();
        return helper.getStateByID(ID);
    }
    public void UpdateTotal(decimal pr, decimal dr, int id)
    {
        OtherPrintTableAdapters.OtherPtintTableAdapter helper = new OtherPrintTableAdapters.OtherPtintTableAdapter();
        helper.UpdateTotal(pr,dr,id);
    }
    public string getSingleOrDo(int ID)
    {
        OtherPrintTableAdapters.OtherPtintTableAdapter helper = new OtherPrintTableAdapters.OtherPtintTableAdapter();
        return helper.getSingleOrDo(ID);
    }
    public string getBingprint(int ID)
    {
        OtherPrintTableAdapters.OtherPtintTableAdapter helper = new OtherPrintTableAdapters.OtherPtintTableAdapter();
        return helper.getBingprint(ID);
    }
    
}