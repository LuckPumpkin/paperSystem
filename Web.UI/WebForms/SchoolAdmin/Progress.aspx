<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Progress.aspx.cs" Inherits="WebForms_Admin_Progress" %>
<%@ Register Assembly="Infrastructure" Namespace="Infrastructure.Controls" TagPrefix="cc1" %>
<%@ Register Assembly="DevExpress.XtraCharts.v14.1.Web, Version=14.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.XtraCharts.Web" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.XtraCharts.v14.1, Version=14.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.XtraCharts" TagPrefix="dx" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link href="../../css/style.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
     <div>
    <h2>基础数据管理</h2>
<%--         DataSourceID="SqlDataSource1"--%>
         <span style="font-size:12px;">          
             <dx:WebChartControl ID="WebChartControl1" runat="server" Visible="False" Style="font-family: Arial;
            font-size: 11px;" Height="495px" Width="1010px" CrosshairEnabled="True" DataSourceID="SqlDataSource1" SeriesDataMember="College" PaletteName="Blue Green" SideBySideBarDistanceVariable="1" SideBySideEqualBarWidth="False">
                 <diagramserializable>
                     <dx:XYDiagram>
                         <axisx visibleinpanesserializable="-1">
                         </axisx>
                         <axisy visibleinpanesserializable="-1">
                         </axisy>
                     </dx:XYDiagram>
                 </diagramserializable>
                 <seriesserializable>
                     <dx:Series ArgumentDataMember="College" ArgumentScaleType="Qualitative" Name="Series 1" SynchronizePointOptions="False" ValueDataMembersSerializable="pcent">
                         <viewserializable>
                             <dx:SideBySideBarSeriesView>
                                 <border thickness="5" />
                             </dx:SideBySideBarSeriesView>
                         </viewserializable>
                         <labelserializable>
                             <dx:SideBySideBarSeriesLabel TextPattern="{S}{V}" LineVisibility="True" ShowForZeroValues="True">
                             </dx:SideBySideBarSeriesLabel>
                         </labelserializable>
                         <topnoptions enabled="True" />
                     </dx:Series>
                 </seriesserializable>
                <SeriesTemplate SynchronizePointOptions="False" argumentdatamember="College" argumentscaletype="Qualitative" valuedatamembersserializable="pcent">
                 </SeriesTemplate>
          </dx:WebChartControl></span>
         <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>" SelectCommand="SELECT [College], [pcent] FROM [View_Progress]"></asp:SqlDataSource>
    </div>
    </form>
</body>
</html>
