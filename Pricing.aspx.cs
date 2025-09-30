using Stripe;
using Stripe.Checkout;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace airesumebuilder
{
    public partial class Pricing : Page
    {
        private readonly string connectionString = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                StripeConfiguration.ApiKey = ConfigurationManager.AppSettings["StripeSecretKey"];
                LoadPlans();

                // Show active plan only if user is logged in
                if (Session["UserId"] != null)
                {
                    int userId = Convert.ToInt32(Session["UserId"]);
                    ShowActivePlan();
                }
                else
                {
                    lblActivePlan.Visible = false; // hide if not logged in
                }
            }

        }

        private void LoadPlans()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM Plans";
                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataSet ds = new DataSet();
                da.Fill(ds);

                plansRepeater.DataSource = ds.Tables[0];
                plansRepeater.DataBind();
            }
        }

        protected void plansRepeater_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DataRowView drv = (DataRowView)e.Item.DataItem;
                int planId = Convert.ToInt32(drv["PlanID"]);

                Repeater featuresRepeater = (Repeater)e.Item.FindControl("featuresRepeater");

                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query = "SELECT * FROM PlanFeatures WHERE PlanID = @PlanID";
                    SqlDataAdapter da = new SqlDataAdapter(query, con);
                    da.SelectCommand.Parameters.AddWithValue("@PlanID", planId);

                    DataSet ds = new DataSet();
                    da.Fill(ds);

                    featuresRepeater.DataSource = ds.Tables[0];
                    featuresRepeater.DataBind();
                }
            }
        }

        private void ShowActivePlan()
        {
            // Check if user is logged in
            if (Session["UserId"] == null)
            {
                lblActivePlan.Visible = false;
                return;
            }

            int userId = Convert.ToInt32(Session["UserId"]);

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"
            SELECT Plan_Id, Selected_Cycle
            FROM User_Planes_tbl
            WHERE User_Id = @UserId AND IsActive = 1"; // fetch active plan

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@UserId", userId);

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    int planId = Convert.ToInt32(reader["Plan_Id"]);
                    string cycle = reader["Selected_Cycle"].ToString(); // monthly/annual

                    lblActivePlan.Text = $"Your Active Plan ID: {planId} ({cycle})";
                    lblActivePlan.Visible = true;
                }
                else
                {
                    lblActivePlan.Visible = false; // no active plan
                }
            }
        }



        [WebMethod]
        public static object CreateCheckoutSession(int planId, string cycle)
        {
            StripeConfiguration.ApiKey = ConfigurationManager.AppSettings["StripeSecretKey"];

            string connectionString = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
            string planName = "";
            decimal amount = 0;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT Name, MonthlyPrice, AnnualPrice FROM Plans WHERE PlanID=@PlanID";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@PlanID", planId);
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    planName = reader["Name"].ToString();
                    amount = cycle == "annual" ? Convert.ToDecimal(reader["AnnualPrice"]) : Convert.ToDecimal(reader["MonthlyPrice"]);
                }
            }

            long amountInPaise = (long)(amount * 100);

            var options = new SessionCreateOptions
            {
                PaymentMethodTypes = new List<string> { "card" },
                LineItems = new List<SessionLineItemOptions>
        {
            new SessionLineItemOptions
            {
                PriceData = new SessionLineItemPriceDataOptions
                {
                    Currency = "inr",
                    UnitAmount = amountInPaise,
                    ProductData = new SessionLineItemPriceDataProductDataOptions
                    {
                        Name = planName,
                    },
                },
                Quantity = 1,
            },
        },
                Mode = "payment",
                SuccessUrl = "https://localhost:44301/Success.aspx?planId=" + planId + "&cycle=" + cycle + "&session_id={CHECKOUT_SESSION_ID}",
                CancelUrl = "https://localhost:44301/Cancel.aspx",
            };

            var service = new SessionService();
            Session session = service.Create(options);

            return new { id = session.Id };
        }

    }
}
