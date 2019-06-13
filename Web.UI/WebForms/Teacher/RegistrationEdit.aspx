<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RegistrationEdit.aspx.cs" Inherits="WebForms_Teacher_RegistrationEdit" %>

<%@ Register Assembly="Infrastructure" Namespace="Infrastructure.Controls" TagPrefix="cc1" %>
<%@ Register Src="../../UserControls/MessageBoxControl.ascx" TagName="MessageBoxControl" TagPrefix="uc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="../../css/style.css" rel="stylesheet" />
    <script src="../../script/jquery.js"></script>
    <script src="../../My97DatePicker/WdatePicker.js"></script>
    <style aria-selected="undefined">
        .FormViewTable td {
            border: 1px solid gray;
            border-collapse: collapse;
            height: 30px;
            line-height: 15px;
        }

        .div_asp {
            margin-top: 12px;
        }

        .dxeTextBox {
            border: none !important;
        }

        td.dxic {
            border-bottom: 1px solid gray;
            border-top: none;
            border-left: none;
            border-right: none;
        }

        .txt, .span_1 {
            display: inline-block;
        }

        table[id^="FVRegistrationEdit_txt_"] {
            width: 40px;
            height: 22px;
        }

        .span_1 {
            position: absolute;
            right: 114px;
            top: 131px;
        }

        .drop {
            border-radius: 5px;
        }

        td[id*="_EC"] {
            position: absolute;
            left: 66px;
            top: 2px;
            border: none;
        }

            td[id*="_EC"] > table > tbody > tr > td {
                border: none;
            }

        td[id*="_txt_"] {
            top: 6px;
        }

        table[id$="ET"] {
            position: relative;
            display: inline-block;
        }

        td[id$="CC"] {
            border: none;
        }
        form#form1 {
            margin-left: -30px;
        }
        .error {
            margin-left: 0px;
        }
    </style>
