<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AssignTask.aspx.cs" Inherits="WebForms_Admin_AssignTask" %>
<%@ Register Assembly="Infrastructure" Namespace="Infrastructure.Controls" TagPrefix="cc1" %>

<%@ Register Src="../../UserControls/MessageBoxControl.ascx" TagName="MessageBoxControl" TagPrefix="uc1" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../../css/style.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        
    <div>
    <h2>分配任务</h2>
        <fieldset>
            <legend>登记管理任务分配</legend>
            <p>
               <asp:LinkButton ID="LtnRegAssign" runat="server" OnClick="LtnRegAssign_Click">分配登记任务</asp:LinkButton>
            </p>
            
                <uc1:MessageBoxControl ID="MsgBox" runat="server" />
            
        </fieldset>
    </div>
    </form>
</body>
</html>
