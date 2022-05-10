<%@ Page Title="" Language="C#" MasterPageFile="~/florist.Master" AutoEventWireup="true"
    CodeBehind="OrderConfirm.aspx.cs" Inherits="Florist.OrderConfirm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="divOrderHeading">
        <div class="divHeading">
            <asp:Panel ID="pnlConfirmOrder" runat="server">
                <div class="divHeading">
                    <asp:Label ID="Label2" runat="server" Text="Please Confirm your order"
                        Font-Bold="True" Font-Size="24px"></asp:Label>
                </div>
                <div class="divRow flex-item">
                    <div class="divCol1">
                        <asp:Label ID="lblOrderNumber" runat="server" Text="Order Number"></asp:Label>
                    </div>
                    <div class="divCol2">
                        <asp:TextBox ID="txtOrderNumber" runat="server" ReadOnly="true" Text=""></asp:TextBox>
                    </div>
                </div>
                <div class="divRow flex-item">
                    <div class="divCol1">
                        <asp:Label ID="Label3" runat="server" Text="Order Total"></asp:Label>
                    </div>
                    <div class="divCol2">
                        <asp:TextBox ID="txtOrderTotal" runat="server" ReadOnly="true" Text=""></asp:TextBox>
                    </div>
                </div>
                <div class="divRow">
                    <div class="divHeading">
                        <asp:Button ID="btnConfirm" runat="server" Text="Confirm Order"
                            CssClass="styled-btn" OnClick="btnConfirm_Click" />
                        <asp:Button ID="btnCancel" runat="server" Text="Cancel Order" CssClass="styled-btn"
                            OnClick="btnCancel_Click" />
                    </div>
                </div>
            </asp:Panel>
            <asp:Panel ID="pnlThankYou" runat="server" Visible="false" CssClass="flex-container">
                <asp:Label ID="lblConfirmMessage" runat="server" Text="Thank You for your order."
                    Font-Size="Larger" Font-Bold="True"></asp:Label>
                <asp:LinkButton ID="lnkHomeLink" runat="server" CssClass="link-button" 
                    OnClick="lnkHomeLink_Click">
                    Return to Home Page</asp:LinkButton>
            </asp:Panel>
        </div>

    </div>
</asp:Content>
