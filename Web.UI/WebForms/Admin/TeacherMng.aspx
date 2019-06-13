<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TeacherMng.aspx.cs" Inherits="WebForms_Admin_TeacherMng" %>

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
            <h2>教师管理</h2>
            <br />
            <fieldset>
                <legend>查询条件<br />
                </legend>
                <p>
                    所属学院：<asp:DropDownList ID="DropDownListCollege" runat="server" AppendDataBoundItems="True" DataSourceID="sdsCollege" DataValueField="BranchName" Height="25px" Width="130px">
                        <asp:ListItem Value="%">【全部】</asp:ListItem>
                    </asp:DropDownList>
                </p>
                <p>
                    教师号&nbsp; ：
                    <asp:TextBox ID="txtCourseno" runat="server" Style="margin-bottom: 0px"></asp:TextBox>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    教师名称：
                    <asp:TextBox ID="txtCoursename" runat="server" Style="margin-bottom: 0px"></asp:TextBox>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:LinkButton ID="btnSearch" runat="server" OnClick="btnSearch_Click">检索</asp:LinkButton>
                </p>
            </fieldset>

            <div style="overflow-x: visible">
                <br />
                <br />
                <div style="text-align: center">
                    <cc1:MyGridView ID="gvTeacher" runat="server" AutoGenerateColumns="False" CssClass="dataTable" DataSourceID="sdsTeacher" AllowPaging="True" AllowSorting="True" EmptyDataText="没有找到任何数据！" PageSize="20" DataKeyNames="Account" OnRowCommand="gvTeacher_RowCommand">
                        <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
                        <Columns>
                            <asp:TemplateField HeaderText="选" InsertVisible="False" Visible="false" >
                                <ItemTemplate>
                                    <asp:Label ID="lblAccount" runat="server" Text='<%# Bind("Account") %>' Visible="False"></asp:Label>
                                    <asp:Label ID="lblName" runat="server" Text='<%# Bind("Name") %>' Visible="False"></asp:Label>
                                    <asp:Label ID="lblCollege" runat="server" Text='<%# Bind("College") %>' Visible="False"></asp:Label>
                                    <asp:Label ID="lblSex" runat="server" Text='<%# Bind("Sex") %>' Visible="False"></asp:Label>
                                    <asp:Label ID="lblTel" runat="server" Text='<%# Bind("Tel") %>' Visible="False"></asp:Label>
                                    <asp:Label ID="lblUserCode" runat="server" Text='<%# Bind("UserCode") %>' Visible="False"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Account" HeaderText="工号" SortExpression="Account" />
                            <asp:BoundField DataField="Name" HeaderText="姓名" SortExpression="Name" />
                            <asp:BoundField DataField="College" HeaderText="学院" SortExpression="College" />
                            <asp:BoundField DataField="Sex" HeaderText="性别" SortExpression="Sex" />
                            <asp:BoundField DataField="Tel" HeaderText="联系电话" SortExpression="Tel" />
                            <asp:BoundField DataField="UserCreateTime" HeaderText="录入时间" SortExpression="UserCreateTime" />
                            <asp:ButtonField CommandName="EditTeacher" HeaderText="修改" Text="修改" />
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
                SelectCommand="SELECT DISTINCT Teacher.Account, Teacher.Name, Teacher.College, Teacher.Sex, Teacher.Tel, [User].UserCreateTime, Teacher.UserCode FROM Teacher INNER JOIN [User] ON Teacher.UserCode = [User].UserCode WHERE (Teacher.Account LIKE @Teacherno) AND (Teacher.Name LIKE @Teachername) AND (Teacher.College LIKE @College)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtCourseno" Name="Teacherno" PropertyName="Text" DefaultValue="%" />
                    <asp:ControlParameter ControlID="txtCoursename" Name="Teachername" PropertyName="Text" DefaultValue="%" />
                    <asp:ControlParameter ControlID="DropDownListCollege" DefaultValue="%" Name="College" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="sdsCollege" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>" SelectCommand="SELECT BranchName, BranchID FROM Branch WHERE (ParentBranchID = 127)"></asp:SqlDataSource>
            <br />
        </div>
        <dx:ASPxPopupControl ID="popupSaveTeacher" runat="server" CloseAction="CloseButton" HeaderText="编辑" Height="275px" Modal="True" ShowFooter="True" Theme="Aqua" Width="357px" PopupAnimationType="Fade" ShowCloseButton="False" ClientInstanceName="popupSaveTeacher" AllowDragging="True" Left="80" Top="100">
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
                <dx:PopupControlContentControl ID="PopupControlContentControl5" runat="server" SupportsDisabledAttribute="True">
                    
                        教&nbsp; 师 号：<asp:TextBox ID="txtAccount" runat="server"></asp:TextBox>

                   
                   
                        <br />
                        <br />

                   
                   
                        教师名称：<asp:TextBox ID="txtName" runat="server"></asp:TextBox>
                    
                    
                        <br />
                        <br />
                        学&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 院：<asp:DropDownList ID="cboCollege" runat="server" DataSourceID="sdsCollege" DataTextField="BranchName" DataValueField="BranchID">
                        </asp:DropDownList>
                        &nbsp;&nbsp;
                        <br />
                        <br />
                        性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 别：<asp:DropDownList ID="cboSex" runat="server" style="height: 19px; width: 39px">
                            <asp:ListItem Value="男">男</asp:ListItem>
                            <asp:ListItem Value="女">女</asp:ListItem>
                        </asp:DropDownList>
                  
                    
                        <br />
                        <br />
                        电&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 话：<asp:TextBox ID="txtTel" runat="server"></asp:TextBox>
                    
                </dx:PopupControlContentControl>
            </ContentCollection>
        </dx:ASPxPopupControl>


        <uc1:MessageBoxControl ID="MsgBox" runat="server" />
        <asp:HiddenField ID="txtUserCode" runat="server" />
    </form>
</body>
</html>
