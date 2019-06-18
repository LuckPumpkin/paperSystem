<%@ Control Language="C#" AutoEventWireup="true" CodeFile="MoverList.ascx.cs" Inherits="UserControls_MoverList" %>
<table class="MoverListTable" cellspacing="0" cellpadding="0">
    <tr>
        <td class="ListHeader">
            可导入字段：
        </td>
        <td>
            &nbsp;
        </td>
        <td class="ListHeader">
            待导入字段：
        </td>
        <td>
            &nbsp;
        </td>
    </tr>
    <tr style="vertical-align: top">
        <td>
            <asp:ListBox ID="lstLeft" runat="server" SelectionMode="Multiple" CssClass="LeftListBox">
            </asp:ListBox>
        </td>
        <td>
            <asp:Button ID="btnMoveRight" runat="server" Text="&gt;" CssClass="MoverButton" OnClick="btnMoveRight_Click" /><br />
            <asp:Button ID="btnMoveRightAll" runat="server" Text="&gt;&gt;" CssClass="MoverButton"
                OnClick="btnMoveRightAll_Click" /><br />
            <asp:Button ID="btnMoveLeft" runat="server" Text="&lt;" CssClass="MoverButton" OnClick="btnMoveLeft_Click"
                Style="height: 21px" /><br />
            <asp:Button ID="btnMoveLeftAll" runat="server" Text="&lt;&lt;" CssClass="MoverButton"
                OnClick="btnMoveLeftAll_Click" /><br />
        </td>
        <td>
            <asp:ListBox ID="lstRight" runat="server" SelectionMode="Multiple" CssClass="RightListBox">
            </asp:ListBox>
        </td>
        <td>
            <asp:Button ID="btnMoveUp" runat="server" Text="上移" CssClass="UpDownButton" OnClick="btnMoveUp_Click" /><br />
            <asp:Button ID="btnMoveDown" runat="server" Text="下移" CssClass="UpDownButton" OnClick="btnMoveDown_Click" />
        </td>
    </tr>
</table>
