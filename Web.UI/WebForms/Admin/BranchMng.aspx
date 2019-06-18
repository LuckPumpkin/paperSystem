<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BranchMng.aspx.cs" Inherits="WebForms_Admin_BranchMng" %>

<%@ Register Src="../../UserControls/MessageBoxControl.ascx" TagName="MessageBoxControl" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<%@ Register Assembly="Infrastructure" Namespace="Infrastructure.Controls" TagPrefix="cc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="../../css/style.css" rel="stylesheet" />
    <script src="../../script/jquery.js"></script>
    <style>
        #MainSplitter_btn1{
                margin: 5px 20px 10px 20px;
    -khtml-user-select: none;
    position: absolute;
    top: 64px;
    left: 202px;
        }
    </style>
    <script>
        function clickButton(filePath, fileName) {
            __doPostBack('btnImport', '');
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <dx:ASPxSplitter ID="MainSplitter" runat="server" Width="100%" EnableTheming="False" PaneMinSize="0px" ShowSeparatorImage="False" Height="100%" FullscreenMode="True" Orientation="Vertical" SeparatorVisible="False">
            <Styles>
                <Pane>
                    <Paddings Padding="10px" />
                    <Border BorderStyle="None" />
                </Pane>
                <Separator BackColor="#EEEEEE">
                    <HoverStyle BackColor="#FFCC00">
                    </HoverStyle>
                </Separator>
                <SeparatorButton>
                    <HoverStyle BackColor="#FFCC00">
                    </HoverStyle>
                </SeparatorButton>
            </Styles>
            <Panes>
                <dx:SplitterPane AutoHeight="True">
                    <ContentCollection>
                        <dx:SplitterContentControl runat="server">
                            <h2>部门管理</h2>
                        </dx:SplitterContentControl>
                    </ContentCollection>
                </dx:SplitterPane>
                <dx:SplitterPane Name="ToolPan" AutoHeight="True">
                    <PaneStyle>
                        <Paddings PaddingBottom="0px" PaddingLeft="30px" PaddingRight="0px" PaddingTop="0px" />
                    </PaneStyle>
                    <ContentCollection>
                        <dx:SplitterContentControl runat="server">
                            <dx:ASPxMenu ID="mnuMain" runat="server" BackColor="White" ClientInstanceName="mnuMain" EnableClientSideAPI="True" EnableTheming="True" OnItemClick="mnuMain_ItemClick" ShowAsToolbar="True" Theme="Default">
                                <ClientSideEvents ItemClick="function(s, e) {
    var itemName = e.item.name;
	var currentNode = treeBranch.GetSelectedNode();
	switch(itemName){
		case 'AddChild':
			if (!currentNode) {
				alert('请先选择当前部门！');
			}
			else {
				$('#popupEdit_txtBranchName').val('');
				$('#popupEdit_hdMode').val('AddChild');
				popupEdit.Show();
			}
			e.processOnServer = false;
			break;
		case 'InsertItem':
			if (!currentNode){
				alert('请先选择当前部门！');
			}
			else if(currentNode.parent == null){
				alert('无法为根部门添加兄弟部门！');
			}
			else {
				$('#popupEdit_txtBranchName').val('');
				$('#popupEdit_hdMode').val('InsertItem');
				popupEdit.Show();
			}
			e.processOnServer = false;
			break;
		case 'DeleteItem':
			if (!currentNode){
				alert('请先选择当前部门！');
				break;
			}
			else if(currentNode.parent == null){
				alert('无法删除根部门！');
				break;
			}
            if(confirm('您真的要删除当前部门吗？'))
				e.processOnServer = true;
            else
                e.processOnServer = false;
			break;
		case 'Edit':
			$('#popupEdit_txtBranchName').val(currentNode.text);
			$('#popupEdit_hdMode').val('Edit');
			popupEdit.Show();
			e.processOnServer = false;
			break;
		case 'Expand':
			treeBranch.ExpandAll();
			e.processOnServer = false;
			break;
		case 'Collapse':
			treeBranch.CollapseAll();
			e.processOnServer = false;
			break;
	}
}" />
                                <Paddings PaddingBottom="5px" PaddingTop="8px" />
                                <Items>
                                    
                                    <dx:MenuItem Name="AddChild" Text="" ToolTip="添加子部门">
                                        <Image Url="~/images/TreeIcon/AddChildItem.png">
                                        </Image>
                                    </dx:MenuItem>
                                    <dx:MenuItem Name="InsertItem" Text="" ToolTip="插入同级部门">
                                        <Image Url="~/images/TreeIcon/InsertItem.png">
                                        </Image>
                                    </dx:MenuItem>
                                    <dx:MenuItem Name="DeleteItem" Text="" ToolTip="删除部门">
                                        <Image Url="~/images/TreeIcon/DeleteItem.png">
                                        </Image>
                                    </dx:MenuItem>
                                    <dx:MenuItem BeginGroup="True" Name="Edit" Text="" ToolTip="编辑">
                                        <Image Url="~/images/edit.png">
                                        </Image>
                                    </dx:MenuItem>
                                    <dx:MenuItem BeginGroup="True" Name="Expand" Text="" ToolTip="全部展开">
                                        <Image Url="~/images/TreeIcon/Expand.png">
                                        </Image>
                                    </dx:MenuItem>
                                    <dx:MenuItem Name="Collapse" Text="" ToolTip="折叠">
                                        <Image Url="~/images/TreeIcon/Collapse.png">
                                        </Image>
                                    </dx:MenuItem>
                                    <dx:MenuItem Name="down" Text="" ToolTip="导出Excel">
                                        <Image Url="~/images/export.png">
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
                        </dx:SplitterContentControl>
                    </ContentCollection>
                </dx:SplitterPane>
                <dx:SplitterPane Name="TreePane" ScrollBars="Auto">
                    <PaneStyle>
                        <Paddings PaddingBottom="10px" PaddingLeft="30px" PaddingRight="10px" PaddingTop="10px" />
                    </PaneStyle>
                    <ContentCollection>
                        <dx:SplitterContentControl runat="server">
                            <dx:ASPxTreeView ID="treeBranch" runat="server" AllowSelectNode="True" ClientInstanceName="treeBranch" EnableTheming="True" Theme="Aqua">
                            </dx:ASPxTreeView>                            
                        </dx:SplitterContentControl>
                    </ContentCollection>
                </dx:SplitterPane>
            </Panes>
        </dx:ASPxSplitter>
        <dx:ASPxPopupControl ID="popupEdit" runat="server" CloseAction="CloseButton" HeaderText="编辑部门信息" Height="139px" Modal="True" ShowFooter="True" Theme="Aqua" Width="367px" PopupAnimationType="Fade" ShowCloseButton="False" ClientInstanceName="popupEdit" AllowDragging="True" Left="80" Top="100">
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
			break;
	}
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
                    
                        部门名称：<asp:TextBox ID="txtBranchName" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtBranchName" CssClass="red" ErrorMessage="（必填字段）"></asp:RequiredFieldValidator>
                        <asp:HiddenField ID="hdMode" runat="server" />
                    
                </dx:PopupControlContentControl>
            </ContentCollection>
        </dx:ASPxPopupControl>
        <uc1:MessageBoxControl ID="MsgBox" runat="server" />
        <div style="display:none">
            <cc1:MyGridView ID="gvSysAdmin" runat="server" ClientInstanceName="gvSysAdmin" AutoGenerateColumns="False" CssClass="dataTable" DataKeyNames="BranchID" DataSourceID="sdsSysAdmin" EmptyDataText="没有找到任何数据！">
                    <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>

                    <Columns>
                        <asp:BoundField DataField="BranchID" HeaderText="部门ID"/>
                        <asp:BoundField DataField="ParentBranchID" HeaderText="父级部门ID"/>
                        <asp:BoundField DataField="BranchName" HeaderText="部门名称"/>   
                    </Columns>

                    <EditRowStyle CssClass="highlightRow"></EditRowStyle>

                    <HeaderStyle CssClass="headerRow"></HeaderStyle>

                    <PagerSettings FirstPageText="首页" LastPageText="尾页" NextPageText="下一页" PreviousPageText="上一页"></PagerSettings>

                    <PagerStyle CssClass="pagerRow"></PagerStyle>

                    <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
                </cc1:MyGridView>
            <asp:SqlDataSource ID="sdsSysAdmin" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>" SelectCommand="SELECT BranchID, ParentBranchID, BranchName FROM Branch">
                </asp:SqlDataSource> 
        </div>
                  <%--<div style="position: absolute;
    top: 80px;
    left: 249px; width: 435px;"> <asp:FileUpload ID="files" runat="server" />
          <asp:LinkButton ID="LinkButton1" runat="server" OnClick="btnExcel" Text="模板下载" Theme="Aqua" CausesValidation="False"></asp:LinkButton>&nbsp;&nbsp;
          <asp:LinkButton ID="btnImport" runat="server" OnClick="btnImport_Click" Text="导入数据库" Theme="Aqua" CausesValidation="False"></asp:LinkButton></div>--%>
    </form>
</body>
</html>
