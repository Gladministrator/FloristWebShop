<%@ Page Title="" Language="C#" MasterPageFile="~/florist.Master" AutoEventWireup="true" CodeBehind="LandingPage.aspx.cs" Inherits="Florist.LandingPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="landingImages">
     <asp:ImageButton ID="imgbtnProfile" runat="server" ImageUrl="~/Images/Profile.png" OnClick="imgbtnProfile_Click" AlternateText="Profile"/>
 </div>  
  <div class="landingImages">
     <asp:ImageButton ID="imgbtnOrder" runat="server" ImageUrl="~/Images/Order.png" OnClick="imgbtnOrder_Click" AlternateText="Order"/>
 </div>  
</asp:Content>
