<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WeekCheck.aspx.cs" Inherits="WebForms_SchoolAdministrator_WeekCheck" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="Infrastructure" Namespace="Infrastructure.Controls" TagPrefix="cc1" %>
<%@ Register Src="~/UserControls/MessageBoxControl.ascx" TagPrefix="uc2" TagName="MessageBoxControl" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="../../css/style.css" rel="stylesheet" />
    <script src="../../script/jquery.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>
        <div>
            <h2>考试周检查</h2>
            <p>
                <asp:LinkButton ID="btnRefreshPress" runat="server" OnClick="btnRefreshPress_Click">更新Process</asp:LinkButton>
                &nbsp;
            &nbsp;<asp:LinkButton ID="btnComputeCourseWeek" runat="server" OnClick="btnComputeCourseWeek_Click">计算课程结课周</asp:LinkButton>
            &nbsp;&nbsp;<asp:LinkButton ID="btnComputeClassWeek" runat="server" OnClick="btnComputeClassWeek_Click">计算班级考试周</asp:LinkButton>
                &nbsp;&nbsp;
                <asp:LinkButton ID="btnComputeTestWeek" runat="server" OnClick="btnComputeTestWeek_Click">安排考试周</asp:LinkButton>
            &nbsp;&nbsp;
                
                    <asp:LinkButton ID="btnExport" runat="server" OnClick="btnExport_Click1">导出Excel</asp:LinkButton>
                
            </p>
            <fieldset>
                <legend>查询条件</legend>
                <p>
                    <asp:CheckBox ID="chkCourse_weekIsNotNull" runat="server" Text="结课周不为空" />&nbsp;&nbsp;<asp:CheckBox ID="chkClass_weekIsNotNull" runat="server" Text="考试周不为空" />
                &nbsp;&nbsp;&nbsp; <asp:CheckBox ID="chkCompare" runat="server" Text="结课周&gt;考试周" />
                    </p>
                <p>
                    课程名：<asp:TextBox ID="txtCourseName" runat="server"></asp:TextBox>
                    &nbsp;&nbsp;课程号：<asp:TextBox ID="txtCourseNum" runat="server" Width="109px"></asp:TextBox>
                    &nbsp;&nbsp; 校区 
                    <asp:DropDownList ID="DropDownListCampus" runat="server" AppendDataBoundItems="True" DataSourceID="sdsCampus" DataTextField="class_campus" DataValueField="class_campus">
                        <asp:ListItem Value="%">【全部】</asp:ListItem>
                    </asp:DropDownList>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:LinkButton ID="btnSearch" runat="server" OnClick="btnSearch_Click">检索</asp:LinkButton>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    </p>
                </fieldset>
            
            
            <cc1:MyGridView ID="gvExCourse" runat="server" AutoGenerateColumns="False" CssClass="dataTable" DataSourceID="sdsExcludeCourse" EmptyDataText="没有检索到任何数据。" AllowPaging="True" AllowSorting="True" Width="100%" PageSize="200">
                <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
                <Columns>
                    <asp:TemplateField  ShowHeader="False" Visible="false">
                        <ItemTemplate>
                            <asp:Label ID="ID" runat="server" Text='<%# Bind("ID") %>' Visible="false"></asp:Label>
                            <asp:Label ID="course_num" runat="server" Text='<%# Bind("course_num") %>' Visible="false"></asp:Label>
                            <asp:Label ID="course_serialNum" runat="server" Text='<%# Bind("course_serialNum") %>' Visible="false"></asp:Label>
                            <asp:Label ID="class_class" runat="server" Text='<%# Bind("class_class") %>' Visible="false"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="course_num" HeaderText="课程号" SortExpression="course_num" />
                    <asp:BoundField DataField="course_serialNum" HeaderText="课序列号" SortExpression="course_serialNum" />
                    <asp:BoundField DataField="course_name" HeaderText="课程名" SortExpression="course_name" />
                    <asp:BoundField DataField="class_time" HeaderText="上课时间" SortExpression="class_time" />
                    <asp:BoundField DataField="class_class" HeaderText="上课班级" SortExpression="class_class" />
                    <asp:BoundField DataField="course_week" HeaderText="结课周" SortExpression="course_week" />
                    <asp:BoundField DataField="class_week" HeaderText="考试周" SortExpression="class_week" />
                    <asp:BoundField DataField="test_week" HeaderText="安排考试周" SortExpression="test_week" />
                </Columns>
                <EditRowStyle CssClass="highlightRow"></EditRowStyle>
                <HeaderStyle CssClass="headerRow"></HeaderStyle>
                <PagerSettings FirstPageText="首页" LastPageText="尾页" NextPageText="下一页" PreviousPageText="上一页"></PagerSettings>
                <PagerStyle CssClass="pagerRow"></PagerStyle>
                <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
            </cc1:MyGridView>
            <p>
                <asp:SqlDataSource ID="sdsExcludeCourse" runat="server" ConnectionString="<%$ ConnectionStrings:CheckConnStr %>" SelectCommand="IF (@Course_weekIsNotNull = 1 AND @Class_weekIsNotNull = 0) SELECT * FROM Week_Course_Class where (class_campus LIKE @class_campus) AND (course_name LIKE '%' + @course_name + '%') AND (course_num LIKE '%' + @course_num + '%') AND (course_week is not null)

