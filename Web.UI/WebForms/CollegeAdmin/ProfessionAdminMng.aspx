<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ProfessionAdminMng.aspx.cs" Inherits="WebForms_CollegeAdmin_ProfessionAdminMng" %>

<%@ Register Assembly="Infrastructure" Namespace="Infrastructure.Controls" TagPrefix="cc1" %>

<%@ Register Src="../../UserControls/MessageBoxControl.ascx" TagName="MessageBoxControl" TagPrefix="uc1" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../../css/style.css" rel="stylesheet" />
    <style type="text/css">
        .auto-style1 {
            color: #0000CC;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2>系管理员账户管理</h2>
            <fieldset>
                <legend>查询条件</legend>
                <p>
                    部门：<asp:DropDownList ID="DropDownListBranch" runat="server" DataSourceID="SqlDataSourceBranch" DataTextField="BranchName" DataValueField="BranchName" Height="18px" Width="120px" AutoPostBack="True">
                    </asp:DropDownList>
                    &nbsp;&nbsp;&nbsp; 工号：<asp:TextBox ID="TextBoxCode" runat="server" AutoPostBack="True"></asp:TextBox>
                    &nbsp;&nbsp;&nbsp; 姓名：<asp:TextBox ID="TextBoxName" runat="server" AutoPostBack="True"></asp:TextBox>
                    &nbsp;&nbsp;&nbsp;
                <asp:LinkButton ID="LBSearch" runat="server" OnClick="LBSearch_Click">检索</asp:LinkButton>
                </p>
            </fieldset>
            <cc1:MyGridView ID="MgvTeacher" runat="server" AutoGenerateColumns="False" CssClass="dataTable" DataKeyNames="UserCode" DataSourceID="SqlDataSourceTeacher" AllowSorting="true" OnRowCommand="MgvTeacher_RowCommand" AllowPaging="True">
                <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>

                <Columns>
                    <asp:BoundField DataField="Account" HeaderText="工号" SortExpression="Account" />
                    <asp:BoundField DataField="Name" HeaderText="姓名" SortExpression="Name" />
                    <asp:BoundField DataField="BranchName" HeaderText="部门名称" SortExpression="BranchName" />
                    <asp:BoundField DataField="Tel" HeaderText="联系电话" SortExpression="Tel" />
                    <asp:BoundField DataField="Profession" HeaderText="所在系" SortExpression="Profession" />
                    <asp:BoundField DataField="UserCode" HeaderText="UserCode" ReadOnly="True" SortExpression="UserCode" Visible="False" />
                    <asp:ButtonField CommandName="Choose" HeaderText="选择" Text="选择" />
                </Columns>
                <EditRowStyle CssClass="highlightRow"></EditRowStyle>
                <HeaderStyle CssClass="headerRow"></HeaderStyle>
                <PagerSettings FirstPageText="首页" LastPageText="尾页" NextPageText="下一页" PreviousPageText="上一页"></PagerSettings>
                <PagerStyle CssClass="pagerRow"></PagerStyle>
                <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
            </cc1:MyGridView>

            <br />
            <p class="auto-style1">系级管理员</p>

            <cc1:MyGridView ID="MgvSelectTeacher" runat="server" AutoGenerateColumns="False" CssClass="dataTable" DataKeyNames="UserCode" DataSourceID="sdsProfessionMnger" OnRowCommand="MgvSelectTeacher_RowCommand" AllowPaging="True">
                <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
                <Columns>
                    <asp:BoundField DataField="Profession" HeaderText="专业" SortExpression="Profession" />
                    <asp:BoundField DataField="Name" HeaderText="管理员" SortExpression="Name" />
                    <asp:BoundField DataField="Tel" HeaderText="电话" SortExpression="Tel" />
                    <asp:ButtonField CommandName="DeleteProMnger" HeaderText="删除" Text="删除" />
                </Columns>
                <EditRowStyle CssClass="highlightRow"></EditRowStyle>
                <HeaderStyle CssClass="headerRow"></HeaderStyle>
                <PagerSettings FirstPageText="首页" LastPageText="尾页" NextPageText="下一页" PreviousPageText="上一页"></PagerSettings>
                <PagerStyle CssClass="pagerRow"></PagerStyle>
                <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
            </cc1:MyGridView>
           
                <uc1:MessageBoxControl ID="MsgBox" runat="server" />
            
            <asp:SqlDataSource ID="SqlDataSourceTeacher" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>" CancelSelectOnNullParameter="False" SelectCommand="SELECT [User].Account, [User].UserCode, [User].BranchID, [User].Name, [User].Tel, Branch.BranchName, Teacher.Profession FROM [User] INNER JOIN Teacher ON [User].UserCode = Teacher.UserCode INNER JOIN Branch ON [User].BranchID = Branch.BranchID WHERE ([User].Account LIKE '%' + @Account + '%') AND ([User].Name LIKE '%' + @Name + '%') AND (Teacher.College LIKE @College) AND ([User].UserCode NOT IN (SELECT UsersInRoles.UserCode FROM UsersInRoles INNER JOIN Roles ON UsersInRoles.RoleId = Roles.RoleId WHERE (Roles.RoleName LIKE '系级管理员'))) AND (Teacher.Profession LIKE @Pro)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="TextBoxCode" DefaultValue="%" Name="Account" PropertyName="Text" />
                    <asp:ControlParameter ControlID="TextBoxName" DefaultValue="%" Name="Name" PropertyName="Text" />
                    <asp:ControlParameter ControlID="txtCollege" DefaultValue="" Name="College" PropertyName="Value" />
                    <asp:ControlParameter ControlID="DropDownListBranch" DefaultValue="" Name="Pro" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSourceBranch" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>" DeleteCommand="DELETE FROM [Branch] WHERE [BranchID] = @BranchID" InsertCommand="INSERT INTO [Branch] ([BranchName]) VALUES (@BranchName)" SelectCommand="SELECT Branch.BranchID, Branch.BranchName FROM Branch INNER JOIN Branch AS Branch_1 ON Branch.ParentBranchID = Branch_1.BranchID AND Branch.BranchID &lt;&gt; Branch_1.BranchID WHERE (Branch_1.BranchName LIKE @College)" UpdateCommand="UPDATE [Branch] SET [BranchName] = @BranchName WHERE [BranchID] = @BranchID">
                <DeleteParameters>
                    <asp:Parameter Name="BranchID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="BranchName" Type="String" />
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtCollege" Name="College" PropertyName="Value" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="BranchName" Type="String" />
                    <asp:Parameter Name="BranchID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="sdsProfessionMnger" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>" SelectCommand="SELECT [User].Account, [User].UserCode, [User].BranchID, [User].Name, [User].Tel, Teacher.Profession FROM [User] INNER JOIN Teacher ON [User].UserCode = Teacher.UserCode INNER JOIN UsersInRoles ON [User].UserCode = UsersInRoles.UserCode INNER JOIN Roles ON UsersInRoles.RoleId = Roles.RoleId WHERE (Roles.RoleName LIKE '系级管理员') AND (Teacher.College LIKE @College)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtCollege" Name="College" PropertyName="Value" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br />
            <asp:HiddenField ID="txtRoleId" runat="server" />
            <asp:HiddenField ID="txtRoleName" runat="server" />
            <asp:HiddenField ID="txtCollege" runat="server" />
            <asp:HiddenField ID="txtTeacherID" runat="server" />
            <br />
            <asp:SqlDataSource ID="SqlDataSource1" runat="server"></asp:SqlDataSource>
    </form>
</body>
</html>
