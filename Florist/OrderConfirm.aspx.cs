using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace Florist
{
    public partial class OrderConfirm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && Request.QueryString["Order"] == null)
            {
                pnlThankYou.Visible = false;
                Response.Redirect("LandingPage.aspx");
            }
            else
            {
                string orderNumber = Request.QueryString["Order"]?.ToString() ?? "No Order Found";
                string total = Request.QueryString["Total"]?.ToString() ?? "NA";
                txtOrderNumber.Text = orderNumber;
                txtOrderTotal.Text = total;
            }
        }

        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            if (int.TryParse(txtOrderNumber.Text, out int output) &&
                int.TryParse(Request.QueryString["NumberItems"]?.ToString(), out int count))
            {
                DatabaseConnection connection = new DatabaseConnection();
                string messageText = connection.ConfirmOrder(output, count, txtOrderTotal.Text,
                Request.QueryString["Contact"]?.ToString());
                lblConfirmMessage.Text = messageText;
                btnConfirm.Visible = false;
                btnCancel.Visible = false;
                pnlThankYou.Visible = true;
            }
            else
            {
                Response.Redirect("Login.aspx");
            }

        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            if (txtOrderNumber.Text.ToString().Length > 0)
            {
                int invoice = Convert.ToInt32(txtOrderNumber.Text);
                DatabaseConnection connection = new DatabaseConnection();
                connection.CancelOrder(invoice);
                Response.Redirect("LandingPage.aspx");
            }
        }

        protected void lnkHomeLink_Click(object sender, EventArgs e)
        {
            Response.Redirect("LandingPage.aspx");
        }
    }
}