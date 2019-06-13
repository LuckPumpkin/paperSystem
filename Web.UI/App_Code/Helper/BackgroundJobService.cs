using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Threading;
using System.Data;
using System.IO;
using Print2Flash3;

namespace Services
{
  public class BackgroundJobService
  {
    static Thread backgroundJob = null;
    static bool stop = true;
    static Object thisLock = new Object();
    static Print2Flash3.Server2 p2fServer;
    static List<string> supportedExts;
    static Print2Flash3.INTERFACE_OPTION interfaceOption;

    public static void StartBackgroundJob()
    {
      if (backgroundJob != null)
        backgroundJob.Abort();

      backgroundJob = new Thread(DoJobs);
      backgroundJob.IsBackground = true;
      backgroundJob.Priority = ThreadPriority.BelowNormal;
      p2fServer = new Print2Flash3.Server2();

      //-- 设置可以转换的文件扩展名
      string[] exts = {".doc", ".docx", ".xls", ".xlsx", ".rtf", ".pdf", ".jpg", ".jpeg", ".tif", ".tiff", ".bmp", ".gif", ".png", ".txt"};
      supportedExts = new List<string>();
      for (int i = 0; i < exts.Length; i++)
        supportedExts.Add(exts[i]);

      //-- 设置生成参数
      interfaceOption = (Print2Flash3.INTERFACE_OPTION)p2fServer.DefaultProfile.InterfaceOptions;
      p2fServer.DefaultProfile.InterfaceOptions = (int)(interfaceOption &
        ~Print2Flash3.INTERFACE_OPTION.INTLOGO & //去掉logo图片
        ~Print2Flash3.INTERFACE_OPTION.INTHELP & //去掉帮助
        ~Print2Flash3.INTERFACE_OPTION.INTROTATE & //去掉旋转文档
        ~Print2Flash3.INTERFACE_OPTION.INTFULLSCREEN //去掉全屏显示按钮
        );

      lock (thisLock)
        stop = false;

      backgroundJob.Start();
    }

    public static void StopBackgroundJobs()
    {
      lock (thisLock)
        stop = true;
    }

    public static bool BackgroundJobIsRuning
    {
      get
      {
        lock (thisLock)
          return !stop;
      }
    }

    public static void DoJobs()
    {
      //AutoGenDocListService svc = new AutoGenDocListService();

      //while (true)
      //{
      //  lock (thisLock)
      //    if (stop)
      //      break;

      //  IEnumerable<AutoGenDocList> docs = svc.GetTopTen();

      //  //--  如果当前没有待生成的文档，休息10秒钟时间。
      //  if (docs.Count() == 0)
      //  {
      //    Thread.Sleep(10000);
      //    continue;
      //  }

      //  //-- 有待生成的文档。
      //  foreach (AutoGenDocList doc in docs)
      //  {
      //    lock (thisLock)
      //      if (stop)
      //        break;

      //    try
      //    {
      //      PrintDoc2Flash(doc.DocToConvert);
      //    }
      //    catch (Exception ex)
      //    {
      //      string errorMsg = string.Format("Print2Flash发生错误，错误消息：{0}，文件：{1}",
      //         ex.Message, doc.DocToConvert);
      //      ErrorLog errLog = new ErrorLog();
      //      errLog.ErrorType = "自动文档生成";
      //      errLog.ErrorMessage = errorMsg;
      //      errLog.LogTime = DateTime.Now;

      //      ErrorLogService errorLogSvc = new ErrorLogService();
      //      errorLogSvc.Add(errLog);
      //    }
      //    finally
      //    {
      //      svc.Delete(doc);
      //    }

      //    Thread.Sleep(100);
      //  }
      //}
    }

    private static void PrintDoc2Flash(string FileToConvert)
    {
      if (!File.Exists(FileToConvert))
        return;

      //-- 检查文件扩展名
      string filePath = Path.GetDirectoryName(FileToConvert);      
      string fileName = Path.GetFileNameWithoutExtension(FileToConvert);
      string ext = Path.GetExtension(FileToConvert);

      if (!supportedExts.Contains(ext.ToLower()))
        return;

      //-- 开始转换
      String fileToConvert = FileToConvert;
      String convertedFileName = Path.Combine(filePath, fileName + ".swf");

      p2fServer.ConvertFile(fileToConvert, convertedFileName, null, null, null);
    }
  }
}