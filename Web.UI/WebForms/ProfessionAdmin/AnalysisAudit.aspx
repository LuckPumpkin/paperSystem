<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AnalysisAudit.aspx.cs" Inherits="WebForms_ProfessionAdmin_AnalysisAudit1" %>

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
            <h2>试卷分析系审核</h2>
            
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
        
            <asp:CheckBox ID="CheckBox" runat="server" AutoPostBack="True" OnCheckedChanged="CheckBox_CheckedChanged" Text="全选" />
            <div style="text-align:center; width: 991px;">
            <asp:Panel ID="Panel1" runat="server" >
                <cc1:MyGridView ID="gvCourse"  runat="server"  AutoGenerateColumns="False" CssClass="dataTable" DataSourceID="sdsPaperAudit"  AllowPaging="True" AllowSorting="True" EmptyDataText="没有找到任何数据！" pageSize="20" OnRowCommand="gvCourseall_RowCommand" DataKeyNames="AnalysisID" style="margin-top: 0px"  >
                    <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
                    <Columns>
                        <asp:TemplateField HeaderText="选择">
                            <ItemTemplate>
                             <asp:CheckBox ID="CheckBox" runat="server"  />
                                <asp:Label ID="lblAnalysisID" runat="server" Text='<%# Bind("AnalysisID") %>' Visible="false"></asp:Label>
                                <asp:Label ID="lblTeacher" runat="server" Text='<%# Bind("course_teacher") %>' Visible="false"></asp:Label>
                                <asp:Label ID="lblCourseNo" runat="server" Text='<%# Bind("course_no") %>' Visible="false"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="course_teacher" HeaderText="教师" SortExpression="course_teacher" />
                        <asp:BoundField DataField="course_name" HeaderText="试卷名称" SortExpression="course_name" />
                        <asp:BoundField DataField="StateName" HeaderText="审核状态" SortExpression="StateName" />
                        <asp:ButtonField CommandName="PaperAnalysis" HeaderText="试卷分析查看" Text="查看" />
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
            <dx:ASPxPopupControl ID="popupAuditEdit" runat="server" CloseAction="CloseButton" HeaderText="编辑评审" Height="208px" Modal="True" ShowFooter="True" Theme="Aqua" Width="332px" PopupAnimationType="Fade" ShowCloseButton="False" ClientInstanceName="popupAuditEdit" AllowDragging="True" Left="80" Top="100">
                <HeaderImage Url="~/images/edit.png">
                </HeaderImage>
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
                    <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server" SupportsDisabledAttribute="True" >
                        
                            选择：<asp:DropDownList ID="DropDownList2" runat="server" width="100px">
                                <asp:ListItem>通过</asp:ListItem>
                                <asp:ListItem>不通过</asp:ListItem>
                            </asp:DropDownList>
                        
                            <br />
                            <br />
                            评语：<asp:TextBox ID="txtAudit" runat="server" Height="114px" TextMode="MultiLine" Width="100%" ></asp:TextBox>
                        
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>

            <asp:SqlDataSource ID="sdsPaperAudit" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>" SelectCommand="SELECT DISTINCT ExaminationCourse.course_no, ExaminationCourse.course_name, ExaminationCourse.course_teacherno, ExaminationCourse.course_teacher, State.StateName, Analysis.ID AS AnalysisID FROM ExaminationCourse INNER JOIN Analysis ON ExaminationCourse.ID = Analysis.ExaminationCourseID INNER JOIN State ON Analysis.state = State.ID WHERE (State.StateName LIKE '试卷分析系待审')">
            </asp:SqlDataSource>

            <asp:HiddenField ID="txtCourseNo" runat="server" />

            <asp:HiddenField ID="txtCount" runat="server" />

            <asp:HiddenField ID="txtAccount" runat="server" />

            <asp:HiddenField ID="txtPro" runat="server" />
            <asp:HiddenField ID="txtTeacherID" runat="server" />

            <br />
        <dx:ASPxPopupControl ID="popupRegistration" runat="server" AllowDragging="True" CloseAction="CloseButton" HeaderText="查看分析表" Height="549px" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Theme="Aqua" Width="863px" AllowResize="True">
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
