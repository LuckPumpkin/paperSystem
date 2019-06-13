<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ImportStudent.aspx.cs" Inherits="WebForms_Admin_ImportStudent" %>

<%@ Register Src="~/UserControls/DataImporter.ascx" TagPrefix="uc1" TagName="DataImporter" %>
<%@ Register Assembly="Infrastructure" Namespace="Infrastructure.Controls" TagPrefix="cc1" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="../../css/style.css" rel="stylesheet" type="text/css" />
    <link href="../../css/MoverListStyle.css" rel="stylesheet" />
    <%@ Register Src="~/UserControls/MessageBoxControl.ascx" TagPrefix="uc1" TagName="MessageBoxControl" %>
</head>
<body>
    <form id="form1" runat="server" >
        <div>
            <h2>导入教师信息</h2>
            <p>
                <asp:LinkButton ID="btn1" Theme="Aqua" runat="server" Text="导出教师数据" OnClick="btnExcel_Click" style="margin:5px 20px 10px 20px;"></asp:LinkButton>
                <asp:LinkButton ID="btnInitial" runat="server" OnClick="btnInitial_Click">用户数据初始化</asp:LinkButton>
            </p>
            <uc1:DataImporter ID="ImportStudent" runat="server" />
           
                <uc1:MessageBoxControl ID="MsgBox" runat="server" />
             <div style="display:none">
            <cc1:MyGridView ID="gvSysAdmin" runat="server" ClientInstanceName="gvSysAdmin" AutoGenerateColumns="False" CssClass="dataTable" DataKeyNames="Account" DataSourceID="sdsSysAdmin" EmptyDataText="没有找到任何数据！">
                    <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>

                    <Columns>
                        <asp:BoundField DataField="Account" HeaderText="工号"/>
                        <asp:BoundField DataField="Name" HeaderText="姓名"/>
                        <asp:BoundField DataField="College" HeaderText="所在部门"/>   
                         <asp:BoundField DataField="Sex" HeaderText="性别"/> 
                         <asp:BoundField DataField="Tel" HeaderText="联系方式"/>  
                    </Columns>

                    <EditRowStyle CssClass="highlightRow"></EditRowStyle>

                    <HeaderStyle CssClass="headerRow"></HeaderStyle>

                    <PagerSettings FirstPageText="首页" LastPageText="尾页" NextPageText="下一页" PreviousPageText="上一页"></PagerSettings>

                    <PagerStyle CssClass="pagerRow"></PagerStyle>

                    <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
                </cc1:MyGridView>
            <asp:SqlDataSource ID="sdsSysAdmin" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>" SelectCommand="SELECT Account, Name, College, Sex, Tel FROM Teacher">
                </asp:SqlDataSource> 
        </div>
        </div>
    </form>
</body>
</html>
