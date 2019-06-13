<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AnalysisAudit.aspx.cs" Inherits="WebForms_CollegeAdmin_AnalysisAudit" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="Infrastructure" Namespace="Infrastructure.Controls" TagPrefix="cc1" %>
<%@ Register Src="~/UserControls/MessageBoxControl.ascx" TagPrefix="uc2" TagName="MessageBoxControl" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link href="../../css/style.css" rel="stylesheet" />
    <script src="../../script/jquery.js"></script>
</head>
<body>
    <form id="form1" runat="server">
          <asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>
    <div>
    <div>
            <h2>分析表查看</h2>
            <asp:Panel ID="Panel1" runat="server" >
                <cc1:MyGridView ID="gvCourse"  runat="server"  AutoGenerateColumns="False" CssClass="dataTable" DataSourceID="sdsPaperAudit"  AllowPaging="True" AllowSorting="True" EmptyDataText="没有找到任何数据！" pageSize="20" OnRowCommand="gvCourse_RowCommand" DataKeyNames="AnalysisID" >
                    <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
                    <Columns>
                        <asp:TemplateField HeaderText="选择" Visible="False">
                            <ItemTemplate>
                             <asp:CheckBox ID="CheckBox" runat="server" AutoPostBack="false" />
                                <asp:Label ID="lblAnalysisID" runat="server" Text='<%# Bind("AnalysisID") %>' Visible="False"></asp:Label>
                                <asp:Label ID="lblTeacher" runat="server" Text='<%# Eval("anateacher_name") %>' Visible="False"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="course_no" HeaderText="课程号" />
                        <asp:BoundField DataField="course_name" HeaderText="课程名称" SortExpression="course_name" />
                        <asp:BoundField DataField="course_profession" HeaderText="系别" />
                        <asp:BoundField DataField="anateacher_name" HeaderText="教师" SortExpression="course_teacher" />
                        <asp:ButtonField CommandName="PaperAnalysis" HeaderText="分析表查看" Text="查看" />
                    </Columns>
                    <EditRowStyle CssClass="highlightRow"></EditRowStyle>
                    <HeaderStyle CssClass="headerRow"></HeaderStyle>
                    <PagerSettings FirstPageText="首页" LastPageText="尾页" NextPageText="下一页" PreviousPageText="上一页">
                    </PagerSettings>
                    <PagerStyle CssClass="pagerRow"></PagerStyle>
                    <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
                </cc1:MyGridView>
            </asp:Panel>
            &nbsp;&nbsp;<uc2:MessageBoxControl runat="server" ID="MsgBox" />

            <asp:SqlDataSource ID="sdsPaperAudit" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>" SelectCommand="SELECT DISTINCT Analysis.ID AS AnalysisID, Analysis.state, ExaminationCourse.course_dept, ExaminationCourse.course_name, ExaminationCourse.anateacher_name, ExaminationCourse.course_no, Course.course_profession FROM ExaminationCourse INNER JOIN Analysis ON ExaminationCourse.ID = Analysis.ExaminationCourseID INNER JOIN Course ON ExaminationCourse.course_no = Course.course_no WHERE (Analysis.state = 15) AND (ExaminationCourse.course_dept LIKE @course_dept)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtCollege" Name="course_dept" PropertyName="Value" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:HiddenField ID="txtAccount" runat="server" />

            <asp:HiddenField ID="txtCollege" runat="server" />
            <asp:HiddenField ID="txtTeacherID" runat="server" />

            <br />
        

        </div>
    </div><dx:ASPxPopupControl ID="popupAnalysis" runat="server" AllowDragging="True" CloseAction="CloseButton" HeaderText="查看分析表" Height="546px" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Theme="Aqua" Width="691px" AllowResize="True">
            <ClientSideEvents CloseUp="function(s, e) {
	__doPostBack('btnRefresh','');
}" />
            <ContentCollection>
                <dx:PopupControlContentControl ID="PopupControlContentControl2" runat="server" SupportsDisabledAttribute="True">
                        <br />
                        <br />
                    </dx:PopupControlContentControl>
            </ContentCollection>
        </dx:ASPxPopupControl>
    </form>
</body>
</html>
