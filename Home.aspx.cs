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

            LoadChatSessions();
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
    }

    // helper class for Gemini API (so we can reuse in ChatPlayGround.aspx.cs too)
    public static class Home1Helper
    {
        public static async Task<string> CallGemini(string promptText)
        {
            using (var client = new System.Net.Http.HttpClient())
            {
                string apiKey = "AIzaSyBprS3Y9gAS1BA61_niS1rpNgwxYHwc7yU";
                string requestUrl = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-pro:generateContent";

                client.DefaultRequestHeaders.Clear();
                client.DefaultRequestHeaders.Add("X-goog-api-key", apiKey);

                var systemPrompt = "You are an assistant that must only respond strictly to the user's prompt and content. Do not provide unrelated information.";

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
