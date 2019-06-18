<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CollegeBill.aspx.cs" Inherits="WebForms_CollegeAdmin_CollegeBill" %>

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
        <h2>账单查看</h2>
    <div style="align-content: center; width: 818px;">
                当前页面记录总计为：<asp:Label ID="Label1" runat="server" Text=""></asp:Label>元
               <dx:ASPxButton ID="btn1" Theme="Aqua" runat="server" Text="导出为Excel" OnClick="btnExcel_Click" style="margin:10px 20px;"></dx:ASPxButton>
    </div>
           
        <div style="overflow-x: visible;">
                <cc1:MyGridView ID="gvOrder" runat="server" AutoGenerateColumns="False" CssClass="dataTable" DataSourceID="sdsBill" AllowSorting="false" EmptyDataText="没有找到任何数据！">
                    <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>

                    <Columns>
                        <asp:BoundField DataField="PID" HeaderText="订单号" SortExpression="PID" />
                        <asp:BoundField DataField="PrivateCollege" HeaderText="学院名称" SortExpression="PrivateCollege" />
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

                    <PagerSettings FirstPageText="首页" LastPageText="尾页" NextPageText="下一页" PreviousPageText="上一页"></PagerSettings>

                    <PagerStyle CssClass="pagerRow"></PagerStyle>

                    <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
                </cc1:MyGridView>
        </div>
       <asp:HiddenField ID="txtTeacherId" runat="server" />
        
        <asp:SqlDataSource ID="sdsBill" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>" SelectCommand="SELECT View_Order.PID, View_Order.PrivateCollege, View_Order.Name, View_Order.course_name, View_Order.paper_AorB, View_Order.paper_num, View_Order.whitePaper_num, View_Order.paper_copyNum, View_Order.paper_state, View_Order.paper_uintPrice, View_Order.whitePaper_unitPrice, View_Order.copy_fee, View_Order.binding_fee, View_Order.total, Course.course_dept FROM Paper INNER JOIN View_Order ON Paper.ID = View_Order.PID INNER JOIN Course ON Paper.courseID = Course.ID WHERE (View_Order.paper_state LIKE '%试卷结账完成%') AND (View_Order.course_dept LIKE '%' + @course_dept + '%')">
        <SelectParameters>



            <asp:ControlParameter ControlID="txtBranch" Name="course_dept" PropertyName="Value" />



        </SelectParameters>
            
            
             </asp:SqlDataSource>
                        <asp:HiddenField runat="server" ID="txtAccount"></asp:HiddenField>
                        <asp:HiddenField runat="server" ID="txtBranch"></asp:HiddenField>
         </div>
    </form>
</body>
</html>
