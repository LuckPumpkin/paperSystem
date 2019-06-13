<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ChangePassword.aspx.cs" Inherits="WebForms_Common_ChangePassword" %>

<%@ Register assembly="DevExpress.Web.v14.1, Version=14.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxPopupControl" tagprefix="dxpc" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>修改个人密码</title>
    <link href="~/css/style.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .auto-style1 {
            width: 190px;
        }
        .auto-style2 {
            height: 23px;
        }
        .auto-style3 {
            width: 190px;
            height: 23px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <h2>
            修改密码</h2>
                <table border="0" cellpadding="1" cellspacing="0" style="border-collapse: collapse;">
                    <tr>
                        <td align="right" class="auto-style2">
                            原密码：
                        </td>
                        <td class="auto-style3">
                            <asp:TextBox ID="CurrentPassword" runat="server" TextMode="Password"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="CurrentPasswordRequired" runat="server" ControlToValidate="CurrentPassword"
                                ErrorMessage="Password is required." ToolTip="Password is required." ValidationGroup="chgPassword">*</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">新密码： </td>
                        <td class="auto-style1">
                            <asp:TextBox ID="NewPassword" runat="server" TextMode="Password"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="NewPasswordRequired" runat="server" ControlToValidate="NewPassword"
                                ErrorMessage="New Password is required." ToolTip="New Password is required."
                                ValidationGroup="chgPassword">*</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">确认密码： </td>
                        <td class="auto-style1">
                            <asp:TextBox ID="ConfirmNewPassword" runat="server" TextMode="Password"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="ConfirmNewPasswordRequired" runat="server" ControlToValidate="ConfirmNewPassword"
                                ErrorMessage="Confirm New Password is required." ToolTip="Confirm New Password is required."
                                ValidationGroup="chgPassword">*</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" colspan="2">
                            <asp:CompareValidator ID="NewPasswordCompare" runat="server" ControlToCompare="NewPassword"
                                ControlToValidate="ConfirmNewPassword" Display="Dynamic" ErrorMessage="确认密码必须和新密码一致。"
                                ValidationGroup="chgPassword"></asp:CompareValidator>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" colspan="2" style="color: Red;">
                            <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" colspan="2">
                            <asp:Button ID="ChangePasswordPushButton" runat="server" CommandName="ChangePassword"
                                Text="修改" ValidationGroup="chgPassword" OnClick="ChangePasswordPushButton_Click" />
                        </td>
                    </tr>
                </table>
            <br />
<dxpc:ASPxPopupControl ID="MessageBox" runat="server" AllowDragging="True"
    CloseAction="CloseButton" Theme="Aqua" HeaderText="消息" Height="98px" Left="30"
    Modal="True" Top="50" Width="330px" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter">
    <ContentStyle VerticalAlign="Top">
    </ContentStyle>
    <SizeGripImage Height="12px" Width="12px" />
    <ContentCollection>
        <dxpc:PopupControlContentControl ID="PopupControlContentControl2" runat="server">
            <table style="width: 295px">
                <tr>
                    <td style="width: 41px" valign="top">
                        <asp:Image ID="imgMessageBoxIcon" runat="server" ImageAlign="Middle" ImageUrl="~/images/Information_icon.png" Width="40px" />
                    </td>
                    <td style="padding-left: 10px" valign="middle">已经成功完成对密码的更改！ </td>
                </tr>
            </table>
        </dxpc:PopupControlContentControl>
    </ContentCollection>
    <CloseButtonImage Height="16px" Width="17px" />
</dxpc:ASPxPopupControl>
        <br />
    </div>
    </form>
</body>
</html>
