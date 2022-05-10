using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace Florist
{
    public partial class Profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string mode = Request.QueryString["Mode"] ?? "0";
                string uname = Request.QueryString["UserName"] ?? "";
                DatabaseConnection databaseConnection = new DatabaseConnection();

                if (mode == "0" || uname.Length == 0 || Session["userID"] == null ||
                    Session["userID"]?.ToString() != Request.QueryString["UserName"]?.ToString())
                {
                    ((Panel)Master.FindControl("navigationPanel")).Visible = false;
                    pnlNewAccount.Visible = true;
                    btnSave.Text = "Save and Create";
                    btnClear.Text = "Clear All Fields";
                }
                else if (mode == "1")
                {
                    btnSave.Text = "Save and Update";
                    btnClear.Text = "Reset";
                    DataSet tableData = databaseConnection.GetUserData(uname);

                    if (tableData.Tables.Count > 0)
                    {
                        txtUserName.ReadOnly = true;

                        for (int i = 0; i < Textboxes().Count; i++)
                        {
                            string textFromDatabase = tableData.Tables[0].Rows[0].ItemArray[i + 1].ToString();
                            Textboxes()[i].Text = textFromDatabase;
                        }
                    }
                }
            }
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
            Trimmer(Textboxes());
            DatabaseConnection databaseConnection = new DatabaseConnection();
            DataSet tableData = databaseConnection.GetUserData(txtUserName.Text);

            if (btnSave.Text == "Save and Update")
            {
                UpdateUserRow(databaseConnection, tableData);
            }
            
            else if (btnSave.Text == "Save and Create")
            {
                InsertUserData(databaseConnection, tableData);
            }
        }
        protected void btnClear_Click(object sender, EventArgs e)
        {
            if (btnClear.Text == "Clear All Fields")
            {
                var allTextFields = Textboxes();
                foreach (var field in allTextFields)
                {
                    field.Text = string.Empty;
                }
            }

            else if (btnClear.Text == "Reset")
            {
                var context = HttpContext.Current;
                Server.Transfer($"Profile.aspx?Mode=1&UserName={context.Session["userID"] ?? ""}");
            }

        }

        private void UpdateUserRow(DatabaseConnection connector, DataSet tableInfo)
        {

            if (tableInfo.Tables[0].Rows.Count > 0 && txtUserName.Text.Length > 0)
            {
                int id = (int)tableInfo.Tables[0].Rows[0]["UserID"];
                lblErrorMsg.Text = connector.UpdateUserData(id, txtLastName.Text, txtFirstName.Text,
                txtUserName.Text, txtPassword.Text, txtPhone.Text, txtEmail.Text, txtSecretQuestion1.Text,
                txtSecretAnswer1.Text, txtSecretQuestion2.Text, txtSecretAnswer2.Text) ;
            }
        }
        
        private void InsertUserData (DatabaseConnection connector, DataSet tableInfo)
        {
            if (tableInfo.Tables[0].Rows.Count > 0)
            {
                lblErrorMsg.Visible = true;
                lblErrorMsg.Text = "The chosen User Name already exists, please choose a new one.";
            }

            else
            {
                var status = connector.InsertUserData(txtLastName.Text, txtFirstName.Text,
                txtUserName.Text, txtPassword.Text, txtPhone.Text, txtEmail.Text, txtSecretQuestion1.Text,
                txtSecretAnswer1.Text, txtSecretQuestion2.Text, txtSecretAnswer2.Text);

                lblErrorMsg.Text = status;

                if (status == "Success!")
                {
                    Response.Redirect("Login.aspx?LoginText=Account Successfully Created!" +
                    "&LoginText2=You Can Now Log In!");
                }
            }

        }
        private List<TextBox> Textboxes()
        {
            ContentPlaceHolder content = (ContentPlaceHolder)Master.FindControl("ContentPlaceHolder1");
            List<TextBox> textboxes = new List<TextBox>();
            foreach (Control c in content.Controls)
            {
                if (c is TextBox)
                {
                    textboxes.Add(c as TextBox);
                }
            }
            return textboxes;
        }
        private void Trimmer(List<TextBox> textboxes)
        {
            foreach(TextBox textbox in textboxes)
            {
                textbox.Text = textbox.Text.Trim();
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            if (btnSave.Text == "Save and Update")
            {
                Response.Redirect("LandingPage.aspx");
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }
    }
}