</head>
<body>
    <asp:Label ID="Label1" runat="server" Font-Size="18px" ForeColor="#cc0000"></asp:Label>
    <br />
    <form id="form1" runat="server">
        <asp:FormView ID="FVRegistrationEdit" runat="server" DataSourceID="SqlDataSource1" DefaultMode="Edit" Height="638px">
            <EditItemTemplate>
                <table style="border: 2px solid gray; border-collapse: collapse;" class="FormViewTable">
                    <tr>
                        <td width="80">课程名称</td>
                        <td width="100">
                            <asp:Label ID="lb_courseName" runat="server" Text='<%# Bind("course_name") %>'></asp:Label>
                            <asp:Label ID="lbRegisID" runat="server" Text='<%# Bind("regID") %>' Visible="False"></asp:Label>
                            <asp:Label ID="lbPaperID" runat="server" Text='<%# Bind("paperID") %>' Visible="False"></asp:Label>
                            <asp:Label ID="lbExamTime" runat="server" Text='<%# Bind("examTime") %>' Visible="False"></asp:Label>
                            <asp:Label ID="lbCoverage" runat="server" Text='<%# Bind("coverage") %>' Visible="False"></asp:Label>
                            <asp:Label ID="lbExpectScore" runat="server" Text='<%# Bind("expectScore") %>' Visible="False"></asp:Label>
                            <asp:Label ID="lbExpectTime" runat="server" Text='<%# Bind("expectTime") %>' Visible="False"></asp:Label>
                            <asp:Label ID="lbExamPercent" runat="server" Text='<%# Bind("examPercent") %>' Visible="False"></asp:Label>
                            <asp:Label ID="lbTiKuorZiNi" runat="server" Text='<%# Bind("tiKuorZiNi") %>' Visible="False"></asp:Label>
                            <asp:Label ID="lbExamMothed" runat="server" Text='<%# Bind("examMothed") %>' Visible="False"></asp:Label>
                        </td>
                        <td width="80">任课教师</td>
                        <td width="100">
                            <asp:Label ID="lb_courseTeacher" runat="server" Text='<%# Bind("course_teacher") %>'></asp:Label>
                        </td>
                        <td width="80">考生人数</td>
                        <td width="100">
                            <dx:ASPxTextBox ID="txtstuNum" runat="server" Text='<%# Bind("stuNum") %>'>
                                <ValidationSettings ErrorDisplayMode="ImageWithText" ValidationGroup="group">
                                    <RegularExpression ErrorText="输入格式错误!"
                                        ValidationExpression="^[1-9]*[1-9][0-9]*$" />
                                    <RequiredField ErrorText="不能为空!" IsRequired="True" />
                                </ValidationSettings>
                            </dx:ASPxTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td width="80">年级</td>
                        <td width="100">
                            <dx:ASPxTextBox ID="txtGrade" runat="server" Text='<%# Bind("grade") %>' NullText="15或15;16">
                                <ValidationSettings ErrorDisplayMode="ImageWithText" ValidationGroup="group">
                                    <RequiredField ErrorText="不能为空!" IsRequired="True" />
                                </ValidationSettings>
                            </dx:ASPxTextBox>
                        </td>
                        <td width="80">专业</td>
                        <td width="100">
                            <dx:ASPxTextBox ID="txtProfession" runat="server" Text='<%# Bind("profession") %>' NullText="信管;工商">
                                <ValidationSettings ErrorDisplayMode="ImageWithText" ValidationGroup="group">
                                    <RequiredField ErrorText="不能为空!" IsRequired="True" />
                                </ValidationSettings>
                            </dx:ASPxTextBox>
                        </td>
                        <td width="80">学院</td>
                        <td width="100">
                            <dx:ASPxTextBox ID="txtCourse_dept" runat="server" Text='<%# Bind("course_dept") %>' NullText="管理学院">
                                <ValidationSettings ErrorDisplayMode="ImageWithText" ValidationGroup="group">
                                    <RequiredField ErrorText="不能为空!" IsRequired="True" />
                                </ValidationSettings>
                            </dx:ASPxTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td width="80">考核类别</td>
                        <td width="100">
                            <asp:Label ID="txtPaper_type" runat="server" Text='<%# Bind("course_type") %>'></asp:Label>
                        </td>
                        <td width="80">考核方式</td>
                        <td width="100">
                            <asp:DropDownList ID="DropDownList2" runat="server" Height="33px" Width="169px" CssClass="drop">
                                <asp:ListItem Value="开卷">开卷</asp:ListItem>
                                <asp:ListItem Value="闭卷">闭卷</asp:ListItem>
                            </asp:DropDownList>
                            <%--<dx:ASPxTextBox ID="txtExamMothed" runat="server" Text='<%# Bind("examMothed") %>' CssClass="FullLength"></dx:ASPxTextBox>--%>
                        </td>
                        <td width="80">考核时长</td>
                        <td width="100">
                            <dx:ASPxTextBox ID="txtExamLength" runat="server" Text='<%# Bind("examLength") %>' NullText="90">
                                <ValidationSettings ErrorDisplayMode="ImageWithText" ValidationGroup="group">
                                    <RegularExpression ErrorText="输入格式错误!"
                                        ValidationExpression="^[1-9]*[1-9][0-9]*$" />
                                    <RequiredField ErrorText="不能为空!" IsRequired="True" />
                                </ValidationSettings>
                            </dx:ASPxTextBox>
                            <span class="span_1">分钟</span>
                        </td>
                    </tr>
                    <tr>
                        <td width="80">试卷页数</td>
                        <td width="100">
                            <dx:ASPxTextBox ID="txtPaper_num" runat="server" Text='<%# Bind("paper_num", "{0}") %>'>
                                <ValidationSettings ErrorDisplayMode="ImageWithText" ValidationGroup="group">
                                    <RegularExpression ErrorText="输入格式错误!"
                                        ValidationExpression="^[1-9]*[1-9][0-9]*$" />
                                    <RequiredField ErrorText="不能为空!" IsRequired="True" />
                                </ValidationSettings>
                            </dx:ASPxTextBox>
                        </td>
                        <td width="80">印制份数</td>
                        <td width="100">
                            <dx:ASPxTextBox ID="txtpaper_copyNum" runat="server" Text='<%# Bind("paper_copyNum", "{0}") %>'>
                                <ValidationSettings ErrorDisplayMode="ImageWithText" ValidationGroup="group">
                                    <RegularExpression ErrorText="输入格式错误!"
                                        ValidationExpression="^[1-9]*[1-9][0-9]*$"/>
                                    <RequiredField ErrorText="不能为空!" IsRequired="True" />
                                </ValidationSettings>
                            </dx:ASPxTextBox>
                        </td>
                        <td width="80">附答题纸数</td>
                        <td width="100">
                            <dx:ASPxTextBox ID="txtWhitePaper_num" runat="server" Text='<%# Bind("whitePaper_num", "{0}") %>'>
                                <ValidationSettings ErrorDisplayMode="ImageWithText" ValidationGroup="group">
                                    <RegularExpression ErrorText="输入格式错误!"
                                        ValidationExpression="^[1-9]*[1-9][0-9]*$" />
                                    <RequiredField ErrorText="不能为空!" IsRequired="True" />
                                </ValidationSettings>
                            </dx:ASPxTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>考核时间：</td>
                        <td colspan="5">第<asp:DropDownList ID="DropDownList3" runat="server" Height="25px" CssClass="drop">
                            <asp:ListItem Value="1">1</asp:ListItem>
                            <asp:ListItem Value="2">2</asp:ListItem>
                            <asp:ListItem Value="3">3</asp:ListItem>
                            <asp:ListItem Value="4">4</asp:ListItem>
                            <asp:ListItem Value="5">5</asp:ListItem>
                            <asp:ListItem Value="6">6</asp:ListItem>
                            <asp:ListItem Value="7">7</asp:ListItem>
                            <asp:ListItem Value="8">8</asp:ListItem>
                            <asp:ListItem Value="9">9</asp:ListItem>
                            <asp:ListItem Value="10">10</asp:ListItem>
                            <asp:ListItem Value="11">11</asp:ListItem>
                            <asp:ListItem Value="12">12</asp:ListItem>
                            <asp:ListItem Value="13">13</asp:ListItem>
                            <asp:ListItem Value="14">14</asp:ListItem>
                            <asp:ListItem Value="15">15</asp:ListItem>
                            <asp:ListItem Value="16">16</asp:ListItem>
                            <asp:ListItem Value="17">17</asp:ListItem>
                            <asp:ListItem Value="18">18</asp:ListItem>
                            <asp:ListItem Value="19">19</asp:ListItem>
                        </asp:DropDownList>
                            教学周——周<asp:DropDownList ID="DropDownList4" runat="server" Height="25px" CssClass="drop">
                                <asp:ListItem Value="1">1</asp:ListItem>
                                <asp:ListItem Value="2">2</asp:ListItem>
                                <asp:ListItem Value="3">3</asp:ListItem>
                                <asp:ListItem Value="4">4</asp:ListItem>
                                <asp:ListItem Value="5">5</asp:ListItem>
                                <asp:ListItem Value="6">6</asp:ListItem>
                                <asp:ListItem Value="7">7</asp:ListItem>
                            </asp:DropDownList>
                            第<asp:DropDownList ID="DropDownList5" runat="server" Height="25px" CssClass="drop">
                                <asp:ListItem Value="1">1</asp:ListItem>
                                <asp:ListItem Value="2">2</asp:ListItem>
                                <asp:ListItem Value="3">3</asp:ListItem>
                                <asp:ListItem Value="4">4</asp:ListItem>
                                <asp:ListItem Value="5">5</asp:ListItem>
                                <asp:ListItem Value="6">6</asp:ListItem>
                                <asp:ListItem Value="7">7</asp:ListItem>
                                <asp:ListItem Value="8">8</asp:ListItem>
                            </asp:DropDownList>
                            节——第<asp:DropDownList ID="DropDownList6" runat="server" Height="25px" CssClass="drop">
                                <asp:ListItem Value="2">2</asp:ListItem>
                                <asp:ListItem Value="3">3</asp:ListItem>
                                <asp:ListItem Value="4">4</asp:ListItem>
                                <asp:ListItem Value="5">5</asp:ListItem>
                                <asp:ListItem Value="6">6</asp:ListItem>
                                <asp:ListItem Value="7">7</asp:ListItem>
                                <asp:ListItem Value="8">8</asp:ListItem>
                            </asp:DropDownList>
                            节
                            <%--<dx:ASPxTextBox ID="txtExamTime" class="textboxnum" runat="server" Text='<%# Bind("examTime") %>' Width="710px" Height="25px"></dx:ASPxTextBox>--%>
                        </td>
                    </tr>
                    <tr>
                        <td>命题情况：</td>
                        <td colspan="5">试题来自题库还是自行拟题：
                            <asp:DropDownList ID="DropDownList1" runat="server" Height="25px" CssClass="drop">
                                <asp:ListItem Value="自拟">自拟</asp:ListItem>
                                <asp:ListItem Value="题库">题库</asp:ListItem>
                            </asp:DropDownList>
                            <br>
                            <div class="div_asp">
                                <%--<%# (Bind("Coverage")).ToString().Substring(14,15)%>--%>
                                基础知识基础理论所占比例：<dx:ASPxTextBox ID="txt_5" class="txt" runat="server">
                                    <ValidationSettings ErrorDisplayMode="ImageWithText" ValidationGroup="group">
                                        <RegularExpression ErrorText="输入格式错误!"
                                            ValidationExpression="^([1-9][0-9]*)+(.[0-9]{1,2})?$" />
                                        <RequiredField ErrorText="不能为空!" IsRequired="True" />
                                    </ValidationSettings>
                                </dx:ASPxTextBox>
                                %
                            </div>
                            <div class="div_asp">
                                知识运用能力的测验所占比例：<dx:ASPxTextBox ID="txt_6" class="txt" runat="server">
                                    <ValidationSettings ErrorDisplayMode="ImageWithText" ValidationGroup="group">
                                        <RegularExpression ErrorText="输入格式错误!"
                                            ValidationExpression="^([1-9][0-9]*)+(.[0-9]{1,2})?$" />
                                        <RequiredField ErrorText="不能为空!" IsRequired="True" />
                                    </ValidationSettings>
                                </dx:ASPxTextBox>
                                %
                            </div>
                            <div class="div_asp">
                                参考资料、课外阅读内容所占比例：<dx:ASPxTextBox ID="txt_7" class="txt" runat="server">
                                    <ValidationSettings ErrorDisplayMode="ImageWithText" ValidationGroup="group">
                                        <RegularExpression ErrorText="输入格式错误!"
                                            ValidationExpression="^([1-9][0-9]*)+(.[0-9]{1,2})?$" />
                                        <RequiredField ErrorText="不能为空!" IsRequired="True" />
                                    </ValidationSettings>
                                </dx:ASPxTextBox>
                                %
                            </div>
                            <%--<dx:ASPxTextBox ID="txtCoverage" runat="server" Height="80px" Style="background-color: #F3F7FD" Text='<%# Bind("coverage") %>' TextMode="MultiLine" Width="710px"></dx:ASPxTextBox>--%>
                            <div class="div_asp">
                                预计中等学生完成答卷所需时间（分钟）：<dx:ASPxTextBox ID="txt_8" class="txt" runat="server">
                                    <ValidationSettings ErrorDisplayMode="ImageWithText" ValidationGroup="group">
                                        <RegularExpression ErrorText="输入格式错误!"
                                            ValidationExpression="^[1-9]*[1-9][0-9]*$" />
                                        <RequiredField ErrorText="不能为空!" IsRequired="True" />
                                    </ValidationSettings>
                                </dx:ASPxTextBox>
                            </div>
                            <div class="div_asp">
                                预计成绩分布：优<dx:ASPxTextBox ID="txt_9" class="txt" runat="server">
                                    <ValidationSettings ErrorDisplayMode="none" ValidationGroup="group">
                                        <RegularExpression ErrorText="*"
                                            ValidationExpression="^([1-9][0-9]*)+(.[0-9]{1,2})?$" />
                                        <RequiredField ErrorText="*" IsRequired="True" />
                                    </ValidationSettings>
                                </dx:ASPxTextBox>
                                %,良<dx:ASPxTextBox ID="txt_10" class="txt" runat="server">
                                    <ValidationSettings ErrorDisplayMode="none" ValidationGroup="group">
                                        <RegularExpression ErrorText="*"
                                            ValidationExpression="^([1-9][0-9]*)+(.[0-9]{1,2})?$" />
                                        <RequiredField ErrorText="*" IsRequired="True" />
                                    </ValidationSettings>
                                </dx:ASPxTextBox>
                                %,中等<dx:ASPxTextBox ID="txt_11" class="txt" runat="server">
                                    <ValidationSettings ErrorDisplayMode="none" ValidationGroup="group">
                                        <RegularExpression ErrorText="*"
                                            ValidationExpression="^([1-9][0-9]*)+(.[0-9]{1,2})?$" />
                                        <RequiredField ErrorText="*" IsRequired="True" />
                                    </ValidationSettings>
                                </dx:ASPxTextBox>
                                %；及格<dx:ASPxTextBox ID="txt_12" class="txt" runat="server">
                                    <ValidationSettings ErrorDisplayMode="none" ValidationGroup="group">
                                        <RegularExpression ErrorText="*"
                                            ValidationExpression="^([1-9][0-9]*)+(.[0-9]{1,2})?$" />
                                        <RequiredField ErrorText="*" IsRequired="True" />
                                    </ValidationSettings>
                                </dx:ASPxTextBox>
                                %；不及格<dx:ASPxTextBox ID="txt_13" class="txt" runat="server">
                                    <ValidationSettings ErrorDisplayMode="ImageWithText" ValidationGroup="group">
                                        <RegularExpression ErrorText="输入格式错误!"
                                            ValidationExpression="^([1-9][0-9]*)+(.[0-9]{1,2})?$" />
                                        <RequiredField ErrorText="不能为空!" IsRequired="True" />
                                    </ValidationSettings>
                                </dx:ASPxTextBox>
                                %
                            </div>
                            <div class="div_asp">
                                本次考核占学期总成绩的比例：<dx:ASPxTextBox ID="txt_14" class="txt" runat="server">
                                    <ValidationSettings ErrorDisplayMode="ImageWithText" ValidationGroup="group">
                                        <RegularExpression ErrorText="输入格式错误!"
                                            ValidationExpression="^([1-9][0-9]*)+(.[0-9]{1,2})?$" />
                                        <RequiredField ErrorText="不能为空!" IsRequired="True" />
                                    </ValidationSettings>
                                </dx:ASPxTextBox>
                                %
                            </div>
                            <br />
                        </td>
                    </tr>


                    <tr>


                        <td>系审核组意见：</td>
                        <td colspan="5">
                            <asp:Label ID="txtProfessionAudit" runat="server" Height="100px" Text='<%# Bind("professionAudit") %>' TextMode="MultiLine" Width="710px"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>院、部审核组意见：</td>
                        <td colspan="5">
                            <asp:Label ID="txtCollegeAudit" runat="server" Height="100px" Text='<%# Bind("collegeAudit") %>' TextMode="MultiLine" Width="710px"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>主管部门意见：</td>
                        <td colspan="5">
                            <asp:Label ID="txtDepartmentChargeAudit" runat="server" Height="100px" Text='<%# Bind("departmentChargeAudit") %>' TextMode="MultiLine" Width="710px"></asp:Label>
                        </td>
                    </tr>
                </table>
                <br />
            </EditItemTemplate>
        </asp:FormView>
        <p style="padding-left: 100px; width: 148px;">
            <dx:ASPxButton ID="UpdateButton" runat="server" Text="保存" OnClick="UpdateButton_Click" Font-Size="20px" ForeColor="#000" Width="100px" Height="35px" ValidationGroup="group" ValidateInvisibleEditors="True" EnableClientSideAPI="True">
                <ClientSideEvents Click="function validate(s,e){
               if (!ASPxClientEdit.ValidateGroup('group'))
                  e.processOnServer = false;
               }" />
            </dx:ASPxButton>
        </p>
        <uc1:MessageBoxControl ID="MsgBox" runat="server" />

        <asp:HiddenField ID="txtState" runat="server" />
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>" SelectCommand="SELECT Registration.grade, Registration.profession, Registration.examLength, Registration.professionAudit, Registration.stuNum, Course.teachingPlan, Course.course_dept, Course.course_name, Course.course_class, Course.course_teacher, Course.course_type, Course.course_attribute, Registration.ID AS regID, Registration.examTime, Registration.examMothed, Registration.TiKuorZiNi, Registration.coverage, Registration.expectTime, Registration.expectScore, Registration.examPercent, Registration.collegeAudit, Registration.departmentChargeAudit, Paper.whitePaper_num, Paper.paper_copyNum, Paper.paper_num, Paper.ID AS paperID, Course.course_no FROM Registration INNER JOIN Course ON Registration.courseID = Course.ID INNER JOIN Paper ON Course.ID = Paper.courseID WHERE (Registration.ID LIKE @regID) AND (Paper.flag LIKE '%考试%')">

            <SelectParameters>
                <asp:QueryStringParameter DefaultValue="" Name="regID" QueryStringField="regID" />
            </SelectParameters>
        </asp:SqlDataSource>
    </form>
</body>
<script type="text/javascript">
    function CloseParentPopup() {
        var p = window.parent;
        var popup = p.window["popupMeetingProposal"];
        popup.Hide();
    }
</script>
</html>


