using System;
using System.Collections.Generic;
using System.Linq;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.IO;
using System.Transactions;

public partial class DataImporter : System.Web.UI.UserControl
{
#region Private Fields

  private List<string> errorList = new List<string>();
  private List<string> fields = new List<string>();
  private string keyField;
  private List<string> protectedFields = new List<string>();
  private Dictionary<string, object> fieldValues = new Dictionary<string, object>();
  private SqlCommand checkExistCmd;
  private SqlCommand insertCommand;
  private SqlCommand updateCommand;
  private string strLine = "";

  private Dictionary<string, FieldItem> FieldsDictionary = new Dictionary<string, FieldItem>();
  private string TableName;
  private string TableDescription;

  private bool CanInsert = true;
  private string UpdatableDataRange="";

  #endregion 

  public event OnDataImport DataInserting;
  public event OnDataImport DataUpdating;

  public event OnSqlGenerate InsertCommandGenerating;
  public event OnSqlGenerate InsertCommandGenerated;

  public event OnDataImportProgress DataImportProgress;

  protected void Page_Load(object sender, EventArgs e)
  {
    if (Page.IsPostBack)
    {
      TableName = (string)ViewState["__TableName"];
      TableDescription = (string)ViewState["__TableDescription"];
      FieldsDictionary = (Dictionary<string, FieldItem>)ViewState["__FieldsDictionary"];
      CanInsert = (bool)ViewState["__CanInsert"];
      UpdatableDataRange = (string)ViewState["__UpdatableDataRange"];
    }
  }
  protected void btnDown_Click(object sender, EventArgs e)
  {
      string strResult = string.Empty;
      string strPath = Server.MapPath("~/xls/");
      string filename = "teacher.txt";
      string strFile = string.Format(@"{0}\{1}", strPath, filename);
      if (strFile == "")
      {
         MsgBox.ShowErrorMessage("无下载模板，请联系系统管理员添加下载模板!");
      }
      else { 
        using (FileStream fs = new FileStream(strFile, FileMode.Open))
        {
          byte[] bytes = new byte[(int)fs.Length];
          fs.Read(bytes, 0, bytes.Length);
          fs.Close();
          Response.ContentType = "application/octet-stream";
          if (Request.UserAgent.ToLower().IndexOf("msie") > -1)
              filename = Attachment.ToHexString(filename);

          //为了向客户端输出空格，需要在当客户端使用 Firefox 时特殊处理
          if (Request.UserAgent.ToLower().IndexOf("firefox") > -1)
              Response.AddHeader("Content-Disposition", "attachment;filename=\"" + filename + "\"");
          else
              Response.AppendHeader("Content-Disposition", "attachment; filename=" + HttpUtility.UrlEncode(filename, System.Text.Encoding.UTF8));
          Response.BinaryWrite(bytes);
          Response.Flush();
         }
      }
  }
  #region 初始化控件

  public void InitDataImporter(string tableName, string tableDescription, List<FieldItem> initialFields)
  {
    TableName = tableName;
    TableDescription = tableDescription;

    FieldsDictionary.Clear();
    foreach (FieldItem item in initialFields)
      FieldsDictionary.Add(item.Name, item);
    
    List<ListItem> tmpItems = new List<ListItem>();
    foreach (FieldItem item in initialFields)
      if (item.Visible) //-- 只显示可见的字段
        tmpItems.Add(new ListItem(item.Code, item.Name));

    olmFieldSelection.InitMoverList(tmpItems);

    ViewState["__TableName"] = TableName;
    ViewState["__TableDescription"] = TableDescription;
    ViewState["__FieldsDictionary"] = FieldsDictionary;
    ViewState["__CanInsert"] = CanInsert;
    ViewState["__UpdatableDataRange"] = UpdatableDataRange;
  }

  public void InitDataImporter(string tableName, string tableDescription, List<FieldItem> initialFields, bool canInsert, string updatableDataRange)
  {
    InitDataImporter(tableName, tableDescription, initialFields);
    this.CanInsert = canInsert;
    this.UpdatableDataRange = updatableDataRange;
    ViewState["__CanInsert"] = CanInsert;
    ViewState["__UpdatableDataRange"] = UpdatableDataRange;

    if (!CanInsert)
      chkAllowInsert.CssClass = "hide";
  }

  #endregion

  #region Wizard Next Button Click

