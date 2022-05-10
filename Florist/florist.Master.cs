using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Florist
{
    public partial class florist : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lnkLoggedIn.Text = Context.Session["userID"]?.ToString();
        }
        protected void lnkProfile_Click(object sender, EventArgs e)
        {
            var context = HttpContext.Current;
            Response.Redirect($"Profile.aspx?Mode=1&UserName={context.Session["userID"] ?? ""}");
        }

        protected void lnkOrder_Click(object sender, EventArgs e)
        {
            var context = HttpContext.Current;
            Response.Redirect($"Order.aspx?Mode=1&UserName={context.Session["userID"] ?? ""}");
        }

        protected void lnkReview_Click(object sender, EventArgs e)
        {
            var context = HttpContext.Current;
            Response.Redirect($"ReviewOrder.aspx?Mode=1&UserName={context.Session["userID"] ?? ""}");
        }

        protected void lnkHome_Click(object sender, EventArgs e)
        {
            var context = HttpContext.Current;
            Response.Redirect($"LandingPage.aspx?Mode=1&UserName={context.Session["userID"] ?? ""}");
        }

        protected void lnkLogout_Click(object sender, EventArgs e)
        {
            var context = HttpContext.Current;
            context.Session.Clear();
            Response.Redirect("Login.aspx?LoginText=You Have Successfully Logged Out");
        }

        protected void lnkLoggedIn_Click(object sender, EventArgs e)
        {
            var context = HttpContext.Current;
            Response.Redirect($"Profile.aspx?Mode=1&UserName={context.Session["userID"] ?? ""}");
        }
    }
}