using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// State 的摘要说明
/// </summary>
public class State
{
	public State()
	{
		//
		// TODO: 在此处添加构造函数逻辑
		//
	}
    public int GetPostStateID(string state,string action)
    {
        //DSRegistrationTableAdapters.RegistrationTableAdapter helper = new DSRegistrationTableAdapters.RegistrationTableAdapter();
        DSStateTableAdapters.StateTableAdapter helper = new DSStateTableAdapters.StateTableAdapter();
        return Convert.ToInt32(helper.GetPostState(state, action).ToString());

    }
    public string GetPostStateName(int stateID)
    {
        DSStateTableAdapters.StateTableAdapter helper = new DSStateTableAdapters.StateTableAdapter();
        return helper.GetStateNameByStateID(stateID);

    }

    public string UpdateStateByStateID(int stateID)
    {
        DSStateTableAdapters.StateTableAdapter helper = new DSStateTableAdapters.StateTableAdapter();
        return helper.UpdateStateByStateID(stateID);

    }
}