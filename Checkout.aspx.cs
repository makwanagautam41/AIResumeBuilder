using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace airesumebuilder
{
    public partial class Checkout : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            AuthHelper.RequireLogin(Page);

            if (!IsPostBack)
            {
                ShowPlanDetails();
                ShowUserDetails();
            }
        }

        private void ShowPlanDetails()
        {
            string planIdStr = Request.QueryString["planId"];
            if (string.IsNullOrEmpty(planIdStr)) return;

            if (!int.TryParse(planIdStr, out int planId)) return;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                string query = "SELECT * FROM Plans WHERE PlanID = @PlanID";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@PlanID", planId);
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            lblPlanName.Text = reader["Name"].ToString();
                            lblDescription.Text = reader["Description"].ToString();
                            lblMonthly.Text = reader["MonthlyPrice"].ToString();
                            lblAnnual.Text = reader["AnnualPrice"].ToString();
                        }
                    }
                }
            }
        }

        private void ShowUserDetails()
        {
            // Assuming user ID is stored in session after login
            if (Session["UserId"] == null) return;

            int userId = Convert.ToInt32(Session["UserId"]);

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                string query = "SELECT name, email FROM user_tbl WHERE Id = @UserID";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@UserID", userId);
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            lblUserName.Text = reader["name"].ToString();
                            lblUserEmail.Text = reader["email"].ToString();
                        }
                    }
                }
            }
        }
    }
}
