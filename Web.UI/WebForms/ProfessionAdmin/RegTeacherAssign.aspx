<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RegTeacherAssign.aspx.cs" Inherits="WebForms_ProfessionAdmin_RegTeacherAssign" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="Infrastructure" Namespace="Infrastructure.Controls" TagPrefix="cc1" %>
<%@ Register Src="~/UserControls/MessageBoxControl.ascx" TagPrefix="uc2" TagName="MessageBoxControl" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../../css/style.css" rel="stylesheet" />
    <style type="text/css">

        .auto-style1 {
            color: #666666;
        }
        .span_px{
          color:red;
          position: absolute;
          top: 75px;
          display: inline-block;
          left: 180px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <h2>出卷人管理</h2>
    
                <dx:ASPxMenu ID="mnuMain" runat="server" BackColor="White" EnableTheming="True" Theme="Default" OnItemClick="mnuToolBar_ItemClick1" >
                    <Paddings PaddingBottom="5px" PaddingTop="8px" />
                    
                    <Items>
                        <dx:MenuItem Text="一键指定出卷人" Name="Audit" BeginGroup="True">
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
         
        <span class="auto-style1 span_px">(*对仅有一名任课老师的课程进行自动指定出卷人）<br />
        </span>
        &nbsp;<asp:Panel ID="Panel1" runat="server" >
              <div style="text-align:center">
                <cc1:MyGridView ID="gvExCourse" runat="server" AutoGenerateColumns="False" CssClass="dataTable" DataSourceID="sdsCourse" AllowPaging="True" AllowSorting="True" EmptyDataText="没有找到任何数据！" PageSize="20" DataKeyNames="ID" OnRowCommand="gvExCourse_RowCommand">
                    <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
                    <Columns>
                        <asp:TemplateField HeaderText="选择" ShowHeader="False" Visible="false">
                            <ItemTemplate>
                                <asp:Label ID="lblcourse_no" runat="server" Text='<%# Bind("course_no") %>' Visible="false"></asp:Label>
                                <asp:Label ID="lbflag" runat="server" Text='<%# Bind("paper_AorB") %>' Visible="False"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="course_no" HeaderText="课程号" SortExpression="course_no" ReadOnly="True" />
                        <asp:BoundField DataField="course_name" HeaderText="课程名" SortExpression="course_name" />
                        <asp:BoundField DataField="course_type" HeaderText="课程类型" SortExpression="course_type" />
                        <asp:BoundField DataField="course_attribute" HeaderText="课程属性" SortExpression="course_attribute" />
                        <asp:ButtonField CommandName="PaperAorB_Edit" HeaderText="考试试卷更改" DataTextField="paper_AorB" />
                        <asp:BoundField DataField="Name" HeaderText="出卷人" SortExpression="Name" />
                        <asp:ButtonField CommandName="TeacherEdit" HeaderText="出卷人更改" Text="编辑" />
                    </Columns>
                    <EditRowStyle CssClass="highlightRow"></EditRowStyle>
                    <HeaderStyle CssClass="headerRow"></HeaderStyle>
                    <PagerSettings FirstPageText="首页" LastPageText="尾页" NextPageText="下一页" PreviousPageText="上一页">
                    </PagerSettings>
                    <PagerStyle CssClass="pagerRow"></PagerStyle>
                    <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
                </cc1:MyGridView>
                  </div>
            </asp:Panel>
            &nbsp;&nbsp;<uc2:messageboxcontrol runat="server" ID="MsgBox" />
            <dx:ASPxPopupControl ID="popupEdit" runat="server" CloseAction="CloseButton" HeaderText="选择出卷人" Height="139px" Modal="True" ShowFooter="True" Theme="Aqua" PopupAnimationType="Fade" ShowCloseButton="False" ClientInstanceName="popupEdit" AllowDragging="True" Left="80" Top="100" Width="328px">
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
                    
                            出卷人：<asp:DropDownList ID="cboCourseTeacher" runat="server" DataSourceID="sdsCourseTeacher" DataTextField="course_teachername" DataValueField="course_teacherno">
                            </asp:DropDownList>
                  
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>
            <asp:SqlDataSource ID="sdsCourse" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>" SelectCommand="SELECT Course.course_no, Course.teachingPlan, Course.course_dept, Course.course_name, Course.course_type, Course.course_teacherno1, Course.course_teacher, Course.course_class, Course.course_attribute, Course.class_campus, Course.CommonOrPrivate, Course.PrivateCollege, Course.course_teacherno, Course.ID, Teacher.Name, Paper.paper_AorB, Paper.flag FROM Course INNER JOIN Paper ON Course.ID = Paper.courseID LEFT OUTER JOIN Teacher ON Course.course_teacherno = Teacher.Account WHERE (Course.course_profession LIKE @pro) AND (Paper.flag LIKE '考试') ORDER BY Course.course_no">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtPro" Name="pro" PropertyName="Value" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:HiddenField ID="txtCount" runat="server" />

            <asp:HiddenField ID="txtPro" runat="server" />
            <asp:HiddenField ID="txtTeacherID" runat="server" />

        <asp:SqlDataSource ID="sdsCourseTeacher" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>" SelectCommand="SELECT course_teacherno, course_teachername FROM CourseTeacher WHERE (course_no LIKE @course_no)">
            <SelectParameters>
                <asp:ControlParameter ControlID="txtCourseNo" Name="course_no" PropertyName="Value" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:HiddenField ID="txtCourseNo" runat="server" />

       
        <asp:HiddenField ID="txtAorB" runat="server"/>

        </div>
    </form>
</body>
</html>

