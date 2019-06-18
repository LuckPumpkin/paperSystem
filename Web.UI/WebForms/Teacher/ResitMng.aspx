<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ResitMng.aspx.cs" Inherits="WebForms_Teacher_ResitMng" %>
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
    <script src="../../My97DatePicker/WdatePicker.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div>

        <h2>补考信息填报</h2>
         <div style="text-align:center;">
           <asp:LinkButton ID="btnrefresh" runat="server" OnClick="refresh_Click"></asp:LinkButton>
        <cc1:MyGridView ID="gvResit" runat="server" CssClass="dataTable" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False"  DataKeyNames="course_no"  DataSourceID="SqlDataSource1" OnRowCommand="gvResit_RowCommand" EmptyDataText="没有找到任何数据！" >
                <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
                <Columns>             
                    <asp:TemplateField HeaderText="Reg_id" InsertVisible="False" Visible="false" SortExpression="course_no">
                        <ItemTemplate>
                            <asp:Label ID="lbpaperID" runat="server" Text='<%# Eval("paperID") %>' Visible="False"></asp:Label>
                            <asp:Label ID="lb_paper_num" runat="server" Text='<%# Eval("paper_num") %>' Visible="False"></asp:Label>
                            <asp:Label ID="lb_whitePaper_num" runat="server" Text='<%# Eval("whitePaper_num") %>' Visible="False"></asp:Label>
                            <asp:Label ID="lb_paper_copyNum" runat="server" Text='<%# Eval("paper_copyNum") %>' Visible="False"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="course_no" HeaderText="课程号" SortExpression="course_no"  />
                    <asp:BoundField DataField="course_name" HeaderText="课程名" SortExpression="course_name"/>
                    <asp:BoundField DataField="paper_AorB" HeaderText="试卷类型" SortExpression="paper_AorB" />
                    <asp:BoundField DataField="paper_num" HeaderText="试卷张数" SortExpression="paper_num" />
                    <asp:BoundField DataField="whitePaper_num" HeaderText="白纸张数" SortExpression="whitePaper_num" />
                    <asp:BoundField DataField="paper_copyNum" HeaderText="试卷份数" SortExpression="paper_copyNum" />
                    <asp:BoundField DataField="getTime" HeaderText="交付时间" SortExpression="getTime" />
                    <asp:ButtonField CommandName="ResitEdit" HeaderText="补考信息编辑" Text="编辑" />                             
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
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>" SelectCommand="SELECT Course.course_no, Course.course_name, Paper.getTime, Paper.submitTime, Paper.flag, Paper.paper_AorB, Paper.courseID, Paper.ID AS paperID, Paper.paper_num, Paper.whitePaper_num, Paper.paper_copyNum FROM Course INNER JOIN Paper ON Course.ID = Paper.courseID WHERE (Course.course_teacherno LIKE @account) AND (Paper.paper_copyNum IS NOT NULL) AND (Paper.paper_state LIKE '%试卷草稿%') AND (Paper.flag LIKE '补考')">
            <SelectParameters>
                <asp:ControlParameter ControlID="txtAccount" Name="account" PropertyName="Value" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
        <asp:HiddenField ID="txtAccount" runat="server" />
        <asp:HiddenField ID="txtTeacherId" runat="server" />
        <br />
        <dx:ASPxPopupControl ID="popupResit" runat="server" AllowDragging="True" CloseAction="CloseButton" HeaderText="编辑" Height="350px" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Theme="Aqua" Width="800px" AllowResize="True">
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
                <uc1:MessageBoxControl ID="MsgBox" runat="server" />

        <asp:HiddenField ID="txtPaperID" runat="server" />

        <dx:ASPxPopupControl ID="popupState" runat="server" CloseAction="CloseButton" HeaderText="提交" Height="139px" Modal="True" ShowFooter="True" Theme="Aqua" Width="367px" PopupAnimationType="Fade" ShowCloseButton="False" ClientInstanceName="popupState" AllowDragging="True" Left="80" Top="100">
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
			popupState.Hide()
            e.processOnServer = false;
			break;}
}" />
                    <Items>
                        <dx:MenuItem Name="Save" Text="确定">
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
                <dx:PopupControlContentControl ID="PopupControlContentControl2" runat="server" SupportsDisabledAttribute="True">
                    您提交的试卷页数或白纸张数已超上限，确定要提交吗？
                </dx:PopupControlContentControl>
            </ContentCollection>
        </dx:ASPxPopupControl>
    </form>
</body>
</html>
