<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DetailEditB.aspx.cs" Inherits="WebForms_Teacher_DetailEditB" %>

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
        $(function () {
            $("input[type=text]").addClass("FullLength");
        });


        function CloseParentPopup() {
            var p = window.parent;
            var popup = p.window["popupMeetingProposal"];
            popup.Hide();
        }
    </script>
    <style>
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

        .textbox1 {
            width: 35px;
            height: 25px;
            border: none;
            background-color: AliceBlue;
        }

        .textbox2 {
            width: 60px;
            height: 25px;
            border: none;
            background-color: AliceBlue;
        }
        .gridviewbutton {
            background-color: Transparent; 
            border-style: none;                
            outline: none;            }
        .auto-style2 {
            text-decoration: underline;
        }
        .新建样式1 {
            font-family: 微软雅黑;
            color: #283B56;
            font-size: 28px;
        }
        .auto-style3 {
            font-family: 微软雅黑;
            color: #283B56;
            font-size: 22px;
        }
        .新建样式3 {
            color: #3F7ABE;
        }
        .新建样式2 {
            color: #3F7ABE;
        }
        </style>
</head>
<body>
    <form id="form1" runat="server">
        <span class="新建样式2">题型编辑<br />
        </span>&nbsp;<div>
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
                    <asp:BoundField DataField="score" HeaderText="分数" SortExpression="score" />
                    <asp:CommandField ShowDeleteButton="True" />
                </Columns>
               <EmptyDataTemplate>
                    <asp:Table ID="Table1" runat="server" CssClass="dataTable" Font-Bold="False" Font-Italic="False" GridLines="Horizontal" Height="18px" Width="700px"  Border="solid">
                        <asp:TableRow runat="server">
                            <asp:TableCell ID="题型" runat="server">模块名</asp:TableCell>
                            <asp:TableCell runat="server">数量</asp:TableCell>
                            <asp:TableCell runat="server">分数</asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </EmptyDataTemplate>

            </asp:GridView>
              <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>" SelectCommand="SELECT Questiontype.qtypeName, Questiontype.quantity, Questiontype.score, Detail.DetailID, Registration.ID, Questiontype.QtypeID FROM Detail INNER JOIN Questiontype ON Detail.DetailID = Questiontype.DetailID INNER JOIN Registration ON Detail.PaperID = Registration.PaperID WHERE (Registration.ID = @ID)"
                 DeleteCommand="DELETE FROM Questiontype FROM Detail INNER JOIN Questiontype ON Detail.DetailID = Questiontype.DetailID INNER JOIN Registration ON Detail.courseID = Registration.courseID WHERE (Questiontype.QtypeID = @QtypeID)">
                <DeleteParameters>
                    <asp:Parameter Name="QtypeID" />
                </DeleteParameters>
                <SelectParameters>
                    <asp:QueryStringParameter Name="ID" QueryStringField="regID" />
                </SelectParameters>

            </asp:SqlDataSource>
            <br />
            <asp:Button runat="server" Text="新增题型" OnClick="AddQuestion_Click"></asp:Button>
            <br />
            <br />
            <br />
            <br />
            <br />
            <span class="新建样式3">模块编辑<br />
            </span><br />
            <asp:GridView ID="GridView2" runat="server" CssClass="dataTable" AutoGenerateColumns="False" DataSourceID="SqlDataSource2" DataKeyNames="ModuleID" AllowSorting="true"
                OnRowDeleting="GridView2_RowDeleting">
                <Columns>
                    <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="ID" Visible="false" />

                    <asp:BoundField DataField="mouduleName" HeaderText="模块名" SortExpression="mouduleName"/>

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
                    <asp:CommandField ShowDeleteButton="True" />

                </Columns>
                <EmptyDataTemplate>
                    <asp:Table ID="Table1" runat="server" CssClass="dataTable" Font-Bold="False" Font-Italic="False" GridLines="Horizontal" Height="18px" Width="700px"  Border="solid">
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
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>" SelectCommand="SELECT Registration.ID, Module.ModuleID, Detail.DetailID, Module.mouduleName, Module.knowledge1, Module.knowledge2, Module.knowledge3, Module.skill1, Module.skill2, Module.skill3, Module.conprehensive1, Module.conprehensive2, Module.conprehensive3, Module.innovation1, Module.innovation2, Module.innovation3 FROM Registration INNER JOIN Paper ON Registration.PaperID = Paper.ID INNER JOIN Module INNER JOIN Detail ON Module.DetailID = Detail.DetailID ON Paper.ID = Detail.PaperID WHERE (Registration.ID LIKE @regID)" DeleteCommand="DELETE FROM Module WHERE (ModuleID LIKE @ModuleID)">
                <DeleteParameters>
                    <asp:Parameter Name="ModuleID" />
                </DeleteParameters>
                <SelectParameters>
                    <asp:QueryStringParameter Name="regID" QueryStringField="regID" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br />
            <asp:Button runat="server" Text="新增模块" OnClick="AddModule_Click"></asp:Button>

            <br />
        </div>
        <div>
            <br />
            <dx:ASPxPopupControl ID="PopupControl1" runat="server" AllowDragging="True" ClientInstanceName="PopupControl" CloseAction="CloseButton" EnableAnimation="False" HeaderText="题型管理" Left="15" Modal="True" Theme="Aqua" Top="15" Width="350px" Height="200px">
                <ContentStyle VerticalAlign="Top">
                </ContentStyle>
                <ContentCollection>
                    <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server">
                        <table border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td style="height: 30px; text-align: right"><strong>题型：</strong> </td>
                                <td style="height: 30px">
                                    <asp:TextBox ID="Textbox0" runat="server" Width="150px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 30px; text-align: right"><strong>数量：</strong> </td>
                                <td style="height: 30px">
                                    <asp:TextBox ID="TextBox1" runat="server" Width="150px" ></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 30px; text-align: right"><strong>分数：</strong> </td>
                                <td style="height: 30px">
                                    <asp:TextBox ID="TextBox2" runat="server" Width="150px"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                        <hr style="text-align: left; margin-top: 10px; margin-bottom: 10px; width: 220px;" />
                        <asp:LinkButton ID="btnInsert" runat="server" OnClick="QtypeInsert_Click">插入</asp:LinkButton>

                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>
            <dx:ASPxPopupControl ID="PopupControl2" runat="server" AllowDragging="True" ClientInstanceName="PopupControl" CloseAction="CloseButton" EnableAnimation="False" HeaderText="题型管理" Left="15" Modal="True" Theme="Aqua" Top="15" Width="450px" Height="200px">
                <ContentStyle VerticalAlign="Top">
                </ContentStyle>
                <ContentCollection>
                    <dx:PopupControlContentControl ID="PopupControlContentControl2" runat="server">
                        <table border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td style="height: 30px; text-align: right"><strong>模块名：</strong></td>
                                <td style="height: 30px">
                                    <asp:TextBox ID="TextBox15" runat="server" Width="50px" Text="模块一"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 30px; text-align: right"><strong>知识1：</strong> </td>
                                <td style="height: 30px">
                                    <asp:TextBox ID="TextBox3" runat="server" Width="50px"></asp:TextBox>
                                </td>
                                <td style="height: 30px; text-align: right"><strong>知识2：</strong> </td>
                                <td style="height: 30px">
                                    <asp:TextBox ID="TextBox4" runat="server" Width="50px" ></asp:TextBox>
                                </td>
                                <td style="height: 30px; text-align: right"><strong>知识3：</strong> </td>
                                 <td style="height: 30px">
                                    <asp:TextBox ID="TextBox5" runat="server" Width="50px" ></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 30px; text-align: right"><strong>技能1：</strong> </td>
                                <td style="height: 30px">
                                    <asp:TextBox ID="TextBox6" runat="server" Width="50px" ></asp:TextBox>
                                </td>
                                <td style="height: 30px; text-align: right"><strong>技能2：</strong> </td>
                                <td style="height: 30px">
                                    <asp:TextBox ID="TextBox7" runat="server" Width="50px" ></asp:TextBox>
                                </td>
                                <td style="height: 30px; text-align: right"><strong>技能3：</strong> </td>
                                <td style="height: 30px">
                                    <asp:TextBox ID="TextBox8" runat="server" Width="50px" ></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 30px; text-align: right"><strong>理解1：</strong> </td>
                                <td style="height: 30px">
                                    <asp:TextBox ID="TextBox9" runat="server" Width="50px" ></asp:TextBox>
                                </td>
                                <td style="height: 30px; text-align: right"><strong>理解2：</strong> </td>
                                <td style="height: 30px">
                                    <asp:TextBox ID="TextBox10" runat="server" Width="50px" ></asp:TextBox>
                                </td>
                                <td style="height: 30px; text-align: right"><strong>理解3：</strong> </td>
                                <td style="height: 30px">
                                    <asp:TextBox ID="TextBox11" runat="server" Width="50px" ></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 30px; text-align: right"><strong>创新1：</strong> </td>
                                <td style="height: 30px">
                                    <asp:TextBox ID="TextBox12" runat="server" Width="50px" ></asp:TextBox>
                                </td>
                                <td style="height: 30px; text-align: right"><strong>创新2：</strong> </td>
                                <td style="height: 30px">
                                    <asp:TextBox ID="TextBox13" runat="server" Width="50px" ></asp:TextBox>
                                </td>
                                <td style="height: 30px; text-align: right"><strong>创新3：</strong> </td>
                                <td style="height: 30px">
                                    <asp:TextBox ID="TextBox14" runat="server" Width="50px" ></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                        <hr style="text-align: left; margin-top: 10px; margin-bottom: 10px; width: 220px;" />
                        <asp:LinkButton ID="btnInsert1" runat="server" OnClick="ModuleInsert_Click">插入</asp:LinkButton>

                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>

        </div>
                 <uc1:MessageBoxControl ID="MsgBox" runat="server" />

    </form>
</body>
</html>
