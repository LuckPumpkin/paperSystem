<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TeacherAddMng.aspx.cs" Inherits="WebForms_Admin_TeacherAddMng" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="Infrastructure" Namespace="Infrastructure.Controls" TagPrefix="cc1" %>
<%@ Register Src="~/UserControls/MessageBoxControl.ascx" TagPrefix="uc2" TagName="MessageBoxControl" %>
<%@ Register Src="../../UserControls/MessageBoxControl.ascx" TagName="MessageBoxControl" TagPrefix="uc1" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="../../css/style.css" rel="stylesheet" />
    <script src="../../script/jquery.js" type="text/javascript"></script>

</head>
<body style="margin-left: 10px">
    <form id="form1" runat="server">
        <div>
            <h2>教师补充管理</h2>
            <br />
            <fieldset>
                <legend>查询条件<br />
                </legend>
                <p>
                    教师号： <asp:TextBox ID="txtCourseno" runat="server" style="margin-bottom: 0px"></asp:TextBox>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    教师名称： <asp:TextBox ID="txtCoursename" runat="server" style="margin-bottom: 0px"></asp:TextBox>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:LinkButton ID="btnSearch" runat="server" OnClick="btnSearch_Click">检索</asp:LinkButton>
                </p>
            </fieldset>
            
            <dx:ASPxMenu ID="mnuMain" runat="server" BackColor="White" EnableTheming="True" ShowAsToolbar="True" Theme="Default" OnItemClick="mnuMain_ItemClick">
                
                <Paddings PaddingBottom="5px" PaddingTop="8px" />
                <Items>
                    <dx:MenuItem Text="按开课学院将教师存入数据库" Name="Save" BeginGroup="True">
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
                            <br />
            <div style="overflow-x: visible">
                <div style="text-align: center">
                    <cc1:MyGridView ID="gvTeacher" runat="server" AutoGenerateColumns="False" CssClass="dataTable" DataSourceID="sdsTeacher" ClientInstanceName="grid" AllowSorting="True" EmptyDataText="没有找到任何数据！">
                        <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
                        <Columns>
                            <asp:BoundField DataField="PrivateCollege" HeaderText="" SortExpression="PrivateCollege" Visible="false" />
                            <asp:TemplateField Visible="false">
                                <ItemTemplate>
                                    <asp:Label ID="lblcourse_teacherno" runat="server" Text='<%# Bind("course_teacherno") %>' Visible="False"></asp:Label>
                                    <asp:Label ID="lblcourse_teachername" runat="server" Text='<%# Bind("course_teachername") %>' Visible="False"></asp:Label>
                                    <asp:Label ID="lbcollege" runat="server" Text='<%# Bind("course_dept") %>' Visible="False"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="course_no" HeaderText="课程号" SortExpression="course_no" />
                            <asp:BoundField DataField="course_name" HeaderText="课程名" SortExpression="course_name" />
                            <asp:BoundField DataField="course_teacherno" HeaderText="教师号" SortExpression="course_teacherno" />
                            <asp:BoundField DataField="course_teachername" HeaderText="教师名" SortExpression="course_teachername" />
                        </Columns>
                        <EditRowStyle CssClass="highlightRow"></EditRowStyle>
                        <HeaderStyle CssClass="FixedHeader"></HeaderStyle>
                        <PagerSettings FirstPageText="首页" LastPageText="尾页" NextPageText="下一页" PreviousPageText="上一页"></PagerSettings>
                        <PagerStyle CssClass="pagerRow"></PagerStyle>
                        <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
                    </cc1:MyGridView>
                </div>
            </div>
            <asp:SqlDataSource ID="sdsTeacher" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>"
                SelectCommand="SELECT DISTINCT CourseTeacher.course_no, CourseTeacher.course_teacherno, CourseTeacher.course_teachername, ExaminationCourse.course_name, ExaminationCourse.course_dept FROM CourseTeacher LEFT OUTER JOIN ExaminationCourse ON CourseTeacher.course_no = ExaminationCourse.course_no WHERE (CourseTeacher.course_teacherno NOT IN (SELECT DISTINCT Account FROM Teacher)) AND (CourseTeacher.course_teacherno LIKE @CourseTeacherno) AND (CourseTeacher.course_teachername LIKE '%' + @CourseTeachername + '%') ORDER BY CourseTeacher.course_teacherno">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtCourseno" DefaultValue="%" Name="CourseTeacherno" PropertyName="Text" />
                    <asp:ControlParameter ControlID="txtCoursename" DefaultValue="%" Name="CourseTeachername" PropertyName="Text" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="sdsCollege" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>" SelectCommand="SELECT BranchName, BranchID FROM Branch WHERE (ParentBranchID = 127)"></asp:SqlDataSource>
            <br />
        </div>
        <dx:ASPxPopupControl ID="popupSaveTeacher" runat="server" CloseAction="CloseButton" HeaderText="存入" Height="139px" Modal="True" ShowFooter="True" Theme="Aqua" Width="328px" PopupAnimationType="Fade" ShowCloseButton="False" ClientInstanceName="popupSaveTeacher" AllowDragging="True" Left="80" Top="100">
            <HeaderImage Url="~/images/edit.png">
            </HeaderImage>
            <FooterStyle>
                <Paddings Padding="5px" />
            </FooterStyle>
            <FooterTemplate>
                <dx:ASPxMenu ID="mnuToolBar1" runat="server" EnableTheming="True" Theme="Aqua" ShowAsToolbar="True" OnItemClick="mnuToolBar1_ItemClick">
                    <ClientSideEvents ItemClick="function(s, e) {
    var itemName = e.item.name;
	switch(itemName){
		case 'Cancel':
			popupSaveTeacher.Hide();
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
                <dx:PopupControlContentControl>
                    点击将此页面教师录入教师数据库！
                </dx:PopupControlContentControl>
            </ContentCollection>
        </dx:ASPxPopupControl>


        <uc1:MessageBoxControl ID="MsgBox" runat="server" />
    </form>
</body>
</html>
