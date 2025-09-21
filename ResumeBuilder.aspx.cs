using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web.UI;

namespace airesumebuilder
{
    public partial class ResumeBuilder : System.Web.UI.Page
    {
        int userId;
        string userEmail;
        protected void Page_Load(object sender, EventArgs e)
        {
            AuthHelper.RequireLogin(this);

            userId = Convert.ToInt32(Session["UserId"]);
            userEmail = Session["userEmail"].ToString();
        }

        protected void btnGenerate_Click(object sender, EventArgs e)
        {
            // This script shows the loader immediately on button click
            string showLoadingScript = @"
                document.getElementById('resumeFormContainer').style.display = 'none';
                document.getElementById('loadingContainer').style.display = 'block';";
            ClientScript.RegisterStartupScript(GetType(), "ShowLoading", showLoadingScript, true);

            try
            {
                // 1. Build the prompt for the AI
                string userPrompt = BuildResumePrompt();

                // 2. Call your Gemini API class
                // IMPORTANT: You must have your 'Gemini_Class.cs' file with the 'CallGeminiResume' method.
                string aiResponse = Gemini_Class.CallGeminiResume(userPrompt);

                // 3. Clean and separate the 3 HTML resume designs
                string cleanedResponse = CleanAIResponse(aiResponse);
                string[] resumes = ExtractResumeDesigns(cleanedResponse);

                // 4. Use fallbacks if AI response isn't structured correctly
                string resume1 = (resumes.Length > 0 && !string.IsNullOrWhiteSpace(resumes[0])) ? resumes[0] : GenerateFallbackResume(1);
                string resume2 = (resumes.Length > 1 && !string.IsNullOrWhiteSpace(resumes[1])) ? resumes[1] : GenerateFallbackResume(2);
                string resume3 = (resumes.Length > 2 && !string.IsNullOrWhiteSpace(resumes[2])) ? resumes[2] : GenerateFallbackResume(3);

                // 5. Save the results to the database
                int newResumeId = SaveResumesToDatabase(resume1, resume2, resume3);

                // 6. Redirect to the new page with the generated ID
                Response.Redirect($"ResumePlayGround.aspx?id={newResumeId}");
            }
            catch (Exception ex)
            {
                ShowError(ex.Message);
            }
        }

        private int SaveResumesToDatabase(string html1, string html2, string html3)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"
                    INSERT INTO GeneratedResumes (UserId,ResumeHtml1, ResumeHtml2, ResumeHtml3) 
                    VALUES (@UserId, @Html1, @Html2, @Html3);
                    SELECT SCOPE_IDENTITY();";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    cmd.Parameters.AddWithValue("@Html1", html1);
                    cmd.Parameters.AddWithValue("@Html2", html2);
                    cmd.Parameters.AddWithValue("@Html3", html3);

                    con.Open();
                    int newId = Convert.ToInt32(cmd.ExecuteScalar());
                    return newId;
                }
            }
        }

        #region Helper Methods from Original File
        private string BuildResumePrompt()
        {
            var sb = new StringBuilder();
            sb.AppendLine("Create THREE complete, professional HTML resume templates for:");
            sb.AppendLine($"Name: {txtFullName.Text}");
            sb.AppendLine($"Email: {txtEmail.Text}");
            sb.AppendLine($"Phone: {txtPhone.Text}");
            if (!string.IsNullOrWhiteSpace(txtLocation.Text)) sb.AppendLine($"Location: {txtLocation.Text}");
            if (!string.IsNullOrWhiteSpace(txtSummary.Text)) sb.AppendLine($"\nPROFESSIONAL SUMMARY:\n{txtSummary.Text}");
            if (!string.IsNullOrWhiteSpace(txtJobTitle.Text)) sb.AppendLine($"\nWORK EXPERIENCE:\nPosition: {txtJobTitle.Text}\nCompany: {txtCompany.Text}\nDuration: {txtDuration.Text}\nDescription: {txtJobDescription.Text}");
            if (!string.IsNullOrWhiteSpace(txtDegree.Text)) sb.AppendLine($"\nEDUCATION:\nDegree: {txtDegree.Text}\nInstitution: {txtInstitution.Text}\nYear: {txtGradYear.Text}\nGPA: {txtGPA.Text}");
            if (!string.IsNullOrWhiteSpace(txtTechnicalSkills.Text) || !string.IsNullOrWhiteSpace(txtSoftSkills.Text)) sb.AppendLine($"\nSKILLS:\nTechnical: {txtTechnicalSkills.Text}\nSoft Skills: {txtSoftSkills.Text}");
            sb.AppendLine("\nCreate 3 different resume designs:");
            sb.AppendLine("1. Modern Professional - Clean, minimalist with blue accents");
            sb.AppendLine("2. Creative Design - Bold colors, unique layout");
            sb.AppendLine("3. Executive Classic - Traditional, elegant");
            sb.AppendLine("Each should be a complete HTML document with embedded CSS. Do not include markdown code fences like ```html or ```.");
            return sb.ToString();
        }

        private string CleanAIResponse(string response)
        {
            response = System.Text.RegularExpressions.Regex.Replace(response, @"```(?:html)?\s*", "", System.Text.RegularExpressions.RegexOptions.IgnoreCase);
            response = response.Replace("```", "");
            return response.Trim();
        }

        private string[] ExtractResumeDesigns(string aiResponse)
        {
            var parts = System.Text.RegularExpressions.Regex.Split(aiResponse, @"(?=<!DOCTYPE)", System.Text.RegularExpressions.RegexOptions.IgnoreCase)
                .Where(p => !string.IsNullOrWhiteSpace(p))
                .ToArray();
            return parts;
        }

        private string GenerateFallbackResume(int templateType)
        {
            // This method creates a basic resume if the AI fails.
            // Your original code for this method is perfectly fine.
            return $"<html><body><h1>Fallback Resume {templateType}</h1><p>Could not generate AI resume. Please try again.</p></body></html>";
        }

        private void ShowError(string message)
        {
            litError.Text = $@"
                <div style='background: #fee; padding: 20px; border-radius: 8px; margin: 20px; border-left: 4px solid #dc2626;'>
                    <h3 style='color: #dc2626;'>⚠️ Error Generating Resumes</h3>
                    <p style='color: #7f1d1d;'>We encountered an issue. Please try again.</p>
                    <small style='color: #991b1b; display: block; margin-top: 10px;'>Details: {Server.HtmlEncode(message)}</small>
                </div>";
            pnlError.Visible = true;

            string hideLoadingScript = @"
                document.getElementById('loadingContainer').style.display = 'none';
                document.getElementById('resumeFormContainer').style.display = 'block';";
            ClientScript.RegisterStartupScript(GetType(), "HideLoadingOnError", hideLoadingScript, true);
        }
        #endregion
    }
}