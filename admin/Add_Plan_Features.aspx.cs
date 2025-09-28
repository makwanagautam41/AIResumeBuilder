using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace airesumebuilder.admin
{
    public partial class Add_Plan_Features : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        SqlConnection con;
        SqlCommand cmd;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                get_connection();
                LoadPlans();
            }
        }

        void get_connection()
        {
            con = new SqlConnection(connStr);
            con.Open();
        }

        void LoadPlans()
        {
            get_connection();
            cmd = new SqlCommand("SELECT PlanID, Name FROM Plans", con);
            ddlPlans.DataSource = cmd.ExecuteReader();
            ddlPlans.DataTextField = "Name";
            ddlPlans.DataValueField = "PlanID";
            ddlPlans.DataBind();
            con.Close();

            ddlPlans.Items.Insert(0, new ListItem("-- Select Plan --", "0"));
        }

        void LoadFeatures()
        {
            get_connection();
            if (ddlPlans.SelectedValue == "0") return;


            cmd = new SqlCommand("SELECT FeatureID, FeatureName, IsIncluded FROM PlanFeatures WHERE PlanID='" + ddlPlans.SelectedValue + "'", con);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            gvFeatures.DataSource = dt;
            gvFeatures.DataBind();

        }

        protected void add_feature_Click(object sender, EventArgs e)
        {
            get_connection();
            if (ddlPlans.SelectedValue == "0" || string.IsNullOrWhiteSpace(feature_name.Text))
            {
                lblMessage.Text = "Please select a plan and enter a feature.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }


            string query = "INSERT INTO PlanFeatures (PlanID, FeatureName, IsIncluded) VALUES ('" + ddlPlans.SelectedValue + "','" + feature_name.Text + "','" + chkIsIncluded.Checked + "')";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.ExecuteNonQuery();
            con.Close();

            lblMessage.Text = "Feature added successfully!";
            lblMessage.ForeColor = System.Drawing.Color.Green;
            feature_name.Text = "";
            chkIsIncluded.Checked = false;

            LoadFeatures();
        }

        protected void ddlPlans_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadFeatures();
        }


        protected void gvFeatures_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            get_connection();
            int featureId = Convert.ToInt32(gvFeatures.DataKeys[e.RowIndex].Value);


            SqlCommand cmd = new SqlCommand("DELETE FROM PlanFeatures WHERE FeatureID='"+featureId+"'", con);
            cmd.ExecuteNonQuery();
            con.Close();

            LoadFeatures();
        }
    }
}
