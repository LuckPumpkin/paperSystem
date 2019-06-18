<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CourseMng.aspx.cs" Inherits="WebForms_SchoolAdmin_CourseMng" MaintainscrollPositionOnPostback = "true"%>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="Infrastructure" Namespace="Infrastructure.Controls" TagPrefix="cc1" %>
<%@ Register Src="~/UserControls/MessageBoxControl.ascx" TagPrefix="uc2" TagName="MessageBoxControl" %>
<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxPopupControl" TagPrefix="dxpc" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../../css/style.css" rel="stylesheet" />
    <style type="text/css">
        .dxmLite {
            font: 12px Tahoma, Geneva, sans-serif;
        }
        div#popupMsg_PW-1,div#popupEdit_DXPWMB-1,div#popupEdit_PW-1,div#MsgBox_MessageBoxPopupControl_PW-1{
	    position:fixed!important;
	}
    </style>
    <%--<script>
        function refresh() {
            gvExCourse.DataBind();
        }
    </script>--%>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2>课程管理</h2>
            <fieldset>
                <legend>查询条件</legend>
                <p>
                    开课学院：<asp:DropDownList ID="DropDownListCollege" runat="server" AppendDataBoundItems="True" DataSourceID="sdsCollege" DataTextField="course_dept" DataValueField="course_dept" style="height:23px;">
                         <asp:ListItem Value="管理学院" Selected="True">--------请选择--------</asp:ListItem>
                         <asp:ListItem Value="%">【全部】</asp:ListItem>
                    </asp:DropDownList>
                    &nbsp;
                </p>
                <p>
                    课程名：<asp:TextBox ID="txtCourseName" runat="server"></asp:TextBox>
                    &nbsp;&nbsp;课程号：<asp:TextBox ID="txtCourseNum" runat="server" Width="109px"></asp:TextBox>
                    &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;
                    <asp:LinkButton ID="btnSearch" runat="server" OnClick="btnSearch_Click">检索</asp:LinkButton>
                </p>
            </fieldset>
            <dx:ASPxMenu ID="mnuMain" runat="server" BackColor="White" EnableTheming="True" ShowAsToolbar="True" Theme="Default" Height="31px" ClientInstanceName="mnuMain" OnItemClick="mnuMain_ItemClick1">
                <Paddings PaddingBottom="5px" PaddingTop="8px" />
                <Items>
                    <dx:MenuItem  Text="添加课程" Name="Add"  BeginGroup="True" >
                        <Image Url="~/images/new.gif">
                        </Image>
                    </dx:MenuItem>
                    <dx:MenuItem Text="刷新表单" Name="shuaxin" BeginGroup="True"  >
                        <Image Url="~/images/refresh.png">
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
            <cc1:MyGridView ID="gvExCourse" runat="server" AutoGenerateColumns="False" CssClass="dataTable" DataSourceID="sdsCourse" AllowPaging="True" ClientInstanceName="gvExCourse" AllowSorting="True" EmptyDataText="没有找到任何数据！" PageSize="200" DataKeyNames="course_no" OnRowCommand="gvCourse_RowCommand">
                <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
                <Columns>
                    <asp:TemplateField HeaderText="course_no" InsertVisible="False" Visible="false" SortExpression="course_no">
                        <ItemTemplate>
                            <asp:Label ID="lblID" runat="server" Text='<%# Bind("ID") %>' Visible="false"></asp:Label>
                            <asp:Label ID="lblcourse_no" runat="server" Text='<%# Bind("course_no") %>' Visible="false"></asp:Label>
                            <asp:Label ID="lblcourse_seriesno" runat="server" Text='<%# Bind("course_serialno") %>' Visible="false"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="course_no" HeaderText="课程号" SortExpression="course_no" ReadOnly="True" />
                    <asp:BoundField DataField="course_name" HeaderText="课程名" SortExpression="course_name" />
                    <asp:BoundField DataField="course_serialno" HeaderText="课序号" SortExpression="course_serialno" />
                    <asp:BoundField DataField="course_type" HeaderText="课程类型" SortExpression="course_type" />
                    <asp:BoundField DataField="teacherName" HeaderText="教师" SortExpression="teacherName" />
                    <asp:BoundField DataField="class" HeaderText="班级" />
                    <asp:BoundField DataField="course_attribute" HeaderText="课程属性" SortExpression="course_attribute" />
                    <asp:ButtonField CommandName="EditCourse" HeaderText="编辑课程" Text="编辑课程" />
                    <asp:ButtonField CommandName="EditTeacher" HeaderText="编辑老师" Text="编辑老师" />
                    <asp:ButtonField CommandName="EditClass" HeaderText="编辑班级" Text="编辑班级" />
                    <asp:ButtonField CommandName="DeleteCourse" HeaderText="删除" Text="删除" />
                </Columns>
                <EditRowStyle CssClass="highlightRow"></EditRowStyle>
                <HeaderStyle CssClass="headerRow"></HeaderStyle>
                <PagerSettings FirstPageText="首页" LastPageText="尾页" NextPageText="下一页" PreviousPageText="上一页"></PagerSettings>
                <PagerStyle CssClass="pagerRow"></PagerStyle>
                <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
            </cc1:MyGridView>



            <dx:ASPxPopupControl ID="popupMsg" runat="server" CloseAction="CloseButton" HeaderText="消息" Height="130px" Modal="True" ShowFooter="True" Theme="Aqua" Width="347px" PopupAnimationType="Fade" ShowCloseButton="False" ClientInstanceName="popupMsg" AllowDragging="True" Left="80" Top="100">
                <FooterStyle>
                    <Paddings Padding="5px" />
                </FooterStyle>
                <FooterTemplate>
                    <dx:ASPxMenu ID="mnuMsg" runat="server" EnableTheming="True" Theme="Aqua" ShowAsToolbar="True" OnItemClick="mnuMsg_ItemClick">
                        <ClientSideEvents ItemClick="function(s, e) {
    var itemName = e.item.name;
	switch(itemName){
		case 'Cancel':
			popupMsg.Hide();
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


                        <asp:Image ID="imgMessageBoxIcon" runat="server" ImageAlign="Middle" ImageUrl="~/images/exclamation_icon.png"
                            Width="40px" />

                        <asp:Label ID="lblMessageBoxMsg" runat="server" Text="         确定要删除该课程吗？"></asp:Label>

                    </dx:PopupControlContentControl>

                </ContentCollection>
            </dx:ASPxPopupControl>




            <dx:ASPxPopupControl ID="popupEdit" runat="server" AllowDragging="True" CloseAction="CloseButton" HeaderText="编辑" Height="472px" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Theme="Aqua" Width="883px">
                <ClientSideEvents CloseUp="function(s, e) {
	__doPostBack('btnRefresh','');
}" />
                        <ContentCollection>
                    <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server" SupportsDisabledAttribute="True">
                        <br />
                        <br />
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>




            <dx:ASPxPopupControl ID="popupAdd" runat="server" AllowDragging="True" CloseAction="CloseButton" HeaderText="添加" Height="472px" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Theme="Aqua" Width="883px">
                <ClientSideEvents CloseUp="function(s, e) {
	__doPostBack('btnRefresh','');
}" />
                        <ContentCollection>
                    <dx:PopupControlContentControl ID="PopupControlContentControl3" runat="server" SupportsDisabledAttribute="True">
                        <br />
                        <br />
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>


            <br />
            <asp:SqlDataSource ID="sdsCourse" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>" SelectCommand="SELECT dbo.AggregateTeacherNoFromSeries(course_no, course_serialno) AS teacherNo, dbo.AggregateTeacherNameFromSeries(course_no, course_serialno) AS teacherName, course_dept, course_name, course_attribute, course_type, course_no, course_serialno, CommonOrPrivate, PrivateCollege, class_campus, ID, dbo.ClassInAna(course_no, course_serialno) AS class FROM ExaminationCourse GROUP BY ID, course_no, course_serialno, course_dept, course_name, course_attribute, course_type, CommonOrPrivate, PrivateCollege, class_campus, ID HAVING (course_name LIKE '%' + @course_name + '%') AND (course_no LIKE @course_no) AND (course_dept LIKE @course_dept)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtCourseName" DefaultValue="%" Name="course_name" PropertyName="Text" />
                    <asp:ControlParameter ControlID="txtCourseNum" DefaultValue="%" Name="course_no" PropertyName="Text" />
                    <%--                        <asp:ControlParameter ControlID="cboDept" Name="course_dept" PropertyName="SelectedValue" DefaultValue="%" />--%>
                    <asp:ControlParameter ControlID="DropDownListCollege" DefaultValue="%" Name="course_dept" PropertyName="SelectedValue" />

                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="sdsCollege" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>" SelectCommand="SELECT DISTINCT course_dept FROM Course"></asp:SqlDataSource>

            <asp:HiddenField ID="txtCount" runat="server" />
            <uc2:MessageBoxControl ID="MsgBox" runat="server" />
            <br />
            <asp:HiddenField ID="txtCourseNo" runat="server" />
            <asp:HiddenField ID="txtExamCourseID" runat="server" />
            <asp:HiddenField ID="txtCourse_seriesno" runat="server" />
        </div>
    </form>
</body>
</html>

