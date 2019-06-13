using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

/// <summary>
/// Branch 的摘要说明
/// </summary>
public class Branch
{
	public Branch()
	{
		//
		// TODO: 在此处添加构造函数逻辑
		//
	}
    public DataTable GetRootBranch()
    {
        DSBranchTableAdapters.BranchTableAdapter helper = new DSBranchTableAdapters.BranchTableAdapter();
        return helper.GetRootBranch();
    }
   
    public DataTable GetChildBranches(int ParentId)
    {
        DSBranchTableAdapters.BranchTableAdapter helper = new DSBranchTableAdapters.BranchTableAdapter();
        return helper.GetChildBranches(ParentId);
    }
    public DataTable GetBranchByBranchId(int branchId)
    {
        DSBranchTableAdapters.BranchTableAdapter helper = new DSBranchTableAdapters.BranchTableAdapter();
        return helper.GetBranchByBranchId(branchId);
    }
    public int GetParentIdByBranchId(int branchId)
    {
        DSBranchTableAdapters.BranchTableAdapter helper = new DSBranchTableAdapters.BranchTableAdapter();
        return Convert.ToInt32(helper.GetParentIdByBranchId(branchId).ToString());
    }
    public int GetBranchIdByBranchName(string branchName)
    {
        DSBranchTableAdapters.BranchTableAdapter helper = new DSBranchTableAdapters.BranchTableAdapter();
        return Convert.ToInt32(helper.GetBranchIdByBranchName(branchName).ToString());
    }
    
    public void DeleteByBranchId(int branchID)
    {
        DSBranchTableAdapters.BranchTableAdapter helper = new DSBranchTableAdapters.BranchTableAdapter();
        helper.DeleteByBranchId(branchID);
    }
    public void InsertNewBranch(int BranchID, int PrarentBranchID, string branchName)
    {
        DSBranchTableAdapters.BranchTableAdapter helper = new DSBranchTableAdapters.BranchTableAdapter();
        helper.InsertNewBranch(BranchID,PrarentBranchID,branchName);
    }
    public void UpdateBranchName(int branchId, string newBranchName)
    {
        DSBranchTableAdapters.BranchTableAdapter helper = new DSBranchTableAdapters.BranchTableAdapter();
        helper.UpdateBranchName(newBranchName,branchId);
    }

    public DataTable GetBranchData()
    {
        DSBranchTableAdapters.BranchTableAdapter helper = new DSBranchTableAdapters.BranchTableAdapter();
        return helper.GetBranchData();
    }
}