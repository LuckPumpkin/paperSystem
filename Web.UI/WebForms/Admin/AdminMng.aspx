<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AdminMng.aspx.cs" Inherits="WebForms_Admin_AdminMng" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<%@ Register Assembly="Infrastructure" Namespace="Infrastructure.Controls" TagPrefix="cc1" %>
<%@ Register Src="~/UserControls/MessageBoxControl.ascx" TagPrefix="uc1" TagName="MessageBoxControl" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="../../css/style.css" rel="stylesheet" />
    <script src="../../script/jquery.js"></script>
    <script type="text/javascript">
        function ShowTeacherDetail(userId) {
            popupTeacherDetail.SetContentUrl("../Common/TeacherDetail.aspx?UserId=" + userId);
            popupTeacherDetail.Show();
        }
    </script>
    
    </head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>
        <div>
            <h2>管理员账户管理</h2>
            <br />
            <p>按管理员类别管理：<asp:DropDownList ID="DropDownUser" runat="server">
                <asp:ListItem Value="系统管理员">系统管理员</asp:ListItem>
                <asp:ListItem Value="校级管理员">校级管理员</asp:ListItem>
                <asp:ListItem Value="院级管理员">院级管理员</asp:ListItem>
                </asp:DropDownList>
&nbsp;&nbsp;
                <asp:LinkButton ID="LinkButton2" runat="server" OnClick="btnSearch_Click">检索</asp:LinkButton>
            </p>
            <br />
            <asp:Label ID="LabelAdmin" runat="server" Text="" ForeColor="#000000"></asp:Label>
            &nbsp;&nbsp;
            <asp:LinkButton ID="LinkButton3" runat="server" OnClick="Addadmin">添加管理员</asp:LinkButton>
&nbsp;<br />
&nbsp;<cc1:MyGridView ID="gvSysAdmin" runat="server" AllowPaging="True" AllowSorting="true" ClientInstanceName="gvSysAdmin" AutoGenerateColumns="False" CssClass="dataTable" DataKeyNames="UserCode" DataSourceID="sdsSysAdmin" EmptyDataText="没有找到任何数据！" OnRowCommand="gvSysAdmin_RowCommand" PageSize="100" >
                    <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>

                    <Columns>
                        
                        <asp:TemplateField HeaderText="UserId" SortExpression="UserCode" Visible="False"  InsertVisible="False">
                            <ItemTemplate>
                                <asp:Label ID="lbUserCode" runat="server" Text='<%# Bind("UserCode") %>' Visible="false"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="BranchName" HeaderText="部门"/>
                        <asp:TemplateField HeaderText="姓名" SortExpression="Name">
                            <EditItemTemplate>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <a href="javascript:void(0)" onclick='javascript:ShowTeacherDetail("<%# Eval("UserCode") %>");'>
                                <asp:Label ID="lblName" runat="server" Text='<%# Bind("Name") %>'></asp:Label></a>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:ButtonField CommandName="DeleteAdmin" HeaderText="删除" Text="删除" />
                    </Columns>

                    <EditRowStyle CssClass="highlightRow"></EditRowStyle>

                    <HeaderStyle CssClass="headerRow"></HeaderStyle>

                    <PagerSettings FirstPageText="首页" LastPageText="尾页" NextPageText="下一页" PreviousPageText="上一页"></PagerSettings>

                    <PagerStyle CssClass="pagerRow"></PagerStyle>

                    <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
                </cc1:MyGridView>
                <asp:SqlDataSource ID="sdsSysAdmin" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>" SelectCommand="IF(@RoleName = '系统管理员')
