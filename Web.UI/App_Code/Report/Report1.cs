using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Report1 的摘要说明
/// </summary>
public class Report1 : DevExpress.XtraReports.UI.XtraReport
{
    private DevExpress.XtraReports.UI.TopMarginBand topMarginBand1;
    private DevExpress.XtraReports.UI.DetailBand detailBand1;
    private DevExpress.XtraReports.UI.PageHeaderBand PageHeader;
    private DevExpress.XtraReports.UI.XRLabel xrLabel5;
    private DevExpress.XtraReports.UI.XRLabel xrLabel4;
    private DevExpress.XtraReports.UI.XRLabel xrLabel3;
    private DevExpress.XtraReports.UI.XRLabel xrLabel2;
    private DevExpress.XtraReports.UI.XRLabel xrLabel1;
    private DevExpress.XtraReports.UI.XRSubreport xrSubreport1;
    private DevExpress.XtraLayout.Converter.LayoutConverter layoutConverter1;
    private System.ComponentModel.IContainer components;
    private DevExpress.XtraLayout.Converter.LayoutConverter layoutConverter2;
    private DevExpress.XtraReports.UI.ReportHeaderBand ReportHeader;
    private DevExpress.Xpo.XPPageSelector xpPageSelector1;
    private DevExpress.CodeRush.PlugInCore.ActionHint actionHint1;
    private DevExpress.XtraReports.UI.BottomMarginBand bottomMarginBand1;

	public Report1()
	{
		//
		// TODO: 在此处添加构造函数逻辑
		//
	}

    private void InitializeComponent()
    {
            string resourceFileName = "Report1.resx";
            this.components = new System.ComponentModel.Container();
            this.topMarginBand1 = new DevExpress.XtraReports.UI.TopMarginBand();
            this.detailBand1 = new DevExpress.XtraReports.UI.DetailBand();
            this.bottomMarginBand1 = new DevExpress.XtraReports.UI.BottomMarginBand();
            this.xrSubreport1 = new DevExpress.XtraReports.UI.XRSubreport();
            this.PageHeader = new DevExpress.XtraReports.UI.PageHeaderBand();
            this.xrLabel5 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel4 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel3 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel2 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel1 = new DevExpress.XtraReports.UI.XRLabel();
            this.layoutConverter1 = new DevExpress.XtraLayout.Converter.LayoutConverter(this.components);
            this.layoutConverter2 = new DevExpress.XtraLayout.Converter.LayoutConverter(this.components);
            this.ReportHeader = new DevExpress.XtraReports.UI.ReportHeaderBand();
            this.xpPageSelector1 = new DevExpress.Xpo.XPPageSelector(this.components);
            this.actionHint1 = new DevExpress.CodeRush.PlugInCore.ActionHint(this.components);
            ((System.ComponentModel.ISupportInitialize)(this.actionHint1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this)).BeginInit();
            // 
            // topMarginBand1
            // 
            this.topMarginBand1.HeightF = 129.1667F;
            this.topMarginBand1.Name = "topMarginBand1";
            // 
            // detailBand1
            // 
            this.detailBand1.HeightF = 88.54166F;
            this.detailBand1.Name = "detailBand1";
            // 
            // bottomMarginBand1
            // 
            this.bottomMarginBand1.Controls.AddRange(new DevExpress.XtraReports.UI.XRControl[] {
            this.xrSubreport1});
            this.bottomMarginBand1.HeightF = 300F;
            this.bottomMarginBand1.Name = "bottomMarginBand1";
            // 
            // xrSubreport1
            // 
            this.xrSubreport1.LocationFloat = new DevExpress.Utils.PointFloat(0F, 0F);
            this.xrSubreport1.Name = "xrSubreport1";
            this.xrSubreport1.ReportSource = new RegistrationReport();
            this.xrSubreport1.SizeF = new System.Drawing.SizeF(630F, 300F);
            // 
            // PageHeader
            // 
            this.PageHeader.Controls.AddRange(new DevExpress.XtraReports.UI.XRControl[] {
            this.xrLabel5,
            this.xrLabel4,
            this.xrLabel3,
            this.xrLabel2,
            this.xrLabel1});
            this.PageHeader.HeightF = 100F;
            this.PageHeader.Name = "PageHeader";
            // 
            // xrLabel5
            // 
            this.xrLabel5.LocationFloat = new DevExpress.Utils.PointFloat(457.2917F, 77.00002F);
            this.xrLabel5.Name = "xrLabel5";
            this.xrLabel5.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel5.SizeF = new System.Drawing.SizeF(100F, 23F);
            this.xrLabel5.Text = "xrLabel1";
            // 
            // xrLabel4
            // 
            this.xrLabel4.LocationFloat = new DevExpress.Utils.PointFloat(357.2917F, 77.00002F);
            this.xrLabel4.Name = "xrLabel4";
            this.xrLabel4.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel4.SizeF = new System.Drawing.SizeF(100F, 23F);
            this.xrLabel4.Text = "xrLabel1";
            // 
            // xrLabel3
            // 
            this.xrLabel3.LocationFloat = new DevExpress.Utils.PointFloat(257.2917F, 77.00002F);
            this.xrLabel3.Name = "xrLabel3";
            this.xrLabel3.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel3.SizeF = new System.Drawing.SizeF(100F, 23F);
            this.xrLabel3.Text = "xrLabel1";
            // 
            // xrLabel2
            // 
            this.xrLabel2.LocationFloat = new DevExpress.Utils.PointFloat(157.2917F, 77.00002F);
            this.xrLabel2.Name = "xrLabel2";
            this.xrLabel2.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel2.SizeF = new System.Drawing.SizeF(100F, 23F);
            this.xrLabel2.Text = "xrLabel1";
            // 
            // xrLabel1
            // 
            this.xrLabel1.LocationFloat = new DevExpress.Utils.PointFloat(57.29167F, 77.00002F);
            this.xrLabel1.Name = "xrLabel1";
            this.xrLabel1.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel1.SizeF = new System.Drawing.SizeF(100F, 23F);
            this.xrLabel1.Text = "xrLabel1";
            // 
            // ReportHeader
            // 
            this.ReportHeader.HeightF = 34.54164F;
            this.ReportHeader.Name = "ReportHeader";
            // 
            // actionHint1
            // 
            this.actionHint1.Color = System.Drawing.Color.DarkGray;
            this.actionHint1.Feature = null;
            this.actionHint1.OptionsPath = null;
            this.actionHint1.ResetDisplayCountOnStartup = false;
            this.actionHint1.Text = null;
            // 
            // Report1
            // 
            this.Bands.AddRange(new DevExpress.XtraReports.UI.Band[] {
            this.topMarginBand1,
            this.detailBand1,
            this.bottomMarginBand1,
            this.PageHeader,
            this.ReportHeader});
            this.DataSource = this.xpPageSelector1;
            this.Margins = new System.Drawing.Printing.Margins(100, 100, 129, 300);
            this.Version = "14.1";
            ((System.ComponentModel.ISupportInitialize)(this.actionHint1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this)).EndInit();

    }
}