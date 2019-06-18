using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using SysData = System.Data;

/// <summary>
/// Summary description for Signature
/// </summary>
public class Signature
{
	public Signature()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    public SysData.DataTable GetDataByCollege()
    {
        DSSignatureTableAdapters.SignatureTableAdapter helper = new DSSignatureTableAdapters.SignatureTableAdapter();
        return helper.GetDataByCollege();
    }
    public void DeleteALLSignature()
    {
        DSSignatureTableAdapters.SignatureTableAdapter helper = new DSSignatureTableAdapters.SignatureTableAdapter();
        helper.DeleteALLSignature();
    }

    public void UpdateColBYCo(string college, string collegesign)
    {
        DSSignatureTableAdapters.SignatureTableAdapter helper = new DSSignatureTableAdapters.SignatureTableAdapter();
        helper.UpdateColBYCo(college, collegesign);
    }
    public void UpdateProsBYColl(string prosign,string college,string pro)
    {
        DSSignatureTableAdapters.SignatureTableAdapter helper = new DSSignatureTableAdapters.SignatureTableAdapter();
        helper.UpdateProsBYColl(prosign,college,pro);
    }
    public SysData.DataTable GetByCourseno(string course_no)
    {
        DSSignatureTableAdapters.SignatureTableAdapter helper = new DSSignatureTableAdapters.SignatureTableAdapter();
        return helper.GetByCourseno(course_no);
    }
}