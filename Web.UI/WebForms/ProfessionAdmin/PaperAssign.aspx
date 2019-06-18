<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PaperAssign.aspx.cs" Inherits="WebForms_ProfessionAdmin_PaperAssign" %>
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
    <h2>试卷指定</h2>
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
                        <dx:MenuItem Text="指定试卷" Name="Exclude" BeginGroup="True">
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
            <asp:Panel ID="Panel1" runat="server"  Width="2500">
                <cc1:MyGridView ID="gvExCourse" runat="server" AutoGenerateColumns="False" CssClass="dataTable" DataSourceID="sdsTeacher" AllowPaging="True" AllowSorting="True" EmptyDataText="没有找到任何数据！" PageSize="20">
                    <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
                    <Columns>
                        <asp:TemplateField HeaderText="选择" ShowHeader="False">
                            <ItemTemplate>
                                <asp:CheckBox ID="CheckBox" runat="server" AutoPostBack="false" />
                                <asp:Label ID="Account" runat="server" Text='<%# Bind("Account") %>' Visible="false"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                        <asp:BoundField DataField="Account" HeaderText="Account" SortExpression="Account" />
                        <asp:BoundField DataField="College" HeaderText="College" SortExpression="College" />
                        <asp:BoundField DataField="Sex" HeaderText="Sex" SortExpression="Sex" />
                        <asp:BoundField DataField="Profession" HeaderText="Profession" SortExpression="Profession" />
                        <asp:BoundField DataField="BranchName" HeaderText="BranchName" SortExpression="BranchName" />
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
            <dx:ASPxPopupControl ID="popupEdit" runat="server" CloseAction="CloseButton" HeaderText="选择专业" Height="139px" Modal="True" ShowFooter="True" Theme="Aqua" Width="367px" PopupAnimationType="Fade" ShowCloseButton="False" ClientInstanceName="popupEdit" AllowDragging="True" Left="80" Top="100">
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
                        
                            试卷：<asp:DropDownList ID="cboType0" runat="server">
                                <asp:ListItem>A</asp:ListItem>
                                <asp:ListItem>B</asp:ListItem>
                            </asp:DropDownList>
                        
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>
            <asp:SqlDataSource ID="sdsPaper" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>" SelectCommand="SELECT Branch.BranchName FROM Branch INNER JOIN Branch AS Branch_1 ON Branch.ParentBranchID = Branch_1.BranchID AND Branch.BranchID &lt;&gt; Branch_1.BranchID WHERE (Branch_1.BranchName LIKE @College)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtCollege" Name="College" PropertyName="Value" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="sdsTeacher" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>" SelectCommand="SELECT Teacher.Name, Teacher.Account, Teacher.College, Teacher.Sex, Teacher.Profession, Branch.BranchName FROM Teacher INNER JOIN [User] ON Teacher.UserCode = [User].UserCode INNER JOIN Branch ON [User].BranchID = Branch.BranchID WHERE (Branch.BranchName LIKE @BranchName)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtCollege" Name="BranchName" PropertyName="Value" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:HiddenField ID="txtCount" runat="server" />

            <asp:HiddenField ID="txtCollege" runat="server" />
            <asp:HiddenField ID="txtTeacherID" runat="server" />

        </div>
    </form>
</body>
</html>
