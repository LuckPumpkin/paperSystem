<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PaperAudit.aspx.cs" Inherits="WebForms_PrintAdmin_PaperAudit" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="Infrastructure" Namespace="Infrastructure.Controls" TagPrefix="cc1" %>
<%@ Register Src="~/UserControls/MessageBoxControl.ascx" TagPrefix="uc2" TagName="MessageBoxControl" %>
<%@ Register src="../../UserControls/MessageBoxControl.ascx" tagname="MessageBoxControl" tagprefix="uc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
         <link href="../../css/style.css" rel="stylesheet" />
    <script src="../../script/jquery.js" type="text/javascript"></script>
    <script src="../../script/GridLineHotTrack.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div>
        <h2>打印审核</h2>
         
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
        <div style="text-align:center">
         <cc1:MyGridView ID="gvCourse" runat="server" AutoGenerateColumns="False" CssClass="dataTable" DataSourceID="sdsPaperAudit" AllowPaging="True" AllowSorting="True" EmptyDataText="没有找到任何数据！" pageSize="20" OnRowCommand="gvCourse_RowCommand">
                <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>

                <Columns>
                    <asp:TemplateField HeaderText="选择" ShowHeader="False">
                        <ItemTemplate>
                            <asp:CheckBox ID="CheckBox" runat="server" AutoPostBack="false" />
                            <asp:Label ID="lblCourseNo" runat="server" Text='<%# Bind("course_no") %>' Visible="False"></asp:Label>
                            <asp:Label ID="lblregID" runat="server" Text='<%# Bind("regID") %>' Visible="False"></asp:Label>
                            <asp:Label ID="lbteacherplan" runat="server" Text='<%# Bind("teachingPlan") %>' Visible="False"></asp:Label>
                            <asp:Label ID="lbcourse_dept" runat="server" Text='<%# Bind("course_dept") %>' Visible="False"></asp:Label>
                             <asp:Label ID="lbCourseName" runat="server" Text='<%# Bind("course_name") %>' Visible="False"></asp:Label>
                            <asp:Label ID="lbPaperID" runat="server" Text='<%# Bind("PaperID") %>' Visible="False"></asp:Label>
                            <asp:Label ID="lbTeacher" runat="server" Text='<%# Bind("course_teacherno") %>' Visible="False"></asp:Label>
                            <asp:Label ID="lbpapertype" runat="server" Text='<%# Bind("paper_AorB") %>' Visible="False"></asp:Label>
                            <asp:Label ID="lbcourseID" runat="server" Text='<%# Eval("courseID") %>' Visible="False"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField HeaderText="课程号" DataField="course_no" SortExpression="course_no" />
                    <asp:BoundField HeaderText="课程名" DataField="course_name" SortExpression="course_name" />
                    <asp:BoundField HeaderText="试卷类型" DataField="flag" SortExpression="flag" />
                    <asp:BoundField HeaderText="卷子页数" DataField="paper_num" SortExpression="paper_num" />
                    <asp:BoundField HeaderText="附白纸数" DataField="whitePaper_num" SortExpression="whitePaper_num" />
                    <asp:BoundField HeaderText="印制份数" DataField="Paper_copyNum" SortExpression="Paper_copyNum" />
                    <%--<asp:ButtonField HeaderText="样卷打印" Text="打印" CommandName="PDF" />    --%>  
                    
                </Columns>
                <EditRowStyle CssClass="highlightRow"></EditRowStyle>
                <HeaderStyle CssClass="headerRow"></HeaderStyle>
                <PagerSettings FirstPageText="首页" LastPageText="尾页" NextPageText="下一页" PreviousPageText="上一页">
                </PagerSettings>
                <PagerStyle CssClass="pagerRow"></PagerStyle>
                <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
            </cc1:MyGridView>
            
           </div>   
                
        <asp:SqlDataSource ID="sdsPaperAudit" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>" SelectCommand="SELECT Course.course_no, Course.course_name, Paper.paper_num, Paper.whitePaper_num, Paper.paper_copyNum, Paper.ID AS PaperID, Paper.flag, Course.teachingPlan, Course.course_dept, Course.course_teacherno, Paper.paper_AorB, Registration.ID AS regID, Course.ID AS courseID FROM Course INNER JOIN Paper ON Course.ID = Paper.courseID INNER JOIN Registration ON Paper.ID = Registration.PaperID WHERE (Paper.flag LIKE '考试') AND (Paper.paper_state LIKE '%试卷印刷部待审%')"></asp:SqlDataSource>
            
           
                
    </div>
        <uc2:MessageBoxControl runat="server" ID="MsgBox" />
        <br />
            <dx:ASPxPopupControl ID="popupAuditEdit" runat="server" CloseAction="CloseButton" HeaderText="编辑评审" Height="141px" Modal="True" ShowFooter="True" Theme="Aqua" Width="329px" PopupAnimationType="Fade" ShowCloseButton="False" ClientInstanceName="popupAuditEdit" AllowDragging="True" Left="80" Top="100">
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
                    <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server" SupportsDisabledAttribute="True">
                        
                            选择：<asp:DropDownList ID="DropDownList2" runat="server" width="100px">
                                <asp:ListItem Value="通过">通过</asp:ListItem>
                                <asp:ListItem Value="不通过">不通过</asp:ListItem>
                            </asp:DropDownList>
                        
                        
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>

       

             <dx:ASPxPopupControl ID="popupPDF" runat="server" AllowDragging="True" CloseAction="CloseButton" HeaderText="打印样卷" Height="600px" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Theme="Aqua" Width="1000px" AllowResize="True">
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
