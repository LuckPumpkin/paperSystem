<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrintBill.aspx.cs" Inherits="WebForms_PrintAdmin_PrintBill" %>
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
                    <asp:DropDownList ID="DropDownListCollege" runat="server" AppendDataBoundItems="True" DataSourceID="sdsCollege" DataValueField="PrivateCollege" Height="25px" Width="130px">
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
            </div>

            <div style="overflow-x: visible">
                <cc1:MyGridView ID="gvOrder" runat="server" AutoGenerateColumns="False" CssClass="dataTable" DataSourceID="sdsOrder" AllowPaging="true" AllowSorting="false" EmptyDataText="没有找到任何数据！">
                    <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
                    <Columns>
                        <asp:BoundField DataField="PID" HeaderText="订单号" SortExpression="PID" />
                        <asp:BoundField DataField="course_dept" HeaderText="开课学院" SortExpression="course_dept" />
                        <asp:BoundField DataField="Name" HeaderText="申请教师" SortExpression="Name" />
                        <asp:BoundField DataField="course_name" HeaderText="试卷名称" SortExpression="course_name" />
                        <asp:BoundField DataField="paper_AorB" HeaderText="试卷类型" SortExpression="paper_AorB" />
                        <asp:BoundField DataField="paper_num" HeaderText="试卷页数" SortExpression="paper_num" />
                        <asp:BoundField DataField="whitePaper_num" HeaderText="附白纸数" SortExpression="whitePaper_num" />
                        <asp:BoundField DataField="paper_copyNum" HeaderText="印刷份数" SortExpression="paper_copyNum" />
                        <asp:BoundField DataField="paper_state" HeaderText="订单状态" SortExpression="paper_state" />
                        <asp:BoundField DataField="print_type" HeaderText="印刷类型" SortExpression="print_type" />
                        <asp:BoundField DataField="paper_uintPrice" HeaderText="印刷单价" SortExpression="paper_uintPrice" />
                        <asp:BoundField DataField="whitePaper_unitPrice" HeaderText="白纸单价" SortExpression="whitePaper_unitPrice" />
                        <asp:BoundField DataField="copy_fee" HeaderText="版印费" SortExpression="copy_fee" />
                        <asp:BoundField DataField="binding_fee" HeaderText="装订费" SortExpression="binding_fee" />
                        <asp:BoundField DataField="total" HeaderText="小计" SortExpression="total" />
                    </Columns>

                    <EditRowStyle CssClass="highlightRow"></EditRowStyle>

                    <HeaderStyle CssClass="FixedHeader"></HeaderStyle>

                    <PagerSettings FirstPageText="首页" LastPageText="尾页" NextPageText="下一页" PreviousPageText="上一页"></PagerSettings>

                    <PagerStyle CssClass="pagerRow"></PagerStyle>

                    <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
                </cc1:MyGridView>
    </div>
                            <asp:SqlDataSource ID="sdsOrder" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>"
                SelectCommand="SELECT PID, Name, course_class, course_name, paper_AorB, paper_num, whitePaper_num, paper_copyNum, getTime, paper_state, print_type, paper_uintPrice, whitePaper_unitPrice, copy_fee, binding_fee, SID, total, standard, SingleOrDouble, submitTime, PrivateCollege, course_dept FROM View_Order WHERE (PrivateCollege LIKE @PrivateCollege) AND (SID = 9)">
                <SelectParameters>
                     <asp:ControlParameter ControlID="DropDownListCollege" DefaultValue="%" Name="PrivateCollege" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br />
            <asp:SqlDataSource ID="sdsCollege" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>"
            SelectCommand="SELECT DISTINCT PrivateCollege FROM View_Order WHERE (PrivateCollege IS NOT NULL)"></asp:SqlDataSource>
    </form>
</body>
</html>
