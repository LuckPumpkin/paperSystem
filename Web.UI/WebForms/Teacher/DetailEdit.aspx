<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DetailEdit.aspx.cs" Inherits="WebForms_Teacher_DetailEdit" %>

<%@ Register Assembly="Infrastructure" Namespace="Infrastructure.Controls" TagPrefix="cc1" %>
<%@ Register Src="../../UserControls/MessageBoxControl.ascx" TagName="MessageBoxControl" TagPrefix="uc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="../../css/style.css" rel="stylesheet" />
    <script src="../../script/jquery.js"></script>
    <script src="../../script/GridLineHotTrack.js"></script>
    <script src="../../My97DatePicker/WdatePicker.js"></script>
    <script type="text/javascript">
        function CloseParentPopup() {
            var p = window.parent;
            var popup = p.window["popupMeetingProposal"];
            popup.Hide();
        }
    </script>
    <style>
        #que, #modle {
            position: absolute;
            top: 80px;
        }

        .span_2 {
            position: absolute;
            top: -15px;
            font-size: 15px;
            color: mediumblue;
        }
        table[id^="PopupControl1_"],
        table[id^="PopupControl2_"] {
            width: 120px;
            height: 30px;
            border-radius: 3px;
        }
        div[id^="PopupControl1_"]>table tbody tr,
        div[id^="PopupControl2_"]>table tbody tr {
            line-height: 2.4rem;
        }
        .model_title_td {
            display: inline-block;
            width: 55px;
            height: 30px;
            line-height: 31px;
            text-align: right;
            font-weight: 700;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div>
                选择编辑内容：<asp:DropDownList ID="DropDownList1" runat="server" Height="23px">
                    <asp:ListItem Value="题型编辑">题型编辑</asp:ListItem>
                    <asp:ListItem Value="模块编辑">模块编辑</asp:ListItem>
                </asp:DropDownList>
                <asp:LinkButton ID="ASPxButton1" runat="server" OnClick="ok_Click" Text="确定" Theme="Aqua"></asp:LinkButton>
            </div>
            <div id="que" runat="server">
                <span class="span_2">题型编辑:</span>
                <br />
                <br />
                <dx:ASPxButton runat="server" Text="新增题型" OnClick="AddQuestion_Click" Theme="Aqua"></dx:ASPxButton>
                <br />
                <br />
                <asp:GridView ID="GridView1" runat="server" CssClass="dataTable" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" DataKeyNames="QtypeID" AllowSorting="true"
                    OnRowDeleting="GridView1_RowDeleting">
                    <Columns>
                        <asp:TemplateField HeaderText="Reg_id" InsertVisible="False" Visible="false" SortExpression="courseID">
                            <ItemTemplate>
                                <asp:Label ID="lbregID" runat="server" Text='<%# Eval("ID") %>'></asp:Label>
                                <asp:Label ID="lbDetailID" runat="server" Text='<%# Eval("DetailID") %>'></asp:Label>
                                <asp:Label ID="lbQTypeID" runat="server" Text='<%# Eval("QtypeID") %>'></asp:Label>
                                <%--<asp:Label ID="lbcourseID" runat="server" Text='<%# Eval("courseID") %>'></asp:Label>--%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="qtypeName" HeaderText="题型" SortExpression="qtypeName" />
                        <asp:BoundField DataField="quantity" HeaderText="数量" SortExpression="quantity" />
                        <asp:BoundField DataField="score" HeaderText="单个分值" SortExpression="score" />
                        <asp:CommandField ShowDeleteButton="True" HeaderText="操作"/>
                    </Columns>
                    <EmptyDataTemplate>
                        <asp:Table ID="Table1" runat="server" CssClass="dataTable" Font-Bold="False" Font-Italic="False" GridLines="Horizontal" Height="18px" Width="700px" Border="solid">
                            <asp:TableRow runat="server">
                                <asp:TableCell ID="题型" runat="server">模块名</asp:TableCell>
                                <asp:TableCell runat="server">数量</asp:TableCell>
                                <asp:TableCell runat="server">单个分值</asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                    </EmptyDataTemplate>
                    <HeaderStyle CssClass="FixedHeader" />
                </asp:GridView>
            </div>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>" SelectCommand="SELECT Questiontype.qtypeName, Questiontype.quantity, Questiontype.score, Detail.DetailID, Registration.ID, Questiontype.QtypeID FROM Detail INNER JOIN Questiontype ON Detail.DetailID = Questiontype.DetailID INNER JOIN Registration ON Detail.PaperID = Registration.PaperID WHERE (Detail.DetailID = @detID)"
                DeleteCommand="DELETE FROM Questiontype FROM Detail INNER JOIN Questiontype ON Detail.DetailID = Questiontype.DetailID INNER JOIN Registration ON Detail.courseID = Registration.courseID WHERE (Questiontype.QtypeID = @QtypeID)">
                <DeleteParameters>
                    <asp:Parameter Name="QtypeID" />
                </DeleteParameters>
                <SelectParameters>
                    <asp:QueryStringParameter Name="detID" QueryStringField="detID" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br />

            <div id="modle" runat="server">
                <span class="span_2">模块编辑:</span>
                <br />
                <br />
                <dx:ASPxButton runat="server" Text="新增模块" OnClick="AddModule_Click" Theme="Aqua"></dx:ASPxButton>
                <br />
                <br />
                <asp:GridView ID="GridView2" runat="server" CssClass="dataTable" AutoGenerateColumns="False" DataSourceID="SqlDataSource2" DataKeyNames="ModuleID" AllowSorting="true"
                    OnRowDeleting="GridView2_RowDeleting">
                    <Columns>
                        <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="ID" Visible="false" />
                        <asp:BoundField DataField="mouduleName" HeaderText="模块名" SortExpression="mouduleName" />
                        <asp:BoundField DataField="knowledge1" HeaderText="知识Ⅰ" SortExpression="knowledge1" />
                        <asp:BoundField DataField="knowledge2" HeaderText="知识Ⅱ" SortExpression="knowledge2" />
                        <asp:BoundField DataField="knowledge3" HeaderText="知识Ⅲ" SortExpression="knowledge3" />
                        <asp:BoundField DataField="skill1" HeaderText="技能Ⅰ" SortExpression="skill1" />
                        <asp:BoundField DataField="skill2" HeaderText="技能Ⅱ" SortExpression="skill2" />
                        <asp:BoundField DataField="skill3" HeaderText="技能Ⅲ" SortExpression="skill3" />
                        <asp:BoundField DataField="conprehensive1" HeaderText="理解Ⅰ" SortExpression="conprehensive1" />
                        <asp:BoundField DataField="conprehensive2" HeaderText="理解Ⅱ" SortExpression="conprehensive2" />
                        <asp:BoundField DataField="conprehensive3" HeaderText="理解Ⅲ" SortExpression="conprehensive3" />
                        <asp:BoundField DataField="innovation1" HeaderText="创新Ⅰ" SortExpression="innovation1" />
                        <asp:BoundField DataField="innovation2" HeaderText="创新Ⅱ" SortExpression="innovation2" />
                        <asp:BoundField DataField="innovation3" HeaderText="创新Ⅲ" SortExpression="innovation3" />
                        <asp:CommandField ShowDeleteButton="True" HeaderText="操作"/>
                    </Columns>
                    <EmptyDataTemplate>
                        <asp:Table ID="Table1" runat="server" CssClass="dataTable" Font-Bold="False" Font-Italic="False" GridLines="Horizontal" Height="18px" Width="700px" Border="solid">
                            <asp:TableRow runat="server">
                                <asp:TableCell ID="模块名" runat="server">模块名</asp:TableCell>
                                <asp:TableCell runat="server">知识Ⅰ</asp:TableCell>
                                <asp:TableCell runat="server">知识Ⅱ</asp:TableCell>
                                <asp:TableCell runat="server">知识Ⅲ</asp:TableCell>
                                <asp:TableCell runat="server">技能Ⅰ</asp:TableCell>
                                <asp:TableCell runat="server">技能Ⅱ</asp:TableCell>
                                <asp:TableCell runat="server">技能Ⅲ</asp:TableCell>
                                <asp:TableCell runat="server">综合Ⅰ</asp:TableCell>
                                <asp:TableCell runat="server">综合Ⅱ</asp:TableCell>
                                <asp:TableCell runat="server">综合Ⅲ</asp:TableCell>
                                <asp:TableCell runat="server">创新Ⅰ</asp:TableCell>
                                <asp:TableCell runat="server">创新Ⅱ</asp:TableCell>
                                <asp:TableCell runat="server">创新Ⅲ</asp:TableCell>
                                <asp:TableCell runat="server">      </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                    </EmptyDataTemplate>
                    <HeaderStyle CssClass="FixedHeader" />
                </asp:GridView>
            </div>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>" SelectCommand="SELECT Registration.ID, Module.ModuleID, Detail.DetailID, Module.mouduleName, Module.knowledge1, Module.knowledge2, Module.knowledge3, Module.skill1, Module.skill2, Module.skill3, Module.conprehensive1, Module.conprehensive2, Module.conprehensive3, Module.innovation1, Module.innovation2, Module.innovation3, Registration.profession FROM Registration INNER JOIN Module INNER JOIN Detail ON Module.DetailID = Detail.DetailID ON Registration.PaperID = Detail.PaperID WHERE (Detail.DetailID LIKE @detID)" DeleteCommand="DELETE FROM Module WHERE (ModuleID LIKE @ModuleID)">
                <DeleteParameters>
                    <asp:Parameter Name="ModuleID" />
                </DeleteParameters>
                <SelectParameters>
                    <asp:QueryStringParameter Name="detID" QueryStringField="detID" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br />
            <br />
            <dx:ASPxPopupControl ID="PopupControl1" runat="server" AllowDragging="True" ClientInstanceName="PopupControl" CloseAction="CloseButton" EnableAnimation="False" HeaderText="题型编辑" Left="15" Modal="True" Theme="Aqua" Top="15" Width="350px" Height="200px">
                <ClientSideEvents PopUp="function(s, e) { ASPxClientEdit.ClearGroup('group');}"/>
                <ContentStyle VerticalAlign="Top">
                </ContentStyle>
                <ContentCollection>
                    <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server">
                        <table border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td style="height: 30px; text-align: right"><strong>题型：</strong> </td>
                                <td style="height: 30px">
                                    <dx:ASPxTextBox ID="Textbox0" runat="server">
                                        <ValidationSettings ErrorDisplayMode="ImageWithText" ValidationGroup="group">
                                            <RegularExpression ErrorText="输入错误!"
                                                ValidationExpression="" />
                                            <RequiredField ErrorText="不能为空!" IsRequired="True" />
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 30px; text-align: right"><strong>数量：</strong> </td>
                                <td style="height: 30px">
                                    <dx:ASPxTextBox ID="TextBox1" runat="server">
                                        <ValidationSettings ErrorDisplayMode="ImageWithText" ValidationGroup="group">
                                            <RegularExpression ErrorText="输入错误!"
                                                ValidationExpression="^(99|[0-9]\d|\d)$" />
                                            <RequiredField ErrorText="不能为空!" IsRequired="True" />
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 30px; text-align: right"><strong>分值：</strong> </td>
                                <td style="height: 30px">
                                    <dx:ASPxTextBox ID="TextBox2" runat="server">
                                        <ValidationSettings ErrorDisplayMode="ImageWithText" ValidationGroup="group">
                                            <RegularExpression ErrorText="输入错误!"
                                                ValidationExpression="^([1-9][0-9]*)+(.[0-9]{1,2})?$" />
                                            <RequiredField ErrorText="不能为空!" IsRequired="True" />
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>

                                </td>
                            </tr>
                        </table>
                        <hr style="text-align: left; margin-top: 10px; margin-bottom: 10px; width: 220px;" />
                        <dx:ASPxButton ID="btnInsert" runat="server" OnClick="QtypeInsert_Click" Theme="Aqua" Text="保存">
                            <ClientSideEvents Click="function validate(s,e){
               if (!ASPxClientEdit.ValidateGroup('group'))
                  e.processOnServer = false;
               }" />
                        </dx:ASPxButton>
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>
            <dx:ASPxPopupControl ID="PopupControl2" runat="server" AllowDragging="True" ClientInstanceName="PopupControl" CloseAction="CloseButton" EnableAnimation="False" HeaderText="模块编辑" Left="15" Modal="True" Theme="Aqua" Top="15" Width="450px" Height="200px">
                <ClientSideEvents PopUp="function(s, e) { ASPxClientEdit.ClearGroup('group1');}"  />
                <ContentStyle VerticalAlign="Top">
                </ContentStyle>
                <ContentCollection>
                    <dx:PopupControlContentControl ID="PopupControlContentControl2" runat="server">
                        <span style="color:red;">*模块编辑中每个空格表示此模块涉及知识、技能、理解及创新的分值</span>
                        <br />
                        <br />
                        <table border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td class="model_title_td"><strong>模块名：</strong></td>
                                <td style="height: 30px">
                                    <dx:ASPxTextBox ID="TextBox15" runat="server" NullText="模块一">
                                        <ValidationSettings ErrorDisplayMode="ImageWithText" ValidationGroup="group1">
                                            <RegularExpression ErrorText="输入错误!"
                                                ValidationExpression="" />
                                            <RequiredField ErrorText="不能为空!" IsRequired="True" />
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="model_title_td"><strong>知识I：</strong> </td>
                                <td style="height: 30px">
                                    <dx:ASPxTextBox ID="TextBox3" runat="server">
                                        <ValidationSettings ErrorDisplayMode="ImageWithText" ValidationGroup="group1">
                                            <RegularExpression ErrorText="输入错误!"
                                                ValidationExpression="^(99|[0-9]\d|\d)$" />
                                            <RequiredField ErrorText="不能为空!" IsRequired="True" />
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>
                                </td>
                                <td class="model_title_td"><strong>知识II：</strong> </td>
                                <td style="height: 30px">
                                    <dx:ASPxTextBox ID="TextBox4" runat="server">
                                        <ValidationSettings ErrorDisplayMode="ImageWithText" ValidationGroup="group1">
                                            <RegularExpression ErrorText="输入错误!"
                                                ValidationExpression="^(99|[0-9]\d|\d)$" />
                                            <RequiredField ErrorText="不能为空!" IsRequired="True" />
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>
                                </td>
                                <td class="model_title_td"><strong>知识III：</strong> </td>
                                <td style="height: 30px">
                                    <dx:ASPxTextBox ID="TextBox5" runat="server">
                                        <ValidationSettings ErrorDisplayMode="ImageWithText" ValidationGroup="group1">
                                            <RegularExpression ErrorText="输入错误!"
                                                ValidationExpression="^(99|[0-9]\d|\d)$" />
                                            <RequiredField ErrorText="不能为空!" IsRequired="True" />
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="model_title_td"><strong>技能I：</strong> </td>
                                <td style="height: 30px">
                                    <dx:ASPxTextBox ID="TextBox6" runat="server">
                                        <ValidationSettings ErrorDisplayMode="ImageWithText" ValidationGroup="group1">
                                            <RegularExpression ErrorText="输入错误!"
                                                ValidationExpression="^(99|[0-9]\d|\d)$" />
                                            <RequiredField ErrorText="不能为空!" IsRequired="True" />
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>
                                </td>
                                <td class="model_title_td"><strong>技能II：</strong> </td>
                                <td style="height: 30px">
                                    <dx:ASPxTextBox ID="TextBox7" runat="server">
                                        <ValidationSettings ErrorDisplayMode="ImageWithText" ValidationGroup="group1">
                                            <RegularExpression ErrorText="输入错误!"
                                                ValidationExpression="^(99|[0-9]\d|\d)$" />
                                            <RequiredField ErrorText="不能为空!" IsRequired="True" />
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>
                                </td>
                                <td class="model_title_td"><strong>技能III：</strong> </td>
                                <td style="height: 30px">
                                    <dx:ASPxTextBox ID="TextBox8" runat="server">
                                        <ValidationSettings ErrorDisplayMode="ImageWithText" ValidationGroup="group1">
                                            <RegularExpression ErrorText="输入错误!"
                                                ValidationExpression="^[0-9]*[0-9][0-9]*$" />
                                            <RequiredField ErrorText="不能为空!" IsRequired="True" />
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="model_title_td"><strong>理解I：</strong> </td>
                                <td style="height: 30px">
                                    <dx:ASPxTextBox ID="TextBox9" runat="server">
                                        <ValidationSettings ErrorDisplayMode="ImageWithText" ValidationGroup="group1">
                                            <RegularExpression ErrorText="输入错误!"
                                                ValidationExpression="^(99|[0-9]\d|\d)$" />
                                            <RequiredField ErrorText="不能为空!" IsRequired="True" />
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>
                                </td>
                                <td class="model_title_td"><strong>理解II：</strong> </td>
                                <td style="height: 30px">
                                    <dx:ASPxTextBox ID="TextBox10" runat="server">
                                        <ValidationSettings ErrorDisplayMode="ImageWithText" ValidationGroup="group1">
                                            <RegularExpression ErrorText="输入错误!"
                                                ValidationExpression="^(99|[0-9]\d|\d)$" />
                                            <RequiredField ErrorText="不能为空!" IsRequired="True" />
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>
                                </td>
                                <td class="model_title_td"><strong>理解III：</strong> </td>
                                <td style="height: 30px">
                                    <dx:ASPxTextBox ID="TextBox11" runat="server">
                                        <ValidationSettings ErrorDisplayMode="ImageWithText" ValidationGroup="group1">
                                            <RegularExpression ErrorText="输入错误!"
                                                ValidationExpression="^(99|[0-9]\d|\d)$" />
                                            <RequiredField ErrorText="不能为空!" IsRequired="True" />
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="model_title_td"><strong>创新I：</strong> </td>
                                <td style="height: 30px">
                                    <dx:ASPxTextBox ID="TextBox12" runat="server">
                                        <ValidationSettings ErrorDisplayMode="ImageWithText" ValidationGroup="group1">
                                            <RegularExpression ErrorText="输入错误!"
                                                ValidationExpression="^(99|[0-9]\d|\d)$" />
                                            <RequiredField ErrorText="不能为空!" IsRequired="True" />
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>
                                </td>
                                <td class="model_title_td"><strong>创新II：</strong> </td>
                                <td style="height: 30px">
                                    <dx:ASPxTextBox ID="TextBox13" runat="server">
                                        <ValidationSettings ErrorDisplayMode="ImageWithText" ValidationGroup="group1">
                                            <RegularExpression ErrorText="输入错误!"
                                                ValidationExpression="^(99|[0-9]\d|\d)$" />
                                            <RequiredField ErrorText="不能为空!" IsRequired="True" />
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>
                                </td>
                                <td class="model_title_td"><strong>创新III：</strong> </td>
                                <td style="height: 30px">
                                    <dx:ASPxTextBox ID="TextBox14" runat="server">
                                        <ValidationSettings ErrorDisplayMode="ImageWithText" ValidationGroup="group1">
                                            <RegularExpression ErrorText="输入错误!"
                                                ValidationExpression="^(99|[0-9]\d|\d)$" />
                                            <RequiredField ErrorText="不能为空!" IsRequired="True" />
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>
                                </td>
                            </tr>
                        </table>
                        <hr style="text-align: left; margin-top: 10px; margin-bottom: 10px; width: 220px;" />
                        <dx:ASPxButton ID="btnInsert1" runat="server" OnClick="ModuleInsert_Click" Text="保存" Theme="Aqua">
                            <ClientSideEvents Click="function validate(s,e){
               if (!ASPxClientEdit.ValidateGroup('group1'))
                  e.processOnServer = false;
               }" />
                        </dx:ASPxButton>
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>

        </div>
        <uc1:MessageBoxControl ID="MsgBox" runat="server" />
    </form>
</body>
</html>
