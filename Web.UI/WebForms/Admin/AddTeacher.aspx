<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddTeacher.aspx.cs" Inherits="WebForms_Admin_AddTeacher" %>

<%@ Register Assembly="Infrastructure" Namespace="Infrastructure.Controls" TagPrefix="cc1" %>

<%@ Register Src="../../UserControls/MessageBoxControl.ascx" TagName="MessageBoxControl" TagPrefix="uc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="../../css/style.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <fieldset>
            <legend>查询条件</legend>
            <p>
                部门：<asp:DropDownList ID="DropDownListBranch" runat="server" DataSourceID="SqlDataSourceBranch" DataTextField="BranchName" DataValueField="BranchID" Height="18px" Width="120px" AppendDataBoundItems="True" AutoPostBack="True">
                    <asp:ListItem Selected="True"></asp:ListItem>
                </asp:DropDownList>
                &nbsp;&nbsp;&nbsp; 工号：<asp:TextBox ID="TextBoxCode" runat="server" AutoPostBack="True" ></asp:TextBox>
                &nbsp;&nbsp;&nbsp; 姓名：<asp:TextBox ID="TextBoxName" runat="server" AutoPostBack="True"></asp:TextBox>
                &nbsp;&nbsp;&nbsp;
                <asp:LinkButton ID="LBSearch" runat="server" OnClick="LBSearch_Click" >检索</asp:LinkButton>

            </p>
        </fieldset>

            <cc1:MyGridView ID="MgvTeacher" runat="server" AutoGenerateColumns="False" AllowSorting="true" CssClass="dataTable" DataKeyNames="UserCode" DataSourceID="SqlDataSourceTeacher" OnRowCommand="MgvTeacher_RowCommand" AllowPaging="True">
                <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>

                <Columns>
                    <asp:BoundField DataField="Account" HeaderText="工号" SortExpression="Account" />
                    <asp:BoundField DataField="Name" HeaderText="姓名" SortExpression="Name" />
                    <asp:BoundField DataField="BranchName" HeaderText="部门名称" SortExpression="BranchName" />
                    <asp:BoundField DataField="Tel" HeaderText="联系电话" SortExpression="Tel" />
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

  

            <uc1:MessageBoxControl ID="MsgBox" runat="server" />

        
        <asp:SqlDataSource ID="SqlDataSourceTeacher" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>" CancelSelectOnNullParameter="false" SelectCommand="IF (@BranchID is null) SELECT [User].Account, [User].UserCode, [User].BranchID, [User].Name, [User].Tel, Branch.BranchName FROM [User] INNER JOIN Teacher ON [User].UserCode = Teacher.UserCode INNER JOIN Branch ON [User].BranchID = Branch.BranchID WHERE ([User].Account LIKE '%' + @Account + '%') AND ([User].UserCode NOT IN (SELECT UserCode FROM UsersInRoles WHERE (RoleId = @RoleId))) AND ([User].Name LIKE '%' + @Name + '%') 

IF (@BranchID is not null) SELECT [User].Account, [User].UserCode, [User].BranchID, [User].Name, [User].Tel, Branch.BranchName FROM [User] INNER JOIN Teacher ON [User].UserCode = Teacher.UserCode INNER JOIN Branch ON [User].BranchID = Branch.BranchID WHERE ([User].Account LIKE '%' + @Account + '%') AND ([User].UserCode NOT IN (SELECT UserCode FROM UsersInRoles WHERE (RoleId = @RoleId))) AND ([User].Name LIKE '%' + @Name + '%') AND (Branch.BranchID = @BranchID)">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownListBranch" DefaultValue="" Name="BranchID" PropertyName="SelectedValue"/>
                <asp:ControlParameter ControlID="TextBoxCode" DefaultValue="%" Name="Account" PropertyName="Text" />
                <asp:ControlParameter ControlID="txtRoleId" DefaultValue="2" Name="RoleId" PropertyName="Value" />
                <asp:ControlParameter ControlID="TextBoxName" DefaultValue="%" Name="Name" PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSourceBranch" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>" DeleteCommand="DELETE FROM [Branch] WHERE [BranchID] = @BranchID" InsertCommand="INSERT INTO [Branch] ([BranchName]) VALUES (@BranchName)" SelectCommand="SELECT BranchID, BranchName FROM Branch WHERE (ParentBranchID = 127)" UpdateCommand="UPDATE [Branch] SET [BranchName] = @BranchName WHERE [BranchID] = @BranchID">
            <DeleteParameters>
                <asp:Parameter Name="BranchID" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="BranchName" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="BranchName" Type="String" />
                <asp:Parameter Name="BranchID" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:HiddenField ID="txtRoleId" runat="server" />
        <asp:HiddenField ID="txtRoleName" runat="server" />
    </form>
</body>
</html>
