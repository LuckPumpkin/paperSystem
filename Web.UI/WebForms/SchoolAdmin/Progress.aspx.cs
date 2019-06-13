using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.XtraCharts;
using System.Data.SqlClient;
using System.Configuration;

public partial class WebForms_Admin_Progress : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Course co = new Course();
        DataTable dt = new DataTable();
        dt = co.GetDataByPrco();
        CreateCustomerChart(dt, WebChartControl1, "各学院基础信息填写进度");


    }
    public void CreateCustomerChart(DataTable dt, DevExpress.XtraCharts.Web.WebChartControl webChartControl, string title)
    {
        webChartControl.Series.Clear(); 
        if (dt.Rows.Count > 0)
        {
            Series series = new Series("学院", ViewType.Pie);//首先new一个对象
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                SeriesPoint point = new SeriesPoint(dt.Rows[i]["College"].ToString(), Convert.ToDouble(dt.Rows[i]["pcent"].ToString()));
                series.Points.Add(point);
            }
            webChartControl.Series.Add(series);
            //样式设置
            series.ArgumentScaleType = ScaleType.Auto;
            series.ValueScaleType = ScaleType.Numerical;

            ChartTitle CTitl = new ChartTitle();//加标题
            CTitl.Text = title;
            webChartControl.Titles.Clear();
            webChartControl.Titles.Add(CTitl);
            webChartControl.Visible = true;
        }
    }

}