SELECT [User].Account, [User].UserCode, [User].Name, Branch.BranchName FROM [User] INNER JOIN UsersInRoles ON [User].UserCode = UsersInRoles.UserCode INNER JOIN Roles ON UsersInRoles.RoleId = Roles.RoleId INNER JOIN Branch ON [User].BranchID = Branch.BranchID WHERE (Roles.RoleName like '系统管理员') ORDER BY [User].Name
IF(@RoleName = '校级管理员')
SELECT [User].Account, [User].UserCode, [User].Name, Branch.BranchName FROM [User] INNER JOIN UsersInRoles ON [User].UserCode = UsersInRoles.UserCode INNER JOIN Roles ON UsersInRoles.RoleId = Roles.RoleId INNER JOIN Branch ON [User].BranchID = Branch.BranchID WHERE (Roles.RoleName like '校级管理员') ORDER BY [User].Name
IF(@RoleName = '院级管理员')
SELECT [User].Account, [User].UserCode, [User].Name, Branch.BranchName FROM [User] INNER JOIN UsersInRoles ON [User].UserCode = UsersInRoles.UserCode INNER JOIN Roles ON UsersInRoles.RoleId = Roles.RoleId INNER JOIN Branch ON [User].BranchID = Branch.BranchID WHERE (Roles.RoleName like  '院级管理员') ORDER BY [User].Name
">
                    <SelectParameters>
                     <asp:ControlParameter ControlID="LabelAdmin"  Name="RoleName" PropertyName="Text" />
                    </SelectParameters>
                </asp:SqlDataSource> 
       
           

            <dx:ASPxPopupControl ID="popupSelectTeacher" runat="server" CloseAction="CloseButton" HeaderText="选择教师" Height="350px" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Theme="Aqua" Width="900px" PopupAnimationType="Fade" ClientInstanceName="popupSelectTeacher" AllowDragging="True" AllowResize="True" style="margin-top: 0px">
                <HeaderImage Url="~/images/edit.png">
                </HeaderImage>
                <ClientSideEvents CloseUp="function(s, e) {
	__doPostBack('LinkButton2','');;
}" />
                <FooterStyle>
                    <Paddings Padding="5px" />
                </FooterStyle>
                <FooterTemplate>
                </FooterTemplate>
                <ContentCollection>
                    <dx:PopupControlContentControl ID="PopupControlContentControl3" runat="server" SupportsDisabledAttribute="True"></dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>
            <dx:ASPxPopupControl ID="popupTeacherDetail" runat="server" CloseAction="CloseButton" HeaderText="教师明细信息" Height="300px" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ShowFooter="True" Theme="Aqua" Width="883px" PopupAnimationType="Fade" ClientInstanceName="popupTeacherDetail" AllowDragging="True" AllowResize="True" FooterText="">
                <HeaderImage Url="~/images/edit.png">
                </HeaderImage>
                <ClientSideEvents Closing="function(s, e) {
	popupTeacherDetail.show=false;
}" />
                <FooterStyle>
                    <Paddings Padding="5px" />
                </FooterStyle>
                <ContentCollection>
                    <dx:PopupControlContentControl ID="PopupControlContentControl4" runat="server" SupportsDisabledAttribute="True"></dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>
           

                    <dx:ASPxPopupControl ID="popupMsg" runat="server" CloseAction="CloseButton" HeaderText="消息" Height="130px" Modal="True" ShowFooter="True" Theme="Aqua" Width="339px" PopupAnimationType="Fade" ShowCloseButton="False" ClientInstanceName="popupMsg" AllowDragging="True" Left="80" Top="100">
                        <FooterStyle>
                            <Paddings Padding="5px" />
                        </FooterStyle>
                        <FooterTemplate>
                            <dx:ASPxMenu ID="mnuMsg" runat="server" EnableTheming="True" Theme="Aqua" ShowAsToolbar="True" OnItemClick="mnuMsg_ItemClick">
                                <ClientSideEvents ItemClick="function(s, e) {
    var itemName = e.item.name;
	switch(itemName){
		case 'Cancel':
			popupMsg.Hide();
            e.processOnServer = false;
			break;}
}" />
                                <Items>
                                    <dx:MenuItem Name="Save" Text="确定">
                                        <Image Url="~/images/save.gif">
                                        </Image>
                                    </dx:MenuItem>
                                    <dx:MenuItem Name="Cancel" Text="取消">
                                        <Image Url="~/images/close.gif">
                                        </Image>
                                    </dx:MenuItem>
                                </Items>
                            </dx:ASPxMenu>
                        </FooterTemplate>
                        <ContentCollection>
                            <dx:PopupControlContentControl ID="PopupControlContentControl2" runat="server" SupportsDisabledAttribute="True">
                                
                              
                                    <asp:Image ID="imgMessageBoxIcon" runat="server" ImageAlign="Middle" ImageUrl="~/images/exclamation_icon.png"
                            Width="40px" />
                                   
                                    <asp:Label ID="lblMessageBoxMsg" runat="server" Text="         确定要删除该管理员吗？"></asp:Label>
                                
                            </dx:PopupControlContentControl>

                        </ContentCollection>
                    </dx:ASPxPopupControl>

                
            <uc1:MessageBoxControl runat="server" ID="MsgBox" />
            <asp:HiddenField ID="txtUserID" runat="server" />
        </div>
    </form>
</body>
</html>
