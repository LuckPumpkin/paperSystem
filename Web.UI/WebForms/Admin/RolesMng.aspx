<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RolesMng.aspx.cs" Inherits="WebForms_Admin_RolesMng" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="../../UserControls/MessageBoxControl.ascx" TagName="MessageBoxControl" TagPrefix="uc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="../../css/style.css" rel="stylesheet" type="text/css" />
    <script src="../../script/jquery.js" type="text/javascript"></script>
    <script src="../../script/GridLineHotTrack.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="sm" runat="server">
        </asp:ScriptManager>
        <div>
            <h2>角色管理</h2>
            <p>
                <asp:LinkButton ID="btnAdd" runat="server" OnClick="btnAdd_Click">添加角色</asp:LinkButton>
                &nbsp;|&nbsp;
            <asp:LinkButton ID="btnCreateSysRoles" runat="server"
                OnClick="btnCreateSysRoles_Click">创建系统角色</asp:LinkButton>
            </p>
            <asp:GridView ID="gvRoles" runat="server" CellPadding="4" CssClass="dataTable" AutoGenerateColumns="False"
                DataSourceID="ObjectDataSource" AllowSorting="True" PageSize="15" OnRowCommand="gvRoles_RowCommand" >
                <RowStyle CssClass="itemRow" />
                <Columns>
                    <asp:BoundField DataField="RoleName" HeaderText="角色" SortExpression="Role" ReadOnly="True" />
                    <asp:TemplateField HeaderText="删除" ShowHeader="False">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnDelete" runat="server" CausesValidation="false" CommandName="DeleteRole"
                                Text="删除"></asp:LinkButton>
                            <asp:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server" TargetControlID="btnDelete"
                                ConfirmText="删除无法恢复，您真的确认要删除该角色吗？">
                            </asp:ConfirmButtonExtender>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <PagerStyle CssClass="pagerRow" />
                <HeaderStyle CssClass="headerRow" />
                <AlternatingRowStyle CssClass="alternateRow" />
                <EditRowStyle BackColor="#2461BF" />
            </asp:GridView>
            <asp:ObjectDataSource ID="ObjectDataSource" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="DSApplicationTableAdapters.RolesTableAdapter"></asp:ObjectDataSource>
            
            <dx:ASPxPopupControl ID="PopupControl" runat="server" AllowDragging="True" CloseAction="CloseButton"
                HeaderText="角色管理" Modal="True" ClientInstanceName="PopupControl" Theme="Aqua" EnableAnimation="False"
                Left="15" Top="15" Width="306px">
                <ContentStyle VerticalAlign="Top">
                </ContentStyle>
                <ContentCollection>
                    <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server">
                        <table border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td style="height: 25px; text-align: right">
                                    <strong>角色：</strong>
                                </td>
                                <td style="height: 25px">
                                    <asp:TextBox ID="txtRole" runat="server" Width="138px"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                        <hr style="text-align: left; margin-top: 10px; margin-bottom: 10px; width: 220px;" />
                        <asp:LinkButton ID="btnInsert" runat="server" OnClick="btnInsert_Click">插入</asp:LinkButton>
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>
          
            <uc1:MessageBoxControl ID="MsgBox" runat="server" />
            <asp:HiddenField ID="txtUserCode" runat="server" />
        </div>
         
    </form>
</body>
</html>
