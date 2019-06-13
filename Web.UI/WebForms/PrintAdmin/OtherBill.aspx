<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OtherBill.aspx.cs" Inherits="WebForms_CollegeAdmin_OtherBill" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="Infrastructure" Namespace="Infrastructure.Controls" TagPrefix="cc1" %>
<%@ Register Src="~/UserControls/MessageBoxControl.ascx" TagPrefix="uc2" TagName="MessageBoxControl" %>
<%@ Register src="../../UserControls/MessageBoxControl.ascx" tagname="MessageBoxControl" tagprefix="uc1" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="Content-Type" content="application/ms-excel; charset=UTF-8"/>
    <title></title>
    <link href="../../css/style.css" rel="stylesheet" />
    <script src="../../script/jquery.js" type="text/javascript"></script>
    <script src="../../script/GridLineHotTrack.js"></script>
    <script src="../../My97DatePicker/WdatePicker.js"></script>
</head>
<body>
    <form id="form1" runat="server">
<fieldset>
                <legend>试卷账单</legend>

                <p>
                    &nbsp;&nbsp;&nbsp;&nbsp;
                         学院 
                    <asp:DropDownList ID="DropDownListCollege" runat="server" AppendDataBoundItems="True" DataSourceID="sdsCollege" DataValueField="College" Height="25px" Width="130px">
                        <asp:ListItem Value="%">全部</asp:ListItem>
                    </asp:DropDownList>
                    &nbsp; &nbsp; &nbsp; 
                    <asp:LinkButton ID="LinkButton1" runat="server" OnClick="btnSearch_Click">检索</asp:LinkButton>

                </p>
            </fieldset>

            <br />

            <div style="align-content: center">
                当前页面记录总计为：<asp:Label ID="Label1" runat="server" Text=""></asp:Label>元              
                <dx:ASPxButton ID="btn1" Theme="Aqua" runat="server" Text="导出为Excel" OnClick="btnExcel_Click" style="margin:10px 20px;"></dx:ASPxButton>
                <br />
            </div>

            <div style="overflow-x: visible">
                <cc1:MyGridView ID="gvOrder" runat="server" AutoGenerateColumns="False" CssClass="dataTable" DataSourceID="sdsOrder" AllowPaging="True" EmptyDataText="没有找到任何数据！">
                    <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
                    <Columns>
                         <asp:BoundField DataField="Name" HeaderText="文件名称" SortExpression="Name" />
                    <asp:BoundField DataField="pageNum" HeaderText="文件页数" SortExpression="pageNum" />
                    <asp:BoundField DataField="printNum" HeaderText="打印份数" SortExpression="printNum" />
                    <asp:BoundField DataField="paper" HeaderText="纸张规格" SortExpression="paper" />
                    <asp:BoundField DataField="SingleOrDouble" HeaderText="单双面" SortExpression="SingleOrDouble" />
                    <asp:BoundField DataField="printColor" HeaderText="墨水选择" SortExpression="printColor" />
                    <asp:BoundField DataField="paperSize" HeaderText="成品规格" SortExpression="paperSize" />
                    <asp:BoundField DataField="cover" HeaderText="封皮选择" SortExpression="cover" />
                    <asp:BoundField DataField="bindMethod" HeaderText="装订方式" SortExpression="bindMethod" />
                    <asp:BoundField DataField="state" HeaderText="订单状态" SortExpression="state" />
                    <asp:BoundField DataField="total" HeaderText="总额" SortExpression="total" />
                    </Columns>

                    <EditRowStyle CssClass="highlightRow"></EditRowStyle>

                    <HeaderStyle CssClass="FixedHeader"></HeaderStyle>

                    <PagerSettings FirstPageText="首页" LastPageText="尾页" NextPageText="下一页" PreviousPageText="上一页"></PagerSettings>

                    <PagerStyle CssClass="pagerRow"></PagerStyle>

                    <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
                </cc1:MyGridView>
    </div>
                 <asp:SqlDataSource ID="sdsOrder" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>"
                SelectCommand="SELECT Name, College, pageNum, printNum, paper, printColor, paperSize, SingleOrDouble, bindMethod, cover, getTime, subTime, state, total FROM OtherPtint WHERE (state = '结账完成')">
            </asp:SqlDataSource>
            <br />
            <asp:SqlDataSource ID="sdsCollege" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>"
            SelectCommand="SELECT DISTINCT College FROM OtherPtint"></asp:SqlDataSource>
    </form>
</body>
</html>
