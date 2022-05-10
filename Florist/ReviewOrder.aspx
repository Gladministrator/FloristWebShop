<%@ Page Title="" Language="C#" MasterPageFile="~/florist.Master" AutoEventWireup="true"
    CodeBehind="ReviewOrder.aspx.cs" Inherits="Florist.ReviewOrder" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="divOrderHeading">
        <div>
            <h1 id="h1ReviewOrder" runat="server"  style="text-align:center"></h1>
            <asp:Panel ID="pnlItems" runat="server">
                <asp:GridView ID="gvReviewOrderHistory" runat="server" Width="1011px"
                    AutoGenerateColumns="False">
                    <AlternatingRowStyle BackColor="#00cccc" />
                    <Columns>
                        <asp:BoundField DataField="InvoiceID" HeaderText="Order Number">
                            <ControlStyle BackColor="#669999" Font-Bold="True" ForeColor="#3333FF" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Date" HeaderText="Invoice Date" DataFormatString="{0:d}">
                            <ControlStyle BackColor="#669999" Font-Bold="True" ForeColor="#3333FF" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:BoundField>
                        <asp:BoundField DataField="NumberOfItems" HeaderText="Number of Items">
                            <ControlStyle BackColor="#669999" Font-Bold="True" ForeColor="#3333FF" BorderStyle="Solid" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:BoundField>
                        <asp:BoundField DataField="TotalPrice" HeaderText="Total Price" DataFormatString="{0:0.00}">
                            <ControlStyle BackColor="#669999" Font-Bold="True" ForeColor="#3333FF" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ShipToName" HeaderText="Ship To" DataFormatString="{0:0.00}">
                            <ControlStyle BackColor="#669999" Font-Bold="True" ForeColor="#3333FF" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:BoundField>
                    </Columns>
                    <HeaderStyle BackColor="#CC6600" />
                    <PagerStyle BackColor="#FFCC00" ForeColor="#FFCC00" />
                    <RowStyle BackColor="#0066cc" />
                </asp:GridView>
            </asp:Panel>
        </div>
    </div>
</asp:Content>
