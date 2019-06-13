<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CommonPrivateMng.aspx.cs" Inherits="WebForms_SchoolAdministrator_CommonPrivateMng" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="Infrastructure" Namespace="Infrastructure.Controls" TagPrefix="cc1" %>
<%@ Register Src="~/UserControls/MessageBoxControl.ascx" TagPrefix="uc2" TagName="MessageBoxControl" %>


<!DOCTYPE html>
<script runat="server">

    protected void btnExport_Click(object sender, EventArgs e)
    {

    }
</script>


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
            <h2>课程属性管理</h2>
           <%-- <p>
                导入考试安排表：<asp:FileUpload ID="files" runat="server" />
                <asp:LinkButton ID="btnExpo" runat="server" OnClick="btnExport_Click">Excel模板下载</asp:LinkButton>&nbsp;
                <asp:LinkButton ID="btnImport" runat="server" OnClick="btnImport_Click">初始化课程类型</asp:LinkButton>&nbsp;</p>
            <p>--%>
                &nbsp;<asp:LinkButton ID="btnInitial" runat="server" OnClick="btnInitial_Click">课程数据初始化</asp:LinkButton>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:LinkButton ID="btnRefresh" runat="server" OnClick="btnRefresh_Click">生成课程属性</asp:LinkButton>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:LinkButton ID="btnExport" runat="server" OnClick="btnExport_Click1">初始化考试课程数据库</asp:LinkButton>
            </p>
            <fieldset>
                <legend>查询条件</legend>
                <p>
                    <asp:CheckBox ID="chkCommon" runat="server" Text="公共课" />&nbsp;&nbsp;<asp:CheckBox ID="chkCPrivate" runat="server" Text="专业课" />
                &nbsp;&nbsp;<asp:CheckBox ID="chkCommonIsNotPrivate" runat="server" Text="开科学院不等于所属学院" /></p>
                <p>
                    课 程 名：<asp:TextBox ID="txtCourseName" runat="server" Height="20px"></asp:TextBox>
                    &nbsp;&nbsp;课程号：<asp:TextBox ID="txtCourseNum" runat="server" Width="109px" Height="20px"></asp:TextBox>
                    &nbsp;</p>
                <p>
                    开课学院：<asp:DropDownList ID="DropDownListCampus0" runat="server" AppendDataBoundItems="True" DataSourceID="SqlDataSource1" DataTextField="course_dept" DataValueField="course_dept" Height="20px" Width="183px">
                        <asp:ListItem Value="%">【全部】</asp:ListItem>
                    </asp:DropDownList>
                    &nbsp;&nbsp; 校 区： 
                    <asp:DropDownList ID="DropDownListCampus" runat="server" AppendDataBoundItems="True" DataSourceID="sdsCampus" DataTextField="class_campus" DataValueField="class_campus" Height="20px" Width="123px">
                        <asp:ListItem Value="%">【全部】</asp:ListItem>
                    </asp:DropDownList>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:LinkButton ID="btnSearch" runat="server" OnClick="btnSearch_Click">检索</asp:LinkButton>&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp;
                    &nbsp; &nbsp;&nbsp;&nbsp; &nbsp;
                    </p>
               
            </fieldset>
                <dx:ASPxMenu ID="mnuMain" runat="server" BackColor="White" EnableTheming="True" ShowAsToolbar="True" Theme="Default" >
                    <ClientSideEvents ItemClick="function(s, e) {
    var itemName = e.item.name;
	switch(itemName){
		case 'CommonOrPrivate':
            popupEditCourseAttribute.Show();  
			break;
        case 'College':
            popupEditCollege.Show();  
			break;}
}" />
                    <Paddings PaddingBottom="5px" PaddingTop="8px" />
                    <Items>
                        <dx:MenuItem Text="修改课程属性" Name="CommonOrPrivate" BeginGroup="True">
                            <Image Url="~/images/edit.png">
                            </Image>
                        </dx:MenuItem>
                        <dx:MenuItem Text="修改所属学院" Name="College" BeginGroup="True">
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
            <dx:ASPxButton ID="btn1" Theme="Aqua" runat="server" Text="导出为Excel" OnClick="btnExcel_Click" style="margin:5px 20px 10px 20px;" HorizontalAlign="Right" RightToLeft="True" VerticalAlign="Middle"></dx:ASPxButton>
            <br />
            <cc1:MyGridView ID="gvExCourse" runat="server" AutoGenerateColumns="False" CssClass="dataTable" DataSourceID="sdsExcludeCourse" EmptyDataText="没有检索到任何数据。" AllowPaging="True" Width="100%" PageSize="200" DataKeyNames="ID">
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
                    <asp:BoundField DataField="course_serialNum" HeaderText="课序号" SortExpression="course_serialNum" />
                    <asp:BoundField DataField="course_type" HeaderText="课程类型" SortExpression="course_type" />
                    <asp:BoundField DataField="course_teacherno" HeaderText="教师号" SortExpression="course_teacherno" />
                    <asp:BoundField DataField="course_teacher" HeaderText="教师" SortExpression="course_teacher" />
                    <asp:BoundField DataField="class_class" HeaderText="班级" SortExpression="class_class" />
                    <asp:BoundField DataField="course_attribute" HeaderText="课程属性" SortExpression="course_attribute" />
                    <asp:BoundField DataField="class_campus" HeaderText="校区" SortExpression="class_campus" />
                    <asp:BoundField DataField="CommonOrPrivate" HeaderText="公共课或专业课" SortExpression="CommonOrPrivate" />
                    <asp:BoundField DataField="PrivateCollege" HeaderText="专业课所属学院" SortExpression="CommonOrPrivate" />
                </Columns>
                <EditRowStyle CssClass="highlightRow"></EditRowStyle>
                <HeaderStyle CssClass="headerRow"></HeaderStyle>
                <PagerSettings FirstPageText="首页" LastPageText="尾页" NextPageText="下一页" PreviousPageText="上一页"></PagerSettings>
                <PagerStyle CssClass="pagerRow"></PagerStyle>
                <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
            </cc1:MyGridView>
            <p>
                <asp:SqlDataSource ID="sdsExcludeCourse" runat="server" ConnectionString="<%$ ConnectionStrings:CheckConnStr %>" SelectCommand="IF (@Course_Common= 1 AND @Course_Private= 0) SELECT * FROM ExaminationCourse where (class_campus LIKE @class_campus) AND (course_dept LIKE @course_dept )AND (course_name LIKE '%' + @course_name + '%') AND (course_num LIKE '%' + @course_num + '%') AND(CommonOrPrivate Like 'c' ) and (type is null)

