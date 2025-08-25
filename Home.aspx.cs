using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Threading.Tasks;
using System.Web.UI;

namespace airesumebuilder
{
    public partial class Home1 : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        SqlConnection con;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userLoggedIn"] == null || Session["userLoggedIn"].ToString() != "true")
            {
                Response.Redirect("Login.aspx");
            }

            if (!IsPostBack)
            {
                LoadChatSessions();
            }

            get_connection();
        }

        void get_connection()
        {
            con = new SqlConnection(connectionString);
            con.Open();
        }

        private void LoadChatSessions()
        {
            get_connection();
            string userId = Session["UserId"].ToString();
            string query = "SELECT ChatId, Title FROM chat_sessions WHERE UserId='" + userId + "' ORDER BY CreatedAt DESC";
            SqlCommand cmd = new SqlCommand(query, con);

            SqlDataReader dr = cmd.ExecuteReader();

            ChatRepeater.DataSource = dr;
            ChatRepeater.DataBind();

            con.Close();
        }

        protected async void Submit_Click(object sender, EventArgs e)
        {
            string userInput = txtMessageBox.Text.Trim();
            if (!string.IsNullOrEmpty(userInput))
            {
                int userId = Convert.ToInt32(Session["UserId"]);

                // create new chat session with title
                int chatId = CreateChatSession(userId, userInput);

                // call Gemini API
                string response = await CallGeminiApi(userInput);
                if (string.IsNullOrEmpty(response) || response.StartsWith("Error:"))
                {
                    response = "Something went wrong or no response from Gemini.";
                }

                // save both user input and AI response
                SaveMessage(chatId, userId, userInput, response);

                Response.Redirect($"ChatPlayGround.aspx?chatid={chatId}");
            }
        }

        private int CreateChatSession(int userId, string firstMessage)
        {
            get_connection();
            int chatId = 0;
            string title = firstMessage.Length > 50 ? firstMessage.Substring(0, 50) + "..." : firstMessage;

            string query = "INSERT INTO chat_sessions (UserId, Title, CreatedAt) VALUES (" + userId + ", '" + title + "', GETDATE())";
            SqlCommand cmd = new SqlCommand(query, con);

            cmd.ExecuteNonQuery();

            // now get the last inserted id
            SqlCommand idCmd = new SqlCommand("SELECT MAX(ChatId) FROM chat_sessions WHERE UserId=" + userId, con);
            chatId = Convert.ToInt32(idCmd.ExecuteScalar());

            return chatId;
        }

        private void SaveMessage(int chatId, int userId, string prompt, string response)
        {
            get_connection();

            // escape single quotes in case text contains '
            prompt = prompt.Replace("'", "''");
            response = response.Replace("'", "''");

            string query = "INSERT INTO chat_messages (ChatId, UserId, Prompt, Response, CreatedAt) VALUES ('" + chatId + "','" + userId + "','" + prompt + "','" + response + "',GETDATE())";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.ExecuteNonQuery();
            con.Close();
        }

        private static async Task<string> CallGeminiApi(string promptText)
        {
            return await Home1Helper.CallGemini(promptText);
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("Home.aspx");
        }

        protected void ChatRepeater_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "DeleteChat")
            {
                int chatId = Convert.ToInt32(e.CommandArgument);
                get_connection();

                // First delete messages of this chat
                string deleteMessages = "DELETE FROM chat_messages WHERE ChatId='"+chatId+"'";
                SqlCommand cmd1 = new SqlCommand(deleteMessages, con);
                cmd1.ExecuteNonQuery();

                // Then delete the chat session
                string deleteSession = "DELETE FROM chat_sessions WHERE ChatId='"+chatId+"'";
                SqlCommand cmd2 = new SqlCommand(deleteSession, con);
                cmd2.ExecuteNonQuery();

                con.Close();

                LoadChatSessions();
            }
        }
    }

    // helper class for Gemini API (so we can reuse in ChatPlayGround.aspx.cs too)
    public static class Home1Helper
    {
        public static async Task<string> CallGemini(string promptText)
        {
            using (var client = new System.Net.Http.HttpClient())
            {
                string apiKey = "AIzaSyDpNtrDDnqKIeO-fM0VMK0TddBJUVTj0yw";
                string requestUrl = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent";

                client.DefaultRequestHeaders.Clear();
                client.DefaultRequestHeaders.Add("X-goog-api-key", apiKey);

                var systemPrompt = "You are an advanced AI resume builder powered by Google Gemini 2.5 Pro. Your task is to create three distinct, complete, and unique HTML and CSS resume designs. Each design should reflect different styles but should still adhere to the highest standards of design excellence. Focus on producing designs that are sophisticated, elegant, and visually striking, each with its own theme.\r\n\r\nKey Objectives:\r\n\r\nThree Distinct Designs: Provide three complete resume designs with completely different structures, layouts, color schemes, and typography, ensuring that each design is unique.\r\n\r\nLuxurious, High-End Aesthetic: Each design should have a high-end, professional feel that suggests luxury and refinement, suitable for top-tier professionals.\r\n\r\nCSS Mastery: The CSS must use the latest techniques and innovations such as Flexbox, CSS Grid, custom properties, and animations, while ensuring the code is clean and efficient.\r\n\r\nTypography & Layouts: Every resume design should have perfect readability, with clear, elegant typography, well-organized sections, and a consistent layout. Each design must feel unique but still professional and legible.\r\n\r\nResponsive and Interactive: Ensure that all designs are fully responsive and functional across all screen sizes (mobile, tablet, desktop) and include subtle animations or transitions that enhance the user experience.\r\n\r\nFocus on Details: Pay special attention to spacing, margins, and design harmony to ensure a visually stunning result. Small, subtle design elements like icons, shadows, and borders should elevate the overall design.\r\nLuxurious Aesthetic & Perfection in Design: The design must be visually stunning and sophisticated, capturing a sense of high-end quality that would befit an elite professional. The resume should have the aura of a multi-million-dollar document, showcasing a top-tier design sensibility.\r\n\r\nElegant and Balanced Layout: Every element of the design should have perfect balance, including typography, margins, spacing, and alignment. The sections should be clearly delineated but flow seamlessly. The overall experience should be fluid and easy to navigate.\r\n\r\nUse of Cutting-Edge CSS Techniques: The CSS must be next-level, leveraging the latest trends and technologies, such as CSS Grid, Flexbox, animations, transitions, and custom properties. The code must be lightweight but highly performant, and the visual effects must be subtle but impactful.\r\n\r\nFocus on Readability & Clarity: While the design should be eye-catching, it must never sacrifice clarity or usability. Prioritize legibility and easy navigation, with careful attention to typography, line-height, font choice, and text hierarchy. The resume should feel easy to read at a glance but have depth when explored in detail.\r\n\r\nResponsive Design: The layout must be fully responsive across all screen sizes—mobile, tablet, and desktop. It should look as stunning and functional on a 5-inch phone screen as it does on a 30-inch monitor.\r\n\r\nAttention to Details: Incorporate subtle but meaningful design elements like elegant icons, creative separators, and professional animations that enhance the user experience without overwhelming the content. Every detail matters, and perfection is the goal.\r\n\r\nImpressive Color Palette & Visual Hierarchy: The color scheme should evoke professionalism while maintaining an aesthetic of luxury and refinement. The palette should complement the content, not distract from it. Use shadows, gradients, and highlights in moderation to add depth and focus.\r\n\r\nConsistency & Cohesion: The design must be consistent across all elements. All the visual components must work in harmony to create a cohesive whole that doesn’t feel cluttered or disjointed.\r\n\r\nCSS that Could Take Months of Expertise to Create: The resume should have a look and feel that suggests a decade of experience in design, where every pixel has been meticulously adjusted, and every animation is purposeful and smooth. Imagine that a team of top-tier designers and CSS experts have collaborated for months to achieve this level of craftsmanship.\r\n\r\nUnique, Memorable, and Impactful: This resume should leave a lasting impression, something that sets the individual apart from all other candidates. It’s not just a resume—it’s a piece of art that will make the viewer want to hire the person instantly.Do not include any additional explanations or text. Provide only the HTML and CSS code for all three designs.";

                var payloadObj = new
                {
                    contents = new[]
                    {
                        new { role = "user", parts = new[] { new { text = systemPrompt } } }, // system instruction
                        new { role = "user", parts = new[] { new { text = promptText } } }   // actual user input
                    }
                };


                string jsonPayload = new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(payloadObj);
                var content = new System.Net.Http.StringContent(jsonPayload, System.Text.Encoding.UTF8, "application/json");

                var response = await client.PostAsync(requestUrl, content);
                if (response.IsSuccessStatusCode)
                {
                    string jsonResponse = await response.Content.ReadAsStringAsync();
                    try
                    {
                        var serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                        dynamic result = serializer.Deserialize<dynamic>(jsonResponse);
                        string textResponse = result["candidates"][0]["content"]["parts"][0]["text"];
                        return textResponse;
                    }
                    catch
                    {
                        return "Error: Could not parse Gemini response.";
                    }
                }
                return $"Error: {response.StatusCode} - {response.ReasonPhrase}";
            }
        }
    }
}
