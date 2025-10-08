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
        SqlConnection con;
        string connectionString = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        private int? activePlanId = null;
        private List<int> purchasedPlanIds = new List<int>();
        
        void get_connection()
        {
            con = new SqlConnection(connectionString);
            con.Open();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                StripeConfiguration.ApiKey = ConfigurationManager.AppSettings["StripeSecretKey"];

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
            get_connection();
            string query = "SELECT Plan_Id, IsActive FROM User_Planes_tbl WHERE User_Id = '" + userId + "'";
            SqlCommand cmd = new SqlCommand(query, con);
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

        private void LoadPlans()
        {
            get_connection();
            string query = "SELECT * FROM Plans";
            SqlDataAdapter da = new SqlDataAdapter(query, con);
            DataSet ds = new DataSet();
            da.Fill(ds);

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

        protected void plansRepeater_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DataRowView drv = (DataRowView)e.Item.DataItem;
                int planId = Convert.ToInt32(drv["PlanID"]);

                Repeater featuresRepeater = (Repeater)e.Item.FindControl("featuresRepeater");

                get_connection();
                string query = "SELECT * FROM PlanFeatures WHERE PlanID = '" + planId + "'";
                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataSet ds = new DataSet();
                da.Fill(ds);

                featuresRepeater.DataSource = ds.Tables[0];
                featuresRepeater.DataBind();
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
            get_connection();

            string query = "SELECT p.Name, up.Selected_Cycle FROM User_Planes_tbl up INNER JOIN Plans p ON up.Plan_Id = p.PlanID WHERE up.User_Id = '" + userId + "' AND up.IsActive = 1";
            SqlCommand cmd = new SqlCommand(query, con);
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

        [WebMethod]
        public static object ActivatePlan(int planId)
        {
            Pricing obj = new Pricing();
            obj.get_connection();

            try
            {
                var context = System.Web.HttpContext.Current;
                if (context.Session["UserId"] == null)
                {
                    return new { success = false, message = "User not logged in" };
                }

                int userId = Convert.ToInt32(context.Session["UserId"]);

                string deactivateQuery = "UPDATE User_Planes_tbl SET IsActive = 0 WHERE User_Id = '" + userId + "'";
                SqlCommand deactivateCmd = new SqlCommand(deactivateQuery, obj.con);
                deactivateCmd.ExecuteNonQuery();

                string activateQuery = "UPDATE User_Planes_tbl SET IsActive = 1, Start_Date = GETDATE() WHERE User_Id = '" + userId + "' AND Plan_Id = '" + planId + "'";
                SqlCommand activateCmd = new SqlCommand(activateQuery, obj.con);
                int rows = activateCmd.ExecuteNonQuery();

                if (rows > 0)
                {
                    return new { success = true, message = "Plan activated successfully" };
                }
                else
                {
                    return new { success = false, message = "Plan not found or already active" };
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

            Pricing obj = new Pricing();
            obj.get_connection();

            string planName = "";
            decimal amount = 0;

            string query = "SELECT Name, MonthlyPrice, AnnualPrice FROM Plans WHERE PlanID = '" + planId + "'";
            SqlCommand cmd = new SqlCommand(query, obj.con);
            SqlDataReader reader = cmd.ExecuteReader();

            if (reader.Read())
            {
                planName = reader["Name"].ToString();
                amount = cycle == "annual" ? Convert.ToDecimal(reader["AnnualPrice"]) : Convert.ToDecimal(reader["MonthlyPrice"]);
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
