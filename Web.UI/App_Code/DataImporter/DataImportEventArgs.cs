using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

public class DataImportEventArgs : EventArgs
{
  public Dictionary<string, object> fieldValues;
}

public class SqlGenerateEventArgs : EventArgs
{
  public List<string> fields;
}

public class DataImportProgressEventArgs : EventArgs
{
  public DataImportProgressEventType EventType; 
  public int Progress;
  public string Message;
}

public enum DataImportProgressEventType
{
  Begin,
  SetProgress,
  Complete,
  Info,
  Error
}

public delegate void OnDataImport(object sender, DataImportEventArgs e);
public delegate void OnSqlGenerate(object sender, SqlGenerateEventArgs e);
public delegate void OnDataImportProgress(object sender, DataImportProgressEventArgs e);