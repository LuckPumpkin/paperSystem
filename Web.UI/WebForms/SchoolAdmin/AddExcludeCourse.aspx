﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddExcludeCourse.aspx.cs" Inherits="WebForms_SchoolAdministrator_AddExcludeCourse" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="Infrastructure" Namespace="Infrastructure.Controls" TagPrefix="cc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc2" %>
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
            <h2>添加课程</h2>
            <p>
                <asp:CheckBox ID="chkIsNull" runat="server" Text="排查类型为空" />
                &nbsp;<asp:CheckBox ID="chkIsNotNull" runat="server" Text="排查类型不为空" />
            </p>
            <fieldset>
                <legend>查询条件</legend>
                <p>
                    教学计划：<asp:DropDownList ID="cboTeachingPlan" runat="server">
                        <asp:ListItem></asp:ListItem>
                    </asp:DropDownList>
                    &nbsp;&nbsp;&nbsp;校区：
                    <asp:DropDownList ID="cboCampus" runat="server">
                    </asp:DropDownList>
                    &nbsp;&nbsp;&nbsp;开课学院：<asp:DropDownList ID="cboDept" runat="server">
                    </asp:DropDownList>
                    &nbsp;
                </p>
                <p>
                    课程名：<asp:TextBox ID="txtCourseName" runat="server"></asp:TextBox>
                    &nbsp;&nbsp;课程号：<asp:TextBox ID="txtCourseNum" runat="server" Width="109px"></asp:TextBox>
                    &nbsp;&nbsp; 排查类型 
                    <asp:DropDownList ID="DropDownListType" runat="server" AppendDataBoundItems="True" DataSourceID="sdsType" DataTextField="type" DataValueField="type">
                        <asp:ListItem Value="%">【全部】</asp:ListItem>
                    </asp:DropDownList>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;
                    <asp:LinkButton ID="btnSearch" runat="server" OnClick="btnSearch_Click">检索</asp:LinkButton>
                </p>
            </fieldset>
                <p>
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
            </p>
                <asp:LinkButton ID="btnAdd" runat="server" OnClick="btnAdd_Click">选中课程添加到排查表</asp:LinkButton>
            </p>
            <cc1:MyGridView ID="gvExCourse" runat="server" AutoGenerateColumns="False" CssClass="dataTable" DataSourceID="sdsExcludeCourse" EmptyDataText="没有检索到任何数据。" AllowPaging="True" AllowSorting="True" Width="100%" PageSize="200">
                <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
                <Columns>
                    <asp:TemplateField HeaderText="选择" ShowHeader="False">
                            <ItemTemplate>
                                <asp:CheckBox ID="CheckBox" runat="server" />
                                <asp:Label ID="ID" runat="server" Text='<%# Bind("Id") %>' Visible="false"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    <asp:BoundField DataField="teachingPlan" HeaderText="教学计划" SortExpression="teachingPlan" />
                    <asp:BoundField DataField="course_dept" HeaderText="开课学院" SortExpression="course_dept" />
                    <asp:BoundField DataField="course_num" HeaderText="课程号" SortExpression="course_num" />
                    <asp:BoundField DataField="course_name" HeaderText="课程名" SortExpression="course_name" />
                    <asp:BoundField DataField="type" HeaderText="类型" SortExpression="type" />
                </Columns>
                <EditRowStyle CssClass="highlightRow"></EditRowStyle>
                <HeaderStyle CssClass="headerRow"></HeaderStyle>
                <PagerSettings FirstPageText="首页" LastPageText="尾页" NextPageText="下一页" PreviousPageText="上一页"></PagerSettings>
                <PagerStyle CssClass="pagerRow"></PagerStyle>
                <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
            </cc1:MyGridView>
            <p>
                <asp:CheckBox ID="CheckBox" runat="server" AutoPostBack="True" OnCheckedChanged="CheckBox_CheckedChanged" Text="全选" />
                &nbsp;&nbsp;&nbsp;
                </p>
            <p>
                <asp:SqlDataSource ID="sdsExcludeCourse" runat="server" ConnectionString="<%$ ConnectionStrings:CheckConnStr %>" SelectCommand="IF (@isNull = 1 AND @isNotNull = 0) SELECT teachingPlan, course_dept, course_num, course_name, course_serialNum, course_type, course_teacher, totalHours_teaching, totalHours_experiment, totalHours_pratice, totalHours_computer, totalHours_outsideClass, course_credit, totalHours, class_time, class_location, class_class, class_campus, course_attribute, type, ID FROM ExaminationCourse WHERE (teachingPlan LIKE @teachingPlan) AND (class_campus LIKE @class_campus) AND (course_dept LIKE @class_Dept) AND (course_name LIKE '%' + @course_name + '%') AND (course_num LIKE '%' + @course_num + '%') AND (type is NULL)

