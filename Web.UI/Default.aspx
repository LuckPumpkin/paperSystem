<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>华北理工大学-试卷管理系统</title>
    <link href="Css/style.css" rel="stylesheet" />
    <link rel="icon" href="../../images/huabeiligong_shijuanguanli.ico" type="image/x-icon" />
    <style type="text/css">
        body {
            margin: 0;
        }

        img {
            border-bottom: medium none;
            border-left: medium none;
            vertical-align: middle;
            border-top: medium none;
            border-right: medium none;
        }

        .wrapper {
            background: url(images/wrapper.png) #FFF repeat-x left top;
        }

        .header {
            height: 72px;
            color: #666;
        }

        .inner-header {
            width: 95%;
            margin: 0 auto;
        }

        .header a {
            color: #666;
        }
        .auto-style1
        {
            display:block;
            text-align:center;
            font-size:32px;
            position: relative;
            top: 9px;
            z-index:1;
        }

        .header .logo {
            background-image: url('images/logo.png');
            width: 570px;
            background-repeat: no-repeat;
            background-position: center center;
            float: left;
            height: 52px;
            cursor: pointer;
            margin: 6px 0;
        }

        .website-links {
            float: right;
            font-size: 115%;
            position: relative;
            margin: 18px 0;
            z-index:2;
        }

            .website-links div {
                display: inline;
                float: left;
                margin-left: 5px;
                margin-right: 5px;
                margin-top: 5px;
            }

            .website-links a {
                display: inline;
                float: left;
                margin-left: 5px;
                margin-right: 5px;
                cursor: pointer;
            }

                .website-links a span {
                    float: left;
                    height: 18px;
                    overflow: hidden;
                    padding: 5px 10px;
                }

                .website-links a.current, .website-links a:hover {
                    background: url(images/website-link-bg-left.png) no-repeat left top;
                    color: #FFF;
                    text-decoration: none;
                }

                    .website-links a.current span, .website-links a:hover span {
                        background: url(images/website-link-bg-right.png) no-repeat right top;
                    }

        .menuTree {
            margin: 0px 10px 0px 10px;
            padding: 8px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">

        <dx:ASPxSplitter ID="MainSplitter" runat="server" Height="100%" Width="100%" FullscreenMode="True" Orientation="Vertical">
            <Styles>
                <Pane>
                    <Paddings Padding="0px" />
                    <Border BorderWidth="0px" />
                </Pane>
            </Styles>
            <Panes>
                <dx:SplitterPane Name="HeaderPane" Size="72px">
                    <ContentCollection>
                        <dx:SplitterContentControl>
                            <div class="wrapper">
                                <div class="header">
                                    <div class="auto-style2" id="divlogo">
                                        <div class="website-links">
                                            <div>
                                                当前登录帐户：<asp:Label ID="lblName" runat="server" Text=""></asp:Label>
                                            </div>
                                            <div>
                                                &nbsp;|&nbsp;
                                            </div>
                                            <asp:LinkButton ID="btnLogout" runat="server" OnClick="btnLogout_Click"><span>注销</span></asp:LinkButton>
                                        </div>
                                        <span class="auto-style1"><strong>华北理工大学试卷管理系统</strong></span></div>
                                </div>
                            </div>
                        </dx:SplitterContentControl>
                    </ContentCollection>
                </dx:SplitterPane>
                <dx:SplitterPane Name="MainPane" Separator-Visible="False">
                    <Separator Visible="False"></Separator>
                    <PaneStyle CssClass="noborder"></PaneStyle>
                    <ContentCollection>
                        <dx:SplitterContentControl>
                            <dx:ASPxSplitter ID="SpliterMenuContent" runat="server" Height="100%" EnableTheming="False" PaneMinSize="0px" ShowSeparatorImage="False">
                                <Styles>
                                    <Pane>
                                        <Paddings Padding="0px" />
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
                                    <dx:SplitterPane Name="LeftPane" ShowCollapseBackwardButton="True" Size="280px" ScrollBars="Auto">
                                        <PaneStyle>
                                            <BorderRight BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="1px" />
                                        </PaneStyle>
                                        <ContentCollection>
                                            <dx:SplitterContentControl>
                                                <div class="menuTree">
                                                    <asp:TreeView ID="siteMapTree" runat="server" DataSourceID="smDS" ShowLines="True"
                                                        OnTreeNodeDataBound="siteMapTree_TreeNodeDataBound" ExpandDepth="3" PopulateNodesFromClient="False">
                                                        <RootNodeStyle ImageUrl="~/images/node-root.gif" />
                                                        <NodeStyle ImageUrl="~/images/node-normal.gif" HorizontalPadding="2px" />
                                                        <LeafNodeStyle ImageUrl="~/images/node-leaf.gif" />
                                                    </asp:TreeView>
                                                    <p>&nbsp;</p>
                                                </div>
                                            </dx:SplitterContentControl>
                                        </ContentCollection>
                                    </dx:SplitterPane>
                                    <dx:SplitterPane Name="ContentPane" ContentUrlIFrameName="fContent" ScrollBars="Auto" ContentUrl="~/Content.aspx">
                                        <Separator>
                                            <SeparatorStyle></SeparatorStyle>
                                        </Separator>
                                        <PaneStyle>
                                            <BorderLeft BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="1px" />
                                        </PaneStyle>
                                        <ContentCollection>
                                            <dx:SplitterContentControl>
                                            </dx:SplitterContentControl>
                                        </ContentCollection>
                                    </dx:SplitterPane>
                                </Panes>
                            </dx:ASPxSplitter>
                        </dx:SplitterContentControl>
                    </ContentCollection>
                </dx:SplitterPane>
            </Panes>
        </dx:ASPxSplitter>
        <asp:SiteMapDataSource ID="smDS" runat="server" />
    </form>
</body>
</html>
