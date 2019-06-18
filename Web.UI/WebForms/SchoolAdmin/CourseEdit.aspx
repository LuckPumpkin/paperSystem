<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CourseEdit.aspx.cs" Inherits="WebForms_SchoolAdmin_CourseEdit" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="Infrastructure" Namespace="Infrastructure.Controls" TagPrefix="cc1" %>
<%@ Register Src="~/UserControls/MessageBoxControl.ascx" TagPrefix="uc2" TagName="MessageBoxControl" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../../css/style.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
            <table style="border: 2px solid gray; border-collapse: collapse;" class="FormViewTable">
                <tr>
                    <td width="80">课程名称</td>
                    <td width="100">
                        <asp:TextBox ID="txtCourseName" runat="server" Text='<%# Bind("course_name") %>' CssClass="FullLength"></asp:TextBox>
                    </td>
                    <td width="80">课程号</td>
                    <td width="100">
                        <asp:TextBox ID="txtCourseNo" runat="server" Text='<%# Bind("course_no") %>' CssClass="FullLength"></asp:TextBox>
                    </td>
                    <td width="80">课序号</td>
                    <td width="100">
                        <asp:TextBox ID="txtCourseSeriesNo" runat="server" Text='<%# Bind("course_serialno") %>' CssClass="FullLength"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td width="80">开科学院</td>
                    <td width="100">
                        <asp:DropDownList ID="cboCourseDept" runat="server" Width="155px" DataTextField="course_dept" DataValueField="course_dept">
                        </asp:DropDownList>
                    </td>
                    <td width="80">课程类型</td>
                    <td width="100">
                        <asp:DropDownList ID="cboCourseType" runat="server" Width="155" DataSourceID="sdsCourseType" DataTextField="course_type" DataValueField="course_type"></asp:DropDownList>
                    </td>
                    <td width="80">课程属性</td>
                    <td width="100">
                        <asp:DropDownList ID="cboCourseAttribute" runat="server" Width="155" DataSourceID="sdsCourseAttribute" DataTextField="course_attribute" DataValueField="course_attribute"></asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td width="80">公共课/专业课</td>
                    <td width="100">
                        <asp:DropDownList ID="cboCommonOrPrivate" runat="server" Width="155px">
                        </asp:DropDownList>
                    </td>
                    <td width="80">专业课学院</td>
                    <td width="100">
                        <asp:DropDownList ID="cboPrivateCollege" runat="server" Width="155px">
                        </asp:DropDownList>
                    </td>
                    <td width="80">课程专业</td>
                    <td width="100">
                        <asp:DropDownList ID="cboCoursePro" runat="server" Width="155px"></asp:DropDownList>
                    </td>
                </tr>
            </table>
            <br />
            <p>
                <asp:LinkButton ID="btnSave" runat="server" CausesValidation="True" Text="保存" OnClick="btnSave_Click" />
            </p>
        </div>
        <uc2:MessageBoxControl ID="MsgBox" runat="server" />
        <p>
            <asp:SqlDataSource ID="sdsCourseType" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>" SelectCommand="SELECT DISTINCT course_type FROM ExaminationCourse"></asp:SqlDataSource>
        </p>
        <p>
            <asp:SqlDataSource ID="sdsCourseAttribute" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>" SelectCommand="SELECT DISTINCT course_attribute FROM ExaminationCourse"></asp:SqlDataSource>
        </p>
        <p>
            <asp:CascadingDropDown ID="CascadingDropDown1" runat="server" TargetControlID="cboCourseDept"
                LoadingText="加载数据中，请稍候..." ServiceMethod="GetCollege" ServicePath="~/WebServices/CascadingService.asmx"
                Category="College" EmptyText="请选择学院..."></asp:CascadingDropDown>
            <asp:CascadingDropDown ID="CascadingDropDown2" runat="server" TargetControlID="cboCoursePro"
                ParentControlID="cboCourseDept" PromptText="请选择专业..." LoadingText="加载数据中，请稍候..."
                ServiceMethod="GetMajorOfCollege" ServicePath="~/WebServices/CascadingService.asmx" Category="Major"
                EmptyText="请选择专业..."></asp:CascadingDropDown>
            <asp:SqlDataSource ID="sdsExamCourse" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>" SelectCommand="SELECT ExaminationCourse.course_dept, ExaminationCourse.course_no, ExaminationCourse.course_name, ExaminationCourse.course_serialno, ExaminationCourse.course_type, ExaminationCourse.course_attribute, ExaminationCourse.class_campus, ExaminationCourse.CommonOrPrivate, ExaminationCourse.PrivateCollege, Course.course_profession FROM ExaminationCourse INNER JOIN Course ON ExaminationCourse.course_no = Course.course_no WHERE (ExaminationCourse.ID LIKE @ID)">
                <SelectParameters>
                    <asp:QueryStringParameter Name="ID" QueryStringField="ID" />
                </SelectParameters>
            </asp:SqlDataSource>
        </p>
        <p>
            <asp:CascadingDropDown ID="CascadingDropDown3" runat="server" TargetControlID="cboCommonOrPrivate"
                LoadingText="加载数据中，请稍候..." ServiceMethod="GetCommonOrPrivate" ServicePath="~/WebServices/CascadingService.asmx"
                Category="CommonOrPrivate"></asp:CascadingDropDown>
            <asp:CascadingDropDown ID="CascadingDropDown4" runat="server" TargetControlID="cboPrivateCollege"
                ParentControlID="cboCommonOrPrivate" PromptText="请选择..." LoadingText="加载数据中，请稍候..."
                ServiceMethod="GetPrivateCollege" ServicePath="~/WebServices/CascadingService.asmx" Category="Major"
                EmptyText="请选择"></asp:CascadingDropDown>
        </p>
    </form>
</body>
</html>
