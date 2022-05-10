using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace Florist
{
    public partial class Order : System.Web.UI.Page
    {
        string number;
        string invoiceID;
        protected void Page_Load(object sender, EventArgs e)
        {
            lblButonError.Visible = false;
            var currentContext = HttpContext.Current;
            if (currentContext.Session["userID"] == null)
            {
                Response.Redirect("Login.aspx");
            }

            if (!IsPostBack)
            {
                DatabaseConnection connection = new DatabaseConnection();
                DataSet databaseData = connection.GetTableData("Get_Occasions_Table");
                DatabaseConnection connection2 = new DatabaseConnection();
                DataSet countryList = connection2.GetTableData("Get_Country_Table");
                DatabaseConnection connection3 = new DatabaseConnection();
                DataSet regionList = connection3.GetTableData("Get_Locations_Table");
                if (databaseData != null && countryList != null && regionList != null)
                {
                    dlOccasion.DataTextField = databaseData.Tables[0].Columns["DisplayValue"].ToString();
                    dlOccasion.DataValueField = databaseData.Tables[0].Columns["Seasonalid"].ToString();
                    dlOccasion.DataSource = databaseData.Tables[0];
                    dlOccasion.DataBind();
                    dlOccasion.Items.Insert(0, new ListItem("Select", "-1"));

                    dlCountry.DataTextField = countryList.Tables[0].Columns["DisplayValue"].ToString();
                    dlCountry.DataValueField = countryList.Tables[0].Columns["CountryID"].ToString();
                    dlCountry.DataSource = countryList.Tables[0];
                    dlCountry.DataBind();
                    dlCountry.Items.Insert(0, new ListItem("Select", "-1"));

                    dlRegion.DataTextField = regionList.Tables[0].Columns["DisplayValue"].ToString();
                    dlRegion.DataValueField = regionList.Tables[0].Columns["RegionID"].ToString();
                    dlRegion.DataSource = regionList.Tables[0];
                    dlRegion.DataBind();
                    dlRegion.Items.Insert(0, new ListItem("Select", "-1"));
                }

            }


        }

        protected void dlOccasion_SelectedIndexChanged(object sender, EventArgs e)
        {
            DatabaseConnection connection = new DatabaseConnection();
            DataSet databaseData = connection.GetTableData("Get_Flowers_Table");

            if (dlOccasion.SelectedValue != "-1" && databaseData != null)
            {
                dlFlower.DataTextField = databaseData.Tables[0].Columns["Description"].ToString();
                dlFlower.DataValueField = databaseData.Tables[0].Columns["FlowerID"].ToString();
                dlFlower.DataSource = databaseData.Tables[0];
                dlFlower.DataBind();
                dlFlower.Items.Insert(0, new ListItem("Select", "-1"));
            }
            else
            {
                dlFlower.Items.Clear();
                dlFlower.Items.Insert(0, new ListItem("Select", "-1"));
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            lblButonError.Visible = false;
            var context = HttpContext.Current;
            string userName = context.Session["userID"].ToString();

            if (ViewState["invoiceID"] != null)
            {
                invoiceID = ViewState["invoiceID"].ToString();
            }

            if (ValidDropDown() && string.IsNullOrEmpty(invoiceID))
            {

                DatabaseConnection connection = new DatabaseConnection();
                DataSet databaseData = connection.GetUserData(userName);
                int id = (int)databaseData.Tables[0].Rows[0]["UserID"];

                string apt = string.IsNullOrEmpty(txtSuite.Text.Trim()) ? null : txtSuite.Text.Trim();
                string fullName = $"{txtFirstName.Text.Trim()} {txtLastName.Text.Trim()}";

                number = connection.GenerateInvoice(id, 1, Convert.ToInt32(dlFlower.SelectedValue),
                    fullName,txtStreetAddress.Text.Trim(), apt, txtCity.Text.Trim(), 
                    Convert.ToInt32(dlRegion.SelectedValue), Convert.ToInt32(dlCountry.SelectedValue),
                    txtZipCode.Text.Trim()
                    );

                ViewState["invoiceID"] = number;
                
                if (int.TryParse(number, out int result))
                {
                    UpdateGrid(result);
                }
                txtOrderNumber.Text = number;
                pnlOrderSummary.Visible = true;
            }
            else if (ValidDropDown() && !string.IsNullOrEmpty(invoiceID))
            {
                if (int.TryParse(invoiceID, out int result))
                {
                    DatabaseConnection connection3 = new DatabaseConnection();
                    connection3.Insert_Item(Convert.ToInt32(dlFlower.SelectedValue), result);
                    UpdateGrid(result);
                }
                else
                {
                    lblError.Text = invoiceID.ToString();
                    lblError.Visible = true;
                    pnlGrid.Visible = false;
                }
            }
        }
        private bool ValidDropDown()
        {
            ContentPlaceHolder content = (ContentPlaceHolder)Master.FindControl("ContentPlaceHolder1");
            List<DropDownList> dropDowns = new List<DropDownList>();

            foreach (Control c in content.Controls)
            {
                if (c is DropDownList)
                {
                    dropDowns.Add(c as DropDownList);
                }
            }

            var selectedDropDowns = dropDowns.Where(x => x.SelectedValue != "-1").ToList();

            return selectedDropDowns.Count == dropDowns.Count;
        }

        private void UpdateGrid(int invoiceID)
        {
            DatabaseConnection connection2 = new DatabaseConnection();
            DataSet gridData = connection2.GridData(invoiceID);
            gvOrderDetails.DataSource = gridData;
            gvOrderDetails.DataBind();

            lblNumberOfItems.Text = gridData.Tables[0].Rows.Count.ToString();

            decimal total = 0;

            foreach (DataRow row in gridData.Tables[0].Rows)
            {
                total = total + Convert.ToDecimal(row[4]);
            }
            txtOrderTotal.Text = $"${total:0.00}";
        }

        protected void OnRowDeleting(Object sender, GridViewDeleteEventArgs e)
        {
            TableCell cell = gvOrderDetails.Rows[e.RowIndex].Cells[0];
            int invoice = Convert.ToInt32(txtOrderNumber.Text);
            int itemNumber = Convert.ToInt32(cell.Text);

            DatabaseConnection connection = new DatabaseConnection();

            string error = connection.DeleteGridRow(invoice, itemNumber);

            if (error == "Updated")
            {
                UpdateGrid(invoice);
            }
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            lblButonError.Visible = false;
            lblButonError.Text = "";
            dlOccasion.SelectedIndex = 0;
            dlFlower.SelectedIndex = 0;
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            if (txtOrderNumber.Text.ToString().Length > 0)
            {
                int invoice = Convert.ToInt32(txtOrderNumber.Text);
                DatabaseConnection connection = new DatabaseConnection();
                connection.CancelOrder(invoice);
            }
            Response.Redirect("LandingPage.aspx");
        }

        protected void btnPlaceOrder_Click(object sender, EventArgs e)
        {
            if (ViewState["invoiceID"] == null || gvOrderDetails.Rows.Count < 1)
            {
                lblButonError.Text = "Please add items to your order before placing an order.";
                lblButonError.Visible = true;
                return;
            }
            string orderNumber = ViewState["invoiceID"].ToString();
            Response.Redirect($"OrderConfirm.aspx?Order={orderNumber}&Total={txtOrderTotal.Text}" +
                $"&NumberItems={gvOrderDetails?.Rows?.Count}&Contact={txtFirstName.Text} {txtLastName.Text}");
        }
    }
}