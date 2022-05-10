using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;


namespace Florist
{
    public class DatabaseConnection
    {
        string connectionString;
        SqlConnection connection;
        DataSet dataSet;
        SqlDataAdapter adapter;

        public DatabaseConnection()
        {
            connectionString = ConfigurationManager.ConnectionStrings["DBConnect"].ConnectionString;
            connection = new SqlConnection(connectionString);
            dataSet = new DataSet();
        }

        public bool CheckValidUser (string userName, string password)
        {
            SqlCommand cmd = new SqlCommand("Login_Check", connection);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@UserName", userName);
            cmd.Parameters.AddWithValue("@Password", password);

            try
            {
                connection.Open();
                cmd.Prepare();
                return Convert.ToBoolean(cmd.ExecuteScalar());
            }
            catch 
            {
                return false;
            }
            finally
            {
                connection.Close();
            }
        }

        public DataSet GetUserData(string userName)
        {
            SqlCommand cmd = new SqlCommand("Get_User_Info", connection);
            cmd.Parameters.AddWithValue("@UserName", userName);
            cmd.CommandType = CommandType.StoredProcedure;
            adapter = new SqlDataAdapter(cmd);
            adapter.SelectCommand = cmd;

            try
            {
                connection.Open();
                adapter.Fill(dataSet);
                return dataSet;
            }
            catch
            {
                return null;
            }
            finally
            {
                connection.Close();
            }
        }
        public string UpdateUserData(int userID, string lastName, string firstName, string userName,
            string password, string phone, string email, string question1, string answer1,
            string question2, string answer2)
        {
            SqlCommand cmd = new SqlCommand("Update_Profile_AND_Recovery", connection);
            cmd.Parameters.AddWithValue("@UserID", userID);
            cmd.Parameters.AddWithValue("@LName", lastName);
            cmd.Parameters.AddWithValue("@FName", firstName);
            cmd.Parameters.AddWithValue("@UserName", userName);
            cmd.Parameters.AddWithValue("@Pswd", password);
            cmd.Parameters.AddWithValue("@Phone", phone);
            cmd.Parameters.AddWithValue("@Email", email);
            cmd.Parameters.AddWithValue("@Status", 1);
            cmd.Parameters.AddWithValue("@Secret1", question1);
            cmd.Parameters.AddWithValue("@Answer1", answer1);
            cmd.Parameters.AddWithValue("@Secret2", question2);
            cmd.Parameters.AddWithValue("@Answer2", answer2);
            cmd.CommandType = CommandType.StoredProcedure;
            adapter = new SqlDataAdapter(cmd);
            adapter.UpdateCommand = cmd;
            try
            {
                cmd.Prepare();
                connection.Open();
                cmd.ExecuteNonQuery();
                return "Update Successful!";
            }
            catch (Exception ex)
            {
                return $"An Error Occurred:{ex.Message}";
            }
            finally
            {
                connection.Close();
            }

        }

        public string InsertUserData(string lastName, string firstName, string userName,
            string password, string phone, string email, string question1, string answer1,
            string question2, string answer2)
        {
            SqlCommand cmd = new SqlCommand("Insert_New_Profile", connection);
            cmd.Parameters.AddWithValue("@LName", lastName);
            cmd.Parameters.AddWithValue("@FName", firstName);
            cmd.Parameters.AddWithValue("@UserName", userName);
            cmd.Parameters.AddWithValue("@Pswd", password);
            cmd.Parameters.AddWithValue("@Phone", phone);
            cmd.Parameters.AddWithValue("@Email", email);
            cmd.Parameters.AddWithValue("@Status", 1);
            cmd.Parameters.AddWithValue("@Secret1", question1);
            cmd.Parameters.AddWithValue("@Answer1", answer1);
            cmd.Parameters.AddWithValue("@Secret2", question2);
            cmd.Parameters.AddWithValue("@Answer2", answer2);

            cmd.CommandType = CommandType.StoredProcedure;
            adapter = new SqlDataAdapter(cmd);
            adapter.InsertCommand = cmd;
            try
            {
                cmd.Prepare();
                connection.Open();
                cmd.ExecuteNonQuery();
                return "Success!";
            }
            catch (Exception ex)
            {
                return $"An Error Occurred:{ex.Message}";
            }
            finally
            {
                connection.Close();
            }
        }
        public DataSet GetTableData (string storedProcedure)
        {
            SqlCommand cmd = new SqlCommand(storedProcedure, connection);
            cmd.CommandType = CommandType.StoredProcedure;
            adapter = new SqlDataAdapter(cmd);
            adapter.SelectCommand = cmd;

            try
            {
                connection.Open();
                adapter.Fill(dataSet);
                return dataSet;
            }
            catch
            {
                return null;
            }
            finally
            {
                connection.Close();
            }
        }
        public string ResetPassword(int id, string password)
        {
            SqlCommand cmd = new SqlCommand("Reset_Password", connection);
            cmd.Parameters.AddWithValue("@UserID", id);
            cmd.Parameters.AddWithValue("@Password", password);
            cmd.CommandType = CommandType.StoredProcedure;
            adapter = new SqlDataAdapter(cmd);
            adapter.InsertCommand = cmd;
            try
            {
                cmd.Prepare();
                connection.Open();
                cmd.ExecuteNonQuery();
                return "Your Password has been updated";
            }
            catch (Exception ex)
            {
                return $"An Error Occurred:{ex.Message}";
            }
            finally
            {
                connection.Close();
            }
        }

