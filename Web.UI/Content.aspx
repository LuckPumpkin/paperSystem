<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Content.aspx.cs" Inherits="Content" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="css/style.css" rel="stylesheet" />
    <style type="text/css">
        .auto-style2 {
            color:#FF0000;
            font-size: medium;
        }
        .auto-style3 {
            font-size: medium;
        }
        .dxtcLite > .dxtc-content{
            border:none!important;
        }
        #ASPxPageControl1_TC,#ASPxPageControl1_CC{
            width:1000px!important;
        }
        .dxtc-rightIndent{
            width:805px!important;
        }
        .flow_img{
            width:auto;
            height:auto;
            text-align:center;
        }
        .flow_img_2{
            width:1000px;
        }
    </style>
     <script type="text/javascript">
         function ShowTeacherDetail(userId) {
             popupTeacherDetail.SetContentUrl("/../WebForms/Common/anaDetail.aspx?College=" + userId);
             popupTeacherDetail.Show();
         }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
                <dx:ASPxPageControl ID="ASPxPageControl1" runat="server" ActiveTabIndex="0" >
                    <TabPages>
                        <dx:TabPage Name="通知消息" Text="通知消息">
                            <ContentCollection>
                                <dx:ContentControl runat="server">
                                    <div>
                                        <p>
                                           欢迎使用华北理工大学试卷管理系统！</p>
                                    </div>
                                    <br/>
                                    <div id="divSchool" runat="server" style="font:25px;">
                                        <asp:ListView ID="ListView1" runat="server" DataSourceID="SqlDataSource1">
                                            <AlternatingItemTemplate>
                                                <li style="background-color: #FFFFFF;color: #284775;">学院名称:
                                                    <asp:Label ID="course_deptLabel" runat="server" Text='<%# Eval("course_dept") %>' />
                                                    <br />
                                                    <br />
                                                    &nbsp;&nbsp;&nbsp;&nbsp;未提交试卷分析数:
                                                    <asp:Label ID="numLabel" runat="server" Text='<%# Eval("num") %>' />份  &nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" onclick='javascript:ShowTeacherDetail("<%# Eval("course_dept") %>");'>详情</a>
                                                    <br />
                                                </li>
                                            </AlternatingItemTemplate>
                                            <EmptyDataTemplate>
                                                未提交试卷分析。
                                            </EmptyDataTemplate>
                                            <ItemSeparatorTemplate>
                                                <br />
                                            </ItemSeparatorTemplate>
                                            <ItemTemplate>
                                                <li style="background-color: #E0FFFF;color: #333333;">学院名称:
                                                    <asp:Label ID="course_deptLabel" runat="server" Text='<%# Eval("course_dept") %>' />
                                                    <br />
                                                    <br />
                                                    &nbsp;&nbsp;&nbsp;&nbsp;未提交试卷分析数:
                                                    <asp:Label ID="numLabel" runat="server" Text='<%# Eval("num") %>' />份  &nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" onclick='javascript:ShowTeacherDetail("<%# Eval("course_dept") %>");'>详情</a>
                                                    <br />
                                                </li>
                                            </ItemTemplate>
                                            <LayoutTemplate>
                                                <div id="itemPlaceholderContainer" runat="server" style="font-family: Verdana, Arial, Helvetica, sans-serif;">
                                                    <span runat="server" id="itemPlaceholder" />
                                                </div>
                                                <div style="text-align: center;background-color: #5D7B9D;font-family: Verdana, Arial, Helvetica, sans-serif;color: #FFFFFF;">
                                                </div>
                                            </LayoutTemplate>
                                        </asp:ListView>
                                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnStr %>" SelectCommand="SELECT course_dept, num FROM (SELECT COUNT(*) AS num, Course.course_dept FROM Analysis INNER JOIN ExaminationCourse ON Analysis.ExaminationCourseID = ExaminationCourse.ID INNER JOIN Course ON ExaminationCourse.course_no = Course.course_no INNER JOIN Paper ON Course.ID = Paper.courseID WHERE (Paper.printed = 1) AND (Analysis.state = 11) GROUP BY Course.course_dept HAVING (COUNT(*) &lt;&gt; 0)) AS derivedtbl_1"></asp:SqlDataSource>
                                    </div>
                                    <div id="divTeacher" runat="server" style="font:20px;">
                                        <p id="p1" runat="server"><span class="auto-style2">★</span><span class="auto-style3">您有<asp:label id="lbreg" runat="server" style="color:#FF0000;width:20px;height:20px;display:inline; font-weight: 700;"></asp:label>份登记表未提交！</span></p>
                                        <p id="p2" runat="server"><span class="auto-style2">★</span><span class="auto-style3">您有<asp:label id="lbana" runat="server" style="color:#FF0000;width:20px;height:20px;display:inline; font-weight: 700;"></asp:label>份分析表未提交！请于考试结束后一周内尽快提交！！</span></p>
                                        <p id="p6" runat="server"><span class="auto-style2">★</span><span class="auto-style3">您有<asp:label id="lbres" runat="server" style="color:#FF0000;width:20px;height:20px;display:inline; font-weight: 700;"></asp:label>条补考信息未提交！</span></p>
                                    </div>
                                    <div id="divProfession" runat="server" style="font:20px;">
                                        <p id="p8" runat="server"><span class="auto-style2">★</span><span class="auto-style3">本专业有<asp:label id="lbanaii" runat="server" style="color:#FF0000;width:20px;height:20px;display:inline; font-weight: 700;"></asp:label>份课程已考试完！请尽快指定教师提交试卷分析！！</span></p>
                                        <p id="p3" runat="server"><span class="auto-style2">★</span><span class="auto-style3">您有<asp:label id="lbredaduit" runat="server" style="color:#FF0000;width:20px;height:20px;display:inline; font-weight: 700;"></asp:label>份登记表未审核！</span></p>
                                        <p id="p4" runat="server"><span class="auto-style2">★</span><span class="auto-style3">您有<asp:label id="lbanaaduit" runat="server" style="color:#FF0000;width:20px;height:20px;display:inline; font-weight: 700;"></asp:label>份分析表未审核！</span></p>
                                    </div>
                                    <div id="divCollege" runat="server" style="font:20px;">
                                        <p id="p7" runat="server"><span class="auto-style2">★</span><span class="auto-style3">本学院有<asp:label id="lbanai" runat="server" style="color:#FF0000;width:20px;height:20px;display:inline; font-weight: 700;"></asp:label>份分析表未提交！请尽快督促教师完成！！</span>&nbsp;&nbsp;&nbsp;<asp:linkButton runat="server" onclick="Show_Click">详情</asp:linkButton></p>
                                        <p id="p5" runat="server"><span class="auto-style2">★</span><span class="auto-style3">您有<asp:label id="lbregaduit" runat="server" style="color:#FF0000;width:20px;height:20px;display:inline; font-weight: 700;"></asp:label>份登记表未审核！</span></p>
                                    </div>
                                    <div id="divPrint" runat="server" style="font:20px;">
                                        <span class="auto-style2">★</span><span class="auto-style3">您有<asp:label id="lbpaper" runat="server" style="color:#FF0000;width:20px;height:20px;display:inline; font-weight: 700;"></asp:label>份样卷需要打印！</span>
                                    </div>
                                    <div id="divDefault" runat="server">
                                    </div>
                                </dx:ContentControl>
                            </ContentCollection>
                        </dx:TabPage>
                        <dx:TabPage Name="流程管理" Text="流程管理">
                            <ContentCollection>
                                <dx:ContentControl runat="server">
                                  <div style="position: relative;">
                                  <!-- 人员管理 -->
                                  <p>(1)人员管理</p>
                                      <img class="flow_img" src="images/progress/work_1.png"/>
                                 </div>
                                    <br />
                                 <div style="position: relative;">
                                  <!-- 试卷打印 -->
                                  <p>(2)试卷打印</p>
                                      <img class="flow_img flow_img_2" src="images/progress/work_2.png"/>
                                 </div>
                                 <div style="position: relative;">
                                  <!-- 试卷分析 -->
                                  <p>(3)试卷分析</p>
                                        <br />
                                      <img class="flow_img" src="images/progress/work_3.png"/>
                                 </div>
                                    <div style="position: relative;">
                                  <!-- 补考管理 -->
                                  <p>(4)补考管理</p>
                                      <img class="flow_img" src="images/progress/work_4.png"/>
                                 </div>
                                </dx:ContentControl>
                            </ContentCollection>
                        </dx:TabPage>
                    </TabPages>
                </dx:ASPxPageControl>
             <dx:ASPxPopupControl ID="popupTeacherDetail" runat="server" CloseAction="CloseButton" HeaderText="教师明细信息" Height="300px" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ShowFooter="True" Theme="Aqua" Width="883px" PopupAnimationType="Fade" ClientInstanceName="popupTeacherDetail" AllowDragging="True" AllowResize="True" FooterText="">
                <HeaderImage Url="~/images/edit.png">
                </HeaderImage>
                <ClientSideEvents Closing="function(s, e) {
	popupTeacherDetail.show=false;
}" />
                <FooterStyle>
                    <Paddings Padding="5px" />
                </FooterStyle>
                <ContentCollection>
                    <dx:PopupControlContentControl ID="PopupControlContentControl4" runat="server" SupportsDisabledAttribute="True"></dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>
                <asp:HiddenField runat="server" ID="txtPro"></asp:HiddenField>
                <asp:HiddenField runat="server" ID="txtCollege"></asp:HiddenField>
        </div>
    </form>
</body>
</html>
