<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ImportTable.aspx.cs" Inherits="WebForms_Admin_ImportTable" %>
<%@ Register Assembly="Infrastructure" Namespace="Infrastructure.Controls" TagPrefix="cc1" %>
<%@ Register Src="../../UserControls/MessageBoxControl.ascx" TagName="MessageBoxControl" TagPrefix="uc1" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
                    请选择导入表类型：<asp:DropDownList ID="cboDocumentType" runat="server">
                        <asp:ListItem Value="ExaminationCourse">考试课程表</asp:ListItem>
                        <asp:ListItem Value="ExcludeCourse">排查表</asp:ListItem>
                        <asp:ListItem Value="Process">进程表</asp:ListItem>
                        <asp:ListItem Value="ClassCollege">学院班级表</asp:ListItem>
                    </asp:DropDownList>

                <dx:ASPxButton ID="btnDownloadModel" runat="server" Text="下载Excel模板" Theme="Aqua" OnClick="btnDownloadModel_Click">
                </dx:ASPxButton>
                </p>
                <hr style=" height:2px;border:none;border-top:2px dotted #CCCCFF;" />
                <p>
                    点击“下载Excel模板”保存Excel数据到客户端
                </p>
                <p>
                    上传导入EXCEL文件：<asp:FileUpload ID="files" runat="server" />
                    &nbsp;&nbsp;&nbsp;&nbsp;

                <dx:ASPxButton ID="btnImport" runat="server" Text="导入数据库" Theme="Aqua" OnClick="btnImport_Click">
                </dx:ASPxButton>
                </p>
            </fieldset>
            <p>
                <uc1:MessageBoxControl ID="MsgBox" runat="server" />
            </p>
        </div>
    </form>
</body>
</html>
