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
    public partial class Success : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        SqlConnection con;
        SqlCommand cmd;

        protected void Page_Load(object sender, EventArgs e)
        {
            AuthHelper.RequireLogin(this);

            int userId = Convert.ToInt32(Session["UserId"]);
            int planId = Convert.ToInt32(Request.QueryString["planId"]);
            string cycle = Request.QueryString["cycle"];
            string sessionId = Request.QueryString["session_id"]; // for Stripe reference

            if (!IsPostBack && userId > 0 && planId > 0)
            {
                SaveUserPlan(userId, planId, cycle, sessionId);
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
    }
}