IF (@isNull = 0 AND @isNotNull = 1) SELECT teachingPlan, course_dept, course_num, course_name, course_serialNum, course_type, course_teacher, totalHours_teaching, totalHours_experiment, totalHours_pratice, totalHours_computer, totalHours_outsideClass, course_credit, totalHours, class_time, class_location, class_class, class_campus, course_attribute, type, ID FROM ExaminationCourse WHERE (teachingPlan LIKE @teachingPlan) AND (class_campus LIKE @class_campus) AND (course_dept LIKE @class_Dept) AND (course_name LIKE '%' + @course_name + '%') AND (course_num LIKE '%' + @course_num + '%') AND (type LIKE '%' + @type+ '%')

IF (@isNull = 1 AND @isNotNull = 1 AND @type='%')
SELECT teachingPlan, course_dept, course_num, course_name, course_serialNum, course_type, course_teacher, totalHours_teaching, totalHours_experiment, totalHours_pratice, totalHours_computer, totalHours_outsideClass, course_credit, totalHours, class_time, class_location, class_class, class_campus, course_attribute, type, ID FROM ExaminationCourse WHERE (teachingPlan LIKE @teachingPlan) AND (class_campus LIKE @class_campus) AND (course_dept LIKE @class_Dept) AND (course_name LIKE '%' + @course_name + '%') AND (course_num LIKE '%' + @course_num + '%') 

IF (@isNull = 1 AND @isNotNull = 1 AND @type!='%')
SELECT teachingPlan, course_dept, course_num, course_name, course_serialNum, course_type, course_teacher, totalHours_teaching, totalHours_experiment, totalHours_pratice, totalHours_computer, totalHours_outsideClass, course_credit, totalHours, class_time, class_location, class_class, class_campus, course_attribute, type, ID FROM ExaminationCourse WHERE (teachingPlan LIKE @teachingPlan) AND (class_campus LIKE @class_campus) AND (course_dept LIKE @class_Dept) AND (course_name LIKE '%' + @course_name + '%') AND (course_num LIKE '%' + @course_num + '%') AND (type LIKE '%' + @type+ '%')

IF (@isNull = 0 AND @isNotNull = 0 AND @type='%')
SELECT teachingPlan, course_dept, course_num, course_name, course_serialNum, course_type, course_teacher, totalHours_teaching, totalHours_experiment, totalHours_pratice, totalHours_computer, totalHours_outsideClass, course_credit, totalHours, class_time, class_location, class_class, class_campus, course_attribute, type, ID FROM ExaminationCourse WHERE (teachingPlan LIKE @teachingPlan) AND (class_campus LIKE @class_campus) AND (course_dept LIKE @class_Dept) AND (course_name LIKE '%' + @course_name + '%') AND (course_num LIKE '%' + @course_num + '%') 

