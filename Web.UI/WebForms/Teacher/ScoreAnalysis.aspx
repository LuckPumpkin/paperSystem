<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ScoreAnalysis.aspx.cs" Inherits="WebForms_Teacher_ScoreAnalysis" %>
<%@ Register Assembly="Infrastructure" Namespace="Infrastructure.Controls" TagPrefix="cc1" %>
<%@ Register Src="../../UserControls/MessageBoxControl.ascx" TagName="MessageBoxControl" TagPrefix="uc1" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link href="../../css/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
            <h2>导入表</h2>
            <fieldset>
                <legend>导入数据</legend>
               
                    <br />
               
                    请将成绩单导入
                
                
                     
                <br />
                <br />
                上传导入EXCEL文件：<asp:FileUpload ID="files" runat="server" />
                    &nbsp;&nbsp;&nbsp;<br />
                <br />
                <br />
&nbsp;<dx:ASPxButton ID="btnImport" runat="server" Text="导入数据库" Theme="Aqua" OnClick="btnImport_Click">
                </dx:ASPxButton>
              
            </fieldset>
            
                <uc1:MessageBoxControl ID="MsgBox" runat="server" />
            
        </div>
    </form>
</body>
</html>
