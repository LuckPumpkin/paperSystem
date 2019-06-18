<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ResitEdit.aspx.cs" Inherits="WebForms_Teacher_ResitEdit" %>
<%@ Register Assembly="Infrastructure" Namespace="Infrastructure.Controls" TagPrefix="cc1" %>
<%@ Register src="../../UserControls/MessageBoxControl.ascx" tagname="MessageBoxControl" tagprefix="uc1" %>

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
     <asp:Label ID="Label1" runat="server" Font-Size="18px" ForeColor="#cc0000"  ></asp:Label>
    <br />
    <form id="form1" runat="server">
        <asp:FormView ID="FVResitEdit" runat="server" DataSourceID="SqlDataSource1" DefaultMode="Edit" Height="200px" >
            <EditItemTemplate>
                <table style="border: 2px solid gray; border-collapse: collapse;" class="FormViewTable">
                    <tr>
                        <td width="80">课程号</td>
                        <td width="100">
                           <asp:Label ID="lb_courseno" runat="server" Text='<%# Bind("course_no") %>' CssClass="FullLength"></asp:Label>
                        </td>
                         <td width="80">课程名称</td>
                        <td width="100">
                            <asp:Label ID="lb_courseName" runat="server" Text='<%# Bind("course_name") %>' CssClass="FullLength"></asp:Label>
                            <asp:Label ID="lbPaperID" runat="server" Text='<%# Bind("paperID") %>' Visible="False"></asp:Label>
                        </td>
                        <td width="80">任课教师</td>
                        <td width="100">
                            <asp:Label ID="lb_courseTeacher" runat="server" Text='<%# Bind("course_teacherno") %>' CssClass="FullLength"></asp:Label>
                        </td>
                    </tr>
                  
                    <tr>
                        <td width="80">试卷页数</td>
                        <td width="100">
                            <asp:TextBox ID="txtPaper_num" class="textboxnum" runat="server" Text='<%# Bind("paper_num", "{0}") %>' CssClass="FullLength"></asp:TextBox>
                        </td>
                        <td width="80">印制份数</td>
                        <td width="100">
                            <asp:TextBox ID="txtpaper_copyNum" class="textboxnum" runat="server" Text='<%# Bind("paper_copyNum", "{0}") %>' CssClass="FullLength"></asp:TextBox>
                        </td>
                        <td width="80">附答题纸数</td>
                        <td width="100">
                            <asp:TextBox ID="txtWhitePaper_num" class="textboxnum" runat="server" Text='<%# Bind("whitePaper_num", "{0}") %>' CssClass="FullLength"></asp:TextBox>
                        </td>
                    </tr>
                  
                </table>
                <br />      
            </EditItemTemplate>
        </asp:FormView>   
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   
        <asp:Button ID="Button1" runat="server" CausesValidation="True" Text="保存" OnClick="lbtnClick" Font-Size="20px" ForeColor="#000" Width="100px" height="35px" />

         <uc1:MessageBoxControl ID="MsgBox" runat="server" />
            &nbsp;<asp:HiddenField ID="Paper_num" runat="server" />
            <asp:HiddenField ID="Paper_copyNum" runat="server" />
            <asp:HiddenField ID="WhitePaper_num" runat="server" />
            <asp:HiddenField ID="txtState" runat="server" />
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>" SelectCommand="SELECT Course.course_name, Course.course_teacher, Paper.whitePaper_num, Paper.paper_copyNum, Paper.paper_num, Paper.ID AS paperID, Course.course_no, Course.course_teacherno FROM Course INNER JOIN Paper ON Course.ID = Paper.courseID WHERE (Paper.paper_AorB LIKE 'B') AND (Paper.ID = @paperID)" UpdateCommand="UPDATE Paper SET whitePaper_num = @whitePaper_num, paper_copyNum = @paper_copyNum, paper_num = @paper_num, paper_state = '试卷草稿' FROM Course INNER JOIN Paper ON Course.ID = Paper.courseID WHERE (Paper.ID = @paperID)">

                <SelectParameters>
                    <asp:QueryStringParameter Name="paperID" QueryStringField="paperID" />
                </SelectParameters>

                <UpdateParameters>
                    <asp:Parameter Name="whitePaper_num" />
                    <asp:Parameter Name="paper_copyNum" />
                    <asp:Parameter Name="paper_num" />
                    <asp:Parameter Name="paperID" />
                </UpdateParameters>

            </asp:SqlDataSource>
 
        
 
    </form>
</body>
</html>


