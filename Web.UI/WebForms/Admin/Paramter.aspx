<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Paramter.aspx.cs" Inherits="WebForms_Admin_Paramter" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="Infrastructure" Namespace="Infrastructure.Controls" TagPrefix="cc1" %>
<%@ Register Src="~/UserControls/MessageBoxControl.ascx" TagPrefix="uc2" TagName="MessageBoxControl" %>
<%@ Register src="../../UserControls/MessageBoxControl.ascx" tagname="MessageBoxControl" tagprefix="uc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
     <link href="../../css/style.css" rel="stylesheet" />
    <script src="../../script/jquery.js" type="text/javascript"></script>
    <script src="../../script/GridLineHotTrack.js"></script>
    <style type="text/css">

.dxmLite
{
	font: 12px Tahoma, Geneva, sans-serif;
}
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <h2>参数管理</h2>
     <cc1:MyGridView ID="gvParameter" runat="server" CssClass="dataTable" DataSourceID="sdsParameter" EmptyDataText="没有找到任何数据！" AllowSorting="true" OnRowCommand="gvCourse_RowCommand" AutoGenerateColumns="False" DataKeyNames="ID" >
            
         
<AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>

          <Columns>
               <asp:TemplateField HeaderText="ID" InsertVisible="False" Visible="false" SortExpression="ID">
                        <ItemTemplate>                           
                            <asp:Label ID="lbID" runat="server" Text='<%# Eval("ID") %>'></asp:Label>
                            <asp:Label ID="lbName" runat="server" Text='<%# Eval("paraName") %>'></asp:Label>
                            <asp:Label ID="lbpara" runat="server" Text='<%# Eval("paraValue") %>'></asp:Label>

                        </ItemTemplate>
                    </asp:TemplateField>
              <asp:BoundField DataField="paraName" HeaderText="参数名" SortExpression="paraName" />
              <asp:BoundField DataField="paraValue" HeaderText="价格" SortExpression="paraValue" />
              <asp:ButtonField Text="修改" CommandName="xiugai" />
          </Columns>

<EditRowStyle CssClass="highlightRow"></EditRowStyle>

<HeaderStyle CssClass="FixedHeader"></HeaderStyle>

<PagerSettings FirstPageText="首页" LastPageText="尾页" NextPageText="下一页" PreviousPageText="上一页"></PagerSettings>

<PagerStyle CssClass="pagerRow"></PagerStyle>

<SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
            
         
          </cc1:MyGridView>
    <asp:HiddenField ID="txtID" runat="server" />
        <asp:SqlDataSource ID="sdsParameter" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>" SelectCommand="SELECT Parameter.* FROM Parameter" UpdateCommand="UPDATE Parameter SET paraValue = @paraValue WHERE (ID = @ID)">
            <UpdateParameters>
                <asp:Parameter Name="paraValue" />
                <asp:Parameter Name="ID" />
            </UpdateParameters>
        </asp:SqlDataSource>

        <br />
        <dx:ASPxPopupControl ID="popupSaveParameter" runat="server" CloseAction="CloseButton" HeaderText="修改" Height="165px" Modal="True" ShowFooter="True" Theme="Aqua" Width="357px" PopupAnimationType="Fade" ShowCloseButton="False" ClientInstanceName="popupSaveTeacher" AllowDragging="True" Left="80" Top="100">
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
                    
                        &nbsp;参 数 名： <asp:Label ID="txtparaName" runat="server"  />
                    
                        &nbsp;<br />
                        <br />
                        &nbsp;单&nbsp;&nbsp;&nbsp;&nbsp; 价：<asp:TextBox ID="txtpareValue" runat="server"></asp:TextBox>
                    
                </dx:PopupControlContentControl>
            </ContentCollection>
        </dx:ASPxPopupControl>


        <asp:SqlDataSource runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>" SelectCommand="SELECT Parameter.* FROM Parameter
where ID =@ID"
            ID="SqlDataSource1" UpdateCommand="UPDATE Parameter SET paraValue = @paraValue WHERE (ID = @ID)">
            <SelectParameters>
                <asp:QueryStringParameter QueryStringField="ID" Name="ID"></asp:QueryStringParameter>
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="paraValue" />
                <asp:Parameter Name="ID" />
            </UpdateParameters>
        </asp:SqlDataSource>

        <uc1:MessageBoxControl ID="MsgBox" runat="server" />
                 
    </div>
    </form>
</body>
</html>
