using System;
using System.Collections.Generic;
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

            string userEmail = Session["userEmail"].ToString();
            userAvatar.Text = userEmail.Substring(0, 1).ToUpper();

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

        protected void Submit_Click(object sender, EventArgs e)
        {
            string userInput = txtMessageBox.Text.Trim();
            if (!string.IsNullOrEmpty(userInput))
            {
                int userId = Convert.ToInt32(Session["UserId"]);
                int chatId = CreateChatSession(userId, userInput);
                string response = Gemini_Class.CallGemini(userInput);
                if (string.IsNullOrEmpty(response) || response.StartsWith("Error:"))
                {
                    response = "Something went wrong or no response from Gemini.";
                }
                SaveMessage(chatId, userId, userInput, response);
                Response.Redirect($"ChatPlayGround.aspx?chatid={chatId}", false); // Add false parameter to avoid ThredAbortException
                Context.ApplicationInstance.CompleteRequest(); // this line will properly completes the current request processing
            }
        }

        //protected void Submit_Click(object sender, EventArgs e)
        //{
        //    string userInput = txtMessageBox.Text.Trim();
        //    if (!string.IsNullOrEmpty(userInput))
        //    {
        //        int userId = Convert.ToInt32(Session["UserId"]);
        //        int chatId = CreateChatSession(userId, userInput);

        //        // Create a list to hold multiple responses
        //        List<string> responses = new List<string>();

        //        // Call Gemini 5 times (you can change number as needed)
        //        for (int i = 0; i < 5; i++)
        //        {
        //            string response = Gemini_Class.CallGemini(userInput);

        //            if (string.IsNullOrEmpty(response) || response.StartsWith("Error:"))
        //            {
        //                response = "Something went wrong or no response from Gemini.";
        //            }

        //            responses.Add(response);
        //        }

        //        // Save all responses
        //        foreach (string res in responses)
        //        {
        //            SaveMessage(chatId, userId, userInput, res);
        //        }

        //        // Redirect after saving
        //        Response.Redirect($"ChatPlayGround.aspx?chatid={chatId}", false);
        //        Context.ApplicationInstance.CompleteRequest();
        //    }
        //}


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

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("Home.aspx");
        }

        protected void ChatRepeater_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            get_connection();
            if (e.CommandName == "DeleteChat")
            {
                int chatId = Convert.ToInt32(e.CommandArgument);

                // First delete messages of this chat
                string deleteMessages = "DELETE FROM chat_messages WHERE ChatId='" + chatId + "'";
                SqlCommand cmd1 = new SqlCommand(deleteMessages, con);
                cmd1.ExecuteNonQuery();

                // Then delete the chat session
                string deleteSession = "DELETE FROM chat_sessions WHERE ChatId='" + chatId + "'";
                SqlCommand cmd2 = new SqlCommand(deleteSession, con);
                cmd2.ExecuteNonQuery();

                con.Close();

                LoadChatSessions();
            }
        }
    }
}
