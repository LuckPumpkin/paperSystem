<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ImportTestTable.aspx.cs" Inherits="WebForms_Admin_ImportTestTable" %>
<%@ Register Assembly="Infrastructure" Namespace="Infrastructure.Controls" TagPrefix="cc1" %>
<%@ Register Src="../../UserControls/MessageBoxControl.ascx" TagName="MessageBoxControl" TagPrefix="uc1" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="Content-Type" content="application/ms-excel; charset=UTF-8"/>
    <title></title>
    <link href="../../css/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
            <h2>导入表</h2>
            <fieldset>
                <legend>导入数据</legend>
                <p>
                    <asp:LinkButton ID="btnInitial" runat="server" OnClick="btnInitial_Click">课程数据初始化</asp:LinkButton>
                </p>
                <p>
                    请选择导入表类型：<asp:DropDownList ID="cboDocumentType" runat="server">
                        <asp:ListItem Value="ExaminationCourse">考试课程表</asp:ListItem>
                    </asp:DropDownList>
                </p>
                <div>
                    上传导入EXCEL文件：<asp:FileUpload ID="files" runat="server" />
                    &nbsp;&nbsp;&nbsp;&nbsp;
                <dx:ASPxButton ID="btnDownloadModel" runat="server" Text="下载Excel模板" Theme="Aqua" OnClick="btnDownloadModel_Click">
                </dx:ASPxButton>
                <dx:ASPxButton ID="btnImport" runat="server" Text="导入数据库" Theme="Aqua" OnClick="btnImport_Click">
                </dx:ASPxButton>
                </div>
            </fieldset>
            
                <uc1:MessageBoxControl ID="MsgBox" runat="server" />
           
        </div>
    </form>
</body>
</html>
