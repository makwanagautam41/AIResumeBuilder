using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;


namespace airesumebuilder
{
    public partial class Success : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        SqlConnection con;
        SqlCommand cmd;
        DataAdapter da;
        DataSet ds;
        int userId = 0;
        int planId = 0;
        string cycle = "";
        string sessionId = "";


        protected void Page_Load(object sender, EventArgs e)
        {
            AuthHelper.RequireLogin(this);

            userId = Convert.ToInt32(Session["UserId"]);
            planId = Convert.ToInt32(Request.QueryString["planId"]);
            cycle = Request.QueryString["cycle"];
            sessionId = Request.QueryString["session_id"];

            if (!IsPostBack && userId > 0 && planId > 0 && !string.IsNullOrEmpty(sessionId))
            {
                SaveUserPlan(userId, planId, cycle, sessionId);
                sendEmail();
            }
        }

        void get_connection()
        {
            con = new SqlConnection(connectionString);
            con.Open();
        }

        private void SaveUserPlan(int userId, int planId, string cycle, string sessionId)
        {
            get_connection();
            DateTime startDate = DateTime.Now;
            DateTime expireDate = cycle == "annual" ? startDate.AddYears(1) : startDate.AddMonths(1);

            string query = "INSERT INTO User_Planes_tbl (User_Id, Plan_Id, Selected_Cycle, Start_Date, Expire_Date, IsActive) " +
                           "VALUES ('" + userId + "', '" + planId + "', '" + cycle + "', '" + startDate + "', '" + expireDate + "', 1)";

            cmd = new SqlCommand(query, con);
            cmd.ExecuteNonQuery();
        }

        private void sendEmail()
        {
            get_connection();

            string user_query = "SELECT * FROM user_tbl WHERE Id = '" + userId + "'";
            string userName = "";
            string email = "";
            string mobile = "";

            cmd = new SqlCommand(user_query, con);
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                userName = dr["name"].ToString();
                email = dr["email"].ToString();
                mobile = dr["mobile"].ToString();
            }
            dr.Close();

            string subject = "Your Subscription Invoice - " + DateTime.Now.ToString("dd MMM yyyy");
            string htmlInvoice = GetPlanInvoiceHtml(planId, cycle, userName, email, mobile);

            AuthHelper.SendEmailAsync(email, subject, htmlInvoice);
        }

        private string GetPlanInvoiceHtml(int planId, string cycle, string userName, string email, string mobile)
        {
            get_connection();

            string plan_query = "SELECT * FROM Plans WHERE PlanID = '" + planId + "'";
            string feature_query = "SELECT * FROM PlanFeatures WHERE PlanID = '" + planId + "'";

            string planName = "";
            string description = "";
            decimal monthlyPrice = 0;
            decimal annualPrice = 0;
            decimal originalPrice = 0;
            bool isPopular = false;
            List<string> features = new List<string>();

            cmd = new SqlCommand(plan_query, con);
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                planName = dr["Name"].ToString();
                description = dr["Description"].ToString();
                monthlyPrice = dr["MonthlyPrice"] == DBNull.Value ? 0 : Convert.ToDecimal(dr["MonthlyPrice"]);
                annualPrice = dr["AnnualPrice"] == DBNull.Value ? 0 : Convert.ToDecimal(dr["AnnualPrice"]);
                originalPrice = dr["OriginalPrice"] == DBNull.Value ? 0 : Convert.ToDecimal(dr["OriginalPrice"]);
                isPopular = dr["IsPopular"] != DBNull.Value && Convert.ToBoolean(dr["IsPopular"]);
            }
            dr.Close();

            cmd = new SqlCommand(feature_query, con);
            SqlDataReader dr2 = cmd.ExecuteReader();
            while (dr2.Read())
            {
                string featureName = dr2["FeatureName"].ToString();
                bool included = Convert.ToBoolean(dr2["IsIncluded"]);
                string icon = included ? "✅" : "❌";
                features.Add(icon + " " + featureName);
            }
            dr2.Close();

            decimal selectedPrice = cycle == "annual" ? annualPrice : monthlyPrice;
            string priceText = cycle == "annual" ? "₹" + annualPrice.ToString("0.00") + " / Year" : "₹" + monthlyPrice.ToString("0.00") + " / Month";

            string planHtml = "<div style='font-family:Arial,Helvetica,sans-serif;max-width:600px;margin:auto;padding:20px;border:1px solid #ddd;border-radius:10px;background:#f9f9f9;'>";
            planHtml += "<h2 style='text-align:center;color:#333;margin-bottom:10px;'>Subscription Invoice</h2>";
            planHtml += "<div style='border-bottom:1px solid #ccc;margin-bottom:15px;'></div>";

            planHtml += "<h3 style='color:#007bff;margin-bottom:5px;'>" + planName;
            if (isPopular)
                planHtml += " <span style='color:#28a745;font-size:14px;'>(Popular)</span>";
            planHtml += "</h3>";
            planHtml += "<p style='margin:5px 0;color:#555;'>" + description + "</p>";

            planHtml += "<table style='width:100%;margin-top:10px;border-collapse:collapse;'>";
            planHtml += "<tr><td style='padding:8px;border:1px solid #ddd;'>Cycle</td><td style='padding:8px;border:1px solid #ddd;text-align:right;'>" + cycle.ToUpper() + "</td></tr>";
            planHtml += "<tr><td style='padding:8px;border:1px solid #ddd;'>Original Price</td><td style='padding:8px;border:1px solid #ddd;text-align:right;'>₹" + originalPrice.ToString("0.00") + "</td></tr>";
            planHtml += "<tr><td style='padding:8px;border:1px solid #ddd;'>Discounted Price</td><td style='padding:8px;border:1px solid #ddd;text-align:right;'>" + priceText + "</td></tr>";
            planHtml += "</table>";

            planHtml += "<h4 style='margin-top:20px;color:#333;'>Included Features:</h4><ul style='list-style:none;padding-left:0;margin-top:5px;'>";
            foreach (string f in features)
            {
                planHtml += "<li style='padding:5px 0;color:#555;'>" + f + "</li>";
            }
            planHtml += "</ul>";

            planHtml += "<div style='border-top:1px solid #ccc;margin-top:20px;padding-top:10px;'>";
            planHtml += "<p style='color:#333;font-size:14px;'><strong>Customer Details</strong></p>";
            planHtml += "<p style='color:#555;font-size:13px;margin:3px 0;'>Name: " + userName + "</p>";
            planHtml += "<p style='color:#555;font-size:13px;margin:3px 0;'>Email: " + email + "</p>";
            planHtml += "<p style='color:#555;font-size:13px;margin:3px 0;'>Mobile: " + mobile + "</p>";
            planHtml += "</div>";

            planHtml += "<div style='border-top:1px solid #ccc;margin-top:20px;padding-top:10px;text-align:center;color:#777;font-size:13px;'>";
            planHtml += "Thank you for your payment.<br><strong>Your subscription is now active!</strong>";
            planHtml += "</div></div>";

            return planHtml;
        }
    }
}
