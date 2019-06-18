<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AllView.aspx.cs" Inherits="WebForms_Teacher_AllView" %>

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
           <asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>
    <div>
    <div>
        <h2>登记表、分析表打印</h2><span class="span_px">*此页面为登记表，分析表及双向细目表的汇总页面，待院级管理员审核通过后显示，教师进行自行打印存档</span>
         <fieldset>
                <legend>登记表打印<br />
                </legend>
                <p>
                <cc1:MyGridView ID="gvReg"  runat="server"  AutoGenerateColumns="False" CssClass="dataTable" DataSourceID="SqlDataSource1"  AllowPaging="True" AllowSorting="True" EmptyDataText="没有找到任何数据！" pageSize="20" OnRowCommand="gvReg_RowCommand" DataKeyNames="regID"  >
                    <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
                    <Columns>
                         <asp:TemplateField HeaderText="" Visible="False">
                            <ItemTemplate>
                                <asp:Label ID="lblRegID" runat="server" Text='<%# Bind("regID") %>' Visible="False"></asp:Label>
                                 
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="course_no" HeaderText="课程号" SortExpression="course_no" />
                        <asp:BoundField DataField="course_name" HeaderText="课程名称" SortExpression="course_name" />
                        <asp:ButtonField CommandName="Registration" HeaderText="登记表打印" Text="打印" />
                    </Columns>
                    <EditRowStyle CssClass="highlightRow"></EditRowStyle>
                    <HeaderStyle CssClass="headerRow"></HeaderStyle>
                    <PagerSettings FirstPageText="首页" LastPageText="尾页" NextPageText="下一页" PreviousPageText="上一页">
                    </PagerSettings>
                    <PagerStyle CssClass="pagerRow"></PagerStyle>
                    <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
                </cc1:MyGridView>
                </p>
               
            </fieldset>
          <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>" SelectCommand="SELECT Registration.state, Course.course_dept, Course.course_teacher, Course.course_name, Course.course_no, Course.course_profession, Registration.ID as regID FROM Registration INNER JOIN Course ON Registration.courseID = Course.ID INNER JOIN Paper ON Registration.PaperID = Paper.ID WHERE (Registration.state &gt;= 4) AND (Course.course_teacherno = @account) AND (Paper.flag LIKE '%考试%')">
              <SelectParameters>
                  <asp:ControlParameter ControlID="txtAccount" Name="account" PropertyName="Value" />
              </SelectParameters>
           </asp:SqlDataSource>
               <fieldset>
                <legend>分析表打印<br />
                </legend>
                <p>
                    <cc1:MyGridView ID="gvAnalysis" runat="server" AutoGenerateColumns="False" CssClass="dataTable" DataSourceID="SqlDataSource2" OnRowCommand="gvAnalysis_RowCommand" DataKeyNames="anaID" EmptyDataText="没有找到任何数据！">
<AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>

                        <Columns>
                             <asp:TemplateField HeaderText="" Visible="False">
                            <ItemTemplate>
                                <asp:Label ID="lblAnaID" runat="server" Text='<%# Bind("anaID") %>' Visible="False"></asp:Label>
                                 
                            </ItemTemplate>
                        </asp:TemplateField>
                            <asp:BoundField DataField="course_no" HeaderText="课程号" SortExpression="course_no" />
                            <asp:BoundField DataField="course_name" HeaderText="课程名" SortExpression="course_name" />
                            <asp:BoundField DataField="course_serialno" HeaderText="课序号" SortExpression="course_serialno" />
                            <asp:ButtonField CommandName="Analysis" HeaderText="分析表打印" Text="打印" />
                        </Columns>

<EditRowStyle CssClass="highlightRow"></EditRowStyle>

<HeaderStyle CssClass="FixedHeader"></HeaderStyle>

<PagerSettings FirstPageText="首页" LastPageText="尾页" NextPageText="下一页" PreviousPageText="上一页"></PagerSettings>

<PagerStyle CssClass="pagerRow"></PagerStyle>

<SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
                    </cc1:MyGridView>
                </p>
               
            </fieldset>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>" SelectCommand="SELECT ExaminationCourse.course_name, ExaminationCourse.course_no, ExaminationCourse.course_serialno, Analysis.state, ExaminationCourse.anateacher_no, Analysis.ID AS anaID FROM Course INNER JOIN ExaminationCourse ON Course.ID = ExaminationCourse.ID INNER JOIN Analysis ON ExaminationCourse.ID = Analysis.ExaminationCourseID WHERE (Analysis.state >= 13) AND (ExaminationCourse.anateacher_no = @account)">
            <SelectParameters>
                <asp:ControlParameter ControlID="txtAccount" Name="account" PropertyName="Value" />
            </SelectParameters>
        </asp:SqlDataSource>
                    <%-- <fieldset>   
        <legend>双向细目表打印
                </legend>
                <p>
                <cc1:MyGridView ID="gvDetail"  runat="server"  AutoGenerateColumns="False" CssClass="dataTable" DataSourceID="SqlDataSource3"  AllowPaging="True" AllowSorting="True" EmptyDataText="没有找到任何数据！" pageSize="20" OnRowCommand="gvDetail_RowCommand" DataKeyNames="DetailID" >
                    <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
                    <Columns>
                        <asp:TemplateField HeaderText="" Visible="False">
                            <ItemTemplate>
                                <asp:Label ID="lblDetID" runat="server" Text='<%# Bind("DetailID") %>' Visible="False"></asp:Label>
                                 
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="course_no" HeaderText="课程号" SortExpression="course_no" />

                        <asp:BoundField DataField="course_name" HeaderText="课程名称" SortExpression="course_name" />
                        <asp:BoundField DataField="paper_AorB" HeaderText="试卷类型" SortExpression="paper_AorB" />
                        
                        
                        <asp:ButtonField CommandName="Detail_QuestionType" HeaderText="细目表1打印" Text="打印" />
                        <asp:ButtonField CommandName="Detail_Module" HeaderText="细目表2打印" Text="打印" />
                    </Columns>
                    <EditRowStyle CssClass="highlightRow"></EditRowStyle>
                    <HeaderStyle CssClass="headerRow"></HeaderStyle>
                    <PagerSettings FirstPageText="首页" LastPageText="尾页" NextPageText="下一页" PreviousPageText="上一页">
                    </PagerSettings>
                    <PagerStyle CssClass="pagerRow"></PagerStyle>
                    <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
                </cc1:MyGridView>
                </p>
                   </fieldset>--%>
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>" SelectCommand=" SELECT Detail.DetailID, Registration.state, Course.course_no, Course.course_name, Course.course_teacherno, Paper.paper_AorB FROM Detail INNER JOIN Paper ON Detail.PaperID = Paper.ID INNER JOIN Course ON Detail.courseID = Course.ID INNER JOIN Registration ON Paper.ID = Registration.PaperID WHERE (Course.course_teacherno = @account) AND (Registration.state >= 4)">

            <SelectParameters>
                <asp:ControlParameter ControlID="txtAccount" Name="account" PropertyName="Value" />
            </SelectParameters>
        </asp:SqlDataSource>

                        <asp:HiddenField ID="txtAccount" runat="server" />
                        <br />
                        <br />
                        <asp:HiddenField ID="txtTeacherId" runat="server" />
         

        <dx:ASPxPopupControl ID="popupRegistration" runat="server" AllowDragging="True" CloseAction="CloseButton" HeaderText="查看登记表" Height="400px" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Theme="Aqua" Width="850px" AllowResize="True">
            <ClientSideEvents CloseUp="function(s, e) {
	__doPostBack('btnRefresh','');
}" />
            <ContentCollection>
                <dx:PopupControlContentControl ID="PopupControlContentControl2" runat="server" SupportsDisabledAttribute="True">
         
                    </dx:PopupControlContentControl>
            </ContentCollection>
        </dx:ASPxPopupControl>

        </div>
    </div>
    </form>
</body>
</html>