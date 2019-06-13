<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Photoupload.aspx.cs" Inherits="WebForms_CollegeAdmin_Zipupload" %>

<%@ Register src="../../UserControls/MessageBoxControl.ascx" tagname="MessageBoxControl" tagprefix="uc2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="Infrastructure" Namespace="Infrastructure.Controls" TagPrefix="cc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link href="../../css/style.css" rel="stylesheet" />
    <script src="../../script/jquery.js"></script>
    <style>
       .p_info{
           margin: 25px;
       }
       #IPersonalCard{
          
       }
       #btnImport{
           margin-top: 25px;
           margin-left: 200px;
       }
       .span_1{

       }
    </style>
    </head>
    <body>
    <form id="form1" runat="server">
    <div>
         <h2>基础信息</h2>
       <div>
        <p class="p_info">姓名：<dx:ASPxLabel ID="lbName" runat="server"></dx:ASPxLabel></p>
        <p class="p_info">性别：<dx:ASPxLabel ID="lbSex" runat="server"></dx:ASPxLabel></p>
        <p class="p_info">电话：<asp:TextBox ID="lbTel" runat="server"></asp:TextBox><span style="color:red">*</span></p>       
        <p class="p_info">签名图片上传：<asp:FileUpload ID="files" runat="server" /></p>
      <p class="p_info" style="height:40px;width:580px;background-color:#D1CA9C">①图片为png格式；
       ②图片命名为本人工号；
       ③签名仅包含教师姓名；
       ④姓名周围减少留白；
          <br />
       ⑤图片背景尽量为白色，不要有阴影，字迹清晰。</p> 
         <div style="display: inline-grid; margin: 25px;">  签名图片展示：<asp:Image CssClass="imgView" ID="IPersonalCard" AlternateText="" ImageUrl="" runat="server"/></div>
           </div>
        <dx:ASPxButton ID="btnImport" runat="server" OnClick="btnImport_Click" Text="保存"></dx:ASPxButton>
    </div>
            <uc2:MessageBoxControl runat="server" ID="MsgBox" />
        <asp:HiddenField ID="txtTeacherId" runat="server" />
        <asp:HiddenField ID="txtAccount" runat="server" />
    </form>
</body>
</html>
