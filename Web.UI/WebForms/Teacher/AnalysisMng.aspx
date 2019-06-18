<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AnalysisMng.aspx.cs" Inherits="WebForms_Teacher_AnalysisMng" %>

<%@ Register Assembly="Infrastructure" Namespace="Infrastructure.Controls" TagPrefix="cc1" %>
<%@ Register src="../../UserControls/MessageBoxControl.ascx" tagname="MessageBoxControl" tagprefix="uc1" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link href="../../css/style.css" rel="stylesheet" />
    <script src="../../script/jquery.js" type="text/javascript"></script>
    <script src="../../script/GridLineHotTrack.js"></script>
<style>
 .span_px{
        color:red;
        position: absolute;
        top: 32px;
        display: inline-block;
        left: 200px;
    }
</style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <h2>试卷分析</h2><span class="span_px">*上传的Excel仅包含分数，单列排开</span>
        <div style="text-align:center">
        <br/>
        <cc1:MyGridView ID="gvCourse" runat="server" CssClass="dataTable" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False"  DataKeyNames="course_no"  DataSourceID="SqlDataSource1" OnRowCommand="gvCourse_RowCommand" EmptyDataText="没有找到任何数据！">
                <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
                <Columns>
                    <asp:TemplateField HeaderText="Analysis_id" InsertVisible="False" Visible="false" SortExpression="ID">
                        <ItemTemplate>
                            <asp:Label ID="lblanalysisId" runat="server" Text='<%# Bind("ID") %>' Visible="False"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="course_no" HeaderText="课程号" SortExpression="course_no" />
                    <asp:BoundField DataField="course_name" HeaderText="课程名" SortExpression="course_name" />
                    <asp:BoundField DataField="course_serialno" HeaderText="课序号" SortExpression="course_serialno" />
                    <asp:ButtonField CommandName="AnalysisEdit" HeaderText="编辑分析" Text="编辑" />
                    <asp:ButtonField CommandName="ScoreUpload" HeaderText="成绩上传" Text="上传" />
                    <asp:ButtonField CommandName="AnalysisReport" HeaderText="分析表打印" Text="打印" />
                    <asp:ButtonField CommandName="Submit" HeaderText="提交" Text="提交" />
                </Columns>
                <EditRowStyle CssClass="highlightRow"></EditRowStyle>
                <HeaderStyle CssClass="headerRow"></HeaderStyle>
                <PagerSettings FirstPageText="首页" LastPageText="尾页" NextPageText="下一页" PreviousPageText="上一页"></PagerSettings>
                <PagerStyle CssClass="pagerRow"></PagerStyle>
                <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
            </cc1:MyGridView>
            </div>
    </div>
        <asp:HiddenField ID="txtTeacherId" runat="server" />
        <br />
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>" SelectCommand="SELECT Analysis.state, ExaminationCourse.course_name, ExaminationCourse.course_serialno, REPLACE(dbo.LeftString(ExaminationCourse.course_teacherno), '*', '') AS TeacherNo, State.StateName, Analysis.ID, ExaminationCourse.course_no FROM Course INNER JOIN Paper ON Course.ID = Paper.courseID INNER JOIN Analysis INNER JOIN ExaminationCourse ON Analysis.ExaminationCourseID = ExaminationCourse.ID INNER JOIN State ON Analysis.state = State.ID ON Course.course_no = ExaminationCourse.course_no WHERE (State.StateName LIKE '试卷分析草稿') AND (ExaminationCourse.anateacher_no LIKE @account) AND (Paper.printed = 1)">
            <SelectParameters>
                <asp:ControlParameter ControlID="txtAccount" Name="account" PropertyName="Value" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
        <dx:ASPxPopupControl ID="popupAnalysis" runat="server" AllowDragging="True" CloseAction="CloseButton" HeaderText="编辑、打印、上传" Height="400px" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Theme="Aqua" Width="850px" AllowResize="True">
            <ClientSideEvents CloseUp="function(s, e) {
	__doPostBack('btnRefresh','');
}" />
            <ContentCollection>
                <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server" SupportsDisabledAttribute="True">
                        <br />
                        <br />
                    </dx:PopupControlContentControl>
            </ContentCollection>
        </dx:ASPxPopupControl>
        
            <dx:ASPxPopupControl ID="popupUpload" runat="server" CloseAction="CloseButton" HeaderText="上传成绩" Height="150px" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ShowFooter="True" Theme="Aqua" Width="354px" PopupAnimationType="Fade" ClientInstanceName="popupUpload" AllowDragging="True" AllowResize="True" FooterText="">
                <HeaderImage Url="~/images/edit.png">
                </HeaderImage>
                <ClientSideEvents Closing="function(s, e) {
	location.replace(location.href);
}" />
                <FooterStyle>
                    <Paddings Padding="5px" />
                </FooterStyle>
                <ContentCollection>
                    <dx:PopupControlContentControl ID="PopupControlContentControl2" runat="server" SupportsDisabledAttribute="True">
                        <asp:FileUpload ID="FileUpload1" runat="server" Height="18px" Width="199px" />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:LinkButton ID="LBUpFile" runat="server" CommandName="UpFile" >上传</asp:LinkButton>
                        <br />
                        <asp:HiddenField ID="txtCourseNo" runat="server" />
                        <asp:HiddenField ID="txtAorB" runat="server" />
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>
       
                <uc1:MessageBoxControl ID="MsgBox" runat="server" />
        <br />
                        <asp:HiddenField runat="server" ID="txtAccount"></asp:HiddenField>

    </form>
</body>
</html>
