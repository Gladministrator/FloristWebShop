using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace Florist
{
    public partial class ForgotPassword : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            ((Panel)Master.FindControl("navigationPanel")).Visible = false;
        }

        protected void btnSubmitUserName_Click(object sender, EventArgs e)
        {
            DatabaseConnection databaseConnection = new DatabaseConnection();
            DataSet info = databaseConnection.GetUserData(txtUserName.Text);

            if (info.Tables[0].Rows.Count == 0)
            {
                pnlRecoveryQuestions.Visible = false;
                lblErrorUserName.Visible = true;
            }
            else 
            {
                lblErrorUserName.Visible = false;
                txtUserName.ReadOnly = true;
                btnSubmitUserName.Visible = false;
                lblQuestion1.Text = info.Tables[0].Rows[0]["SecretQuestion1"].ToString();
                lblQuestion2.Text = info.Tables[0].Rows[0]["SecretQuestion2"].ToString();
                pnlRecoveryQuestions.Visible = true;
                Session["Answer1"] = info.Tables[0].Rows[0]["Answer1"].ToString();
                Session["Answer2"] = info.Tables[0].Rows[0]["Answer2"].ToString();
                Session["id"] = info.Tables[0].Rows[0]["UserID"].ToString();
            }
        }

        protected void btnSubmitAnswers_Click(object sender, EventArgs e)
        {
            if (txtAnswer1.Text == (string)(Session["Answer1"]) &&
                txtAnswer2.Text == (string)(Session["Answer2"]))
            {
                lblAnswersWrong.Visible = false;
                pnlResetPassword.Visible = true;
                txtAnswer1.ReadOnly = true;
                txtAnswer2.ReadOnly = true;
                btnSubmitAnswers.Visible = false;
            }
            else
            {
                lblAnswersWrong.Visible = true;
            }

        }

        protected void btnSubmitPassword_Click(object sender, EventArgs e)
        {
            int id = Convert.ToInt32(Session["id"]);
            DatabaseConnection databaseConnection = new DatabaseConnection();
            lblCompletion.Text = databaseConnection.ResetPassword(id,txtResetPassword.Text);
            pnlCompletion.Visible = true;
        }

        protected void lnkReturnLogin_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }
    }
}