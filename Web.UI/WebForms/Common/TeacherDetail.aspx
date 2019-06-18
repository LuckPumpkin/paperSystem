<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TeacherDetail.aspx.cs" Inherits="WebForms_Common_TeacherDetail" %>

<%@ Register assembly="Infrastructure" namespace="Infrastructure.Controls" tagprefix="cc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
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
    <p class="auto-style1">

        教师详情</p>
        <div style="text-align:center;">
           
            <cc1:MyGridView ID="MyGridView1" runat="server" AutoGenerateColumns="False" CssClass="dataTable" DataKeyNames="UserCode" DataSourceID="SqlDataSourceTeacher" Width="955px">
<AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>

                <Columns>
                    <asp:BoundField DataField="Account" HeaderText="账号" SortExpression="Account" />
                    <asp:BoundField DataField="Name" HeaderText="姓名" SortExpression="Name" />
                    <asp:BoundField DataField="Sex" HeaderText="性别" SortExpression="Sex" />
                    <asp:BoundField DataField="Password" HeaderText="密码" SortExpression="Password" />
                    <asp:BoundField DataField="Tel" HeaderText="电话" SortExpression="Tel" />
                    <asp:BoundField DataField="Email" HeaderText="邮箱" SortExpression="Email" />
                    <asp:BoundField DataField="Mobile" HeaderText="手机" SortExpression="Mobile" />
                </Columns>

<EditRowStyle CssClass="highlightRow"></EditRowStyle>

<HeaderStyle CssClass="headerRow"></HeaderStyle>

<PagerSettings FirstPageText="首页" LastPageText="尾页" NextPageText="下一页" PreviousPageText="上一页"></PagerSettings>

<PagerStyle CssClass="pagerRow"></PagerStyle>

<SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
            </cc1:MyGridView>
                
            <asp:SqlDataSource ID="SqlDataSourceTeacher" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr%>" DeleteCommand="DELETE FROM [User] WHERE [UserCode] = @UserCode" InsertCommand="INSERT INTO [User] ([UserCode], [Name], [Password], [Tel], [Email], [IDCard], [Mobile], [Sex]) VALUES (@UserCode, @Name, @Password, @Tel, @Email, @IDCard, @Mobile, @Sex)" SelectCommand="SELECT UserCode, Name, Password, Tel, Email, IDCard, Mobile, Sex, Account FROM [User] WHERE (UserCode = @UserCode)" UpdateCommand="UPDATE [User] SET [Name] = @Name, [Password] = @Password, [Tel] = @Tel, [Email] = @Email, [IDCard] = @IDCard, [Mobile] = @Mobile, [Sex] = @Sex WHERE [UserCode] = @UserCode">
                <DeleteParameters>
                    <asp:Parameter Name="UserCode" Type="String" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="UserCode" Type="String" />
                    <asp:Parameter Name="Name" Type="String" />
                    <asp:Parameter Name="Password" Type="String" />
                    <asp:Parameter Name="Tel" Type="String" />
                    <asp:Parameter Name="Email" Type="String" />
                    <asp:Parameter Name="IDCard" Type="String" />
                    <asp:Parameter Name="Mobile" Type="String" />
                    <asp:Parameter Name="Sex" Type="String" />
                </InsertParameters>
                <SelectParameters>
                    <asp:QueryStringParameter Name="UserCode" QueryStringField="UserId" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="Name" Type="String" />
                    <asp:Parameter Name="Password" Type="String" />
                    <asp:Parameter Name="Tel" Type="String" />
                    <asp:Parameter Name="Email" Type="String" />
                    <asp:Parameter Name="IDCard" Type="String" />
                    <asp:Parameter Name="Mobile" Type="String" />
                    <asp:Parameter Name="Sex" Type="String" />
                    <asp:Parameter Name="UserCode" Type="String" />
                </UpdateParameters>
            </asp:SqlDataSource>

            </div>
    </div>
    </form>
</body>
</html>
