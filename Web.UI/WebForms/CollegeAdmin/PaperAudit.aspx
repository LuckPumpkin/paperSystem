<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PaperAudit.aspx.cs" Inherits="WebForms_ProfessionAdmin_PaperAudit" %>

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
        top: 101px;
        display: inline-block;
        left: 50px;
    }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>
        <div>
            <h2>试卷院审查</h2><span class="span_px">
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
                <cc1:MyGridView ID="gvCourse" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CssClass="dataTable" DataSourceID="sdsPaperAudit" EmptyDataText="没有找到任何数据！" OnRowCommand="gvCourse_RowCommand" pageSize="20">
                    <AlternatingRowStyle CssClass="alternateRow" />
                    <Columns>
                        <asp:TemplateField HeaderText="选择" ShowHeader="False">
                            <ItemTemplate>
                                <asp:CheckBox ID="CheckBox" runat="server" AutoPostBack="false" />
                                <asp:Label ID="lblRegID" runat="server" Text='<%# Bind("RegistrationID") %>' Visible="False"></asp:Label>
                                <asp:Label ID="lblTeacher" runat="server" Text='<%# Bind("Name") %>' Visible="False"></asp:Label>
                                <asp:Label ID="lblCourseNo" runat="server" Text='<%# Bind("course_no") %>' Visible="False"></asp:Label>
                                <asp:Label ID="lbcourseID" runat="server" Text='<%# Eval("courseID") %>' Visible="False"></asp:Label>
                                <asp:Label ID="lbTeachingPlan" runat="server" Text='<%# Bind("teachingPlan") %>' Visible="False"></asp:Label>
                                <asp:Label ID="lbCourseDept" runat="server" Text='<%# Bind("course_dept") %>' Visible="False"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="course_no" HeaderText="课程号" SortExpression="course_no" />
                        <asp:BoundField DataField="course_name" HeaderText="课程名" SortExpression="course_name" />
                        <asp:BoundField DataField="Name" HeaderText="教师" SortExpression="Name" />
                        <asp:ButtonField CommandName="PrintRegistration" HeaderText="登记表打印" Text="打印" />
                   <%--     <asp:ButtonField CommandName="PrintDetail" HeaderText="细目表1打印" ShowHeader="True" Text="打印" />
                        <asp:ButtonField CommandName="PrintQuestiontype" HeaderText="细目表2打印" ShowHeader="True" Text="打印" />--%>
                    </Columns>
                    <EditRowStyle CssClass="highlightRow" />
                    <HeaderStyle CssClass="headerRow" />
                    <PagerSettings FirstPageText="首页" LastPageText="尾页" NextPageText="下一页" PreviousPageText="上一页" />
                    <PagerStyle CssClass="pagerRow" />
                    <SelectedRowStyle CssClass="selectedRow" />
                </cc1:MyGridView>
            </asp:Panel>
            &nbsp;&nbsp;<uc2:MessageBoxControl runat="server" ID="MsgBox" />
            <dx:ASPxPopupControl ID="popupAuditEdit" runat="server" CloseAction="CloseButton" HeaderText="编辑评审" Height="171px" Modal="True" ShowFooter="True" Theme="Aqua" Width="367px" PopupAnimationType="Fade" ShowCloseButton="False" ClientInstanceName="popupAuditEdit" AllowDragging="True" Left="80" Top="100">
                <HeaderImage Url="~/images/edit.png">
                </HeaderImage>
                <ClientSideEvents Init="function(s, e) {
   $(&quot;#popupAuditEdit_txtAudit&quot;).val(&quot;&quot;);
}" />
                <FooterStyle>
                    <Paddings Padding="5px" />
                </FooterStyle>
                <FooterTemplate>
                    <dx:ASPxMenu ID="mnuToolBar" runat="server" EnableTheming="True" Theme="Aqua" ShowAsToolbar="True" OnItemClick="mnuToolBar_ItemClick">
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
                       
                            选择：<asp:DropDownList ID="DropDownList2" runat="server" width="114px">
                                <asp:ListItem>通过</asp:ListItem>
                                <asp:ListItem>不通过</asp:ListItem>
                            </asp:DropDownList>
                            <br />
                        <br />
                       
                            评语：<asp:TextBox ID="txtAudit" runat="server" Height="114px" TextMode="MultiLine" Width="100%" ></asp:TextBox>
                        
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>

            <asp:SqlDataSource ID="sdsPaperAudit" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>" SelectCommand="SELECT DISTINCT Registration.ID AS RegistrationID, Course.course_no, Course.course_name, Course.course_class, Course.course_teacher, State.StateName, Teacher.College, [User].UserCode, Course.teachingPlan, Course.course_dept, Teacher.Name, Registration.courseID FROM [User] INNER JOIN Course ON [User].Account = Course.course_teacherno INNER JOIN Teacher ON [User].UserCode = Teacher.UserCode INNER JOIN State INNER JOIN Registration ON State.ID = Registration.state ON Course.ID = Registration.courseID INNER JOIN Paper ON Course.ID = Paper.courseID AND Registration.PaperID = Paper.ID WHERE (Teacher.College LIKE '%' + @College + '%') AND (State.StateName LIKE '%' + @StateName+ '%') AND (Paper.flag = '考试')">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtCollege" DefaultValue="" Name="College" PropertyName="Value" />
                    <asp:ControlParameter ControlID="txtStateName" DefaultValue="试卷学院待审" Name="StateName" PropertyName="Value" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:HiddenField ID="txtCourseNo" runat="server" />

            <asp:HiddenField ID="txtCount" runat="server" />

            <asp:HiddenField ID="txtAccount" runat="server" />

            <asp:HiddenField ID="txtStateName" runat="server" />

            <asp:HiddenField ID="txtCollege" runat="server" />
            <asp:HiddenField ID="txtTeacherID" runat="server" />

            <br />
        <dx:ASPxPopupControl ID="popupRegistration" runat="server" AllowDragging="True" CloseAction="CloseButton" HeaderText="打印" Height="546px" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Theme="Aqua" Width="685px">
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