  protected void ImportWizard_NextButtonClick(object sender, WizardNavigationEventArgs e)
  {
    switch (e.NextStepIndex)
    {
      case 1:
        rblKeyField.Items.Clear();
        foreach (ListItem item in olmFieldSelection.RightItems)
        {
          if (FieldsDictionary[item.Value].CanBeKey)
            rblKeyField.Items.Add(new ListItem(item.Text, item.Value));
        }

        if (rblKeyField.Items.Count > 0)
          rblKeyField.SelectedIndex = 0;

        break;
      case 2:
        cblProtectFields.Items.Clear();

        //-- 找出主键
        foreach (ListItem item in rblKeyField.Items)
          if (item.Selected)
          {
            keyField = item.Value;
            break;
          }

        //-- 如果字段不允许修改，那它必须是保护字段
        foreach (ListItem item in olmFieldSelection.RightItems)
        {
          if (item.Value == keyField)
            continue;

          ListItem newListItem = new ListItem(item.Text, item.Value);
          if (!FieldsDictionary[item.Value].CanUpdate)
          {
            newListItem.Selected = true;
            newListItem.Enabled = false;
          }

          cblProtectFields.Items.Add(newListItem);
        }
        break;
    }
  }

  #endregion

  #region Wizard Finish Button Click

  protected void ImportWizard_FinishButtonClick(object sender, WizardNavigationEventArgs e)
  {
    if (fileUpload.FileName.Length == 0)
    {
      MsgBox.ShowErrorMessage("请先选择需要上传的文本文件！");
      return;
    }

    try
    {
      errorList.Clear();

      PrepareFields();
      PrepareCommand();
      UploadStudentInfo();

      if (errorList.Count == 0)
      {
        ImportWizard.ActiveStepIndex = 0;
        olmFieldSelection.MoveLeftAll();
        MsgBox.ShowMessage(TableDescription + "信息上传成功！");

        if (DataImportProgress != null)
          DataImportProgress(null, new DataImportProgressEventArgs() { EventType = DataImportProgressEventType.Info, Message = TableDescription + "信息上传成功！" });
      }
      else
      {
        StringBuilder sb = new StringBuilder();
        foreach (string s in errorList)
          sb.Append(s);
        txtErrorMsg.Text = sb.ToString();
        ErrorMessagesPopup.ShowOnPageLoad = true;

        if (DataImportProgress != null)
          DataImportProgress(null, new DataImportProgressEventArgs() { EventType = DataImportProgressEventType.Error, Message = txtErrorMsg.Text });
      }
    }
    catch (Exception ex)
    {
      StringBuilder sb = new StringBuilder();
      sb.Append("<p><strong>错误发生，错误信息：</strong></p>");
      sb.Append(string.Format("<p>{0}</p>", ex.Message));
      sb.Append(string.Format("<p>出错行信息：{0}</p>", Server.HtmlEncode(strLine)));

      MsgBox.ShowErrorMessage(sb.ToString());
    }
  }

  #endregion

  #region PrepareCommand

  //----------------------------------------------------------------
  // 动态产生用于插入、更新以及判断是否存在的命令
  //----------------------------------------------------------------
  private void PrepareCommand()
  {
    DataImporterSQLGenerator g = new DataImporterSQLGenerator(FieldsDictionary);

    SqlGenerateEventArgs e = new SqlGenerateEventArgs();
    e.fields = fields;

    checkExistCmd =  g.GenerateCheckExistCommand(TableName, keyField);
    updateCommand = g.GenerateUpdateCommand(TableName, keyField, fields, protectedFields, UpdatableDataRange);

    if (InsertCommandGenerating != null)
      InsertCommandGenerating(null, e);
    insertCommand = g.GenerateInsertCommand(TableName, fields);
    if (InsertCommandGenerated != null)
      InsertCommandGenerated(null, e);
  }

  #endregion

  #region PrepareFields

  //----------------------------------------------------------------
  // 从向导中提取出各种字段
  //----------------------------------------------------------------
  private void PrepareFields()
  {
    //-- 找出所有字段
    foreach (ListItem item in olmFieldSelection.RightItems)
      fields.Add(item.Value);

    //-- 找出主键
    foreach (ListItem item in rblKeyField.Items)
      if (item.Selected)
      {
        keyField = item.Value;
        break;
      }

    //-- 找出保护字段
    foreach (ListItem item in cblProtectFields.Items)
      if (item.Selected)
        protectedFields.Add(item.Value);
  }

  #endregion

  #region FileUpload

