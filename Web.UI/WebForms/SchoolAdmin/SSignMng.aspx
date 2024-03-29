﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SSignMng.aspx.cs" Inherits="WebForms_SchoolAdmin_SSignMng" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="Infrastructure" Namespace="Infrastructure.Controls" TagPrefix="cc1" %>
<%@ Register Src="~/UserControls/MessageBoxControl.ascx" TagPrefix="uc2" TagName="MessageBoxControl" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../../css/style.css" rel="stylesheet" />
    <style type="text/css">

         .auto-style2 {
            color: #ff0000;
        }
	.span_px{
            color:red;
            position: absolute;
            top: 32px;
            display: inline-block;
            left: 200px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <h2>试卷院级签字人管理</h2>
        <span class="auto-style2 span_px">*请先进行角色管理，对院级管理员进行管理，再进行院级签名人指定！</span>
        <asp:Panel ID="Panel1" runat="server" >
              <div style="text-align:center">
                <cc1:MyGridView ID="gvExCourse" runat="server" AutoGenerateColumns="False" CssClass="dataTable" DataSourceID="sdsCourse" AllowPaging="True" AllowSorting="True" EmptyDataText="没有找到任何数据！" PageSize="20"  OnRowCommand="gvExCourse_RowCommand">
                    <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
                    <Columns>
                        <asp:TemplateField HeaderText="选择" ShowHeader="False" Visible="false">
                            <ItemTemplate>
                                <asp:Label ID="lbcollege" runat="server" Text='<%# Bind("BranchName") %>' Visible="False"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="BranchName" HeaderText="学院名称" SortExpression="BranchName" />
                        <asp:BoundField DataField="Name" HeaderText="签名人" SortExpression="Name" />
                        <asp:ButtonField CommandName="SignEdit" HeaderText="签名人更改" Text="编辑" />
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
            <dx:ASPxPopupControl ID="popupEdit" runat="server" CloseAction="CloseButton" HeaderText="选择签名人" Height="139px" Modal="True" ShowFooter="True" Theme="Aqua" PopupAnimationType="Fade" ShowCloseButton="False" ClientInstanceName="popupEdit" AllowDragging="True" AllowResize="true" Left="80" Top="100" Width="328px">
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
                    
                            签名人：<asp:DropDownList ID="cbocollege" runat="server" DataSourceID="sdsCourseTeacher" DataTextField="Name" DataValueField="Name">
                            </asp:DropDownList>
                  
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>
            <asp:SqlDataSource ID="sdsCourse" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>" SelectCommand="SELECT DISTINCT Branch.BranchName, Teacher.Name, Signature.CollegeSignature FROM Teacher INNER JOIN Signature ON Teacher.Account = Signature.CollegeSignature INNER JOIN UsersInRoles ON Teacher.UserCode = UsersInRoles.UserCode RIGHT OUTER JOIN Branch ON Teacher.College = Branch.BranchName WHERE (Branch.ParentBranchID = 127)">
            </asp:SqlDataSource>

            <asp:HiddenField ID="txtCollege" runat="server" />

        <asp:SqlDataSource ID="sdsCourseTeacher" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>" SelectCommand="SELECT DISTINCT Teacher.College, Teacher.Name FROM Teacher INNER JOIN UsersInRoles ON Teacher.UserCode = UsersInRoles.UserCode WHERE (UsersInRoles.RoleId = 3) AND (Teacher.College LIKE @College)">
            <SelectParameters>
                <asp:ControlParameter ControlID="txtCollege" Name="College" PropertyName="Value" />
            </SelectParameters>
        </asp:SqlDataSource>

       
        <asp:HiddenField ID="txtAorB" runat="server"/>

        </div>
    </form>
</body>
</html>

