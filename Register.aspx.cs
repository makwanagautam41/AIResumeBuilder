using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace airesumebuilder
{
    public partial class Register : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;
        String img_file_name;

        protected void Page_Load(object sender, EventArgs e)
        {
            get_connection();
            if (Session["userLoggedIn"] == "true")
            {
                Response.Redirect("Home.aspx");
            }
        }

        void get_connection()
        {
            con = new SqlConnection(connectionString);
            con.Open();
        }

        int check_user_exist(string email, string mobile)
        {
            get_connection();

            string sql = "SELECT COUNT(*) FROM user_tbl WHERE Email = '" + email + "' OR Mobile = '" + mobile + "'";
            SqlCommand cmd = new SqlCommand(sql, con);

            int count = Convert.ToInt32(cmd.ExecuteScalar());

            if (count > 0)
            {
                LabelMessage.Text = "User already exists!";
                LabelMessage.ForeColor = System.Drawing.Color.Red;
                con.Close();
                return 1;
            }
            con.Close();
            return 0;
        }

        void img_upload()
        {
            if (ImageFile.HasFile)
            {
                img_file_name = "images/" + ImageFile.FileName;
                ImageFile.SaveAs(Server.MapPath(img_file_name));
            }
        }

        protected void ButtonRegister_Click(object sender, EventArgs e)
        {
            String name = TextBoxName.Text;
            String email = TextBoxEmail.Text;
            String mobile = TextBoxMobile.Text;
            String password = TextBoxPassword.Text;

            if (check_user_exist(email, mobile) == 1)
            {
                return;
            }

            get_connection();
            img_upload();
            String query = "INSERT INTO user_tbl(Name, Email, Mobile, Password,Image,Gender) VALUES ('" + name + "','" + email + "','" + mobile + "','" + password + "','"+img_file_name+"','"+genderRadioButton.Text+"')";
            cmd = new SqlCommand(query, con);
            try
            {
                cmd.ExecuteNonQuery();
                Session["successMessage"] = "Registration successfull!";
                Response.Redirect("Login.aspx");
            }
            catch (Exception ex)
            {
                LabelMessage.Text = "Error: " + ex.Message;
                LabelMessage.ForeColor = System.Drawing.Color.Red;
            }
            finally
            {
                con.Close();
            }
        }
    }
}