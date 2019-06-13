<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OtherPrint.aspx.cs" Inherits="WebForms_SchoolAdmin_OtherPrint" %>

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
    <script src="../../script/GridLineHotTrack.js"></script>
    <script src="../../My97DatePicker/WdatePicker.js"></script>
    <style>
        .span_px{
        color:red;
        position: absolute;
        top: 32px;
        display: inline-block;
        left: 185px;
    }
    </style>
</head>
    <body>
    <form id="form1" runat="server">
    <div>
         <h2>校级其他文件打印</h2><span class="span_px">*新建打印单后打印文件参数将以表格形式展示</span>
          <dx:ASPxButton ID="ASPxButton1" Theme="Aqua" runat="server" Text="新建打印" OnClick="btnNew_Click" style="margin:5px 5px 5px 0px;"></dx:ASPxButton>
         <br />
         <br />
        <asp:Panel ID="Panel1" runat="server" >
            <%--<asp:CheckBox ID="CheckBox" runat="server" AutoPostBack="True" OnCheckedChanged="CheckBox_CheckedChanged" Text="全选" />--%>
            <cc1:MyGridView ID="gvDetail" runat="server" AutoGenerateColumns="False" CssClass="dataTable" AllowSorting="True" OnRowCommand="gvDetail_RowCommand" EmptyDataText="没有找到任何数据！" DataSourceID="SqlDataSource1" >
                <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
                <Columns>
                    <asp:TemplateField InsertVisible="False" Visible="false" SortExpression="ID">
                        <ItemTemplate>
                            <asp:Label ID="lbOrderID" runat="server" Text='<%# Bind("ID") %>' Visible="False"></asp:Label>
                            <asp:Label ID="lbName" runat="server" Text='<%# Bind("Name") %>' Visible="False"></asp:Label>
                            <asp:Label ID="lbpageNum" runat="server" Text='<%# Bind("pageNum") %>' Visible="False"></asp:Label>
                            <asp:Label ID="lbprintNum" runat="server" Text='<%# Bind("printNum") %>' Visible="False"></asp:Label>
                            <asp:Label ID="lbpaper" runat="server" Text='<%# Bind("paper") %>' Visible="False"></asp:Label>
                            <asp:Label ID="lbSingleOrDouble" runat="server" Text='<%# Bind("SingleOrDouble") %>' Visible="False"></asp:Label>
                            <asp:Label ID="lbprintColor" runat="server" Text='<%# Bind("printColor") %>' Visible="False"></asp:Label>
                            <asp:Label ID="lbpaperSize" runat="server" Text='<%# Bind("paperSize") %>' Visible="False"></asp:Label>
                            <asp:Label ID="lbcover" runat="server" Text='<%# Bind("cover") %>' Visible="False"></asp:Label>
                            <asp:Label ID="lbbindMethod" runat="server" Text='<%# Bind("bindMethod") %>' Visible="False"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Name" HeaderText="文件名称" SortExpression="Name" />
                    <asp:BoundField DataField="pageNum" HeaderText="文件页数" SortExpression="pageNum" />
                    <asp:BoundField DataField="printNum" HeaderText="打印份数" SortExpression="printNum" />
                    <asp:BoundField DataField="paper" HeaderText="纸张规格" SortExpression="paper" />
                    <asp:BoundField DataField="SingleOrDouble" HeaderText="单双面" SortExpression="SingleOrDouble" />
                    <asp:BoundField DataField="printColor" HeaderText="墨水选择" SortExpression="printColor" />
                    <asp:BoundField DataField="paperSize" HeaderText="成品规格" SortExpression="paperSize" />
                     <asp:BoundField DataField="cover" HeaderText="封皮选择" SortExpression="cover" />
                    <asp:BoundField DataField="bindMethod" HeaderText="装订方式" SortExpression="bindMethod" />
                    <asp:ButtonField CommandName="PrintEdit" HeaderText="编辑" Text="编辑" />
                    <asp:TemplateField HeaderText="交付时间" ShowHeader="False" SortExpression="getTime">
                        <ItemTemplate>
                            <asp:TextBox ID="Time" runat="server" Text='<%# Bind("getTime") %>' onclick="WdatePicker()"></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField> 
                    <asp:ButtonField CommandName="Submit" HeaderText="提交" Text="提交" />
                </Columns>
                <EditRowStyle CssClass="highlightRow"></EditRowStyle>
                <HeaderStyle CssClass="FixedHeader"></HeaderStyle>
                <PagerSettings FirstPageText="首页" LastPageText="尾页" NextPageText="下一页" PreviousPageText="上一页">
                </PagerSettings>
                <PagerStyle CssClass="pagerRow"></PagerStyle>
                <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
            </cc1:MyGridView>
            </asp:Panel>
         <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>" SelectCommand="SELECT DISTINCT ID, Name, College, pageNum, printNum, paper, printColor, paperSize, SingleOrDouble, bindMethod, cover, getTime, subTime, total, printed FROM OtherPtint WHERE (College LIKE @college) AND (state is null)" UpdateCommand="UPDATE OtherPtint SET getTime = @getTime WHERE (ID LIKE @ID)">
            <SelectParameters>
                <asp:ControlParameter ControlID="txtCollege" Name="college" PropertyName="Value" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="getTime" />
                <asp:Parameter Name="ID" />
            </UpdateParameters>
        </asp:SqlDataSource>
         <br />
        <uc2:MessageBoxControl runat="server" ID="MsgBox" />
        <dx:ASPxPopupControl ID="popupEdit" runat="server" CloseAction="CloseButton" HeaderText="新建打印" Height="275px" Modal="True" ShowFooter="True" Theme="Aqua" Width="357px" PopupAnimationType="Fade" ShowCloseButton="False" ClientInstanceName="popupEdit" AllowDragging="True" Left="80" Top="100">
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
			popupEdit.Hide();
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
                        文件名称：<asp:TextBox ID="txtName" runat="server"></asp:TextBox>   
                        <br />
                        <br />
                        文件页数：<asp:TextBox ID="txtpageNum" runat="server"></asp:TextBox>
                        <br />
                        <br />                 
                        打印份数：<asp:TextBox runat="server" ID="txtPrintNum"></asp:TextBox>

                        <br />
                        <br />
                        纸张规格：<asp:DropDownList ID="dropaper" runat="server" Height="25px" Width="51px">
                            <asp:ListItem Value="70">70</asp:ListItem>
                            <asp:ListItem Value="80">80</asp:ListItem>
                        </asp:DropDownList>
                        <br />
                        <br />
                        单&nbsp; 双 面：<asp:DropDownList ID="droSingleOrDouble" runat="server" Height="25px" Width="51px">
                            <asp:ListItem Value="单面">单面</asp:ListItem>
                            <asp:ListItem Value="双面">双面</asp:ListItem>
                        </asp:DropDownList>
                        <br />
                        <br />
                        墨水选择：<asp:DropDownList ID="droprintColor" runat="server" Height="25px" Width="51px">
                            <asp:ListItem Value="黑白">黑白</asp:ListItem>
                            <asp:ListItem Value="彩印">彩印</asp:ListItem>
                        </asp:DropDownList>
                        <br />
                        <br />
                        成品规格：<asp:DropDownList runat="server" ID="dropaperSize" Height="25px" Width="75px">
                            <asp:ListItem Value="32开">32开</asp:ListItem>
                            <asp:ListItem Value="16开">16开</asp:ListItem>
                            <asp:ListItem Value="8开">8开</asp:ListItem>
                        </asp:DropDownList>
                        <br />
                        <br />
                        封皮选择：<asp:DropDownList ID="drocover" runat="server" Height="25px" Width="75px">
                            <asp:ListItem Value="皮卡纸">皮卡纸</asp:ListItem>
                            <asp:ListItem Value="白卡纸">白卡纸</asp:ListItem>
                        </asp:DropDownList>
                        <br />
                        <br />
                        装订方式：<asp:DropDownList ID="drobindMethod" runat="server" Height="25px" Width="75px">
                            <asp:ListItem Value="骑马订">骑马订</asp:ListItem>
                            <asp:ListItem Value="胶订">胶订</asp:ListItem>
                        </asp:DropDownList>
                        <br /> 
                </dx:PopupControlContentControl>
            </ContentCollection>
        </dx:ASPxPopupControl>
        <dx:ASPxPopupControl ID="popupEdit1" runat="server" CloseAction="CloseButton" HeaderText="打印参数编辑" Height="275px" Modal="True" ShowFooter="True" Theme="Aqua" Width="357px" PopupAnimationType="Fade" ShowCloseButton="False" ClientInstanceName="popupEdit1" AllowDragging="True" Left="80" Top="100">
            <HeaderImage Url="~/images/edit.png">
            </HeaderImage>
            <FooterStyle>
                <Paddings Padding="5px" />
            </FooterStyle>
            <FooterTemplate>
                <dx:ASPxMenu ID="mnuToolBar1" runat="server" EnableTheming="True" Theme="Aqua" ShowAsToolbar="True" OnItemClick="mnuToolBar_ItemClick">
                 <ClientSideEvents ItemClick="function(s, e) {
    var itemName = e.item.name;
	switch(itemName){
		case 'Cancel':
			popupEdit1.Hide();
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
                <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server" SupportsDisabledAttribute="True">
                        文件名称：<asp:TextBox ID="txtName1" runat="server"></asp:TextBox>   
                        <br />
                        <br />
                        文件页数：<asp:TextBox ID="txtpageNum1" runat="server"></asp:TextBox>
                        <br />
                        <br />                 
                        打印份数：<asp:TextBox runat="server" ID="txtPrintNum1"></asp:TextBox>

                        <br />
                        <br />
                        纸张规格：<asp:DropDownList ID="dropaper1" runat="server" Height="25px" Width="51px">
                            <asp:ListItem Value="70">70</asp:ListItem>
                            <asp:ListItem Value="80">80</asp:ListItem>
                        </asp:DropDownList>
                        <br />
                        <br />
                        单&nbsp; 双 面：<asp:DropDownList ID="droSingleOrDouble1" runat="server" Height="25px" Width="51px">
                            <asp:ListItem Value="单面">单面</asp:ListItem>
                            <asp:ListItem Value="双面">双面</asp:ListItem>
                        </asp:DropDownList>
                        <br />
                        <br />
                        墨水选择：<asp:DropDownList ID="droprintColor1" runat="server" Height="25px" Width="51px">
                            <asp:ListItem Value="黑白">黑白</asp:ListItem>
                            <asp:ListItem Value="彩印">彩印</asp:ListItem>
                        </asp:DropDownList>
                        <br />
                        <br />
                        成品规格：<asp:DropDownList runat="server" ID="dropaperSize1" Height="25px" Width="75px">
                            <asp:ListItem Value="32开">32开</asp:ListItem>
                            <asp:ListItem Value="16开">16开</asp:ListItem>
                            <asp:ListItem Value="8开">8开</asp:ListItem>
                        </asp:DropDownList>
                        <br />
                        <br />
                        封皮选择：<asp:DropDownList ID="drocover1" runat="server" Height="25px" Width="75px">
                            <asp:ListItem Value="皮卡纸">皮卡纸</asp:ListItem>
                            <asp:ListItem Value="白卡纸">白卡纸</asp:ListItem>
                        </asp:DropDownList>
                        <br />
                        <br />
                        装订方式：<asp:DropDownList ID="drobindMethod1" runat="server" Height="25px" Width="87px">
                            <asp:ListItem Value="骑马订">骑马订</asp:ListItem>
                            <asp:ListItem Value="胶订">胶订</asp:ListItem>
                        </asp:DropDownList>
                        <br /> 
                      <asp:HiddenField ID="txtID" runat="server" />
                </dx:PopupControlContentControl>
            </ContentCollection>
        </dx:ASPxPopupControl>
        <asp:HiddenField ID="txtTeacherId" runat="server" />
        <asp:HiddenField ID="txtCollege" runat="server" />
        <asp:HiddenField ID="txtTeacher" runat="server" />
    </div>
    </form>
</body>
</html>
