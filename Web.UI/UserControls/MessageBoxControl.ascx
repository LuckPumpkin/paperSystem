<%@ Control Language="C#" AutoEventWireup="true" CodeFile="MessageBoxControl.ascx.cs"
    Inherits="UserControls_MessageBoxControl" %>
<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxPopupControl" TagPrefix="dxpc" %>
<dxpc:ASPxPopupControl ID="MessageBoxPopupControl" runat="server" AllowDragging="True"
    CloseAction="CloseButton" Theme="Aqua" HeaderText="消息" Height="98px" Left="30"
    Modal="True" Top="50" Width="330px" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter">
    <ContentStyle VerticalAlign="Top">
    </ContentStyle>
    <SizeGripImage Height="12px" Width="12px" />
    <ContentCollection>
        <dxpc:PopupControlContentControl ID="PopupControlContentControl2" runat="server">
            <table width="100%">
                <tr>
                    <td valign="top" style="width: 41px">
                        <asp:Image ID="imgMessageBoxIcon" runat="server" ImageAlign="Middle" ImageUrl="~/images/exclamation_icon.png"
                            Width="40px" />
                    </td>
                    <td valign="top" style="padding-left: 25px">
                        <asp:Label ID="lblMessageBoxMsg" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>
        </dxpc:PopupControlContentControl>
    </ContentCollection>
    <CloseButtonImage Height="16px" Width="17px" />
</dxpc:ASPxPopupControl>
