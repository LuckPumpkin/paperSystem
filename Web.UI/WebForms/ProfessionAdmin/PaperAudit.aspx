<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PaperAudit.aspx.cs" Inherits="WebForms_ProfessionAdmin_A" %>

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
    <style>
        .span_px{
        color:red;
        position: absolute;
        top: 116px;
        display: inline-block;
        left: 51px;
    }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>
        <div>
            <h2>试卷系审查</h2>
            <dx:ASPxMenu ID="mnuMain" runat="server" BackColor="White" EnableTheming="True" ShowAsToolbar="True" Theme="Default" OnItemClick="mnuMain_ItemClick">
                    <Paddings PaddingBottom="5px" PaddingTop="8px" />
                    <Items>
                        <dx:MenuItem Text="评审" Name="Audit" BeginGroup="True">
                            <Image Url="~/images/edit.png">
                            </Image>
                        </dx:MenuItem>
                    </Items>
                    <ItemStyle>
                        <HoverStyle BackColor="#E2F0FF">
                            <Border BorderColor="#A3C0E8" />
                        </HoverStyle>
                    </ItemStyle>
                    <Border BorderStyle="None" />
                </dx:ASPxMenu>
            <asp:Panel ID="Panel1" runat="server"  >
                <asp:CheckBox ID="CheckBox" runat="server" AutoPostBack="True" OnCheckedChanged="CheckBox_CheckedChanged" Text="全选" />
                <cc1:MyGridView ID="gvCourse" runat="server" AutoGenerateColumns="False" CssClass="dataTable" DataSourceID="sdsPaperAudit" AllowPaging="True" AllowSorting="True" EmptyDataText="没有找到任何数据！" pageSize="20" OnRowCommand="gvCourse_RowCommand">
                    <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
                    <Columns>
                        <asp:TemplateField HeaderText="选择" ShowHeader="False">
                            <ItemTemplate>
                                <asp:CheckBox ID="CheckBox" runat="server" AutoPostBack="false" />
                                <asp:Label ID="lblRegID" runat="server" Text='<%# Bind("RegistrationID") %>' Visible="false"></asp:Label>
                                <asp:Label ID="lblTeacher" runat="server" Text='<%# Bind("Name") %>' Visible="false"></asp:Label>
                                <asp:Label ID="lblCourseID" runat="server" Text='<%# Bind("courseID") %>' Visible="false"></asp:Label>
                                <asp:Label ID="lblCourse_no" runat="server" Text='<%# Bind("course_no") %>' Visible="false"></asp:Label>
                                <asp:Label ID="lbTeachingPlan" runat="server" Text='<%# Bind("teachingPlan") %>' Visible="False"></asp:Label>
                                <asp:Label ID="lbCourseDept" runat="server" Text='<%# Bind("course_dept") %>' Visible="False"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="course_no" HeaderText="课程号" SortExpression="course_no" />
                        <asp:BoundField DataField="course_name" HeaderText="课程名" SortExpression="course_name" />
                        <asp:BoundField DataField="Name" HeaderText="教师" SortExpression="Name" />
                        <asp:BoundField DataField="StateName" HeaderText="状态" SortExpression="StateName" />
                        <%--<asp:ButtonField CommandName="Read" HeaderText="试卷查看" Text="查看" />--%>
                        <asp:ButtonField CommandName="PrintRegistration" HeaderText="登记表打印" Text="打印" />
                       <%-- <asp:ButtonField CommandName="PrintDetail" HeaderText="细目表1打印" ShowHeader="True" Text="打印" />
                        <asp:ButtonField CommandName="PrintQuestiontype" HeaderText="细目表2打印" ShowHeader="True" Text="打印" />--%>
                        <%--<asp:ButtonField CommandName="Audit" HeaderText="评审" Text="评审" />--%>
                    </Columns>
                    <EditRowStyle CssClass="highlightRow"></EditRowStyle>
                    <HeaderStyle CssClass="headerRow"></HeaderStyle>
                    <PagerSettings FirstPageText="首页" LastPageText="尾页" NextPageText="下一页" PreviousPageText="上一页">
                    </PagerSettings>
                    <PagerStyle CssClass="pagerRow"></PagerStyle>
                    <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
                </cc1:MyGridView>
            </asp:Panel>
                </div>
            &nbsp;&nbsp;<uc2:MessageBoxControl runat="server" ID="MsgBox" />
            <dx:ASPxPopupControl ID="popupAuditEdit" runat="server" CloseAction="CloseButton" HeaderText="编辑评审" Height="178px" Modal="True" ShowFooter="True" Theme="Aqua" Width="334px" PopupAnimationType="Fade" ShowCloseButton="False" ClientInstanceName="popupAuditEdit" AllowDragging="True" Left="80" Top="100">
                <HeaderImage Url="~/images/edit.png">
                </HeaderImage>
                <ClientSideEvents Init="function(s, e) {
   $(&quot;#popupAuditEdit_txtAudit&quot;).val(&quot;&quot;);
}" />
                <FooterStyle>
                    <Paddings Padding="5px" />
                </FooterStyle>
                <FooterTemplate>
                    <dx:ASPxMenu ID="mnuToolBar" runat="server" EnableTheming="True" Theme="Aqua" ShowAsToolbar="True" OnItemClick="mnuToolBar_ItemClick1">
                        <ClientSideEvents ItemClick="function(s, e) {
    var itemName = e.item.name;
	switch(itemName){
		case 'Cancel':
			popupAuditEdit.Hide();
            e.processOnServer = false;
			break;}
}" />
                        <Items>
                            <dx:MenuItem Name="Save" Text="保存">
                                <Image Url="~/images/save.gif">
                                </Image>
                            </dx:MenuItem>
                            <dx:MenuItem Name="Cancel" Text="取消">
                                <Image Url="~/images/close.gif">
                                </Image>
                            </dx:MenuItem>
                        </Items>
                    </dx:ASPxMenu>
                </FooterTemplate>
                <ContentCollection>
                    <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server" SupportsDisabledAttribute="True">
                        
                            选择：<asp:DropDownList ID="DropDownList2" runat="server" width="100px">
                                <asp:ListItem Value="试卷系审核通过">通过</asp:ListItem>
                                <asp:ListItem Value="试卷系审核不通过">不通过</asp:ListItem>
                            </asp:DropDownList>
                            <br />
                            <br />
                        
                        
                            评语：<asp:TextBox ID="txtAudit" runat="server" Height="114px" TextMode="MultiLine" Width="100%"> </asp:TextBox>
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>

            <asp:SqlDataSource ID="sdsPaperAudit" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>" SelectCommand="SELECT DISTINCT Registration.ID AS RegistrationID, Course.course_no, Course.course_name, Course.course_class, State.StateName, Course.ID AS courseID, Course.teachingPlan, Course.course_dept, Teacher.Name FROM Registration INNER JOIN Course ON Registration.courseID = Course.ID INNER JOIN State ON Registration.state = State.ID INNER JOIN Teacher ON Course.course_teacherno = Teacher.Account INNER JOIN Paper ON Registration.PaperID = Paper.ID AND Course.ID = Paper.courseID WHERE (Course.course_profession LIKE @pro) AND (State.StateName LIKE '%试卷系待审%') AND (Paper.flag = '考试')">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtPro" Name="pro" PropertyName="Value" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:HiddenField ID="txtCourseID" runat="server" />

            <asp:HiddenField ID="txtCount" runat="server" />

            <asp:HiddenField ID="txtAccount" runat="server" />

            <asp:HiddenField ID="txtPro" runat="server" />
            <asp:HiddenField ID="txtTeacherID" runat="server" />

            <asp:HiddenField ID="txtRegID" runat="server" />

            <asp:HiddenField ID="txtCourseNo" runat="server" />
            <asp:HiddenField ID="txtAorB" runat="server" />
           

        <asp:HiddenField ID="txtCourseDept" runat="server" />

        <asp:HiddenField ID="txtTeachingPlan" runat="server" />
           

            <br />
        <dx:ASPxPopupControl ID="popupRegistration" runat="server" AllowDragging="True" CloseAction="CloseButton" HeaderText="查看" Height="544px" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Theme="Aqua" Width="841px" AllowResize="True">
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

        </div>
    </form>
</body>
</html>
