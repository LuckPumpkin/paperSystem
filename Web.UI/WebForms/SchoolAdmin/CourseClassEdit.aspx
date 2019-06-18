<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CourseClassEdit.aspx.cs" Inherits="WebForms_SchoolAdmin_CourseClassEdit" %>

<%@ Register assembly="Infrastructure" namespace="Infrastructure.Controls" tagprefix="cc1" %>

<%@ Register src="../../UserControls/MessageBoxControl.ascx" tagname="messageboxcontrol" tagprefix="uc2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link href="../../css/style.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <h2>课程班级编辑</h2>
        
   
                <dx:ASPxMenu ID="mnuMain" runat="server" BackColor="White" EnableTheming="True" ShowAsToolbar="True" Theme="Default" Height="31px">
                    <ClientSideEvents ItemClick="function(s, e) {
    var itemName = e.item.name;
	switch(itemName){
		case 'Add':
            popupAdd.Show();  
			break;}
}" />
                    <Paddings PaddingBottom="5px" PaddingTop="8px" />
                    <Items>
                        <dx:MenuItem Text="添加班级" Name="Add" BeginGroup="True">
                            <Image Url="~/images/new.gif">
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
         <br />
            <asp:Panel ID="Panel1" runat="server"  >
                <cc1:MyGridView ID="gvExCourse" runat="server" AutoGenerateColumns="False" CssClass="dataTable" DataSourceID="sdsCourseSeriesClass" AllowPaging="True" AllowSorting="True" EmptyDataText="没有找到任何数据！" PageSize="20" DataKeyNames="course_no" OnRowCommand="gvExCourse_RowCommand">
                    <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
                    <Columns>
                        <asp:TemplateField HeaderText="course_no" InsertVisible="False" Visible="false" SortExpression="course_no">
                        <ItemTemplate>
                            <asp:Label ID="lblcourse_no" runat="server" Text='<%# Bind("course_no") %>' Visible="false"></asp:Label>
                            <asp:Label ID="lbcourse_seriesno" runat="server" Text='<%# Bind("course_seriesno") %>' Visible="false"></asp:Label>
                            <asp:Label ID="lbcourse_class" runat="server" Text='<%# Bind("course_class") %>' Visible="false"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                        <asp:BoundField DataField="course_no" HeaderText="课程号" SortExpression="course_no" ReadOnly="True" />
                        <asp:BoundField DataField="course_name" HeaderText="课程名" SortExpression="course_name" />
                        <asp:BoundField DataField="course_seriesno" HeaderText="课序号" SortExpression="course_seriesno" />
                        <asp:BoundField DataField="course_class" HeaderText="班级" SortExpression="course_class" />
                         <asp:ButtonField CommandName="EditClass" HeaderText="编辑" Text="编辑" />
                        <asp:ButtonField CommandName="DeleteClass" HeaderText="删除" Text="删除" />
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
    &nbsp;
        <br />
        <uc2:messageboxcontrol runat="server" ID="MsgBox" />
            <br />

            <dx:ASPxPopupControl ID="popupAdd" runat="server" CloseAction="CloseButton" HeaderText="添加" Height="133px" Modal="True" ShowFooter="True" Theme="Aqua" Width="350px" PopupAnimationType="Fade" ShowCloseButton="False" ClientInstanceName="popupAdd" AllowDragging="True" Left="80" Top="100">
                <HeaderImage Url="~/images/new.gif">
                </HeaderImage>
                <FooterStyle>
                    <Paddings Padding="5px" />
                </FooterStyle>
                <FooterTemplate>
                    <dx:ASPxMenu ID="mnuAdd" runat="server" EnableTheming="True" Theme="Aqua" ShowAsToolbar="True" OnItemClick="mnuAdd_ItemClick">
                        <ClientSideEvents ItemClick="function(s, e) {
    var itemName = e.item.name;
	switch(itemName){
		case 'Cancel':
			popupAdd.Hide();
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
                        
                            班级名称：<asp:TextBox ID="txtClass" runat="server"></asp:TextBox>
                       
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>

            <br />

            <dx:ASPxPopupControl ID="popupEdit" runat="server" CloseAction="CloseButton" HeaderText="编辑" Height="149px" Modal="True" ShowFooter="True" Theme="Aqua" Width="353px" PopupAnimationType="Fade" ShowCloseButton="False" ClientInstanceName="popupEdit" AllowDragging="True" Left="80" Top="100">
                <HeaderImage Url="~/images/edit.png">
                </HeaderImage>
                <FooterStyle>
                    <Paddings Padding="5px" />
                </FooterStyle>
                <FooterTemplate>
                    <dx:ASPxMenu ID="mnuEdit" runat="server" EnableTheming="True" Theme="Aqua" ShowAsToolbar="True" OnItemClick="mnuEdit_ItemClick">
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
                    <dx:PopupControlContentControl ID="PopupControlContentControl2" runat="server" SupportsDisabledAttribute="True">
                        
                            班级名称&nbsp;：<asp:TextBox ID="txtClass0" runat="server"></asp:TextBox>
                            <asp:HiddenField ID="txtCourse_no" runat="server" />
                            <asp:HiddenField ID="txtCourse_seriesno" runat="server" />
                            <asp:HiddenField ID="txtCourse_class" runat="server" />
                        
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>
                <br />
            <asp:SqlDataSource ID="sdsCourseSeriesClass" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>" SelectCommand="SELECT ExaminationCourse.course_name, CourseSeriesClass.course_no, CourseSeriesClass.course_seriesno, CourseSeriesClass.course_class FROM ExaminationCourse INNER JOIN CourseSeriesClass ON ExaminationCourse.course_no = CourseSeriesClass.course_no AND ExaminationCourse.course_serialno = CourseSeriesClass.course_seriesno WHERE (CourseSeriesClass.course_no LIKE @course_no) AND (CourseSeriesClass.course_seriesno LIKE @course_seriesno)">
                <SelectParameters>
                    <asp:QueryStringParameter Name="course_no" QueryStringField="course_no" />
                    <asp:QueryStringParameter Name="course_seriesno" QueryStringField="course_seriesno" />
                </SelectParameters>
            </asp:SqlDataSource>

                <asp:SqlDataSource ID="sdsCollege" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>" SelectCommand="SELECT DISTINCT course_dept FROM Course"></asp:SqlDataSource>

            <asp:HiddenField ID="txtCount" runat="server" />

    </form>
</body>
</html>
