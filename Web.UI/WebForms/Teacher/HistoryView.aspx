<%@ Page Language="C#" AutoEventWireup="true" CodeFile="HistoryView.aspx.cs" Inherits="WebForms_Teacher_HistoryView" %>

<%@ Register Assembly="Infrastructure" Namespace="Infrastructure.Controls" TagPrefix="cc1" %>
<%@ Register Src="../../UserControls/MessageBoxControl.ascx" TagName="MessageBoxControl" TagPrefix="uc1" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="../../css/style.css" rel="stylesheet" />
    <script src="../../script/jquery.js" type="text/javascript"></script>
    <script src="../../script/GridLineHotTrack.js"></script>
    <script src="../../My97DatePicker/WdatePicker.js"></script>



</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2>历史数据查看</h2>
            <fieldset>
                <legend>查询</legend>
                <p>
                    学期：  
                    <asp:DropDownList ID="DropDownListType" runat="server" AppendDataBoundItems="True" DataSourceID="sdsTeachingPlan" DataTextField="teachingPlan" DataValueField="teachingPlan">
                        <asp:ListItem Value="%">【全部】</asp:ListItem>
                    </asp:DropDownList>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;
                    <asp:LinkButton ID="btnSearch" runat="server" OnClick="btnSearch_Click">检索</asp:LinkButton>
                </p>
            </fieldset>

            <fieldset>
                <legend>登记表</legend>
                <br />
                <cc1:MyGridView ID="gvRegistration" runat="server" CssClass="dataTable" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="course_no" DataSourceID="sdsRegistration" OnRowCommand="gvRegistration_RowCommand">
                    <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
                    <Columns>
                        <asp:TemplateField HeaderText="Reg_id" InsertVisible="False" Visible="false" SortExpression="course_no">
                            <ItemTemplate>
                                <asp:Label ID="lblcourse_no" runat="server" Text='<%# Bind("course_no") %>' Visible="false"></asp:Label>
                                <asp:Label ID="lbregID" runat="server" Text='<%# Bind("ID") %>' Visible="false"></asp:Label>
                                <asp:Label ID="lbpaperID" runat="server" Text='<%# Bind("PaperID") %>' Visible="False"></asp:Label>
                                <asp:Label ID="lbpapernum" runat="server" Text='<%# Eval("paper_num") %>'></asp:Label>
                                <asp:Label ID="lbpapercopynum" runat="server" Text='<%# Bind("paper_copyNum") %>' Visible="False"></asp:Label>
                                <asp:Label ID="lbwhitepapernum" runat="server" Text='<%# Eval("whitePaper_num") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="course_no" HeaderText="课程号" SortExpression="course_no" />
                        <asp:BoundField DataField="course_name" HeaderText="课程名" SortExpression="course_name" />
                        <asp:ButtonField CommandName="RegReport" HeaderText="登记表打印" Text="打印" />
                        <asp:ButtonField CommandName="DetailReport" HeaderText="细目表1打印" Text="打印" />
                        <asp:ButtonField CommandName="QuestiontypeReport" HeaderText="细目表2打印" Text="打印" />
                        <asp:ButtonField CommandName="PaperDownloadA" HeaderText="A卷下载" Text="下载" />
                        <asp:ButtonField CommandName="PaperDownloadB" HeaderText="B卷下载" Text="下载" />
                    </Columns>
                    <EditRowStyle CssClass="highlightRow"></EditRowStyle>
                    <HeaderStyle CssClass="headerRow"></HeaderStyle>
                    <PagerSettings FirstPageText="首页" LastPageText="尾页" NextPageText="下一页" PreviousPageText="上一页"></PagerSettings>
                    <PagerStyle CssClass="pagerRow"></PagerStyle>
                    <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
                </cc1:MyGridView>
            
            </fieldset>

            <fieldset>
                <legend>分析表</legend>
               
                <cc1:MyGridView ID="gvAnalysis" runat="server" CssClass="dataTable" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False"  DataKeyNames="course_no"  DataSourceID="sdsAnalysis" OnRowCommand="gvAnalysis_RowCommand">
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
                    <asp:BoundField DataField="paper_AorB" HeaderText="试卷号" SortExpression="paper_AorB" />
                    <asp:ButtonField CommandName="AnalysisReport" HeaderText="分析表打印" Text="打印" />
                </Columns>
                <EditRowStyle CssClass="highlightRow"></EditRowStyle>
                <HeaderStyle CssClass="headerRow"></HeaderStyle>
                <PagerSettings FirstPageText="首页" LastPageText="尾页" NextPageText="下一页" PreviousPageText="上一页"></PagerSettings>
                <PagerStyle CssClass="pagerRow"></PagerStyle>
                <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
            </cc1:MyGridView>
            
            </fieldset>
            
            
                <asp:HiddenField ID="txtTeacherId" runat="server" />
            
            
                <asp:SqlDataSource ID="sdsRegistration" runat="server" ConnectionString="<%$ ConnectionStrings:HistoryConnStr %>" SelectCommand="SELECT Course.course_name, Course.course_no, Registration.ID, Paper.getTime, Paper.paper_copyNum, Paper.ID AS PaperID, Paper.whitePaper_num, Paper.paper_num FROM Paper INNER JOIN Course ON Paper.courseID = Course.ID AND Paper.teachingPlan = Course.teachingPlan INNER JOIN Registration ON Course.ID = Registration.courseID AND Course.teachingPlan = Registration.teachingPlan WHERE (Course.course_teacherno LIKE @account) AND (Paper.flag IS NOT NULL) AND (Course.teachingPlan LIKE @tePlan)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="txtAccount" Name="account" PropertyName="Value" />
                        <asp:ControlParameter ControlID="DropDownListType" Name="tePlan" PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>
          
            
                <asp:SqlDataSource ID="sdsAnalysis" runat="server" ConnectionString="<%$ ConnectionStrings:HistoryConnStr %>" SelectCommand="SELECT DISTINCT Paper.paper_AorB, Paper.paper_state, Paper.paper_num, Paper.whitePaper_num, Paper.paper_copyNum, Paper.print_type, Paper.paper_uintPrice, Paper.whitePaper_unitPrice, Paper.copy_fee, Paper.binding_fee, Analysis.professionAudit, Analysis.collegeAudit, Analysis.state, Analysis.maxScore, Analysis.minScore, Analysis.basicAnalysis, Analysis.expandAnalysis, Analysis.teachAnalysis, Analysis.num_less60, Analysis.num_60_70, Analysis.num_70_80, Analysis.num_80_90, Analysis.num_more90, Analysis.PaperID, ExaminationCourse.teachingPlan, ExaminationCourse.course_dept, ExaminationCourse.course_name, ExaminationCourse.course_serialno, ExaminationCourse.course_type, REPLACE(dbo.LeftString(ExaminationCourse.course_teacherno), '*', '') AS TeacherNo, ExaminationCourse.course_teacher, ExaminationCourse.class_class, ExaminationCourse.course_attribute, ExaminationCourse.class_campus, Analysis.ID, ExaminationCourse.CommonOrPrivate, ExaminationCourse.PrivateCollege, ExaminationCourse.course_no FROM Paper INNER JOIN Analysis ON Paper.ID = Analysis.PaperID AND Paper.teachingPlan = Analysis.teachingPlan INNER JOIN ExaminationCourse ON Analysis.ExaminationCourseID = ExaminationCourse.ID AND Analysis.teachingPlan = ExaminationCourse.teachingPlan WHERE (REPLACE(dbo.LeftString(ExaminationCourse.course_teacherno), '*', '') LIKE @account) AND (ExaminationCourse.teachingPlan LIKE @taPlan)">
            <SelectParameters>
                <asp:ControlParameter ControlID="txtAccount" Name="account" PropertyName="Value" />
                <asp:ControlParameter ControlID="DropDownListType" Name="taPlan" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
            
                <asp:SqlDataSource ID="sdsTeachingPlan" runat="server" ConnectionString="<%$ ConnectionStrings:HistoryConnStr %>" SelectCommand="SELECT DISTINCT teachingPlan FROM Course"></asp:SqlDataSource>
            

            
                <dx:ASPxPopupControl ID="popupRegistration" runat="server" AllowDragging="True" CloseAction="CloseButton" HeaderText="编辑" Height="400px" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Theme="Aqua" Width="850px" AllowResize="True">
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
            
           
                <uc1:MessageBoxControl ID="MsgBox" runat="server" />
            

          
                <asp:HiddenField runat="server" ID="txtAccount"></asp:HiddenField>
           
           
                <asp:HiddenField runat="server" ID="txtCourseNo"></asp:HiddenField>
            


        </div>

    </form>
</body>
</html>
