<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OtherPrint.aspx.cs" Inherits="WebForms_CollegeAdmin_OtherPrint" %>
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
    <script src="../../script/GridLineHotTrack.js"></script>
    <script src="../../My97DatePicker/WdatePicker.js"></script>
    <style>
        .Panel {
            border-width: 2px;
            border-color: gray;
        }

        .FormViewTable td {
            border: 1px solid gray;
            border-collapse: collapse;
            height: 30px;
            line-height: 15px;
        }

        .FullLength {
            width: 150px;
            height: 25px;
            background-color: #F3F7FD;
            margin: 0px;
            padding: 0px;
        }
    </style>
</head>
<body style="margin-left: 10px">
    <form id="form1" runat="server">
        <div>
            <fieldset>
                <legend>查询条件</legend>
                <p style="width: 211px" />
                &nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:CheckBox ID="chkHave" runat="server" Text="已送印" />
                &nbsp;&nbsp;
                    
                 <asp:CheckBox ID="chkHavnot" runat="server" Text="未送印" />
                &nbsp;&nbsp;

                <p>
                    &nbsp;&nbsp;&nbsp;&nbsp;
                        学院 
                    <asp:DropDownList ID="DropDownListCollege" runat="server" AppendDataBoundItems="True" DataSourceID="sdsCollege" DataValueField="College" Height="25px" Width="130px">
                        <asp:ListItem Value="%">【全部】</asp:ListItem>
                    </asp:DropDownList>
                     &nbsp; 联系人：<asp:TextBox ID="txtTeacherName" runat="server" Width="109px"></asp:TextBox>

                </p>
                <p>
                    <%-- Text='<%DateTime.Parse("").ToShortDateString()%>'--%>
                    &nbsp;&nbsp;&nbsp;&nbsp; 交付日期：从
                    <asp:TextBox ID="txtjfDate1" runat="server" onclick="WdatePicker()"></asp:TextBox>&nbsp;到
                    <asp:TextBox ID="txtjfDate2" runat="server" onclick="WdatePicker()"></asp:TextBox>
                </p>
                <p>
                    <%-- Text='<%DateTime.Parse("").ToShortDateString()%>'--%>
                    &nbsp;&nbsp;&nbsp;&nbsp; 送印日期：从
                    <asp:TextBox ID="txtsyDate3" runat="server" onclick="WdatePicker()"></asp:TextBox>&nbsp;到
                    <asp:TextBox ID="txtsyDate4" runat="server" onclick="WdatePicker()"></asp:TextBox>
                    &nbsp; &nbsp;
                    <asp:LinkButton ID="LinkButton1" runat="server" OnClick="btnSearch_Click">检索</asp:LinkButton>&nbsp;&nbsp;
                </p>
            </fieldset>

            <br />
            <dx:ASPxMenu ID="mnuMain" runat="server" BackColor="White" EnableTheming="True" ShowAsToolbar="True" Theme="Default" OnItemClick="mnuToolBar_ItemClick"  >
                <ClientSideEvents ItemClick="function(s, e) {
    var itemName = e.item.name;
	switch(itemName){
        case 'College':
            popupEditCollege.Show();
			break;
        case 'jiezhang':
            PopupControljiezhagn.Show();  
			break;}
}" />
                <Paddings PaddingBottom="5px" PaddingTop="8px" />
                <Items>
                    <dx:MenuItem Text="撤销送印" Name="College" BeginGroup="True">
                        <Image Url="~/images/edit.png">
                        </Image>
                    </dx:MenuItem>
                    <dx:MenuItem Text="结账" Name="jiezhang" BeginGroup="True">
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

            <div style="overflow-x: visible">
                <br />
                <asp:CheckBox ID="CheckBox" runat="server" AutoPostBack="True" OnCheckedChanged="CheckBox_CheckedChanged" Text="全选" />
                <div style="text-align:center">
                <cc1:MyGridView ID="gvOrder" runat="server" AutoGenerateColumns="False" CssClass="dataTable" DataSourceID="sdsOrder" ClientInstanceName="grid" OnRowCommand="gvOrder_RowCommand" AllowSorting="True" EmptyDataText="没有找到任何数据！">
                    <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
                    <Columns>
                        <asp:BoundField DataField="College" HeaderText="" SortExpression="College" Visible="false" />
                        <asp:TemplateField HeaderText="选择" ShowHeader="False">
                            <ItemTemplate>
                                <asp:CheckBox ID="CheckBox" runat="server" />
                                <asp:Label ID="lbPid" runat="server" Text='<%# Bind("ID") %>' Visible="False"></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle Font-Size="Medium" />
                        </asp:TemplateField>
                        <asp:ButtonField CommandName="print" HeaderText="送印" Text="送印" >
                        <ControlStyle Font-Size="Medium" />
                        <HeaderStyle Font-Size="Medium" />
                        </asp:ButtonField>
                    <asp:BoundField DataField="Name" HeaderText="文件名称" SortExpression="Name" />
                    <asp:BoundField DataField="Tname" HeaderText="联系人" SortExpression="Tname" />
                    <asp:BoundField DataField="pageNum" HeaderText="文件页数" SortExpression="pageNum" />
                    <asp:BoundField DataField="printNum" HeaderText="打印份数" SortExpression="printNum" />
                    <asp:BoundField DataField="paper" HeaderText="纸张规格" SortExpression="paper" />
                    <asp:BoundField DataField="SingleOrDouble" HeaderText="单双面" SortExpression="SingleOrDouble" />
                    <asp:BoundField DataField="printColor" HeaderText="墨水选择" SortExpression="printColor" />
                    <asp:BoundField DataField="paperSize" HeaderText="成品规格" SortExpression="paperSize" />
                    <asp:BoundField DataField="cover" HeaderText="封皮选择" SortExpression="cover" />
                    <asp:BoundField DataField="bindMethod" HeaderText="装订方式" SortExpression="bindMethod" />
                    <asp:BoundField DataField="state" HeaderText="订单状态" SortExpression="state" />
                    <asp:BoundField DataField="total" HeaderText="总额" SortExpression="total" />
                    </Columns>

                    <EditRowStyle CssClass="highlightRow"></EditRowStyle>

                    <HeaderStyle CssClass="FixedHeader"></HeaderStyle>

                    <PagerSettings FirstPageText="首页" LastPageText="尾页" NextPageText="下一页" PreviousPageText="上一页"></PagerSettings>

                    <PagerStyle CssClass="pagerRow"></PagerStyle>

                    <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
                </cc1:MyGridView>
            </div>
                </div>

            <asp:SqlDataSource ID="sdsOrder" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>" SelectCommand="IF(@Order_Have = 0 AND @Order_Havenot = 0) SELECT * FROM OtherPtint WHERE (College LIKE '%' + @College + '%') AND (Tname LIKE '%' + @Tname + '%') AND ((state LIKE '待送印') OR (state LIKE '待结账')) AND (getTime BETWEEN CONVERT(datetime, @jfdate1) AND CONVERT(datetime, @jfdate2)) AND (subTime BETWEEN CONVERT(datetime, @syDate3) AND CONVERT(datetime, @syDate4)) AND ((printed = 1) OR (printed = 0)) IF(@Order_Have = 1 AND @Order_Havenot = 1) SELECT * FROM OtherPtint WHERE (College LIKE '%' + @College + '%') AND (Tname LIKE '%' + @Tname + '%') AND ((state LIKE '待送印') OR (state LIKE '待结账')) AND (getTime BETWEEN CONVERT(datetime, @jfdate1) AND CONVERT(datetime, @jfdate2)) AND (subTime BETWEEN CONVERT(datetime, @syDate3) AND CONVERT(datetime, @syDate4)) AND ((printed = 1) OR (printed = 0)) IF(@Order_Have = 1 AND @Order_Havenot = 0) SELECT * FROM OtherPtint WHERE (College LIKE '%' + @College + '%') AND (Tname LIKE '%' + @Tname + '%') AND ((state LIKE '待送印') OR (state LIKE '待结账')) AND (getTime BETWEEN CONVERT(datetime, @jfdate1) AND CONVERT(datetime, @jfdate2)) AND (subTime BETWEEN CONVERT(datetime, @syDate3) AND CONVERT(datetime, @syDate4)) AND (printed = 1) IF(@Order_Have = 0 AND @Order_Havenot = 1) SELECT * FROM OtherPtint WHERE (College LIKE '%' + @College + '%') AND (Tname LIKE '%' + @Tname + '%') AND ((state LIKE '待送印') OR (state LIKE '待结账')) AND (getTime BETWEEN CONVERT(datetime, @jfdate1) AND CONVERT(datetime, @jfdate2)) AND (subTime BETWEEN CONVERT(datetime, @syDate3) AND CONVERT(datetime, @syDate4)) AND (printed = 0)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="chkHave" DefaultValue="0" Name="Order_Have" PropertyName="Checked" />
                    <asp:ControlParameter ControlID="chkHavnot" DefaultValue="0" Name="Order_Havenot" PropertyName="Checked" />
                    <asp:ControlParameter ControlID="DropDownListCollege" DefaultValue="%" Name="College" PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="txtTeacherName" DefaultValue="%" Name="Tname" PropertyName="Text" />
                    <asp:ControlParameter ControlID="txtjfDate1" DefaultValue="2010-01-01" Name="jfDate1" PropertyName="Text" />
                    <asp:ControlParameter ControlID="txtjfDate2" DefaultValue="2100-01-01" Name="jfDate2" PropertyName="Text" />
                    <asp:ControlParameter ControlID="txtsyDate3" DefaultValue="2010-01-01" Name="syDate3" PropertyName="Text" />
                    <asp:ControlParameter ControlID="txtsyDate4" DefaultValue="2100-01-01" Name="syDate4" PropertyName="Text" />
                </SelectParameters>
            </asp:SqlDataSource>

        </div>
        <asp:SqlDataSource ID="sdsCollege" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>"
            SelectCommand="SELECT DISTINCT College FROM OtherPtint"></asp:SqlDataSource>

        <%------------------------生成生产通知单弹出框----------------------------%>
        <dx:ASPxPopupControl ID="popupOrder" runat="server" AllowDragging="True" CloseAction="CloseButton" HeaderText="打印" Height="493px" Modal="True" PopupHorizontalAlign="WindowCenter" ShowCloseButton="true" PopupVerticalAlign="WindowCenter" Theme="Aqua" Width="862px" AllowResize="True">
            <ClientSideEvents CloseUp="function(s, e) {
	__doPostBack('btnRefresh','');
}" />
            <ContentCollection>

                <dx:PopupControlContentControl ID="PopupControlContentControl4" runat="server" SupportsDisabledAttribute="True">
                    <br />
                    <br />
                </dx:PopupControlContentControl>
            </ContentCollection>
        </dx:ASPxPopupControl>

        <dx:ASPxPopupControl ID="popupEditCollege" runat="server" CloseAction="CloseButton" HeaderText="撤销送印" Height="139px" Modal="True" ShowFooter="True" Theme="Aqua" Width="367px" PopupAnimationType="Fade" ShowCloseButton="False" ClientInstanceName="popupEditCollege" AllowDragging="True" Left="80" Top="100">
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
                    确定撤销所选订单的送印吗？
                </dx:PopupControlContentControl>
            </ContentCollection>
        </dx:ASPxPopupControl>
        <dx:ASPxPopupControl ID="PopupControljiezhagn" runat="server" CloseAction="CloseButton" HeaderText="结账" Height="139px" Modal="True" ShowFooter="True" Theme="Aqua" Width="367px" PopupAnimationType="Fade" ShowCloseButton="False" ClientInstanceName="PopupControljiezhagn" AllowDragging="True" Left="80" Top="100">
            <HeaderImage Url="~/images/edit.png">
            </HeaderImage>
            <FooterStyle>
                <Paddings Padding="5px" />
            </FooterStyle>
            <FooterTemplate>
                <dx:ASPxMenu ID="mnuToolBar" runat="server" EnableTheming="True" Theme="Aqua" ShowAsToolbar="True" OnItemClick="mnuToolBar_ItemClickjiezhang">
                    <ClientSideEvents ItemClick="function(s, e) {
    var itemName = e.item.name;
	switch(itemName){
		case 'Cancel':
			PopupControljiezhagn.Hide()
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
                <dx:PopupControlContentControl ID="PopupControlContentControl3" runat="server" SupportsDisabledAttribute="True">
                    确定结账所选记录吗？结账后无法撤回。
                </dx:PopupControlContentControl>
            </ContentCollection>
        </dx:ASPxPopupControl>

        <uc1:MessageBoxControl ID="MsgBox" runat="server" />
    </form>
</html>
