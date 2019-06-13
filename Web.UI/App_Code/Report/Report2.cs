using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Report2 的摘要说明
/// </summary>
public class Report2:DevExpress.XtraReports.UI.XtraReport
{
    private DevExpress.XtraReports.UI.TopMarginBand topMarginBand1;
    private DevExpress.XtraReports.UI.DetailBand detailBand1;
    private DevExpress.XtraReports.UI.XRLabel xrLabel6;
    private DevExpress.XtraReports.UI.XRLabel xrLabel5;
    private DevExpress.XtraReports.UI.XRLabel xrLabel4;
    private DevExpress.XtraReports.UI.XRLabel xrLabel3;
    private DevExpress.XtraReports.UI.XRLabel xrLabel2;
    private DevExpress.XtraReports.UI.XRLabel xrLabel1;
    private DevExpress.XtraReports.UI.ReportHeaderBand ReportHeader;
    private AnalysisDS analysisDS1;
    private AnalysisDSTableAdapters.DataTable1TableAdapter dataTable1TableAdapter1;
    private QuestiontypeDS questiontypeDS1;
    private QuestiontypeDSTableAdapters.QuestiontypeTableAdapter questiontypeTableAdapter1;
    private System.ComponentModel.BackgroundWorker backgroundWorker1;
    private DevExpress.XtraReports.UI.BottomMarginBand bottomMarginBand1;

	public Report2()
	{
		//
		// TODO: 在此处添加构造函数逻辑
		//
	}

    private void InitializeComponent()
    {
            string resourceFileName = "Report2.resx";
            this.topMarginBand1 = new DevExpress.XtraReports.UI.TopMarginBand();
            this.detailBand1 = new DevExpress.XtraReports.UI.DetailBand();
            this.bottomMarginBand1 = new DevExpress.XtraReports.UI.BottomMarginBand();
            this.xrLabel1 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel2 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel3 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel4 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel5 = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLabel6 = new DevExpress.XtraReports.UI.XRLabel();
            this.ReportHeader = new DevExpress.XtraReports.UI.ReportHeaderBand();
            this.analysisDS1 = new AnalysisDS();
            this.dataTable1TableAdapter1 = new AnalysisDSTableAdapters.DataTable1TableAdapter();
            this.questiontypeDS1 = new QuestiontypeDS();
            this.questiontypeTableAdapter1 = new QuestiontypeDSTableAdapters.QuestiontypeTableAdapter();
            this.backgroundWorker1 = new System.ComponentModel.BackgroundWorker();
            ((System.ComponentModel.ISupportInitialize)(this.analysisDS1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.questiontypeDS1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this)).BeginInit();
            // 
            // topMarginBand1
            // 
            this.topMarginBand1.Controls.AddRange(new DevExpress.XtraReports.UI.XRControl[] {
            this.xrLabel1,
            this.xrLabel2,
            this.xrLabel3,
            this.xrLabel4,
            this.xrLabel5,
            this.xrLabel6});
            this.topMarginBand1.HeightF = 30.20836F;
            this.topMarginBand1.Name = "topMarginBand1";
            // 
            // detailBand1
            // 
            this.detailBand1.HeightF = 85.00001F;
            this.detailBand1.Name = "detailBand1";
            // 
            // bottomMarginBand1
            // 
            this.bottomMarginBand1.HeightF = 76.04166F;
            this.bottomMarginBand1.Name = "bottomMarginBand1";
            // 
            // xrLabel1
            // 
            this.xrLabel1.LocationFloat = new DevExpress.Utils.PointFloat(21.875F, 7.208332F);
            this.xrLabel1.Name = "xrLabel1";
            this.xrLabel1.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel1.SizeF = new System.Drawing.SizeF(100F, 23F);
            this.xrLabel1.Text = "123";
            // 
            // xrLabel2
            // 
            this.xrLabel2.LocationFloat = new DevExpress.Utils.PointFloat(121.875F, 7.208332F);
            this.xrLabel2.Name = "xrLabel2";
            this.xrLabel2.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel2.SizeF = new System.Drawing.SizeF(100F, 23F);
            this.xrLabel2.Text = "123";
            // 
            // xrLabel3
            // 
            this.xrLabel3.LocationFloat = new DevExpress.Utils.PointFloat(221.875F, 7.208332F);
            this.xrLabel3.Name = "xrLabel3";
            this.xrLabel3.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel3.SizeF = new System.Drawing.SizeF(100F, 23F);
            this.xrLabel3.Text = "123";
            // 
            // xrLabel4
            // 
            this.xrLabel4.LocationFloat = new DevExpress.Utils.PointFloat(321.875F, 7.208363F);
            this.xrLabel4.Name = "xrLabel4";
            this.xrLabel4.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel4.SizeF = new System.Drawing.SizeF(100F, 23F);
            this.xrLabel4.Text = "xrLabel111";
            // 
            // xrLabel5
            // 
            this.xrLabel5.LocationFloat = new DevExpress.Utils.PointFloat(421.875F, 7.208363F);
            this.xrLabel5.Name = "xrLabel5";
            this.xrLabel5.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel5.SizeF = new System.Drawing.SizeF(100F, 23F);
            this.xrLabel5.Text = "1111111";
            // 
            // xrLabel6
            // 
            this.xrLabel6.LocationFloat = new DevExpress.Utils.PointFloat(521.875F, 7.208363F);
            this.xrLabel6.Name = "xrLabel6";
            this.xrLabel6.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabel6.SizeF = new System.Drawing.SizeF(100F, 23F);
            this.xrLabel6.Text = "xrLabel111111";
            // 
            // ReportHeader
            // 
            this.ReportHeader.HeightF = 100F;
            this.ReportHeader.Name = "ReportHeader";
            // 
            // analysisDS1
            // 
            this.analysisDS1.DataSetName = "AnalysisDS";
            this.analysisDS1.EnforceConstraints = false;
            this.analysisDS1.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // dataTable1TableAdapter1
            // 
            this.dataTable1TableAdapter1.ClearBeforeFill = true;
            // 
            // questiontypeDS1
            // 
            this.questiontypeDS1.DataSetName = "QuestiontypeDS";
            this.questiontypeDS1.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // questiontypeTableAdapter1
            // 
            this.questiontypeTableAdapter1.ClearBeforeFill = true;
            // 
            // Report2
            // 
            this.Bands.AddRange(new DevExpress.XtraReports.UI.Band[] {
            this.topMarginBand1,
            this.detailBand1,
            this.bottomMarginBand1,
            this.ReportHeader});
            this.DataAdapter = this.questiontypeTableAdapter1;
            this.DataMember = "Questiontype";
            this.DataSource = this.questiontypeDS1;
            this.Margins = new System.Drawing.Printing.Margins(100, 100, 30, 76);
            this.Version = "14.1";
            ((System.ComponentModel.ISupportInitialize)(this.analysisDS1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.questiontypeDS1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this)).EndInit();

    }
}