﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PaperCheck.aspx.cs" Inherits="WebForms_ProfessionAdmin_PaperCheck" %>

<%@ Register Assembly="DevExpress.XtraReports.v14.1.Web, Version=14.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraReports.Web" TagPrefix="dx" %>

<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>

<%@ Register assembly="DevExpress.Web.v14.1, Version=14.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxImageSlider" tagprefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link href="../../css/style.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <asp:Label ID="Label1" runat="server"  Font-Size="18px" ForeColor="#cc0000"></asp:Label>
        <br />
        <br />
    <div>
    
        
            <dx:ASPxImageSlider ID="ASPxImageSlider1" runat="server" Height="1137px" Width="990px" BackColor="White" >
                <SettingsAutoGeneratedImages ImageCacheFolder="~\Thumb\" />
            </dx:ASPxImageSlider>
        
        <p style="padding-left:100px;margin-top:5px; width: 189px; text-align:center; height: 39px;">

           <asp:Button ID="LinkButton1" runat="server" OnClick="LinkButton1_Click" Font-Size="25px"  ForeColor="#000" Width="100px" Height="40px" text="已阅"></asp:Button>

        </p>
    
    </div>

    </form>
</body>
</html>