        public string GenerateInvoice(int userID, int itemNum, int flowerID, string name, 
        string street, string apartment, string city, int region, int country, 
        string ZipCode)
        {
            SqlCommand cmd = new SqlCommand("Generate_Invoice", connection);
            cmd.Parameters.AddWithValue("@ID", userID);
            cmd.Parameters.AddWithValue("@ItemNumber", itemNum);
            cmd.Parameters.AddWithValue("@Flower", flowerID);
            cmd.Parameters.AddWithValue("@ContactName", name);
            cmd.Parameters.AddWithValue("@Street", street);
            cmd.Parameters.AddWithValue("@Apt", apartment);
            cmd.Parameters.AddWithValue("@City", city);
            cmd.Parameters.AddWithValue("@Region", region);
            cmd.Parameters.AddWithValue("@Country", country);
            cmd.Parameters.AddWithValue("@ZipCode", ZipCode);

            cmd.CommandType = CommandType.StoredProcedure;
            adapter = new SqlDataAdapter(cmd);
            adapter.InsertCommand = cmd;
            try
            {
                cmd.Prepare();
                connection.Open();
                return cmd.ExecuteScalar().ToString();
                
            }
            catch (Exception ex)
            {
                return $"An Error Occurred:{ex.Message}";
            }
            finally
            {
                connection.Close();
            }
        }

        public DataSet GridData(int identityNumber)
        {
                SqlCommand cmd = new SqlCommand("Get_Order_Details", connection);
                cmd.Parameters.AddWithValue("@IdentityNumber", identityNumber);
                cmd.CommandType = CommandType.StoredProcedure;
                adapter = new SqlDataAdapter(cmd);
                adapter.SelectCommand = cmd;

                try
                {
                    dataSet.Clear();
                    connection.Open();
                    adapter.Fill(dataSet);
                    return dataSet;
                }
                catch
                {
                    return null;
                }
                finally
                {
                    connection.Close();
                }
        }
        public string Insert_Item(int flower, int invoiceNumber )
        {

            SqlCommand cmd = new SqlCommand("Insert_Item", connection);
            cmd.Parameters.AddWithValue("@Flower", flower);
            cmd.Parameters.AddWithValue("@InvoiceID", invoiceNumber);
            cmd.CommandType = CommandType.StoredProcedure;
            adapter = new SqlDataAdapter(cmd);
            adapter.InsertCommand = cmd;

            try
            {
                cmd.Prepare();
                connection.Open();
                cmd.ExecuteNonQuery();
                return "Item Inserted";
            }
            catch
            {
                return null;
            }
            finally
            {
                connection.Close();
            }
        }
        public string DeleteGridRow(int invoiceID, int itemNumber)
        {
            SqlCommand cmd = new SqlCommand("Delete_Row", connection);
            cmd.Parameters.AddWithValue("@InvoiceNumber", invoiceID);
            cmd.Parameters.AddWithValue("@ItemNumber", itemNumber);
            cmd.CommandType = CommandType.StoredProcedure;
            adapter = new SqlDataAdapter(cmd);
            adapter.DeleteCommand = cmd;
            try
            {
                cmd.Prepare();
                connection.Open();
                cmd.ExecuteNonQuery();
                return "Updated";
            }
            catch (Exception ex)
            {
                return $"An Error Occurred:{ex.Message}";
            }
            finally
            {
                connection.Close();
            }
        }
        public string CancelOrder(int invoiceID)
        {
            SqlCommand cmd = new SqlCommand("Cancel_Order", connection);
            cmd.Parameters.AddWithValue("@InvoiceID", invoiceID);
            cmd.CommandType = CommandType.StoredProcedure;
            adapter = new SqlDataAdapter(cmd);
            adapter.DeleteCommand = cmd;
            try
            {
                cmd.Prepare();
                connection.Open();
                cmd.ExecuteNonQuery();
                return "Updated";
            }
            catch (Exception ex)
            {
                return $"An Error Occurred:{ex.Message}";
            }
            finally
            {
                connection.Close();
            }
        }
        public string ConfirmOrder(int orderNumber, int numberOfItems, string totalPrice, string name)
        {
            SqlCommand cmd = new SqlCommand("Confirm_Order", connection);
            cmd.Parameters.AddWithValue("@OrderNumber", orderNumber);
            cmd.Parameters.AddWithValue("@NumberOfItems", numberOfItems);
            cmd.Parameters.AddWithValue("@TotalPrice", totalPrice);
            cmd.Parameters.AddWithValue("@ContactName", name);
            cmd.CommandType = CommandType.StoredProcedure;
            adapter = new SqlDataAdapter(cmd);
            adapter.InsertCommand = cmd;
            try
            {
                cmd.Prepare();
                connection.Open();
                cmd.ExecuteNonQuery();
                return "Thank You for your Order!";
            }
            catch (Exception ex)
            {
                return $"An Error Occurred:{ex.Message}";
            }
            finally
            {
                connection.Close();
            }
        }
        public DataSet GetOrderHistory(string storedProcedure, int userID)
        {
            dataSet.Clear();
            SqlCommand cmd = new SqlCommand(storedProcedure, connection);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@UserID", userID);
            adapter = new SqlDataAdapter(cmd)
            {
                SelectCommand = cmd
            };

            try
            {   
                connection.Open();
                adapter.Fill(dataSet);
                return dataSet;
            }
            catch
            {
                return null;
            }
            finally
            {
                connection.Close();
            }
        }
    }
}