  protected void UploadStudentInfo()
  {
    if (!fileUpload.HasFile)
      return;

    Stream stream = fileUpload.FileContent;
    StreamReader reader = new StreamReader(stream, Encoding.GetEncoding("gb2312"));

    if (chkDataHeadIncluded.Checked)
      reader.ReadLine();

    List<string> lines = new List<string>();

    //-- 将文档内容一次读入数组
    strLine = reader.ReadLine();
    while (strLine != null)
    {
      lines.Add(strLine);
      strLine = reader.ReadLine();
    }

    //-- 处理待导入的数据
    if (DataImportProgress != null)
      DataImportProgress(null, new DataImportProgressEventArgs() { EventType = DataImportProgressEventType.Begin, Progress = 0 });

    for (int i = 0; i < lines.Count; i++)
    {
      try
      {
        int percent = Convert.ToInt32(Math.Ceiling((i + 1.0) * 100 / lines.Count));
        if (DataImportProgress != null)
          DataImportProgress(null, new DataImportProgressEventArgs() { EventType = DataImportProgressEventType.SetProgress, Progress = percent });

        ParseLine(lines[i]);

        using (TransactionScope ts = new TransactionScope())
        {
          if (CheckRecordExist())
            RunUpdateCommand();
          else
            if (chkAllowInsert.Checked)
              RunInsertCommand();
          ts.Complete();
        }
      }
      catch (Exception ex)
      {
        StringBuilder sb = new StringBuilder();
        sb.Append(string.Format("<p><strong>第 {0} 行数据解析错误！</strong></p>", i + 1));
        sb.Append(string.Format("<strong>错误信息：</strong>{0}<br />", ex.Message));
        sb.Append(string.Format("<strong>出错行内容：</strong>{0}", Server.HtmlEncode(lines[i])));
        sb.Append("<hr />");

        errorList.Add(sb.ToString());
        if (errorList.Count >= 50)
        {
          errorList.Add("<p>!!!! 错误数达到上限 50，终止数据导入 !!!!</p>");
          return;
        }
      }
    }
    if (DataImportProgress != null)
      DataImportProgress(null, new DataImportProgressEventArgs() { EventType = DataImportProgressEventType.Complete, Progress = 100 });
  }

  private void ParseLine(string strLine)
  {
    string[] tmp = strLine.Split(new char[] { ',' });
    if (tmp.Length != fields.Count)
      throw new Exception(string.Format("“{0}”经切分后与指定字段数不匹配。", strLine));

    fieldValues.Clear();
    for (int i = 0; i < fields.Count; i++)
    {
      if (FieldsDictionary[fields[i]].IsReferenceField)
        fieldValues.Add(fields[i], GetReferenceKey(tmp[i], FieldsDictionary[fields[i]]));
      else
        fieldValues.Add(fields[i], SQLTypeConverter.Parse(tmp[i], FieldsDictionary[fields[i]].Type));
    }
  }

  private object GetReferenceKey(string refValue, FieldItem theField)
  {
    SqlCommand cmd = DataImporterSQLGenerator.GenerateGetRefKeyCommand(theField.refTableName, theField.refKeyName, theField.refFieldName, theField.refFieldType);
    cmd.Parameters[0].Value = SQLTypeConverter.Parse(refValue, theField.refFieldType);

    object result = SQLHelper.RunScalar(cmd);
    if (result == null)
      throw new Exception(string.Format("没有找到“{0}”对应的键值！", refValue));

    return result;
  }

  private bool CheckRecordExist()
  {
    foreach (SqlParameter sp in checkExistCmd.Parameters)
    {
      if (fieldValues[sp.SourceColumn] == null)
      {
        sp.IsNullable = true;
        sp.Value = DBNull.Value;
      }
      else
        sp.Value = fieldValues[sp.SourceColumn];
    }

    int result = (int)SQLHelper.RunScalar(checkExistCmd);

    if (result == 0)
      return false;
    else
      return true;
  }

  private void RunUpdateCommand()
  {
    DataImportEventArgs e = new DataImportEventArgs();
    e.fieldValues = fieldValues;

    if (DataUpdating != null)
      DataUpdating(null, e);

    foreach (SqlParameter sp in updateCommand.Parameters)
    {
      if (fieldValues[sp.SourceColumn] == null)
      {
        sp.IsNullable = true;
        sp.Value = DBNull.Value;
      }
      else
        sp.Value = fieldValues[sp.SourceColumn];
    }

    if (SQLHelper.RunNonQuery(updateCommand) == 0)
      throw new Exception("更新失败!");
  }

  private void RunInsertCommand()
  {
    DataImportEventArgs e = new DataImportEventArgs();
    e.fieldValues = fieldValues;

    if (DataInserting != null)
      DataInserting(null, e);

    foreach (SqlParameter sp in insertCommand.Parameters)
    {
      if (fieldValues[sp.SourceColumn] == null)
      {
        sp.IsNullable = true;
        sp.Value = DBNull.Value;
      }
      else
        sp.Value = fieldValues[sp.SourceColumn];
    }

    if (SQLHelper.RunNonQuery(insertCommand) == 0)
      throw new Exception("插入记录失败！");
  }

  #endregion

}