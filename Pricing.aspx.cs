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
        private int? activePlanId = null;
        private List<int> purchasedPlanIds = new List<int>();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                StripeConfiguration.ApiKey = ConfigurationManager.AppSettings["StripeSecretKey"];

                // Get user's plans before loading all plans
                if (Session["UserId"] != null)
                {
                    int userId = Convert.ToInt32(Session["UserId"]);
                    LoadUserPlans(userId);
                    ShowActivePlan();
                }
                else
                {
                    lblActivePlan.Visible = false;
                }

                LoadPlans();
            }
        }

        private void LoadUserPlans(int userId)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT Plan_Id, IsActive
                    FROM User_Planes_tbl
                    WHERE User_Id = @UserId";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@UserId", userId);

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    int planId = Convert.ToInt32(reader["Plan_Id"]);
                    bool isActive = Convert.ToBoolean(reader["IsActive"]);

                    purchasedPlanIds.Add(planId);

                    if (isActive)
                    {
                        activePlanId = planId;
                    }
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

                // Add custom columns to dataset
                ds.Tables[0].Columns.Add("IsActivePlan", typeof(bool));
                ds.Tables[0].Columns.Add("IsPurchased", typeof(bool));

                foreach (DataRow row in ds.Tables[0].Rows)
                {
                    int planId = Convert.ToInt32(row["PlanID"]);
                    row["IsActivePlan"] = (activePlanId.HasValue && activePlanId.Value == planId);
                    row["IsPurchased"] = purchasedPlanIds.Contains(planId);
                }

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
            if (Session["UserId"] == null)
            {
                lblActivePlan.Visible = false;
                return;
            }

            int userId = Convert.ToInt32(Session["UserId"]);

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT p.Name, up.Selected_Cycle
                    FROM User_Planes_tbl up
                    INNER JOIN Plans p ON up.Plan_Id = p.PlanID
                    WHERE up.User_Id = @UserId AND up.IsActive = 1";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@UserId", userId);

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    string planName = reader["Name"].ToString();
                    string cycle = reader["Selected_Cycle"].ToString();

                    lblActivePlan.Visible = true;
                }
                else
                {
                    lblActivePlan.Visible = false;
                }
            }
        }

        [WebMethod]
        public static object ActivatePlan(int planId)
        {
            try
            {
                var context = System.Web.HttpContext.Current;
                if (context.Session["UserId"] == null)
                {
                    return new { success = false, message = "User not logged in" };
                }

                int userId = Convert.ToInt32(context.Session["UserId"]);
                string connectionString = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;

                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    con.Open();

                    // First, deactivate all plans for this user
                    string deactivateQuery = @"
                        UPDATE User_Planes_tbl 
                        SET IsActive = 0 
                        WHERE User_Id = @UserId";

                    SqlCommand deactivateCmd = new SqlCommand(deactivateQuery, con);
                    deactivateCmd.Parameters.AddWithValue("@UserId", userId);
                    deactivateCmd.ExecuteNonQuery();

                    // Then, activate the selected plan
                    string activateQuery = @"
                        UPDATE User_Planes_tbl 
                        SET IsActive = 1, Start_Date = GETDATE()
                        WHERE User_Id = @UserId AND Plan_Id = @PlanId";

                    SqlCommand activateCmd = new SqlCommand(activateQuery, con);
                    activateCmd.Parameters.AddWithValue("@UserId", userId);
                    activateCmd.Parameters.AddWithValue("@PlanId", planId);

                    int rowsAffected = activateCmd.ExecuteNonQuery();

                    if (rowsAffected > 0)
                    {
                        return new { success = true, message = "Plan activated successfully" };
                    }
                    else
                    {
                        return new { success = false, message = "Plan not found or already active" };
                    }
                }
            }
            catch (Exception ex)
            {
                return new { success = false, message = "Error: " + ex.Message };
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