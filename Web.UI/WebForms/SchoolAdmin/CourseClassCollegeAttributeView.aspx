<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CourseClassCollegeAttributeView.aspx.cs" Inherits="WebForms_SchoolAdministrator_CourseClassCollegeAttributeView" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="Infrastructure" Namespace="Infrastructure.Controls" TagPrefix="cc1" %>
<%@ Register Src="~/UserControls/MessageBoxControl.ascx" TagPrefix="uc2" TagName="MessageBoxControl" %>


<!DOCTYPE html>
<script runat="server">

    protected void btnExport_Click(object sender, EventArgs e)
    {

    }
</script>


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="../../css/style.css" rel="stylesheet" />
    <script src="../../script/jquery.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <h2>课程、班级、学院、属性信息查看</h2>
        <p>
                    <asp:LinkButton ID="btnExport" runat="server" OnClick="btnExport_Click1">导出Excel</asp:LinkButton>
        </p>
    
    </div>
        <cc1:MyGridView ID="gvExCourse" runat="server" AutoGenerateColumns="False" CssClass="dataTable" AllowSorting="true" DataSourceID="sdsCourseClassCollegeAttribute">
<AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>

            <Columns>
                <asp:BoundField DataField="course_num" HeaderText="course_num" SortExpression="course_num" />
                <asp:BoundField DataField="course_serialNum" HeaderText="course_serialNum" SortExpression="course_serialNum" />
                <asp:BoundField DataField="course_name" HeaderText="course_name" SortExpression="course_name" />
                <asp:BoundField DataField="course_teacherno" HeaderText="course_teacherno" SortExpression="course_teacherno" />
                <asp:BoundField DataField="course_teacher" HeaderText="course_teacher" SortExpression="course_teacher" />
                <asp:BoundField DataField="class_class" HeaderText="class_class" SortExpression="class_class" />
                <asp:BoundField DataField="College" HeaderText="College" SortExpression="College" />
                <asp:BoundField DataField="class_campus" HeaderText="class_campus" SortExpression="class_campus" />
                <asp:BoundField DataField="test_week" HeaderText="test_week" SortExpression="test_week" />
                <asp:BoundField DataField="type" HeaderText="type" ReadOnly="True" SortExpression="type" />
            </Columns>

<EditRowStyle CssClass="highlightRow"></EditRowStyle>

<HeaderStyle CssClass="FixedHeader"></HeaderStyle>

<PagerSettings FirstPageText="首页" LastPageText="尾页" NextPageText="下一页" PreviousPageText="上一页"></PagerSettings>

<PagerStyle CssClass="pagerRow"></PagerStyle>

<SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
        </cc1:MyGridView>
        <asp:SqlDataSource ID="sdsCourseClassCollegeAttribute" runat="server" ConnectionString="<%$ ConnectionStrings:CheckConnStr %>" SelectCommand="SELECT * FROM [View_Course_Class_Type_College]"></asp:SqlDataSource>
    </form>
</body>
</html>
