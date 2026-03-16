using System;
using System.Web.UI.WebControls;

namespace Florist
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ((Panel)Master.FindControl("navigationPanel")).Visible = false;
            loginText.InnerText = Request.QueryString["LoginText"] ??
            "Please Login or create a profile";
            loginText2.InnerText = Request.QueryString["LoginText2"] ?? "";
        }
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            DatabaseConnection databaseConnect = new DatabaseConnection();

            string userName = txtUserName.Text.ToString().Trim();
            string password = txtPassword.Text.ToString().Trim();

            if (databaseConnect.CheckValidUser(userName, password))
            {
                Session["userID"] = userName;
                lblMsg.Visible = false;
                Response.Redirect("LandingPage.aspx");
            }
            else
            {
                lblMsg.Visible = true;
            }

        }
        protected void lnkCreateProfile_Click(object sender, EventArgs e)
        {
            Response.Redirect("Profile.aspx?Mode=0&UserName=");
        }

        protected void lnkForgotPassword_Click(object sender, EventArgs e)
        {
            Response.Redirect("ForgotPassword.aspx");
        }
    }
}