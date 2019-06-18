<%@ Page Language="C#" AutoEventWireup="true" CodeFile="paperPDF.aspx.cs" Inherits="WebForms_PrintAdmin_paperPDF" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="../../css/style.css" rel="stylesheet" />
    <script src="../../script/jquery.js"></script>
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
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:FormView ID="FormView1" runat="server" DataSourceID="SqlDataSource1" Visible="False">

                <EditItemTemplate>
                    course_name:
                    <asp:TextBox ID="course_nameTextBox" runat="server" Text='<%# Bind("course_name") %>' />
                    <br />
                    course_teacherno:
                    <asp:TextBox ID="course_teachernoTextBox" runat="server" Text='<%# Bind("course_teacherno") %>' />
                    <br />
                    <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="更新" />
                    &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="取消" />
                </EditItemTemplate>
                <InsertItemTemplate>
                    course_name:
                    <asp:TextBox ID="course_nameTextBox" runat="server" Text='<%# Bind("course_name") %>' />
                    <br />
                    course_teacherno:
                    <asp:TextBox ID="course_teachernoTextBox" runat="server" Text='<%# Bind("course_teacherno") %>' />
                    <br />
                    <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="插入" />
                    &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="取消" />
                </InsertItemTemplate>

                <ItemTemplate>
                    course_name:
                    <asp:Label ID="course_nameLabel" runat="server" Text='<%# Bind("course_name") %>' />
                    <br />
                    course_teacherno:
                    <asp:Label ID="course_teachernoLabel" runat="server" Text='<%# Bind("course_teacherno") %>' />
                    <br />
                </ItemTemplate>
            </asp:FormView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>" SelectCommand="SELECT Course.course_teacherno, Course.teachingPlan, Course.course_dept, Paper.paper_AorB, Course.course_no FROM Course INNER JOIN Paper ON Course.ID = Paper.courseID WHERE (Course.course_teacherno = @course_teacherno) AND (Course.course_no = @course_no) AND (Course.teachingPlan = @teachingPlan) AND (Course.course_dept = @course_dept) AND (Paper.paper_AorB = @type) ">
                <SelectParameters>
                    <asp:QueryStringParameter Name="course_teacherno" QueryStringField="course_teacherno" />
                    <asp:QueryStringParameter Name="course_no" QueryStringField="course_no"/>
                    <asp:QueryStringParameter Name="teachingPlan" QueryStringField="teachingPlan" />
                    <asp:QueryStringParameter Name="course_dept" QueryStringField="course_dept" />
                    <asp:QueryStringParameter Name="type" QueryStringField="type" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
    </form>
</body>
</html>
