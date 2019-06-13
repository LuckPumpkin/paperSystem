<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DataImporter.ascx.cs" Inherits="DataImporter" %>

<%@ Register Src="MessageBoxControl.ascx" TagName="MessageBoxControl" TagPrefix="uc1" %>
<%@ Register Src="MoverList.ascx" TagName="MoverList" TagPrefix="uc2" %>
<script type="text/javascript" language="javascript">
    function SetPorgressBar(pos) {
        //设置进度条居中
        ProgressBarSide.style.height = "21px";
        ProgressBarSide.style.display = "";
        //设置进度条百分比
        ProgressBar.style.width = pos + "%";
        ProgressText.innerHTML = pos + "%";
    }
    //完成后隐藏进度条
    function SetCompleted() {
        ProgressBarSide.style.display = "none";
    }
</script>
<style>
   #ImportStudent_ImportWizard_StepNavigationTemplateContainerID_StepNextButton,#ImportStudent_ImportWizard_StepNavigationTemplateContainerID_StepPreviousButton{
      margin:10px 10px 10px 5px;
   }
</style>
<asp:Wizard ID="ImportWizard" runat="server" ActiveStepIndex="0" Height="335px" Width="495px"
    BorderColor="#8BB6EF" BorderStyle="Solid" BorderWidth="1px" OnNextButtonClick="ImportWizard_NextButtonClick"
    OnFinishButtonClick="ImportWizard_FinishButtonClick" DisplaySideBar="False" style="margin-top: 0px">
    <StepNavigationTemplate>
        <asp:Button ID="StepPreviousButton" runat="server" CausesValidation="False" CommandName="MovePrevious" Text="上一步" />
        <asp:Button ID="StepNextButton" runat="server" CommandName="MoveNext" Text="下一步" />
    </StepNavigationTemplate>
    <StepStyle VerticalAlign="Top" BorderStyle="None" />
    <WizardSteps>
        <asp:WizardStep ID="WizardStep1" runat="server" Title="第一步：指定待导入字段">
            <div style="padding: 10px">
                <p>
                    <strong>第一步：选择待导入数据包含的字段及顺序</strong>
                </p>
                <p>
                    选择要导入的字段及字段排列顺序：
                </p>
                <uc2:MoverList ID="olmFieldSelection" runat="server" />
            </div>
        </asp:WizardStep>
        <asp:WizardStep ID="WizardStep2" runat="server" Title="第二步：指定主键">
            <div style="padding: 10px">
                <p>
                    <strong>第二步：指定主键</strong>
                </p>
                <p>
                    <asp:RadioButtonList ID="rblKeyField" runat="server" RepeatColumns="4" RepeatDirection="Horizontal"
                        Width="466px">
                    </asp:RadioButtonList>
                </p>
            </div>
        </asp:WizardStep>
        <asp:WizardStep ID="WizardStep3" runat="server" Title="第三步：指定保护字段">
            <div style="padding: 10px">
                <p>
                    <strong>第三步：选择保护字段</strong>
                </p>
                <div style="height: 48px; width: 460px; padding: 4px; border: 1px solid #a4dbfe; background-color: #e5f5ff; padding: 5 10 5 0; color: Gray; line-height: 24px;">
                    <div style="float: left; width: 40px; height: 48px; text-align: center; vertical-align: middle;">
                        <img alt="" src="../../images/information.png" style="margin-top: 4px;" />
                    </div>
                    <div>
                        一旦字段被设为保护字段，在上传过程中将比较这些保护字段与数据库中的相应字段值是否一致，只有一致时数据才能上传成功，否则数据将上传失败。
                    </div>
                </div>
                <p>
                    <asp:CheckBoxList ID="cblProtectFields" runat="server" RepeatColumns="4" RepeatDirection="Horizontal"
                        Width="470px">
                    </asp:CheckBoxList>
                </p>
            </div>
        </asp:WizardStep>
        <asp:WizardStep ID="WizardStep4" runat="server" Title="第四步：上传数据文件">
            <div style="padding: 10px">
                <p>
                    <strong>第四步：上传要导入的数据文件</strong>
                </p>
                <div style="height: 48px; width: 460px; padding: 4px; border: 1px solid #a4dbfe; background-color: #e5f5ff; padding: 5 10 5 0; color: Gray; line-height: 24px;">
                    <div style="float: left; width: 40px; height: 48px; text-align: center; vertical-align: middle;">
                        <img alt="" src="../../images/information.png" style="margin-top: 4px;" />
                    </div>
                    <div>
                        文件格式为CSV格式的纯文本文件。每行代表一条记录，字段间使用“，”分割。日期请采用“yyyy-mm-dd”格式。
                    </div>
                </div>
		<dx:ASPxButton runat="server" Theme="Aqua" OnClick="btnDown_Click" ID="btnImport0" Text="下载文本模板" style="margin:10px 0 10px 0;"></dx:ASPxButton>
                <div>
                    <asp:FileUpload ID="fileUpload" runat="server"/>
                </div>
                <p style="padding: 10px">
                    <asp:CheckBox ID="chkAllowInsert" runat="server" Text="如果数据库中不存在该纪录，则插入至数据库中。" />
                    <br />
                    <asp:CheckBox ID="chkDataHeadIncluded" runat="server" Text="数据文件包含标题" />
                </p>
            </div>
        </asp:WizardStep>
    </WizardSteps>
    <NavigationStyle BackColor="#E2F0FF" BorderColor="#8BB6EF" BorderWidth="1px" />
    <SideBarStyle HorizontalAlign="Left" VerticalAlign="Top" />
</asp:Wizard>
<p></p>
<uc1:MessageBoxControl ID="MsgBox" runat="server" />
<p></p>
<dx:ASPxPopupControl ID="ErrorMessagesPopup" runat="server" AllowDragging="True" CloseAction="CloseButton" HeaderText="导入数据错误" Height="256px" Modal="True" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Theme="Aqua" Width="474px">
    <ContentCollection>
        <dx:PopupControlContentControl runat="server" SupportsDisabledAttribute="True">
            <div style="width: 436px; height: 192px; overflow: scroll; border: 1px solid red; padding: 5px;">
                <asp:Literal ID="txtErrorMsg" runat="server"></asp:Literal>
            </div>
        </dx:PopupControlContentControl>
    </ContentCollection>
</dx:ASPxPopupControl>
