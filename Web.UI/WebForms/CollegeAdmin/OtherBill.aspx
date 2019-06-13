<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OtherBill.aspx.cs" Inherits="WebForms_CollegeAdmin_OtherBill" %>
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
            <h2>其他账单查看</h2>
            <br />
    <div style="align-content: center; width: 818px;">
                &nbsp;当前页面记录总计为：<asp:Label ID="Label1" runat="server" Text=""></asp:Label>元
                <dx:ASPxButton ID="btn1" Theme="Aqua" runat="server" Text="导出为Excel" OnClick="btnExcel_Click" style="margin:5px 20px 10px 20px;"></dx:ASPxButton>
                <br />
                <cc1:MyGridView ID="gvOrder" runat="server" AutoGenerateColumns="False" CssClass="dataTable"  HorizontalAlign="Center" EmptyDataText="没有找到任何数据！" AllowPaging="True" Width="800px" DataSourceID="SqlDataSource1">
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
                    <PagerSettings FirstPageText="首页" LastPageText="尾页" NextPageText="下一页" PreviousPageText="上一页">
                    </PagerSettings>
                    <PagerStyle CssClass="pagerRow"></PagerStyle>
                    <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
                </cc1:MyGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>" SelectCommand="SELECT DISTINCT ID, Name, College, pageNum, printNum, paper, printColor, paperSize, SingleOrDouble, bindMethod, cover, getTime, subTime, total, printed, state FROM OtherPtint WHERE (College LIKE @college) AND (state = '结账完成')">
            <SelectParameters>
                <asp:ControlParameter ControlID="txtBranch" Name="college" PropertyName="Value" DefaultValue="%" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:HiddenField runat="server" ID="txtAccount"></asp:HiddenField>
                        <asp:HiddenField runat="server" ID="txtBranch"></asp:HiddenField>
          <asp:HiddenField ID="txtTeacherId" runat="server" />
        <asp:HiddenField ID="txtCollege" runat="server" />
        <asp:HiddenField ID="txtTeacher" runat="server" />
    </div>
     </form>
</body>
</html>
