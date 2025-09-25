//using System;
//using System.Collections.Generic;
//using System.Linq;
//using System.Web;
//using System.Web.UI;
//using System.Web.UI.WebControls;
//using System.Configuration;
//using System.Data;
//using System.Data.SqlClient;

//namespace airesumebuilder
//{
//    public partial class Pricing : System.Web.UI.Page
//    {
//        string connectionString = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
//        SqlConnection con;
//        SqlDataAdapter da;
//        DataSet ds;
//        SqlCommand cmd;

//        protected void Page_Load(object sender, EventArgs e)
//        {

//            get_connection();
//            if (!IsPostBack)
//            {
//                get_plans();
//            }


//        }

//        void get_connection()
//        {
//            con = new SqlConnection(connectionString);
//            con.Open();
//        }

//        void get_plans()
//        {
//            get_connection();
//            string query = "SELECT * FROM Plans";
//            da = new SqlDataAdapter(query, con);
//            ds = new DataSet();
//            da.Fill(ds);
//            plansRepeater.DataSource = ds.Tables[0];
//            plansRepeater.DataBind();
//        }

//        void get_features_for_plan(int planId)
//        {
//            get_connection();
//            string query = "SELECT * FROM PlanFeatures WHERE PlanId = " + planId;
//            da = new SqlDataAdapter(query, con);
//            ds = new DataSet();
//            da.Fill(ds);
//            featuresRepeater.DataSource = ds.Tables[0];
//            featuresRepeater.DataBind();
//        }
//    }
//}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace airesumebuilder
{
    public partial class Pricing : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                get_plans();
            }
        }

        void get_plans()
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
    }
}
