<%@ Page Title="" Language="C#" MasterPageFile="~/florist.Master" AutoEventWireup="true"
    CodeBehind="Order.aspx.cs" Inherits="Florist.Order" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3 style="margin: 5px 0 0 0; text-align: center; color: darkblue;">Order Flowers
    </h3>
    <div class="divOrderHeading">
        <div class="divRow">
            <div class="divCol1">
                <asp:Label ID="Label1" runat="server" Text="Occasion"></asp:Label>
            </div>
            <div class="divCol2">
                <asp:DropDownList ID="dlOccasion" runat="server" CssClass="drop-down-menu" Width="150px"
                    Height="25px" AutoPostBack="true"
                    OnSelectedIndexChanged="dlOccasion_SelectedIndexChanged">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rvOccasion" runat="server"
                    ErrorMessage="Select Occasion" ControlToValidate="dlOccasion"
                    ForeColor="Red" Font-Size="Large" Text="*"
                    ToolTip="Select Occasion" ValidationGroup="Order"
                    InitialValue="-1"></asp:RequiredFieldValidator>
            </div>
            <div class="divCol1">
                <asp:Label ID="Label2" runat="server" Text="Flower"></asp:Label>
            </div>
            <div class="divCol2">
                <asp:DropDownList ID="dlFlower" runat="server" CssClass="drop-down-menu" Width="150px"
                    Height="25px" AutoPostBack="true">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfFlower" runat="server"
                    ErrorMessage="Select Flower" ControlToValidate="dlFlower"
                    ForeColor="Red" Font-Size="Large" Text="*"
                    ToolTip="Select Flower" ValidationGroup="Order"
                    InitialValue="-1"></asp:RequiredFieldValidator>
            </div>
        </div>
        <asp:Panel ID="pnlOrderSummary" Visible="false" runat="server">
            <div class="divRow">
                <div class="divCol1">
                    <asp:Label ID="Label3" runat="server" Text="Order #"></asp:Label>
                </div>
                <div class="divCol2">
                    <asp:TextBox ID="txtOrderNumber" runat="server" ReadOnly="true"></asp:TextBox>
                </div>
                <div class="divCol1">
                    <asp:Label ID="Label4" runat="server" Text="Order Total"></asp:Label>
                </div>
                <div class="divCol2">
                    <asp:TextBox ID="txtOrderTotal" runat="server" ReadOnly="true"></asp:TextBox>
                </div>
            </div>
        </asp:Panel>
        <asp:Panel ID="pnlAddress" runat="server">

            <div class="divRow">
                <asp:Label ID="Label7" runat="server" Text="Ship To Address" ForeColor="darkblue"
                    Font-Bold="true" Font-Size="Large"></asp:Label>
            </div>
            <div class="divRow">
                <div class="divCol1">
                    <asp:Label ID="Label13" runat="server" Text="First Name"></asp:Label>
                </div>
                <div class="divCol2">
                    <asp:TextBox ID="txtFirstName" runat="server" Width="193px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfFirstName" runat="server"
                        ErrorMessage="First Name is Required"
                        ControlToValidate="txtFirstName" Text="*"
                        ForeColor="Red" ToolTip="First Name is Required"
                        Font-Size="Large" ValidationGroup="Order"></asp:RequiredFieldValidator>

                </div>
                <div class="divCol1">
                    <asp:Label ID="Label14" runat="server" Text="Last Name"></asp:Label>
                </div>
                <div class="divCol2">
                    <asp:TextBox ID="txtLastName" runat="server" Width="181px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfLastName" runat="server"
                        ErrorMessage="Last Name is Required"
                        ControlToValidate="txtLastName" Text="*"
                        ForeColor="Red" ToolTip="Last Name is Required"
                        Font-Size="Large" ValidationGroup="Order"></asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="divRow">
                <div class="divCol1">
                    <asp:Label ID="Label6" runat="server" Text="Street Address"></asp:Label>
                </div>
                <div class="divCol2">
                    <asp:TextBox ID="txtStreetAddress" runat="server" Width="192px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfStreetAddress" runat="server"
                        ErrorMessage="Street Address Required"
                        ControlToValidate="txtStreetAddress" Text="*"
                        ForeColor="Red" ToolTip="Street Address Required"
                        Font-Size="Large" ValidationGroup="Order"></asp:RequiredFieldValidator>
                </div>
                <div class="divCol1">
                    <asp:Label ID="Label8" runat="server" Text="Suite"></asp:Label>
                </div>
                <div class="divCol2">
                    <asp:TextBox ID="txtSuite" runat="server"></asp:TextBox>
                </div>
            </div>
            <div class="divRow">
                <div class="divCol1">
                    <asp:Label ID="Label9" runat="server" Text="City"></asp:Label>
                </div>
                <div class="divCol2">
                    <asp:TextBox ID="txtCity" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfCity" runat="server"
                        ErrorMessage="City Required"
                        ControlToValidate="txtCity" Text="*"
                        ForeColor="Red" ToolTip="City Required"
                        Font-Size="Large" ValidationGroup="Order"></asp:RequiredFieldValidator>
                </div>
                <div class="divCol1">
                    <asp:Label ID="Label10" runat="server" Text="Region"></asp:Label>
                </div>
                <div class="divCol2">
                    <asp:DropDownList ID="dlRegion" runat="server" CssClass="drop-down-menu" Height="25px"
                        Width="200px">
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfRegion" runat="server"
                        ErrorMessage="Region Required"
                        ControlToValidate="dlRegion" Text="*"
                        ForeColor="Red" ToolTip="Region Required"
                        Font-Size="Large" ValidationGroup="Order" InitialValue="-1"></asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="divRow">
                <div class="divCol1">
                    <asp:Label ID="Label11" runat="server" Text="Country"></asp:Label>
                </div>
                <div class="divCol2">
                    <asp:DropDownList ID="dlCountry" runat="server" CssClass="drop-down-menu" Height="25px"
                        Width="128px">
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfCountry" runat="server"
                        ErrorMessage="Country Required"
                        ControlToValidate="dlCountry" Text="*"
                        ForeColor="Red" ToolTip="Country Required"
                        Font-Size="Large" ValidationGroup="Order" InitialValue="-1"></asp:RequiredFieldValidator>
                </div>
                <div class="divCol1">
                    <asp:Label ID="Label12" runat="server" Text="Zip Code"></asp:Label>
                </div>
                <div class="divCol2">
                    <asp:TextBox ID="txtZipCode" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfZipCode" runat="server"
                        ErrorMessage="Zip Code Required"
                        ControlToValidate="txtZipCode" Text="*"
                        ForeColor="Red" ToolTip="Zip Code Required"
                        Font-Size="Large" ValidationGroup="Order"></asp:RequiredFieldValidator>
                </div>
            </div>
        </asp:Panel>
        <asp:Label ID="lblButonError" runat="server" Visible="false" CssClass="lbl-error-msg centered-field"></asp:Label>
        <div>
            <div class="divHeading">
                <asp:Button ID="btnAdd" runat="server" Text="Add to Order" CssClass="styled-btn"
                    ValidationGroup="Order" OnClick="btnAdd_Click" />
                <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="styled-btn"
                    CausesValidation="False" OnClick="btnReset_Click" />
                <asp:Button ID="btnCancel" runat="server" Text="Cancel Order"
                    CssClass="styled-btn" CausesValidation="False" OnClick="btnCancel_Click" />
                <asp:Button ID="btnPlaceOrder" runat="server" Text="Place Order"
                    CssClass="styled-btn" CausesValidation="False" OnClick="btnPlaceOrder_Click" />
            </div>
        </div>
        <br />
        <div>
            <asp:Label runat="server" ID="lblError" Visible="false"></asp:Label>
            <asp:Panel ID="pnlGrid" runat="server" Visible="true">
                <div>
                    <asp:Label ID="Label5" runat="server" Text="Number of Items in order"
                        Font-Bold="True" Font-Size="Large" ForeColor="darkblue"></asp:Label>
                    &nbsp;&nbsp;
                    <asp:Label ID="lblNumberOfItems" runat="server" Text="0"></asp:Label>
                </div>

                <asp:GridView ID="gvOrderDetails" runat="server" Width="1011px"
                    AutoGenerateColumns="False" OnRowDeleting="OnRowDeleting">
                    <AlternatingRowStyle BackColor="#00cccc" />
                    <Columns>
                        <asp:BoundField DataField="Item Number" HeaderText="Item Number">
                            <ControlStyle BackColor="#669999" Font-Bold="True" ForeColor="#3333FF" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Flower" HeaderText="Flower">
                            <ControlStyle BackColor="#669999" Font-Bold="True" ForeColor="#3333FF" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="{0:0.00}">
                            <ControlStyle BackColor="#669999" Font-Bold="True" ForeColor="#3333FF" BorderStyle="Solid" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Taxes" HeaderText="Taxes" DataFormatString="{0:0.00}">
                            <ControlStyle BackColor="#669999" Font-Bold="True" ForeColor="#3333FF" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Subtotal" HeaderText="Subtotal" DataFormatString="{0:0.00}">
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                            <ControlStyle BackColor="#669999" Font-Bold="True" ForeColor="#3333FF" />
                        </asp:BoundField>
                        <asp:CommandField ShowDeleteButton="True" ButtonType="Link" 
                            ControlStyle-CssClass="delete-button centered-field">
                        <ControlStyle CssClass="delete-button centered-field" />
                        </asp:CommandField>
                    </Columns>
                    <HeaderStyle BackColor="#CC6600" />
                    <PagerStyle BackColor="#FFCC00" ForeColor="#FFCC00" />
                    <RowStyle BackColor="#0066cc" />
                </asp:GridView>
                <div class="divHeading">
                </div>
            </asp:Panel>
        </div>
    </div>
</asp:Content>
