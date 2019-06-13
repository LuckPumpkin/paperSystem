<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Bill.aspx.cs" Inherits="WebForms_SchoolAdmin_Bill" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="Infrastructure" Namespace="Infrastructure.Controls" TagPrefix="cc1" %>
<%@ Register Src="~/UserControls/MessageBoxControl.ascx" TagPrefix="uc2" TagName="MessageBoxControl" %>
<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxPopupControl" TagPrefix="dxpc" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta http-equiv="Content-Type" content="application/ms-excel; charset=UTF-8"/>
    <title></title>
      <link href="../../css/style.css" rel="stylesheet" />
    <style type="text/css">
 
        table.dataTable {
	color: #333;
	border-collapse: collapse;
	border: 1px solid #a3c0e8;
    margin-left: 0px;
    margin-right: 0px;
}
.FixedHeader
        {
            position: relative;
            top: expression(this.offsetParent.scrollTop);
            background-color: #dbeafe;
            background-image: url('../../images/gvHeaderBackground.gif');
            height: 21px;
            text-align: center;
            vertical-align: middle;
        }
.dataTable tr td, th {
	font-size: 12px;
	font-weight: normal;
	padding: 4px;
	border: 1px solid #bed6f6;
}
.alternateRow {
	background-color: #f4f8fe;
}
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        <%--<fieldset>
                <legend>账单</legend>

                <p>
                    &nbsp;&nbsp;&nbsp;&nbsp;
                         学院 
                    <asp:DropDownList ID="DropDownListCollege" runat="server" AppendDataBoundItems="True" DataSourceID="sdsCollege" DataValueField="PrivateCollege" Height="25px" Width="130px">
                        <asp:ListItem Value="%">全部</asp:ListItem>
                    </asp:DropDownList>
                    &nbsp; &nbsp; &nbsp; 
                    <asp:LinkButton ID="LinkButton1" runat="server" OnClick="btnSearch_Click">检索</asp:LinkButton>

                </p>
            </fieldset>--%>
            <h2>试卷账单查看</h2>
            <br />
    <div style="align-content: center; width: 818px;">
                &nbsp;当前页面记录总计为：<asp:Label ID="Label1" runat="server" Text=""></asp:Label>元
                <dx:ASPxButton ID="btn1" Theme="Aqua" runat="server" Text="导出为Excel" OnClick="btnExcel_Click" style="margin:5px 20px 10px 20px;"></dx:ASPxButton>
                <br />
                <cc1:MyGridView ID="gvOrder" runat="server" AutoGenerateColumns="False" CssClass="dataTable" DataSourceID="sdsBill"  HorizontalAlign="Center" EmptyDataText="没有找到任何数据！" AllowPaging="True" Width="800px">
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
                        <asp:BoundField DataField="paper_uintPrice" HeaderText="印刷单价" SortExpression="paper_uintPrice" />
                        <asp:BoundField DataField="whitePaper_unitPrice" HeaderText="白纸单价" SortExpression="whitePaper_unitPrice" />
                        <asp:BoundField DataField="copy_fee" HeaderText="版印费" SortExpression="copy_fee" />
                        <asp:BoundField DataField="binding_fee" HeaderText="装订费" SortExpression="binding_fee" />
                        <asp:BoundField DataField="total" HeaderText="小计" SortExpression="total" />
                    </Columns>
                    <EditRowStyle CssClass="highlightRow"></EditRowStyle>
                    <HeaderStyle CssClass="FixedHeader"></HeaderStyle>
                    <PagerSettings FirstPageText="首页" LastPageText="尾页" NextPageText="下一页" PreviousPageText="上一页">
                    </PagerSettings>
                    <PagerStyle CssClass="pagerRow"></PagerStyle>
                    <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
                </cc1:MyGridView>
    </div>
        <asp:SqlDataSource ID="sdsBill" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>" SelectCommand="SELECT PID, PrivateCollege, Name, course_name, paper_AorB, paper_num, whitePaper_num, paper_copyNum, paper_state, paper_uintPrice, whitePaper_unitPrice, copy_fee, binding_fee, total, course_dept FROM View_Order WHERE (PrivateCollege LIKE '%+&quot;校管&quot;+%') AND (paper_state LIKE '%+&quot;试卷结账完成&quot;+%')">
         </asp:SqlDataSource>   
           <%-- <asp:SqlDataSource ID="sdsCollege" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>"
            SelectCommand="SELECT DISTINCT PrivateCollege FROM View_Order WHERE (PrivateCollege IS NOT NULL)"></asp:SqlDataSource>--%>
            </div>            
    </form>
</body>
</html>

