<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AnalysisEdit.aspx.cs" Inherits="WebForms_Teacher_AnalysisEdit" %>

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
            var popup = p.window["popupAnalysis"];
            popup.Hide();
        }
    </script>
    <style>
        .FormViewTable td {
            border: 1px solid gray;
            border-collapse: collapse;
            height: 24px;
            line-height: 15px;
        }

        .FullLength {
            width: 150px;
            height: 24px;
            background-color: #F3F7FD;
            margin: 0px;
            padding: 0px;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">
        <asp:FormView ID="FVAnalysisEdit" runat="server" DataSourceID="SqlDataSource1" DefaultMode="Edit">
            <EditItemTemplate>
                <table style="border: 2px solid gray; border-collapse: collapse;" class="FormViewTable">
                    <tr>
                        <td>基础分析：</td>
                        <td colspan="5">
                            <asp:TextBox ID="txtbasicAnalysis" runat="server" Style="background-color: #F3F7FD" Text='<%# Bind("basicAnalysis") %>' TextMode="MultiLine" Width="710px" Height="100px"></asp:TextBox>
                            <asp:Label ID="lbAnalysisID" runat="server" Text='<%# Bind("ID") %>' Visible="False"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>扩展分析：</td>
                        <td colspan="5">
                            <asp:TextBox ID="txtExpandAnalysis" runat="server" Style="background-color: #F3F7FD" Text='<%# Bind("expandAnalysis") %>' TextMode="MultiLine" Width="710px" Height="100px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>教学分析：</td>
                        <td colspan="5">
                            <asp:TextBox ID="txtTeachAnalysis" runat="server" Style="background-color: #F3F7FD" Text='<%# Bind("teachAnalysis") %>' TextMode="MultiLine" Width="710px" Height="100px"></asp:TextBox>
                        </td>
                    </tr>
                    <caption>
                    <p>
                        <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="保存信息"/>
                    </p>
                </caption>
                    
            </EditItemTemplate>
        </asp:FormView>

        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>" SelectCommand="SELECT ID, expandAnalysis, teachAnalysis, basicAnalysis FROM Analysis WHERE (ID LIKE @anaID)" 
            UpdateCommand="UPDATE Analysis SET basicAnalysis = @basicAnalysis, expandAnalysis = @expandAnalysis, teachAnalysis = @teachAnalysis WHERE (ID = @ID)">
            <SelectParameters>
                <asp:QueryStringParameter DefaultValue="" Name="anaID" QueryStringField="anaID" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="basicAnalysis" />
                <asp:Parameter Name="expandAnalysis" />
                <asp:Parameter Name="teachAnalysis" />
                <asp:Parameter Name="ID" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>
