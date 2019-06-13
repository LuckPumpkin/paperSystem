using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Parameter 的摘要说明
/// </summary>
public class Parameter
{
	public Parameter()
	{
		//
		// TODO: 在此处添加构造函数逻辑
		//
	}
    public void UpdateParaValue(float paraValue,int ID)
    {
        DSParameterTableAdapters.ParameterTableAdapter helper = new DSParameterTableAdapters.ParameterTableAdapter();
        helper.UpdateParaValue(paraValue, ID);
    }
}