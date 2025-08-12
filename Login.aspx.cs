using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace airesumebuilder
{
    public partial class Login : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        SqlConnection con;
        SqlCommand cmd;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["successMessage"] != null)
            {
                LabelMessage.Text = Session["successMessage"].ToString();
                LabelMessage.ForeColor = System.Drawing.Color.Green;
                Session["successMessage"] = null;
            }
        }
        void get_connection()
        {
            con = new SqlConnection(connectionString);
            con.Open();
        }

        int check_user_exist(string email)
        {
            get_connection();

            string sql = "SELECT COUNT(*) FROM user_tbl WHERE Email = '" + email + "'";
            SqlCommand cmd = new SqlCommand(sql, con);

            int count = Convert.ToInt32(cmd.ExecuteScalar());

            if (count > 0)
            {
                return 1;
            }
            con.Close();
            return 0;
        }

        protected void ButtonLogin_Click(object sender, EventArgs e)
        {
            string email = TextBoxEmail.Text.Trim();
            string password = TextBoxPassword.Text.Trim();

            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
            {
                LabelMessage.Text = "Please enter both email and password.";
                LabelMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            if (check_user_exist(email) == 0)
            {
                LabelMessage.Text = "User with this email does not exist.";
                LabelMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            try
            {
                get_connection();
                string query = "SELECT COUNT(*) FROM user_tbl WHERE Email = '" + email + "' AND Password = '" + password + "'";
                cmd = new SqlCommand(query, con);

                if ((int)cmd.ExecuteScalar() > 0)
                {
                    Session["userLoggedIn"] = "true";
                    Session["userEmail"] = email;
                    Response.Redirect("Home.aspx");
                }
                else
                {
                    LabelMessage.Text = "Invalid password.";
                    LabelMessage.ForeColor = System.Drawing.Color.Red;
                }
            }
            catch (Exception ex)
            {
                LabelMessage.Text = "Error: " + ex.Message;
                LabelMessage.ForeColor = System.Drawing.Color.Red;
            }
            finally
            {
                con.Close();
            }

        }
    }
}