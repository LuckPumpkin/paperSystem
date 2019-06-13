<%@ Page Language="C#" AutoEventWireup="true" CodeFile="anaDetail.aspx.cs" Inherits="WebForms_Common_anaDetail" %>

<%@ Register assembly="Infrastructure" namespace="Infrastructure.Controls" tagprefix="cc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link href="../../css/style.css" rel="stylesheet" />
    <style type="text/css">
       #btn1{
           margin:10px 0px!important;
       }
    </style>
</head>
<body>
    <form id="form2" runat="server">
    <div>
        学院未提交试卷分析表详情<span style="color:red;">(*若教师工号为空和姓名为空,请先通知系主任进行试卷分析教师指定)<br />
        <dx:ASPxButton ID="btn1" Theme="Aqua" runat="server" Text="导出为Excel" OnClick="btnExcel_Click" style="margin:10px 20px;"></dx:ASPxButton>
        </span>
        <div style="text-align:center;">
           
            <cc1:MyGridView ID="MyGridView1" runat="server" AutoGenerateColumns="False" CssClass="dataTable" DataKeyNames="course_dept" DataSourceID="SqlDataSourceTeacher" Width="955px">
<AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>

                <Columns>
                    <asp:BoundField DataField="course_dept" HeaderText="学院" SortExpression="course_dept" />
                    <asp:BoundField DataField="course_profession" HeaderText="专业" SortExpression="course_profession" />
                    <asp:BoundField DataField="anateacher_no" HeaderText="工号" SortExpression="anateacher_no" />
                    <asp:BoundField DataField="anateacher_name" HeaderText="姓名" SortExpression="anateacher_name" />
                    <asp:BoundField DataField="course_no" HeaderText="课程号" SortExpression="course_no"/>
                    <asp:BoundField DataField="course_name" HeaderText="课程名" SortExpression="course_name" />
                    <asp:BoundField DataField="Tel" HeaderText="电话" SortExpression="Tel" />
                </Columns>

<EditRowStyle CssClass="highlightRow"></EditRowStyle>

<HeaderStyle CssClass="headerRow"></HeaderStyle>

<PagerSettings FirstPageText="首页" LastPageText="尾页" NextPageText="下一页" PreviousPageText="上一页"></PagerSettings>

<PagerStyle CssClass="pagerRow"></PagerStyle>

<SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
            </cc1:MyGridView>
                
            <asp:SqlDataSource ID="SqlDataSourceTeacher" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>" SelectCommand="SELECT derivedtbl_1.course_dept, derivedtbl_1.course_profession, derivedtbl_1.course_no, derivedtbl_1.course_name, derivedtbl_1.anateacher_no, derivedtbl_1.anateacher_name, Teacher.Tel FROM (SELECT COUNT(*) AS num, Course.course_dept, Course.course_no, Course.course_name, ExaminationCourse.anateacher_no, Course.course_profession, ExaminationCourse.anateacher_name FROM Analysis INNER JOIN ExaminationCourse ON Analysis.ExaminationCourseID = ExaminationCourse.ID INNER JOIN Course ON ExaminationCourse.course_no = Course.course_no INNER JOIN Paper ON Course.ID = Paper.courseID WHERE (Paper.printed = 1) AND (Analysis.state = 11) GROUP BY Course.course_dept, Course.course_no, ExaminationCourse.anateacher_no, Course.course_profession, ExaminationCourse.anateacher_name, Course.course_name HAVING (COUNT(*) &lt;&gt; 0)) AS derivedtbl_1 LEFT OUTER JOIN Teacher ON derivedtbl_1.anateacher_no = Teacher.Account WHERE (derivedtbl_1.course_dept = @course_dept)">
                <SelectParameters>
                    <asp:QueryStringParameter Name="course_dept" QueryStringField="College" />
                </SelectParameters>
            </asp:SqlDataSource>

            </div>
    </div>
    </form>
</body>
</html>