IF (@Course_Common = 0 AND @Course_Private= 1) SELECT * FROM ExaminationCourse  where (class_campus LIKE @class_campus ) AND (course_dept LIKE @course_dept )AND (course_name LIKE '%' + @course_name + '%') AND (course_num LIKE '%' + @course_num + '%')AND(CommonOrPrivate Like 'p' )and (type is null)

IF (@Course_Common = 1 AND @Course_Private= 1   AND @compare=1)
SELECT * FROM ExaminationCourse where (class_campus LIKE @class_campus )AND (course_dept LIKE @course_dept ) AND (course_name LIKE '%' + @course_name + '%') AND(CommonOrPrivate Like 'p' or  CommonOrPrivate Like 'c')AND (course_num LIKE '%' + @course_num + '%') AND([PrivateCollege]&lt;&gt;[course_dept]) and (type is null)

IF (@Course_Common= 0 AND @Course_Private = 0   AND @compare=1)
SELECT * FROM ExaminationCourse where (class_campus LIKE @class_campus )AND (course_dept LIKE @course_dept ) AND (course_name LIKE '%' + @course_name + '%') AND (course_num LIKE '%' + @course_num + '%') AND(CommonOrPrivate Like 'p' or  CommonOrPrivate Like 'c')AND([PrivateCollege]&lt;&gt;[course_dept]) and (type is null)

IF (@Course_Common= 1 AND @Course_Private = 1   AND @compare=0)
SELECT * FROM ExaminationCourse where (class_campus LIKE @class_campus )AND (course_dept LIKE @course_dept ) AND (course_name LIKE '%' + @course_name + '%') AND(CommonOrPrivate Like 'p' or  CommonOrPrivate Like 'c')AND (course_num LIKE '%' + @course_num + '%') and (type is null)

