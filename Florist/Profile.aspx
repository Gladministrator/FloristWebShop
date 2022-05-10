<%@ Page Title="" Language="C#" MasterPageFile="~/florist.Master" AutoEventWireup="true"
    CodeBehind="Profile.aspx.cs" Inherits="Florist.Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Panel ID="pnlNewAccount" runat="server" Visible="false">
        <h1 style="text-align: center">Create an Account</h1>
    </asp:Panel>
    <div class="flex-container">
        <div class="flex-item">
            <div class="divColProfile">
                <asp:Label ID="Label1" runat="server" Text="Last Name"></asp:Label>
            </div>
            <div class="divCol2">
                <asp:TextBox ID="txtLastName" runat="server" MaxLength="50" Width="200px"
                    Height="25px"></asp:TextBox>
            </div>
            <div>
                <asp:RequiredFieldValidator ID="rvLastName" runat="server"
                    ErrorMessage="Last Name is Required" Text="*"
                    ControlToValidate="txtLastName" Font-Size="Large" ForeColor="Red"
                    ToolTip="Last Name Required" ValidationGroup="Profile"></asp:RequiredFieldValidator>
            </div>
        </div>
        <div class="flex-item">
            <div class="divColProfile">
                <asp:Label ID="Label2" runat="server" Text="First Name"></asp:Label>
            </div>
            <div class="divCol2">
                <asp:TextBox ID="txtFirstName" runat="server" MaxLength="50" Width="200px"
                    Height="25px"></asp:TextBox>
            </div>
            <div>
                <asp:RequiredFieldValidator ID="rvFirstName" runat="server"
                    ErrorMessage="First Name is Required" Text="*"
                    ControlToValidate="txtFirstName" Font-Size="Large" ForeColor="Red"
                    ToolTip="First Name is Required" ValidationGroup="Profile"></asp:RequiredFieldValidator>
            </div>
        </div>
        <div class="flex-item">
            <div class="divColProfile">
                <asp:Label ID="Label3" runat="server" Text="User Name"></asp:Label>
            </div>
            <div class="divCol2">
                <asp:TextBox ID="txtUserName" runat="server" MaxLength="50" Width="200px" Height="25px"></asp:TextBox>
            </div>
            <div>
                <asp:RequiredFieldValidator ID="rvUserName" runat="server"
                    ErrorMessage="User Name is Required" Text="*"
                    ControlToValidate="txtUserName" Font-Size="Large" ForeColor="Red"
                    ToolTip="User Name is Required" ValidationGroup="Profile"></asp:RequiredFieldValidator>
            </div>
        </div>
        <div class="flex-item">
            <div class="divColProfile">
                <asp:Label ID="Label4" runat="server" Text="Password"></asp:Label>
            </div>
            <div class="divCol2">
                <asp:TextBox ID="txtPassword" runat="server" MaxLength="15" Width="200px" Height="25px"></asp:TextBox>
            </div>
            <div>
                <asp:RequiredFieldValidator ID="rvPassword" runat="server"
                    ErrorMessage="Password is Required" Text="*"
                    ControlToValidate="txtPassword" Font-Size="Large" ForeColor="Red"
                    ToolTip="Password is Required" ValidationGroup="Profile"></asp:RequiredFieldValidator>
            </div>
        </div>
        <div class="flex-item">
            <div class="divColProfile">
                <asp:Label ID="Label5" runat="server" Text="Phone Number"></asp:Label>
            </div>
            <div class="divCol2">
                <asp:TextBox ID="txtPhone" runat="server" MaxLength="25" Width="200px" Height="25px"></asp:TextBox>
            </div>
            <div>
                <asp:RequiredFieldValidator ID="rvPhone" runat="server"
                    ErrorMessage="Phone Number is Required" Text="*"
                    ControlToValidate="txtPhone" Font-Size="Large" ForeColor="Red"
                    ToolTip="Phone Number is Required" ValidationGroup="Profile"></asp:RequiredFieldValidator>
            </div>
        </div>
        <div class="flex-item">
            <div class="divColProfile">
                <asp:Label ID="Label6" runat="server" Text="Email Address"></asp:Label>
            </div>
            <div class="divCol2">
                <asp:TextBox ID="txtEmail" runat="server" MaxLength="150" Width="200px"
                    Height="25px"></asp:TextBox>
            </div>
            <div>
                <asp:RequiredFieldValidator ID="rvEmail" runat="server"
                    ErrorMessage="Email is Required" Text="*"
                    ControlToValidate="txtEmail" Font-Size="Large" ForeColor="Red"
                    ToolTip="Email is Required" ValidationGroup="Profile"></asp:RequiredFieldValidator>
            </div>
        </div>
        <div class="flex-item">
            <div class="divColProfile">
                <asp:Label ID="Label7" runat="server" Text="Secret Question 1"></asp:Label>
            </div>
            <div class="divCol2">
                <asp:TextBox ID="txtSecretQuestion1" runat="server" MaxLength="75" Width="200px"
                    Height="25px"></asp:TextBox>
            </div>
            <div>
                <asp:RequiredFieldValidator ID="rvSecretQuestion1" runat="server"
                    ErrorMessage="Secret Question 1 is Required" Text="*"
                    ControlToValidate="txtSecretQuestion1" Font-Size="Large" ForeColor="Red"
                    ToolTip="Secret Question 1 is Required" ValidationGroup="Profile"></asp:RequiredFieldValidator>
            </div>
        </div>
        <div class="flex-item">
            <div class="divColProfile">
                <asp:Label ID="Label8" runat="server" Text="Secret Answer 1"></asp:Label>
            </div>
            <div class="divCol2">
                <asp:TextBox ID="txtSecretAnswer1" runat="server" MaxLength="75" Width="200px"
                    Height="25px"></asp:TextBox>
            </div>
            <div>
                <asp:RequiredFieldValidator ID="rvSecretAnswer1" runat="server"
                    ErrorMessage="Secret Answer 1 is Required" Text="*"
                    ControlToValidate="txtSecretAnswer1" Font-Size="Large" ForeColor="Red"
                    ToolTip="Secret Answer 1 is Required" ValidationGroup="Profile"></asp:RequiredFieldValidator>
            </div>
        </div>
        <div class="flex-item">
            <div class="divColProfile">
                <asp:Label ID="Label9" runat="server" Text="Secret Question 2"></asp:Label>
            </div>
            <div class="divCol2">
                <asp:TextBox ID="txtSecretQuestion2" runat="server" MaxLength="75" Width="200px"
                    Height="25px"></asp:TextBox>
            </div>
            <div>
                <asp:RequiredFieldValidator ID="rvSecretQuestion2" runat="server"
                    ErrorMessage="Secret Question 2 is Required" Text="*"
                    ControlToValidate="txtSecretQuestion2" Font-Size="Large" ForeColor="Red"
                    ToolTip="Secret Question 2 is Required" ValidationGroup="Profile"></asp:RequiredFieldValidator>
            </div>
        </div>
        <div class="flex-item">
            <div class="divColProfile">
                <asp:Label ID="Label10" runat="server" Text="Secret Answer 2"></asp:Label>
            </div>
            <div class="divCol2">
                <asp:TextBox ID="txtSecretAnswer2" runat="server" MaxLength="75" Width="200px"
                    Height="25px"></asp:TextBox>
            </div>
            <div>
                <asp:RequiredFieldValidator ID="rvSecretAnswer2" runat="server"
                    ErrorMessage="Secret Answer 2 is Required" Text="*"
                    ControlToValidate="txtSecretAnswer2" Font-Size="Large" ForeColor="Red"
                    ToolTip="Secret Answer 2 is Required" ValidationGroup="Profile"></asp:RequiredFieldValidator>
            </div>
        </div>
    </div>

    <div style="margin-top:15px;">
        <asp:Label ID="lblErrorMsg" runat="server" Visible="false" CssClass="centered-field"
            Font-Bold="True" Font-Size="Medium"
            ForeColor="Red" Text="Error Msg"></asp:Label>
        <div class="divHeading">
            <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="styled-btn" ValidationGroup="Profile"
                OnClick="btnSave_Click" />
            <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="styled-btn" CausesValidation="false"
                OnClick="btnClear_Click" />
            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="styled-btn" 
                OnClick="btnCancel_Click" />
        </div>
    </div>
</asp:Content>
