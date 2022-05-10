using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace Florist
{
    public partial class ReviewOrder : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var currentContext = HttpContext.Current;

            if (currentContext.Session["userID"]?.ToString() != null)
            {
                DatabaseConnection connection = new DatabaseConnection();
                DataSet databaseData = connection.GetUserData(currentContext.Session["userID"]?.ToString());
                int id = (int)databaseData.Tables[0]?.Rows[0]["UserID"];
                DataSet table = connection.GetOrderHistory("Get_Orders", id);
                string text = table.Tables[0].Rows.Count > 0 ? "Order History" : "You have not made any orders";
                h1ReviewOrder.InnerText = text;
                gvReviewOrderHistory.DataSource = table;
                gvReviewOrderHistory.DataBind();
                var test = Context.Session["userID"].ToString();
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }
    }
}