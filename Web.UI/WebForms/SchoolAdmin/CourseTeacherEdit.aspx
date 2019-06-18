<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CourseTeacherEdit.aspx.cs" Inherits="WebForms_SchoolAdmin_CourseTeacherEdit" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="Infrastructure" Namespace="Infrastructure.Controls" TagPrefix="cc1" %>
<%@ Register Src="~/UserControls/MessageBoxControl.ascx" TagPrefix="uc2" TagName="MessageBoxControl" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../../css/style.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <h2>课程教师编辑</h2>
        

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
                        <dx:MenuItem Text="添加教师" Name="Add" BeginGroup="True">
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
                <cc1:MyGridView ID="gvExCourse" runat="server" AutoGenerateColumns="False" CssClass="dataTable" DataSourceID="sdsCourseSeriesTeacher" AllowPaging="True" AllowSorting="True" EmptyDataText="没有找到任何数据！" PageSize="20" DataKeyNames="course_no" OnRowCommand="gvExCourse_RowCommand">
                    <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
                    <Columns>
                        <asp:TemplateField HeaderText="course_no" InsertVisible="False" Visible="false" SortExpression="course_no">
                        <ItemTemplate>
                            <asp:Label ID="lblcourse_no" runat="server" Text='<%# Bind("course_no") %>' Visible="false"></asp:Label>
                            <asp:Label ID="lbcourse_seriesno" runat="server" Text='<%# Bind("course_seriesno") %>' Visible="false"></asp:Label>
                            <asp:Label ID="lbcourse_teacherno" runat="server" Text='<%# Bind("course_teacherno") %>' Visible="false"></asp:Label>
			    <asp:Label ID="lbcourse_teachername" runat="server" Text='<%# Bind("course_teachername") %>' Visible="false"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                        <asp:BoundField DataField="course_no" HeaderText="课程号" SortExpression="course_no" ReadOnly="True" />
                        <asp:BoundField DataField="course_name" HeaderText="课程名" SortExpression="course_name" />
                        <asp:BoundField DataField="course_seriesno" HeaderText="课序号" SortExpression="course_seriesno" />
                        <asp:BoundField DataField="course_teachername" HeaderText="教师" SortExpression="course_teachername" />
                         <asp:ButtonField CommandName="EditTeacher" HeaderText="编辑" Text="编辑" />
                        <asp:ButtonField CommandName="DeleteTeacher" HeaderText="删除" Text="删除" />
                    </Columns>
                    <EditRowStyle CssClass="highlightRow"></EditRowStyle>
                    <HeaderStyle CssClass="headerRow"></HeaderStyle>
                    <PagerSettings FirstPageText="首页" LastPageText="尾页" NextPageText="下一页" PreviousPageText="上一页">
                    </PagerSettings>
                    <PagerStyle CssClass="pagerRow"></PagerStyle>
                    <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
                </cc1:MyGridView>
            </asp:Panel>
            &nbsp;&nbsp;<uc2:messageboxcontrol runat="server" ID="MsgBox" />
            <br />

            <dx:ASPxPopupControl ID="popupAdd" runat="server" CloseAction="CloseButton" HeaderText="添加" Height="188px" Modal="True" ShowFooter="True" Theme="Aqua" Width="350px" PopupAnimationType="Fade" ShowCloseButton="False" ClientInstanceName="popupAdd" AllowDragging="True" Left="80" Top="100">
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
                        
                            教师名称：<asp:TextBox ID="txtTeacherName" runat="server"></asp:TextBox>
                        <br />
                            <br />
                            <br />
                            教&nbsp; 师 号：<asp:TextBox ID="txtTeacherNo" runat="server"></asp:TextBox>
                        
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>

            <dx:ASPxPopupControl ID="popupEdit" runat="server" CloseAction="CloseButton" HeaderText="编辑" Height="188px" Modal="True" ShowFooter="True" Theme="Aqua" Width="392px" PopupAnimationType="Fade" ShowCloseButton="False" ClientInstanceName="popupEdit" AllowDragging="True" Left="80" Top="100">
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
                        
                            教师名称：<asp:TextBox ID="txtTeacherName0" runat="server"></asp:TextBox>
                        
                        
                            <br />
                            <br />
                            <br />
                            教&nbsp; 师 号：<asp:TextBox ID="txtTeacherNo0" runat="server"></asp:TextBox>
                            <asp:HiddenField ID="txtCourse_no" runat="server" />
                            <asp:HiddenField ID="txtCourse_seriesno" runat="server" />
                            <asp:HiddenField ID="txtCourse_teacherno" runat="server" />
                            <asp:HiddenField ID="txtCourse_teachername" runat="server" />
                       
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>
                <br />
            <asp:SqlDataSource ID="sdsCourseSeriesTeacher" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>" SelectCommand="SELECT CourseSeriesTeacher.course_no, CourseSeriesTeacher.course_seriesno, CourseSeriesTeacher.course_teacherno, CourseSeriesTeacher.course_teachername, ExaminationCourse.course_name FROM CourseSeriesTeacher INNER JOIN ExaminationCourse ON CourseSeriesTeacher.course_no = ExaminationCourse.course_no AND CourseSeriesTeacher.course_seriesno = ExaminationCourse.course_serialno WHERE (CourseSeriesTeacher.course_no LIKE @course_no) AND (CourseSeriesTeacher.course_seriesno LIKE @course_seriesno)">
                <SelectParameters>
                    <asp:QueryStringParameter Name="course_no" QueryStringField="course_no" />
                    <asp:QueryStringParameter Name="course_seriesno" QueryStringField="course_seriesno" />
                </SelectParameters>
            </asp:SqlDataSource>

                <asp:SqlDataSource ID="sdsCollege" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>" SelectCommand="SELECT DISTINCT course_dept FROM Course"></asp:SqlDataSource>

            <asp:HiddenField ID="txtCount" runat="server" />

            </div>
    </form>
</body>
</html>

