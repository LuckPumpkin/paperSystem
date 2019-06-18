<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PaperEdit.aspx.cs" Inherits="WebForms_Teacher_PaperEdit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="../../css/style.css" rel="stylesheet" />
    <script src="../../script/jquery.js"></script>
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
    </style>

</head>
<body>
    <form id="form1" runat="server">
        <%--OnPageIndexChanging="FVRegistrationEdit_PageIndexChanging"--%>
        <asp:FormView ID="FVRegistrationEdit" runat="server" DataSourceID="SqlDataSource2" DefaultMode="Edit" Height="174px">
            <EditItemTemplate>
                <table style="border: 2px solid gray; border-collapse: collapse;" class="FormViewTable">
                    <tr>
                        <%--<td width="80">课程名称</td>
                        <td width="100">
                            <asp:Label ID="lb_courseName" runat="server" Text='<%# Bind("course_name") %>' CssClass="FullLength"></asp:Label>
                            <asp:Label ID="lbRegisID" runat="server" Text='<%# Bind("ID") %>' Visible="False"></asp:Label>
                        </td>
                        <td width="80">任课教师</td>
                        <td width="100">
                            <asp:Label ID="lb_courseTeacher" runat="server" Text='<%# Bind("course_teacher") %>' CssClass="FullLength"></asp:Label>
                        </td>
                        <td width="80">考生人数</td>
                        <td width="100">
                            <asp:Label ID="lb_course" runat="server" Text='<%# Bind("selected_studentNum") %>' CssClass="FullLength"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td width="80">年级</td>
                        <td width="100">
                            <asp:TextBox ID="txtGrade" runat="server" Text='<%# Bind("grade") %>' CssClass="FullLength"></asp:TextBox>
                        </td>
                        <td width="80">专业</td>
                        <td width="100">
                            <asp:TextBox ID="txtProfession" runat="server" Text='<%# Bind("profession") %>' CssClass="FullLength"></asp:TextBox>
                        </td>
                        <td width="80">学院</td>
                        <td width="100">
                            <asp:TextBox ID="txtCourse_dept" runat="server" Text='<%# Bind("course_dept") %>' CssClass="FullLength"></asp:TextBox>
                        </td>
                    </tr>--%>
                     <tr>
                        <td width="80">试卷页数</td>
                        <td width="100">
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("paper_num", "{0}") %>' CssClass="FullLength" ></asp:TextBox>
                            <asp:Label ID="lbID" runat="server" Text='<%# Bind("ID") %>' Visible="False"></asp:Label>
                        </td>
                        <td width="80">印制份数</td>
                        <td width="100">
                            <asp:TextBox ID="txtpPaper_copyNum" runat ="server" Text='<%# Bind("paper_copyNum", "{0}") %>' CssClass="FullLength" ></asp:TextBox>
                        </td>
                        <td width="80">附答题纸数</td>
                        <td width="100">
                            <asp:TextBox ID="txtWhitePaper_num" runat="server" Text='<%# Bind("whitePaper_num", "{0}") %>' CssClass="FullLength" ></asp:TextBox>
                        </td>
                    </tr>
     
                </table>
                <br />
                     <caption>
                        <p>
                            <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="保存信息"/>
                        </p>            
                    </caption>
            </EditItemTemplate>

        </asp:FormView>


        <div>
        </div>


        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>" SelectCommand="SELECT paper_num, whitePaper_num, paper_copyNum, flag, ID FROM Paper WHERE (ID LIKE @paperID)"
            UpdateCommand="UPDATE Paper SET paper_num = @paper_num, whitePaper_num = @whitePaper_num, paper_copyNum = @paper_copyNum WHERE  (ID LIKE @ID)">
            <SelectParameters>
                <asp:QueryStringParameter Name="paperID" QueryStringField="paperID" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="paper_num" />
                <asp:Parameter Name="whitePaper_num" />
                <asp:Parameter Name="paper_copyNum" />
                <asp:Parameter Name="ID" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>
