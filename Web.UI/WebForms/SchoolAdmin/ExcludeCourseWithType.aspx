<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ExcludeCourseWithType.aspx.cs" Inherits="WebForms_SchoolAdministrator_ExcludeCourseWithType" %>
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
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>
        <div>
            <h2>类别排查</h2>
            <p>
                <asp:CheckBox ID="chkIsNull" runat="server" Text="排查类型为空" />
                &nbsp;<asp:CheckBox ID="chkIsNotNull" runat="server" Text="排查类型不为空" />
            </p>
            <fieldset>
                <legend>选择类别</legend>
                <p>
                    校区：<asp:DropDownList ID="cboSchool" runat="server" AppendDataBoundItems="True" AutoPostBack="false" DataSourceID="sdsCampus" DataTextField="class_campus" DataValueField="class_campus" Width="127px">
                        <asp:ListItem Value="%">【全部】</asp:ListItem>
                    </asp:DropDownList>
                    &nbsp;&nbsp;
                 类型要求：<asp:DropDownList ID="cboType" runat="server" AppendDataBoundItems="True" DataSourceID="SqlExcludeType" DataTextField="exclude_type" DataValueField="exclude_SQL" Width="127px">
                     <asp:ListItem Value="%">【全部】</asp:ListItem>
                 </asp:DropDownList>
                    &nbsp;&nbsp;
                    <asp:LinkButton ID="LinkButtonSearch" runat="server" OnClick="LinkButtonSearch_Click">检索</asp:LinkButton>
                    &nbsp;&nbsp;&nbsp;&nbsp;
                </p>
            </fieldset>
                <dx:ASPxMenu ID="mnuMain" runat="server" BackColor="White" EnableTheming="True" ShowAsToolbar="True" Theme="Default">
                    <ClientSideEvents ItemClick="function(s, e) {
    var itemName = e.item.name;
	switch(itemName){
		case 'Exclude':
            popupEdit.Show();  
			break;}
}" />
                    <Paddings PaddingBottom="5px" PaddingTop="8px" />
                    <Items>
                        <dx:MenuItem Text="修改类型" Name="Exclude" BeginGroup="True">
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
            <asp:Panel ID="Panel1" runat="server"  Width="2500">
                <p>
                 <asp:CheckBox ID="CheckBox" runat="server" AutoPostBack="True" OnCheckedChanged="CheckBox_CheckedChanged" Text="全选" />
                    </p>
                <cc1:MyGridView ID="gvExCourse" runat="server" AutoGenerateColumns="False" CssClass="dataTable" DataSourceID="sdsExCourse" AllowPaging="True" AllowSorting="True" EmptyDataText="没有找到任何数据！" PageSize="400">
                    <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
                    <Columns>
                        <asp:TemplateField HeaderText="选择" ShowHeader="False">
                            <ItemTemplate>
                                <asp:CheckBox ID="CheckBox" runat="server" AutoPostBack="false" />
                                <asp:Label ID="ID" runat="server" Text='<%# Bind("ID") %>' Visible="false"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="teachingPlan" HeaderText="教学计划" SortExpression="teachingPlan" />
                        <asp:BoundField DataField="type" HeaderText="排查类型" SortExpression="type" />
                        <asp:BoundField DataField="course_dept" HeaderText="开课学院" SortExpression="course_dept" />
                        <asp:BoundField DataField="course_name" HeaderText="课程名" SortExpression="course_name" />
                        <asp:BoundField DataField="course_serialNum" HeaderText="课序号" SortExpression="course_serialNum" />
                        <asp:BoundField DataField="course_type" HeaderText="课程类别" SortExpression="course_type" />
                        <asp:BoundField DataField="course_teacher" HeaderText="教师" SortExpression="course_teacher" />
                        <asp:BoundField DataField="course_credit" HeaderText="学分" SortExpression="course_credit" />
                        <asp:BoundField DataField="totalHours_teaching" HeaderText="授课学时" SortExpression="totalHours_teaching" />
                        <asp:BoundField DataField="totalHours_experiment" HeaderText="实验学时" SortExpression="totalHours_experiment" />
                        <asp:BoundField DataField="totalHours_pratice" HeaderText="实践学时" SortExpression="totalHours_pratice" />
                        <asp:BoundField DataField="totalHours_computer" HeaderText="上机学时" SortExpression="totalHours_computer" />
                        <asp:BoundField DataField="totalHours_outsideClass" HeaderText="课外学时" SortExpression="totalHours_outsideClass" />
                        <asp:BoundField DataField="totalHours" HeaderText="总学时" SortExpression="totalHours" />
                        <asp:BoundField DataField="class_time" HeaderText="上课时间" SortExpression="class_time" />
                        <asp:BoundField DataField="class_location" HeaderText="上课地点" SortExpression="class_location" />
                        <asp:BoundField DataField="class_class" HeaderText="上课班级" SortExpression="class_class" />
                        <asp:BoundField DataField="class_campus" HeaderText="校区" SortExpression="class_campus" />
                        <asp:BoundField DataField="course_attribute" HeaderText="课程属性" SortExpression="course_attribute" />
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
            <dx:ASPxPopupControl ID="popupEdit" runat="server" CloseAction="CloseButton" HeaderText="选择类别信息" Height="139px" Modal="True" ShowFooter="True" Theme="Aqua" Width="367px" PopupAnimationType="Fade" ShowCloseButton="False" ClientInstanceName="popupEdit" AllowDragging="True" Left="80" Top="100">
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
			popupEdit.Hide();
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
                        <p>
                            类型名称：<asp:DropDownList ID="cboType0" runat="server" DataSourceID="sdsExcludeType" DataTextField="exclude_type" DataValueField="exclude_value"></asp:DropDownList>
                        </p>
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>
            <asp:SqlDataSource ID="sdsExcludeType" runat="server" ConnectionString="<%$ ConnectionStrings:CheckConnStr %>" SelectCommand="SELECT [exclude_type], [exclude_value] FROM [ExcludeType]"></asp:SqlDataSource>
            <asp:SqlDataSource ID="sdsExCourse" runat="server" ConnectionString="<%$ ConnectionStrings:CheckConnStr %>" SelectCommand="SELECT * FROM [ExaminationCourse]"></asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlExcludeType" runat="server" ConnectionString="<%$ ConnectionStrings:CheckConnStr %>" SelectCommand="SELECT * FROM [ExcludeType]"></asp:SqlDataSource>
            <asp:SqlDataSource ID="sdsCampus" runat="server" ConnectionString="<%$ ConnectionStrings:CheckConnStr %>" SelectCommand="SELECT distinct  [class_campus] FROM [ExaminationCourse]"></asp:SqlDataSource>

            <asp:HiddenField ID="txtCount" runat="server" />

        </div>
    </form>
</body>
</html>
