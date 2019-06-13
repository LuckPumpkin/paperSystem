using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SysData = System.Data;

/// <summary>
/// Detail 的摘要说明
/// </summary>
public class Detail
{
	public Detail()
	{
		//
		// TODO: 在此处添加构造函数逻辑
		//
	}
    public SysData.DataTable GetDetailByCID(int courseID)
    {
        DSDetailxsdTableAdapters.DetailTableAdapter helper = new DSDetailxsdTableAdapters.DetailTableAdapter();
        return helper.GetDetailByCID(courseID);
    }
    public int getDetailID(int regID)
    {
        DSDetailxsdTableAdapters.DetailTableAdapter helper = new DSDetailxsdTableAdapters.DetailTableAdapter();
        return Convert.ToInt32(helper.GetDetailID(regID).ToString());
    }
    public void DeleteAllModule()
    {
        DSDetailxsdTableAdapters.DetailTableAdapter helper = new DSDetailxsdTableAdapters.DetailTableAdapter();
        helper.DeleteAllModule();
    }
    public void DeleteModuleByDetailID(int detID)
    {
        DSDetailxsdTableAdapters.DetailTableAdapter helper = new DSDetailxsdTableAdapters.DetailTableAdapter();
        helper.DeleteModuleByDetailID(detID);
    }
    public void DeleteQbyDetailID(int detID)
    {
        DSDetailxsdTableAdapters.DetailTableAdapter helper = new DSDetailxsdTableAdapters.DetailTableAdapter();
        helper.DeleteQbyDetailID(detID);
    }
    public void DeleteAllQuestiontype()
    {
        DSDetailxsdTableAdapters.DetailTableAdapter helper = new DSDetailxsdTableAdapters.DetailTableAdapter();
        helper.DeleteAllQuestiontype();
    }
    public int GetModuleNumByDetID(int detID)
    {
        DSDetailxsdTableAdapters.DetailTableAdapter helper = new DSDetailxsdTableAdapters.DetailTableAdapter();
        return Convert.ToInt32(helper.GetModuleNumByDetID(detID));
    }
    public int GetQNumByDetID(int detID)
    {
        DSDetailxsdTableAdapters.DetailTableAdapter helper = new DSDetailxsdTableAdapters.DetailTableAdapter();
        return Convert.ToInt32(helper.GetQNumByDetID(detID));
    }

    public int GetDetailID(int regID)
    {
        DetailDSTableAdapters.DetailTableAdapter helper = new DetailDSTableAdapters.DetailTableAdapter();
        return Convert.ToInt32(helper.FillBy(regID).ToString());
    }
     public void DeleteAllDetail()
     {
         DSDetailxsdTableAdapters.DetailTableAdapter helper = new DSDetailxsdTableAdapters.DetailTableAdapter();
         helper.DeleteAllDetail();
     }
     public void InsertDetail(int courseID,int PaperID)
     {
         DSDetailxsdTableAdapters.DetailTableAdapter helper = new DSDetailxsdTableAdapters.DetailTableAdapter();
         helper.InsertDetail(courseID,PaperID);
     }
     public void DeleteDetailByCourseID(int courseID)
     {
         DSDetailxsdTableAdapters.DetailTableAdapter helper = new DSDetailxsdTableAdapters.DetailTableAdapter();
         helper.DeleteDetailByCourseID(courseID);
     }
}