IF (@Course_Common= 0 AND @Course_Private  = 0 )
SELECT * FROM ExaminationCourse where (class_campus LIKE @class_campus) AND (course_dept LIKE @course_dept )AND (course_name LIKE '%' + @course_name + '%') AND(CommonOrPrivate Like 'p' or  CommonOrPrivate Like 'c')AND (course_num LIKE '%' + @course_num + '%') and (type is null) ">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="chkCommon" DefaultValue="" Name="Course_Common" PropertyName="Checked" />
                        <asp:ControlParameter ControlID="chkCPrivate" Name="Course_Private" PropertyName="Checked" />
                        <asp:ControlParameter ControlID="DropDownListCampus" DefaultValue="%" Name="class_campus" PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="DropDownListCampus0" DefaultValue="%" Name="course_dept" PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="txtCourseName" DefaultValue="%" Name="course_name" PropertyName="Text" />
                        <asp:ControlParameter ControlID="txtCourseNum" DefaultValue="%" Name="course_num" PropertyName="Text" />
                        <asp:ControlParameter ControlID="chkCommonIsNotPrivate" DefaultValue="" Name="compare" PropertyName="Checked" />
                    </SelectParameters>
                </asp:SqlDataSource>
            <asp:SqlDataSource ID="sdsCampus" runat="server" ConnectionString="<%$ ConnectionStrings:CheckConnStr %>" SelectCommand="SELECT DISTINCT class_campus FROM ExaminationCourse WHERE (class_campus IS NOT NULL)"></asp:SqlDataSource>
            </p>
            <p>
                &nbsp;</p>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CheckConnStr %>" SelectCommand="SELECT DISTINCT course_dept FROM ExaminationCourse"></asp:SqlDataSource>
            <uc2:MessageBoxControl runat="server" ID="MsgBox" />
            <br />
                <dx:ASPxPopupControl ID="popupEditCourseAttribute" runat="server" CloseAction="CloseButton" HeaderText="编辑课程属性" Height="139px" Modal="True" ShowFooter="True" Theme="Aqua" Width="367px" PopupAnimationType="Fade" ShowCloseButton="False" ClientInstanceName="popupEditCourseAttribute" AllowDragging="True" Left="80" Top="100">
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
			popupEditCourseAttribute.Hide();
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
                                课程属性：<asp:DropDownList ID="cboType" runat="server" DataSourceID="sdsEditCourseAttribute" DataTextField="CommonOrPrivate" DataValueField="CommonOrPrivate">
                                    <asp:ListItem Value="">【NULL】</asp:ListItem>
                                </asp:DropDownList>
                            </p>
                        </dx:PopupControlContentControl>
                    </ContentCollection>
                </dx:ASPxPopupControl>
                <asp:SqlDataSource ID="sdsEditCourseAttribute" runat="server" ConnectionString="<%$ ConnectionStrings:CheckConnStr %>" SelectCommand="SELECT DISTINCT CommonOrPrivate FROM ExaminationCourse WHERE (CommonOrPrivate IS NOT NULL)"></asp:SqlDataSource>
            <br />
                <dx:ASPxPopupControl ID="popupEditCollege" runat="server" CloseAction="CloseButton" HeaderText="编辑学院" Height="139px" Modal="True" ShowFooter="True" Theme="Aqua" Width="367px" PopupAnimationType="Fade" ShowCloseButton="False" ClientInstanceName="popupEditCollege" AllowDragging="True" Left="80" Top="100">
                    <HeaderImage Url="~/images/edit.png">
                    </HeaderImage>
                    <FooterStyle>
                        <Paddings Padding="5px" />
                    </FooterStyle>
                    <FooterTemplate>
                        <dx:ASPxMenu ID="mnuToolBar" runat="server" EnableTheming="True" Theme="Aqua" ShowAsToolbar="True" OnItemClick="mnuToolBar_ItemClick1">
                            <ClientSideEvents ItemClick="function(s, e) {
    var itemName = e.item.name;
	switch(itemName){
		case 'Cancel':
			popupEditCollege.Hide()
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
                            <p>
                                所属学院：<asp:DropDownList ID="cboType0" runat="server" DataSourceID="sdsEditCollege" DataTextField="College" DataValueField="College">
                                    <asp:ListItem Value="">【NULL】</asp:ListItem>
                                </asp:DropDownList>
                            </p>
                        </dx:PopupControlContentControl>
                    </ContentCollection>
                </dx:ASPxPopupControl>
                <asp:SqlDataSource ID="sdsEditCollege" runat="server" ConnectionString="<%$ ConnectionStrings:CheckConnStr %>" SelectCommand="SELECT DISTINCT College FROM ClassCollege"></asp:SqlDataSource>
            <br />
        </div>
    </form>
</body>
</html>