IF (@Course_weekIsNotNull = 0 AND @Class_weekIsNotNull = 1) SELECT * FROM Week_Course_Class  where (class_campus LIKE @class_campus ) AND (course_name LIKE '%' + @course_name + '%') AND (course_num LIKE '%' + @course_num + '%') AND (class_week is not null)

IF (@Course_weekIsNotNull= 1 AND @Class_weekIsNotNull = 1   AND @compare=1)
SELECT * FROM Week_Course_Class where (class_campus LIKE @class_campus ) AND (course_name LIKE '%' + @course_name + '%') AND (course_num LIKE '%' + @course_num + '%') AND (course_week is not null) AND (class_week is not null) AND(convert(int,course_week)&gt;convert(int,class_week))

IF (@Course_weekIsNotNull= 0 AND @Class_weekIsNotNull = 0   AND @compare=1)
SELECT * FROM Week_Course_Class where (class_campus LIKE @class_campus ) AND (course_name LIKE '%' + @course_name + '%') AND (course_num LIKE '%' + @course_num + '%') AND (course_week is not null) AND (class_week is not null) AND(convert(int,course_week)&gt;convert(int,class_week))

IF (@Course_weekIsNotNull= 1 AND @Class_weekIsNotNull = 1   AND @compare=0)
SELECT * FROM Week_Course_Class where (class_campus LIKE @class_campus ) AND (course_name LIKE '%' + @course_name + '%') AND (course_num LIKE '%' + @course_num + '%') AND (course_week is not null) AND (class_week is not null)

IF (@Course_weekIsNotNull= 0 AND @Class_weekIsNotNull  = 0 )
SELECT * FROM Week_Course_Class where (class_campus LIKE @class_campus) AND (course_name LIKE '%' + @course_name + '%') AND (course_num LIKE '%' + @course_num + '%') ">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="chkCourse_weekIsNotNull" DefaultValue="0" Name="Course_weekIsNotNull" PropertyName="Checked" />
                        <asp:ControlParameter ControlID="chkClass_weekIsNotNull" DefaultValue="0" Name="Class_weekIsNotNull" PropertyName="Checked" />
                        <asp:ControlParameter ControlID="DropDownListCampus" DefaultValue="%" Name="class_campus" PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="txtCourseName" DefaultValue="%" Name="course_name" PropertyName="Text" />
                        <asp:ControlParameter ControlID="txtCourseNum" DefaultValue="%" Name="course_num" PropertyName="Text" />
                        <asp:ControlParameter ControlID="chkCompare" DefaultValue="0" Name="compare" PropertyName="Checked" />
                    </SelectParameters>
                </asp:SqlDataSource>
            <asp:SqlDataSource ID="sdsCampus" runat="server" ConnectionString="<%$ ConnectionStrings:CheckConnStr %>" SelectCommand="SELECT DISTINCT class_campus FROM ExaminationCourse WHERE (class_campus IS NOT NULL)"></asp:SqlDataSource>
            </p>
            <uc2:MessageBoxControl runat="server" ID="MsgBox" />
        </div>
    </form>
</body>
</html>
