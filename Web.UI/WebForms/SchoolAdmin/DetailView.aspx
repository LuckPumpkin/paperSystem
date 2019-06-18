<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DetailView.aspx.cs" Inherits="WebForms_SchoolAdmin_DetailView" %>

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
            <div>
                <h2>试卷命题细目表查看</h2>

                <p>
                    按学院检索：
            <asp:DropDownList ID="DropDownListCollege" runat="server" AppendDataBoundItems="True" DataSourceID="sdsCollege" DataValueField="course_dept" Height="25px" Width="130px">
                <asp:ListItem Value="%">【全部】</asp:ListItem>
            </asp:DropDownList>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:LinkButton ID="LinkButton1" runat="server" OnClick="btnSearch_Click">检索</asp:LinkButton>
                </p>
                <asp:Panel ID="Panel1" runat="server" >
                    <div style="text-align: center">
                        <cc1:MyGridView ID="gvCourse" runat="server" AutoGenerateColumns="False" CssClass="dataTable" DataSourceID="sdsPaperDetail" AllowPaging="True" AllowSorting="True" EmptyDataText="没有找到任何数据！" PageSize="20" OnRowCommand="gvCourse_RowCommand" DataKeyNames="DetailID">
                            <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
                            <Columns>
                                <asp:TemplateField HeaderText="选择" Visible="False">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="CheckBox" runat="server" AutoPostBack="false" />
                                        <asp:Label ID="lblDetailID" runat="server" Text='<%# Bind("DetailID") %>' Visible="False"></asp:Label>
                                        <asp:Label ID="lblTeacher" runat="server" Text='<%# Bind("course_teacher") %>' Visible="False"></asp:Label>
                                        <asp:Label ID="lblCourseNo" runat="server" Text='<%# Bind("course_no") %>' Visible="False"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="course_dept" HeaderText="学院" SortExpression="course_dept" />
                                <asp:BoundField DataField="course_profession" HeaderText="专业" SortExpression="course_profession" />
                                <asp:BoundField DataField="course_no" HeaderText="课程号" SortExpression="course_no" />
                                <asp:BoundField DataField="course_name" HeaderText="课程名称" SortExpression="course_name" />
                                <asp:BoundField DataField="course_teacher" HeaderText="教师" SortExpression="course_teacher" />
                                <asp:ButtonField CommandName="PaperDetail" HeaderText="细目表1查看" Text="查看" />
                                <asp:ButtonField CommandName="PaperDet" HeaderText="细目表2查看" Text="查看" />
                            </Columns>
                            <EditRowStyle CssClass="highlightRow"></EditRowStyle>
                            <HeaderStyle CssClass="headerRow"></HeaderStyle>
                            <PagerSettings FirstPageText="首页" LastPageText="尾页" NextPageText="下一页" PreviousPageText="上一页"></PagerSettings>
                            <PagerStyle CssClass="pagerRow"></PagerStyle>
                            <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
                        </cc1:MyGridView>
                    </div>
                </asp:Panel>
                &nbsp;<asp:SqlDataSource ID="sdsPaperDetail" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>" SelectCommand="SELECT DISTINCT Course.course_dept, Course.course_teacher, Course.course_name, Course.course_no, Course.course_profession, Detail.DetailID FROM Registration INNER JOIN Course ON Registration.courseID = Course.ID INNER JOIN Detail ON Course.ID = Detail.courseID WHERE (Registration.state &gt;= 4) AND (Course.course_dept LIKE '%' + @course_dept + '%')">

                    <SelectParameters>
                        <asp:ControlParameter ControlID="DropDownListCollege" DefaultValue="%" Name="course_dept" PropertyName="SelectedValue" />
                    </SelectParameters>

                </asp:SqlDataSource>

                <asp:SqlDataSource ID="sdsCollege" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>"
                    SelectCommand="SELECT DISTINCT Course.course_dept FROM Registration INNER JOIN Course ON Registration.courseID = Course.ID INNER JOIN Detail ON Course.ID = Detail.courseID WHERE (Registration.state &gt;= 4) AND (Course.course_dept IS NOT NULL)"></asp:SqlDataSource>

                <br />
                <dx:ASPxPopupControl ID="popupDetail" runat="server" AllowDragging="True" CloseAction="CloseButton" HeaderText="查看命题细目表" Height="400px" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" AllowResize="true" Theme="Aqua" Width="850px">
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
        </div>
    </form>
</body>
</html>
