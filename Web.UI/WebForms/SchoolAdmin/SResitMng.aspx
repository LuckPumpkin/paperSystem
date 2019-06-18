<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SResitMng.aspx.cs" Inherits="WebForms_SchoolAdmin_SResitMng" %>

<%@ Register Assembly="Infrastructure" Namespace="Infrastructure.Controls" TagPrefix="cc1" %>
<%@ Register src="../../UserControls/MessageBoxControl.ascx" tagname="MessageBoxControl" tagprefix="uc1" %>
<%@ Register src="../../UserControls/MessageBoxControl.ascx" tagname="MessageBoxControl" tagprefix="uc2" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta http-equiv="Content-Type" content="application/ms-excel; charset=UTF-8"/>
    <title></title>
    <link href="../../css/style.css" rel="stylesheet" />
    <script src="../../script/jquery.js" type="text/javascript"></script>
    <script src="../../script/GridLineHotTrack.js"></script>
    
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <h2>补考管理</h2>
       上传补考信息：

                        <asp:FileUpload ID="files" runat="server" />

                        &nbsp;<dx:ASPxButton runat="server" Theme="Aqua" OnClick="btnDown_Click" ID="btnImport0" Text="下载Excel模板"></dx:ASPxButton>

                  
        
        &nbsp;<dx:ASPxButton runat="server" Theme="Aqua" OnClick="btnImport_Click" ID="btnImport" Text="上传"></dx:ASPxButton>

                  
        
    </div>
        <br />
        <br />
            <asp:Panel ID="Panel1" runat="server"  >
                <cc1:MyGridView ID="gvCourse"  runat="server"  AutoGenerateColumns="False" CssClass="dataTable"  AllowPaging="True" AllowSorting="True" EmptyDataText="没有找到任何数据！" pageSize="20"  style="margin-top: 0px" DataSourceID="sdsPaperAudit"   >
                    <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
                    <Columns>
                        <asp:BoundField DataField="course_no" HeaderText="课程号" SortExpression="course_no" />
                        <asp:BoundField DataField="course_name" HeaderText="课程名" SortExpression="course_name" />
                        <asp:BoundField DataField="paper_copyNum" HeaderText="补考人数" SortExpression="paper_copyNum" />
                        <asp:BoundField DataField="getTime" HeaderText="补考时间" SortExpression="getTime" />
                    </Columns>
                    <EditRowStyle CssClass="highlightRow"></EditRowStyle>
                    <HeaderStyle CssClass="headerRow"></HeaderStyle>
                    <PagerSettings FirstPageText="首页" LastPageText="尾页" NextPageText="下一页" PreviousPageText="上一页">
                    </PagerSettings>
                    <PagerStyle CssClass="pagerRow"></PagerStyle>
                    <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
                </cc1:MyGridView>
        </asp:Panel>

            <asp:SqlDataSource ID="sdsPaperAudit" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>" SelectCommand="SELECT DISTINCT Course.course_no, Course.course_name, Paper.paper_copyNum, Paper.getTime FROM Paper INNER JOIN Course ON Paper.courseID = Course.ID WHERE (Paper.flag LIKE '补考') AND (Paper.paper_copyNum IS NOT NULL) AND (Paper.paper_state LIKE '试卷草稿')">
            </asp:SqlDataSource>

        <uc2:MessageBoxControl runat="server" ID="MsgBox" />

    </form>
</body>
</html>
