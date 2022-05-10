<%@ Page Title="" Language="C#" MasterPageFile="~/florist.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Florist.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1 style="text-align: center">Welcome</h1>
    <h2 id="loginText" runat="server" style="text-align: center"></h2>
    <h3 id="loginText2" runat="server" style="text-align: center"></h3>

    <div class="divLoginLeft">
        <div>
            <asp:Label ID="Label1" runat="server" Text="User Name" CssClass="labelSpacing"></asp:Label>
            <asp:TextBox ID="txtUserName" runat="server" Width="300px"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rvUserName" runat="server"
                ErrorMessage="User Name Required" Text="*"
                ControlToValidate="txtUserName" Font-Size="Large" ForeColor="Red"
                ToolTip="User Name Required" ValidationGroup="Login"></asp:RequiredFieldValidator>
        </div>
        <div class="password-box">
            <asp:Label ID="Label2" runat="server" Text="Password" CssClass="labelSpacingPassword"></asp:Label>
            <asp:TextBox ID="txtPassword" runat="server" Width="300px" TextMode="Password"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rvPassword" runat="server"
                ErrorMessage="Password Required" Text="*"
                ControlToValidate="txtPassword" Font-Size="Large" ForeColor="Red"
                ToolTip="Password Required" ValidationGroup="Login"></asp:RequiredFieldValidator>
        </div>
        <div class="divHeading">
            <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="styled-btn" ValidationGroup="Login" OnClick="btnLogin_Click" />
        </div>
        <div>
            <div class="divHeading">
                <asp:LinkButton ID="lnkCreateProfile" runat="server" CssClass="link-button"
                    CausesValidation="False" OnClick="lnkCreateProfile_Click">Create Profile</asp:LinkButton>
            </div>
            <div class="divHeading">
                <asp:LinkButton ID="lnkForgotPassword" runat="server" CssClass="link-button"
                    CausesValidation="False" OnClick="lnkForgotPassword_Click">Forgot Password</asp:LinkButton>
            </div>
            <div class="divHeading">
                <asp:Label ID="lblMsg" runat="server" Text="Login Failed" Visible="false" ForeColor="Red" Font-Size="Medium" Font-Bold="true"></asp:Label>
            </div>
        </div>
    </div>
    <div class="divLoginRight">
        <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/LoginImage.png"
            Width="305px" />
    </div>


</asp:Content>