IF (@isNull = 0 AND @isNotNull = 0 AND @type!='%')
SELECT teachingPlan, course_dept, course_num, course_name, course_serialNum, course_type, course_teacher, totalHours_teaching, totalHours_experiment, totalHours_pratice, totalHours_computer, totalHours_outsideClass, course_credit, totalHours, class_time, class_location, class_class, class_campus, course_attribute, type, ID FROM ExaminationCourse WHERE (teachingPlan LIKE @teachingPlan) AND (class_campus LIKE @class_campus) AND (course_dept LIKE @class_Dept) AND (course_name LIKE '%' + @course_name + '%') AND (course_num LIKE '%' + @course_num + '%') AND (type LIKE '%' + @type+ '%')">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="chkIsNull" DefaultValue="false" Name="isNull" PropertyName="Checked" />
                        <asp:ControlParameter ControlID="chkIsNotNull" DefaultValue="false" Name="isNotNull" PropertyName="Checked" />
                        <asp:ControlParameter ControlID="cboTeachingPlan" DefaultValue="%" Name="teachingPlan" PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="cboCampus" DefaultValue="%" Name="class_campus" PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="cboDept" DefaultValue="%" Name="class_Dept" PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="txtCourseName" DefaultValue="%" Name="course_name" PropertyName="Text" />
                        <asp:ControlParameter ControlID="txtCourseNum" DefaultValue="%" Name="course_num" PropertyName="Text" />
                        <asp:ControlParameter ControlID="DropDownListType" DefaultValue="%" Name="type" PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </p>
            <p>
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
                                类型名称：<asp:DropDownList ID="cboType" runat="server" DataSourceID="sdsExcludeType" DataTextField="exclude_type" DataValueField="exclude_value">
                                    <asp:ListItem Value="">【NULL】</asp:ListItem>
                                </asp:DropDownList>
                            </p>
                        </dx:PopupControlContentControl>
                    </ContentCollection>
                </dx:ASPxPopupControl>
                <asp:SqlDataSource ID="sdsExcludeType" runat="server" ConnectionString="<%$ ConnectionStrings:CheckConnStr %>" SelectCommand="SELECT [exclude_type], [exclude_value] FROM [ExcludeType]"></asp:SqlDataSource>
            </p>
            <cc2:CascadingDropDown ID="CascadingDropDown1" runat="server" TargetControlID="cboTeachingPlan"
                PromptText="请选择教学计划..." LoadingText="加载数据中，请稍候..." ServiceMethod="GetTeachingPlan" ServicePath="~/WebServices/CascadingService.asmx"
                Category="TeachingPlan" EmptyText="请选择教学计划..."></cc2:CascadingDropDown>
            <cc2:CascadingDropDown ID="CascadingDropDown2" runat="server" TargetControlID="cboCampus"
                ParentControlID="cboTeachingPlan" PromptText="请选择校区..." LoadingText="加载数据中，请稍候..."
                ServiceMethod="GetCampusOfTeachingPlan" ServicePath="~/WebServices/CascadingService.asmx" Category="Campus"
                EmptyText="请选择专业..."></cc2:CascadingDropDown>
            <cc2:CascadingDropDown ID="CascadingDropDown3" runat="server" TargetControlID="cboDept"
                ParentControlID="cboCampus" PromptText="请选择开课学院..." LoadingText="加载数据中，请稍候..." ServiceMethod="GetDeptOfCampus"
                ServicePath="~/WebServices/CascadingService.asmx" Category="Dept" EmptyText="请选择开课开课学院..."></cc2:CascadingDropDown>
            <uc2:MessageBoxControl runat="server" ID="MsgBox" />
            <br />
        </div>

        <asp:HiddenField ID="txtID" runat="server" />
        <br />
            <asp:SqlDataSource ID="sdsType" runat="server" ConnectionString="<%$ ConnectionStrings:CheckConnStr %>" SelectCommand="SELECT DISTINCT type FROM ExaminationCourse WHERE (type IS NOT NULL) "></asp:SqlDataSource>
    </form>
</body>
</html>
