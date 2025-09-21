using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace airesumebuilder
{
    public partial class EditProfile : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        SqlConnection con;
        SqlCommand cmd;

        void get_connection()
        {
            con = new SqlConnection(connectionString);
            con.Open();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            AuthHelper.RequireLogin(this);

            if (Request.Form["ButtonUpdate"] == null)
            {
                get_connection();
                string user_id = Request.QueryString["Id"];
                get_user_details(int.Parse(user_id));
            }
        }
        void get_user_details(int id)
        {
            String query = "SELECT * FROM user_tbl WHERE Id='" + id + "'";
            cmd = new SqlCommand(query, con);

            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.Read())
            {
                TextBoxId.Text = reader["Id"].ToString();
                TextBoxName.Text = reader["name"].ToString();
                TextBoxEmail.Text = reader["email"].ToString();
                TextBoxMobile.Text = reader["mobile"].ToString();
                GenderRadioButton.SelectedValue = reader["gender"].ToString();
            }

            reader.Close();
        }

        protected void ButtonUpdate_Click(object sender, EventArgs e)
        {
            get_connection();
            string query = "UPDATE user_tbl SET name='" + TextBoxName.Text + "',email='" + TextBoxEmail.Text + "',mobile='" + TextBoxMobile.Text + "',gender='" + GenderRadioButton.SelectedValue + "' WHERE Id='" + TextBoxId.Text + "'";
            cmd = new SqlCommand(query, con);
            try
            {
                cmd.ExecuteNonQuery();
                Session["successMessage"] = "Updation successfull!";
                Session["userEmail"] = TextBoxEmail.Text;
                Response.Redirect("Profile.aspx");
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