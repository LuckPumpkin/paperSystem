<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PaperMng.aspx.cs" Inherits="WebForms_Teacher_PaperMng" %>
<%@ Register Assembly="Infrastructure" Namespace="Infrastructure.Controls" TagPrefix="cc1" %>
<%@ Register src="../../UserControls/MessageBoxControl.ascx" tagname="MessageBoxControl" tagprefix="uc1" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link href="../../css/style.css" rel="stylesheet" />
    <script src="../../script/jquery.js"></script>
    <script src="../../script/GridLineHotTrack.js"></script>
    <script src="../../My97DatePicker/WdatePicker.js"></script>

</head>
<body>
        <form id="form1" runat="server">
                <div>
        <h2>试卷填报</h2>
 <%--       <div style="text-align:center;">
        <fieldset>
                <legend>双向细目表填报<br />
                </legend>
                <p>
           <cc1:MyGridView ID="gvDetail" runat="server" AutoGenerateColumns="False" CssClass="dataTable" AllowSorting="True" DataSourceID="SqlDataSource2" OnRowCommand="gvDetail_RowCommand" EmptyDataText="没有找到任何数据！" >
<AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>

                <Columns>
                      <asp:TemplateField HeaderText="Reg_id" InsertVisible="False" Visible="false" SortExpression="course_no">
                        <ItemTemplate>
                            <asp:Label ID="lblcourse_no" runat="server" Text='<%# Bind("course_no") %>' Visible="False"></asp:Label>
                            <asp:Label ID="lbregID" runat="server" Text='<%# Bind("regID") %>' Visible="false"></asp:Label>
                            <asp:Label ID="lbdetailID" runat="server" Text='<%# Bind("DetailID") %>' Visible="False"></asp:Label>
                           <%-- <asp:Label ID="lbTeachingPlan" runat="server" Text='<%# Bind("teachingPlan") %>' Visible="False"></asp:Label>
                            <asp:Label ID="lbCourseDept" runat="server" Text='<%# Bind("course_dept") %>' Visible="False"></asp:Label>
                            <asp:Label ID="lbpapernum" runat="server" Text='<%# Eval("paper_num") %>'></asp:Label>
                            <asp:Label ID="lbpapercopynum" runat="server" Text='<%# Bind("paper_copyNum") %>' Visible="False"></asp:Label>
                            <asp:Label ID="lbwhitepapernum" runat="server" Text='<%# Eval("whitePaper_num") %>'></asp:Label>--%>
   <%--                     </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="course_no" HeaderText="课程号" SortExpression="course_no" />
                    <asp:BoundField DataField="course_name" HeaderText="课程名" SortExpression="course_name" />
                    <asp:BoundField DataField="paper_AorB" HeaderText="试卷类型" SortExpression="paper_AorB" />
                    <asp:ButtonField CommandName="DetailEdit" HeaderText="双向细目表编辑" Text="编辑" />
                    <asp:ButtonField CommandName="DetailReport" HeaderText="细目表1打印" Text="打印" />
                    <asp:ButtonField CommandName="QuestiontypeReport" HeaderText="细目表2打印" Text="打印" />
                </Columns>

<EditRowStyle CssClass="highlightRow"></EditRowStyle>

<HeaderStyle CssClass="FixedHeader"></HeaderStyle>

<PagerSettings FirstPageText="首页" LastPageText="尾页" NextPageText="下一页" PreviousPageText="上一页"></PagerSettings>

<PagerStyle CssClass="pagerRow"></PagerStyle>

<SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
            </cc1:MyGridView>
                    </p>--%>
