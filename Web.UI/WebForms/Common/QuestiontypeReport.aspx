<%@ Page Language="C#" AutoEventWireup="true" CodeFile="QuestiontypeReport.aspx.cs" Inherits="WebForms_Common_QuestiontypeReport" %>
<%@ Register Assembly="DevExpress.XtraReports.v14.1.Web, Version=14.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraReports.Web" TagPrefix="dx" %>
<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <div style="padding-left:50px;">
        <dx:ReportToolbar ID="rtQuestiontypeTb" runat="server" ReportViewerID="rvQuestiontype" ShowDefaultButtons="False" Theme="Aqua">
         <Items>
                <dx:ReportToolbarButton ItemKind="Search" />
                <dx:ReportToolbarSeparator />
                <dx:ReportToolbarSeparator />
                <dx:ReportToolbarButton Enabled="False" ItemKind="FirstPage" />
                <dx:ReportToolbarButton Enabled="False" ItemKind="PreviousPage" />
                <dx:ReportToolbarLabel ItemKind="PageLabel" />
                <dx:ReportToolbarComboBox ItemKind="PageNumber" Width="65px">
                </dx:ReportToolbarComboBox>
                <dx:ReportToolbarLabel ItemKind="OfLabel" />
                <dx:ReportToolbarTextBox IsReadOnly="True" ItemKind="PageCount" />
                <dx:ReportToolbarButton ItemKind="NextPage" />
                <dx:ReportToolbarButton ItemKind="LastPage" />
                <dx:ReportToolbarSeparator />
<%--                <dx:ReportToolbarButton ItemKind="SaveToDisk" />
                <dx:ReportToolbarButton ItemKind="SaveToWindow" />--%>
                <dx:ReportToolbarComboBox ItemKind="SaveFormat" Width="70px">
                    <elements>
                        <dx:ListElement Value="pdf" />
                        <dx:ListElement Value="xls" />
                        <dx:ListElement Value="xlsx" />
                        <dx:ListElement Value="rtf" />
                        <dx:ListElement Value="mht" />
                        <dx:ListElement Value="html" />
                        <dx:ListElement Value="txt" />
                        <dx:ListElement Value="csv" />
                        <dx:ListElement Value="png" />
                    </elements>
                </dx:ReportToolbarComboBox>
                 <dx:ReportToolbarButton ItemKind="PrintReport" />
                <dx:ReportToolbarButton ItemKind="PrintPage" />
            </Items>
            <styles>
                <LabelStyle>
                            <Margins MarginLeft='3px' MarginRight='3px' />
                        </LabelStyle>
            </styles>
        </dx:ReportToolbar>
        
    </div>
        <p>
            <dx:ReportViewer ID="rvQuestiontype" runat="server" ReportName="Report1" Theme="Aqua" >
                <Border BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="1px" />
            </dx:ReportViewer>
        </p>
    
    </div>

    </form>
</body>
</html>

