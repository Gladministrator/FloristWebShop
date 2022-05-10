<%@ Page Title="" Language="C#" MasterPageFile="~/florist.Master" AutoEventWireup="true"
    CodeBehind="ForgotPassword.aspx.cs" Inherits="Florist.ForgotPassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3 style="text-align: center; color:#b36200; margin: 0 0; font-size:22px">Please fill the below information to reset your password
    </h3>
    <div class="main-recovery-content">
        <div class="recovery-content">
            <asp:Label ID="Label1" runat="server" Text="Enter Your User Name" CssClass="label-recovery"
                Font-Bold="True"></asp:Label>
            <div>
                <asp:TextBox ID="txtUserName" runat="server" MaxLength="50" Width="200px"
                    Height="25px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rvUserName" runat="server"
                    ErrorMessage="User Name is Required" Text="*"
                    ControlToValidate="txtUserName" Font-Size="Large" ForeColor="Red"
                    ToolTip="User Name Required" ValidationGroup="username"></asp:RequiredFieldValidator>
            </div>
            <asp:Label ID="lblErrorUserName" runat="server" Visible="false" Text="Invalid User Name"></asp:Label>
            <asp:Button ID="btnSubmitUserName" runat="server" CssClass="styled-btn" Text="Submit User Name"
                ValidationGroup="username"
                OnClick="btnSubmitUserName_Click" />
        </div>
        <asp:Panel CssClass="recovery-content" ID="pnlRecoveryQuestions" runat="server" Visible="false">
            <asp:Label runat="server" Font-Bold="True" CssClass="label-recovery">Please answer your security questions</asp:Label>
            <asp:Label ID="lblQuestion1" runat="server" Text="Security Question 1"></asp:Label>
            <div>
                <asp:TextBox ID="txtAnswer1" runat="server" MaxLength="75"
                    Width="200px" Height="25px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rvQuestion1" runat="server"
                    ErrorMessage="Security Answer is Required" Text="*"
                    ControlToValidate="txtAnswer1" Font-Size="Large" ForeColor="Red"
                    ToolTip="Security Answer is Required" ValidationGroup="Questions">
                </asp:RequiredFieldValidator>
            </div>
            <asp:Label ID="lblQuestion2" runat="server" Text="Securet Question 2"></asp:Label>
            <div>
                <asp:TextBox ID="txtAnswer2" runat="server" MaxLength="75"
                    Width="200px" Height="25px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rvQuestion2" runat="server"
                    ErrorMessage="Security Answer is Required" Text="*"
                    ControlToValidate="txtAnswer2" Font-Size="Large" ForeColor="Red"
                    ToolTip="Security Answer is Required" ValidationGroup="Questions"></asp:RequiredFieldValidator>
            </div>
            <asp:Label ID="lblAnswersWrong" runat="server" Text="Incorrect Answer(s)" Visible="false"></asp:Label>
            <asp:Button ID="btnSubmitAnswers" runat="server" CssClass="styled-btn" Text="Submit Answers"
                ValidationGroup="Questions" OnClick="btnSubmitAnswers_Click" />
        </asp:Panel>
        <asp:Panel CssClass="recovery-content" ID="pnlResetPassword" runat="server" Visible="false">
            <asp:Label ID="lblResetPassword" runat="server" Text="Enter New Password" Font-Bold="True"
                CssClass="label-recovery"></asp:Label>
            <div>
                <asp:TextBox ID="txtResetPassword" runat="server" Width="200px" Height="25px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rvResetPassword" runat="server"
                    ErrorMessage="A New Password is Required" Text="*"
                    ControlToValidate="txtResetPassword" Font-Size="Large" ForeColor="Red"
                    ToolTip="A New Password is Required" ValidationGroup="Password">
                </asp:RequiredFieldValidator>
            </div>
            <asp:Button ID="btnSubmitPassword" runat="server" CssClass="styled-btn" Text="Reset Password"
                ValidationGroup="Password" OnClick="btnSubmitPassword_Click" />
        </asp:Panel>
        <asp:Panel ID="pnlCompletion" runat="server" Visible="false" CssClass="recovery-content">
            <asp:Label ID="lblCompletion" runat="server"></asp:Label>
        </asp:Panel>
        <asp:LinkButton CssClass="centered-field link-button" ID="lnkReturnLogin" runat="server" Font-Bold="True"
            ForeColor="#000066" OnClick="lnkReturnLogin_Click">Return to Login Page</asp:LinkButton>
    </div>
    <br />
</asp:Content>
