using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Florist
{
    public partial class LandingPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void imgbtnProfile_Click(object sender, ImageClickEventArgs e)
        {
            var context = HttpContext.Current;
            Response.Redirect($"Profile.aspx?Mode=1&UserName={context.Session["userID"] ?? ""}");
        }

        protected void imgbtnOrder_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect($"Order.aspx?Mode=1&UserName={Session["userID"] ?? ""}");
        }
    }
}