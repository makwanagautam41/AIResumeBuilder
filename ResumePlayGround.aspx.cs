using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Text;
using System.Web;

namespace airesumebuilder
{
    public partial class ResumePlayGround : System.Web.UI.Page
    {
        int userId;
        string userEmail;
        string connectionString = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        SqlConnection con;
        private string[] Resumes
        {
            get { return ViewState["Resumes"] as string[]; }
            set { ViewState["Resumes"] = value; }
        }

        private int ActiveTemplate
        {
            get { return (int)(ViewState["ActiveTemplate"] ?? 1); }
            set { ViewState["ActiveTemplate"] = value; }
        }

        private int CurrentResumeId
        {
            get { return (int)(ViewState["ResumeId"] ?? 0); }
            set { ViewState["ResumeId"] = value; }
        }

        void get_connection()
        {
            con = new SqlConnection(connectionString);
            con.Open();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            AuthHelper.RequireLogin(this);
            get_connection();

            userId = Convert.ToInt32(Session["UserId"]);
            userEmail = Session["userEmail"].ToString();
            LoadUserResumes();

            if (!IsPostBack)
            {
                int resumeId = Convert.ToInt32(Request.QueryString["id"]);
                if (resumeId <= 0)
                {
                    ShowError("Invalid or missing resume ID.");
                    return;
                }

                int selected = Convert.ToInt32(Request.QueryString["selected"]);
                if (selected < 1 || selected > 3) selected = 1;

                CurrentResumeId = resumeId;
                ActiveTemplate = selected;

                string[] arr = LoadResumes(resumeId);
                if (arr == null)
                {
                    ShowError("The requested resume could not be found.");
                    return;
                }

                Resumes = EnsureNonEmpty(arr);
                BindActive();
            }
        }

        //this method is used for showing the sidebar history of past created resumes
        private void LoadUserResumes()
        {
            get_connection();

            string query = "SELECT ResumeId, CreatedAt FROM GeneratedResumes WHERE UserId = '" + userId + "' ORDER BY CreatedAt DESC, ResumeId DESC";

            SqlCommand cmd = new SqlCommand(query, con);
            SqlDataReader rdr = cmd.ExecuteReader();

            if (rdr.HasRows)
            {
                ResumeRepeater.DataSource = rdr;
                ResumeRepeater.DataBind();
                EmptyState.Visible = false;
            }
            else
            {
                ResumeRepeater.DataSource = null;
                ResumeRepeater.DataBind();
                EmptyState.Visible = true;
            }
        }

        //this method is used for showing the resumes content based on the resumeId from the query string
        private string[] LoadResumes(int resumeId)
        {
            get_connection();
            SqlCommand cmd = new SqlCommand("SELECT ResumeHtml1, ResumeHtml2, ResumeHtml3 FROM GeneratedResumes WHERE ResumeId='" + resumeId + "'", con);

            con.Open();
            SqlDataReader rd = cmd.ExecuteReader();

            string[] result = null;

            if (rd.Read())
            {
                result = new string[]
                {
                    rd["ResumeHtml1"] != DBNull.Value ? rd["ResumeHtml1"].ToString() : "",
                    rd["ResumeHtml2"] != DBNull.Value ? rd["ResumeHtml2"].ToString() : "",
                    rd["ResumeHtml3"] != DBNull.Value ? rd["ResumeHtml3"].ToString() : ""
                };
            }

            rd.Close();

            return result;
        }



        private string[] EnsureNonEmpty(string[] input)
        {
            var arr = new string[3];
            for (int i = 0; i < 3; i++)
            {
                arr[i] = string.IsNullOrWhiteSpace(input[i])
                    ? "<!DOCTYPE html><html><head><meta charset='UTF-8'><meta name='viewport' content='width=device-width, initial-scale=1' /></head><body><div style='padding:24px;font-family:Segoe UI'>No HTML found for this template.</div></body></html>"
                    : input[i];
            }
            return arr;
        }

        private void BindActive()
        {
            // Show content panel
            phError.Visible = false;
            pnlContent.Visible = true;

            // Tab visual state
            lnkTab1.CssClass = "tab" + (ActiveTemplate == 1 ? " active" : "");
            lnkTab2.CssClass = "tab" + (ActiveTemplate == 2 ? " active" : "");
            lnkTab3.CssClass = "tab" + (ActiveTemplate == 3 ? " active" : "");

            // Only render the active template into the iframe
            int idx = ActiveTemplate - 1;
            string html = Resumes[idx];

            // Ensure full document
            if (!html.TrimStart().StartsWith("<!DOCTYPE", StringComparison.OrdinalIgnoreCase))
            {
                html = "<!DOCTYPE html><html><head><meta charset='UTF-8'><meta name='viewport' content='width=device-width, initial-scale=1' /></head><body>"
                     + html + "</body></html>";
            }

            // Render iframe via Literal
            litResumeFrame.Text = $"<iframe srcdoc=\"{HttpUtility.HtmlAttributeEncode(html)}\" " +
                                  "style='width:100%;height:800px;border:0;' " +
                                  "sandbox='allow-same-origin allow-scripts allow-popups allow-forms'></iframe>";
        }

        protected void lnkTab_Click(object sender, EventArgs e)
        {
            int arg = Convert.ToInt32(((System.Web.UI.WebControls.LinkButton)sender).CommandArgument);
            if (arg < 1 || arg > 3) arg = 1;

            ActiveTemplate = arg;
            BindActive();
        }

        protected void btnDownload_Click(object sender, EventArgs e)
        {
            int idx = ActiveTemplate - 1;
            string html = Resumes[idx];
            string filename = $"resume_{CurrentResumeId}_{ActiveTemplate}.html";

            Response.Clear();
            Response.ContentType = "text/html";
            Response.ContentEncoding = Encoding.UTF8;
            Response.AddHeader("Content-Disposition", "attachment;filename=" + filename);
            Response.Write(html);
            Response.End();
        }

        protected void btnPrint_Click(object sender, EventArgs e)
        {
            string url = $"~/ResumePrint.aspx?id={CurrentResumeId}&selected={ActiveTemplate}";
            Response.Redirect(url, false);
            Context.ApplicationInstance.CompleteRequest();
        }

        private void ShowError(string msg)
        {
            pnlContent.Visible = false;
            phError.Visible = true;
            litError.Text = HttpUtility.HtmlEncode(msg);
        }
    }
}