<%--</fieldset>--%>&nbsp;<asp:LinkButton ID="btnrefresh" runat="server" OnClick="refresh_Click"></asp:LinkButton>
      
            <br />
            <fieldset>
                <legend>登记表填报<br />
                </legend>
                <p>
              <cc1:MyGridView ID="gvCourse" runat="server" CssClass="dataTable" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False"  DataKeyNames="course_no"  DataSourceID="SqlDataSource1" OnRowCommand="gvCourse_RowCommand" EmptyDataText="没有找到任何数据！" >
                <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
                <Columns>             
                    <asp:TemplateField HeaderText="Reg_id" InsertVisible="False" Visible="false" SortExpression="course_no">
                        <ItemTemplate>
                            <asp:Label ID="lblcourse_no" runat="server" Text='<%# Bind("course_no") %>' Visible="false"></asp:Label>
                            <asp:Label ID="lbcourseID" runat="server" Text='<%# Bind("courseID") %>' Visible="false"></asp:Label>
                            <asp:Label ID="lbregID" runat="server" Text='<%# Bind("ID") %>' Visible="false"></asp:Label>
                            <asp:Label ID="lbpaperID" runat="server" Text='<%# Bind("PaperID") %>' Visible="False"></asp:Label>
                            <asp:Label ID="lbTeachingPlan" runat="server" Text='<%# Bind("teachingPlan") %>' Visible="False"></asp:Label>
                            <asp:Label ID="lbCourseDept" runat="server" Text='<%# Bind("course_dept") %>' Visible="False"></asp:Label>
                            <asp:Label ID="lbpapernum" runat="server" Text='<%# Eval("paper_num") %>'></asp:Label>
                            <asp:Label ID="lbpapercopynum" runat="server" Text='<%# Bind("paper_copyNum") %>' Visible="False"></asp:Label>
                            <asp:Label ID="lbwhitepapernum" runat="server" Text='<%# Eval("whitePaper_num") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="course_no" HeaderText="课程号" SortExpression="course_no"  />
                    <asp:BoundField DataField="course_name" HeaderText="课程名" SortExpression="course_name"/>
                    <asp:BoundField DataField="StateName" HeaderText="登记表状态" SortExpression="StateName" />
                    <asp:ButtonField CommandName="RegEdit" HeaderText="登记表编辑" Text="编辑" />             
                   <%-- <asp:ButtonField CommandName="PaperUploadA" HeaderText="A卷上传" Text="上传" />
                    <asp:ButtonField CommandName="PaperUploadB" HeaderText="B卷上传" Text="上传" />
                    <asp:ButtonField CommandName="PaperDownloadA" HeaderText="A卷下载" Text="下载" />
                    <asp:ButtonField CommandName="PaperDownloadB" HeaderText="B卷下载" Text="下载" />--%>
                    <asp:TemplateField HeaderText="交付时间" ShowHeader="False" SortExpression="getTime">
                        <ItemTemplate>
                            <asp:TextBox ID="Time" runat="server" Text='<%# Bind("getTime") %>' onclick="WdatePicker()"></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>                                
                    <asp:ButtonField CommandName="Submit" HeaderText="提交" Text="提交" />
                </Columns>
                <EditRowStyle CssClass="highlightRow"></EditRowStyle>
                <HeaderStyle CssClass="headerRow"></HeaderStyle>
                <PagerSettings FirstPageText="首页" LastPageText="尾页" NextPageText="下一页" PreviousPageText="上一页"></PagerSettings>
                <PagerStyle CssClass="pagerRow"></PagerStyle>
                <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
            </cc1:MyGridView>
             </p>
                </fieldset>
            </div>
    </div>
        <asp:HiddenField ID="txtTeacherId" runat="server" />
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>" SelectCommand="SELECT Course.course_no, Course.course_name, Paper.paper_AorB, Registration.state, Detail.DetailID, Registration.ID AS regID FROM Course INNER JOIN Detail ON Course.ID = Detail.courseID INNER JOIN Paper ON Detail.PaperID = Paper.ID INNER JOIN Registration ON Detail.courseID = Registration.courseID AND Detail.PaperID = Registration.PaperID WHERE (Registration.state = 1 OR Registration.state = 2) AND (Course.course_teacherno = @account)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtAccount" Name="account" PropertyName="Value" />
                </SelectParameters>
            </asp:SqlDataSource>
        <br />
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>" SelectCommand="SELECT DISTINCT Course.course_name, Course.course_no, Paper.getTime, Paper.paper_copyNum, Paper.ID AS PaperID, Paper.whitePaper_num, Paper.paper_num, Paper.submitTime, Course.course_dept, Course.teachingPlan, State.StateName, Paper.paper_AorB, Registration.ID, Course.ID AS courseID FROM State INNER JOIN Registration ON State.ID = Registration.state INNER JOIN Course ON Registration.courseID = Course.ID INNER JOIN Paper ON Registration.PaperID = Paper.ID WHERE (State.StateName LIKE '%试卷草稿%' OR State.StateName LIKE '%试卷系待审%') AND (Paper.flag LIKE '%考试%') AND (Course.course_teacherno LIKE @account)" UpdateCommand="UPDATE Paper SET getTime = @getTime FROM Paper INNER JOIN Course ON Paper.course_no = Course.course_no INNER JOIN Registration INNER JOIN State ON Registration.state = State.ID ON Course.course_no = Registration.course_no WHERE (Paper.course_no = @course_no) AND (State.StateName LIKE '%试卷草稿%') AND (Paper.flag LIKE '%考试%')">
            <SelectParameters>
                <asp:ControlParameter ControlID="txtAccount" Name="account" PropertyName="Value" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="getTime" />
                <asp:Parameter Name="course_no" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <br />
        <%--dateFmt: 'yyyy-MM-dd HH:mm:ss'--%>
        <dx:ASPxPopupControl ID="popupRegistration" runat="server" AllowDragging="True" CloseAction="CloseButton" HeaderText="编辑" Height="472px" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Theme="Aqua" Width="883px" AllowResize="True">
            <ClientSideEvents CloseUp="function(s, e) {
	__doPostBack('btnrefresh','');
}" />
            <ContentCollection>

                <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server" SupportsDisabledAttribute="True">
                        <br />
                        <br />
                    </dx:PopupControlContentControl>
            </ContentCollection>
        </dx:ASPxPopupControl>


        
            <dx:ASPxPopupControl ID="popupUpload" runat="server" CloseAction="CloseButton" HeaderText="上传试卷" Height="150px" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ShowFooter="True" Theme="Aqua" Width="354px" PopupAnimationType="Fade" ClientInstanceName="popupUpload" AllowDragging="True" AllowResize="True" FooterText="">
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
                        <asp:LinkButton ID="LBUpFile" runat="server" CommandName="UpFile" OnClick="LBUpFile_Click">上传</asp:LinkButton>
                        <br /><br /><br />
                        <asp:LinkButton ID="LBdownTemplate" runat="server" CommandName="DownLoadTemplate" OnClick="LBDownFile_Click">下载试卷模板</asp:LinkButton>
                        <asp:HiddenField ID="txtCourseNo" runat="server" />
                        <asp:HiddenField ID="txtAorB" runat="server" />
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>
        
                <uc1:MessageBoxControl ID="MsgBox" runat="server" />
        <br />
                        <asp:HiddenField runat="server" ID="txtAccount"></asp:HiddenField>

        <asp:HiddenField ID="txtTeachingPlan" runat="server" />
        <asp:HiddenField ID="txtCourseDept" runat="server" />

                        <asp:HiddenField runat="server" ID="txtCourseID"></asp:HiddenField>

        <br />

    </form>
        </form>
</body>
</html>
