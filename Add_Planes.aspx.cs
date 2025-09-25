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
    public partial class Add_Planes : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;

        protected void Page_Load(object sender, EventArgs e)
        {
            get_connection();
        }

        void get_connection()
        {
            con = new SqlConnection(connectionString);
            con.Open();
        }

        protected void addPlanButton_Click(object sender, EventArgs e)
        {
            get_connection();
            string query = "INSERT INTO Plans (Name, MonthlyPrice, AnnualPrice, OriginalPrice, Description, IsPopular) VALUES ('"+planName.Text+"','"+planMonthlyPrice.Text+"','"+planAnnualPrice.Text+"','"+planOriginalPrice.Text+"','"+planDescription.Text+"','"+planIsPopular.Checked + "')";
            cmd = new SqlCommand(query, con);
            cmd.ExecuteNonQuery();
        }
    }
}