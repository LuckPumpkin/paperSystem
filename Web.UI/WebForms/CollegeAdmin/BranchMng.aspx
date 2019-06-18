<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BranchMng.aspx.cs" Inherits="WebForms_Admin_BranchMng" %>

<%@ Register Src="../../UserControls/MessageBoxControl.ascx" TagName="MessageBoxControl" TagPrefix="uc1" %>
<%@ Register Assembly="Infrastructure" Namespace="Infrastructure.Controls" TagPrefix="cc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="../../css/style.css" rel="stylesheet" />
    <script src="../../script/jquery.js"></script>
    <style>
        #btnImport{
     margin: 5px 20px 10px 20px;
    -khtml-user-select: none;
    position: absolute;
    top: 28px;
    left: 160px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
         <%--<asp:LinkButton ID="btnImport" runat="server" OnClick="btnExcel_Click" Text="导出院系信息" Theme="Aqua">
                            </asp:LinkButton>--%>
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
                <dx:SplitterPane Name="TitlePane" Size="60px">
                    <PaneStyle>
                        <Paddings PaddingLeft="40px" />
                    </PaneStyle>
                    <ContentCollection>
                        <dx:SplitterContentControl runat="server">
                            <h2>院级专业查看</h2>
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
        
         <asp:HiddenField ID="txtAccount" runat="server" />
        <asp:HiddenField ID="txtPbrID" runat="server" />
            <asp:HiddenField ID="txtCollege" runat="server" />
            <asp:HiddenField ID="txtTeacherID" runat="server" />
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
            <asp:SqlDataSource ID="sdsSysAdmin" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>" SelectCommand="SELECT BranchID, ParentBranchID, BranchName FROM Branch WHERE (ParentBranchID LIKE @ParentBranchID)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtPbrID" Name="ParentBranchID" PropertyName="Value" />
                </SelectParameters>
                </asp:SqlDataSource> 
        </div>
    </form>
</body>
</html>
