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
    public partial class Profile : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        SqlConnection con;
        SqlCommand cmd;
        string user_id;
        void get_connection()
        {
            con = new SqlConnection(connectionString);
            con.Open();
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            AuthHelper.RequireLogin(this);

            get_connection();

            if (Session["successMessage"] != null)
            {
                LabelMessage.Text = Session["successMessage"].ToString();
                LabelMessage.ForeColor = System.Drawing.Color.Green;
                Session["successMessage"] = null;
            }

            String email = Session["userEmail"].ToString();
            get_user_details(email);

            con.Close();
        }


        void get_user_details(String email)
        {
            String query = "SELECT * FROM user_tbl WHERE email='" + email + "'";
            cmd = new SqlCommand(query, con);

            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.Read())
            {
                user_id = reader["Id"].ToString();
                Idtxt.Text = reader["Id"].ToString();
                Nametxt.Text = reader["name"].ToString();
                Emailtxt.Text = reader["email"].ToString();
                Mobiletxt.Text = reader["mobile"].ToString();
                Gendertxt.Text = reader["gender"].ToString();
            }

            reader.Close();
        }

        protected void BtnEditProfile_Click(object sender, EventArgs e)
        {
            Response.Redirect("EditProfile.aspx?Id="+user_id);
        }

        protected void BtnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Session["userLoggedIn"] = "false";
            Session["userEmail"] = null;
            Response.Redirect("Login.aspx");
        }

        protected void BtnGoHome_Click(object sender, EventArgs e)
        {
            Response.Redirect("Home.aspx");
        }
    }
}