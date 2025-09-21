using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Drawing;
using System.Text;
using System.Threading.Tasks;
using System.Web.UI;
using Markdig;

namespace airesumebuilder
{
    public partial class ChatPlayGround : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        SqlConnection con;
        int chatId;
        int userId;
        string userEmail;

        void get_connection()
        {
            con = new SqlConnection(connectionString);
            con.Open();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            AuthHelper.RequireLogin(this);

            if (!int.TryParse(Request.QueryString["chatid"], out chatId))
            {
                Response.Redirect("Home.aspx");
            }

            userId = Convert.ToInt32(Session["UserId"]);
            userEmail = Session["userEmail"].ToString();

            if (!IsPostBack)
            {
                LoadMessages();
                LoadChatSessions();
            }
        }

        protected void Submit_Click(object sender, EventArgs e)
        {
            string userInput = txtMessageBox.Text.Trim();
            if (!string.IsNullOrEmpty(userInput))
            {
                string conversationHistory = GetConversationHistory(chatId);

                string fullPrompt = conversationHistory + "\nUser: " + userInput + "\nAI:";

                string response = Gemini_Class.CallGemini(fullPrompt);

                if (string.IsNullOrEmpty(response) || response.StartsWith("Error:"))
                {
                    response = "Something went wrong or no response from Gemini.";
                }
                SaveMessage(chatId, userId, userInput, response);
                LoadMessages();
                txtMessageBox.Text = "";
            }
        }

        private string GetConversationHistory(int chatId)
        {
            get_connection();
            StringBuilder sb = new StringBuilder();

            string query = "SELECT Prompt, Response FROM chat_messages WHERE ChatId='" + chatId + "' ORDER BY CreatedAt ASC";
            SqlCommand cmd = new SqlCommand(query, con);

            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                sb.AppendLine("User: " + dr["Prompt"].ToString());
                sb.AppendLine("AI: " + dr["Response"].ToString());
            }
            con.Close();

            return sb.ToString();
        }

        //private void LoadMessages()
        //{
        //    get_connection();
        //    StringBuilder sb = new StringBuilder();

        //    string query = "SELECT Prompt, Response FROM chat_messages WHERE ChatId='" + chatId + "' ORDER BY CreatedAt ASC";
        //    SqlCommand cmd = new SqlCommand(query, con);

        //    SqlDataReader dr = cmd.ExecuteReader();
        //    while (dr.Read())
        //    {
        //        string userMsg = dr["Prompt"].ToString();
        //        string aiMsg = dr["Response"].ToString();

        //        sb.Append($@"
        //                <div class='message user'>
        //                    <div class='avatar'>{userEmail[0].ToString()}</div>
        //                    <div class='bubble'>{userMsg}</div>
        //                </div>
        //                <div class='message assistant'>
        //                    <div class='avatar'>AI</div>
        //                    <div class='bubble'>{aiMsg}</div>
        //                </div>");
        //    }
        //    con.Close();

        //    chatFeed.InnerHtml = sb.ToString();
        //}

        private void LoadMessages()
        {
            get_connection();
            StringBuilder sb = new StringBuilder();

            string query = "SELECT Prompt, Response FROM chat_messages WHERE ChatId='" + chatId + "' ORDER BY CreatedAt ASC";
            SqlCommand cmd = new SqlCommand(query, con);

            SqlDataReader dr = cmd.ExecuteReader();

            if (!dr.HasRows)
            {
                dr.Close();
                con.Close();
                Response.Redirect("Home.aspx");
                return;
            }

            while (dr.Read())
            {
                string userMsg = dr["Prompt"].ToString();
                string aiMsg = dr["Response"].ToString();

                // Convert markdown to HTML
                string formattedAiMsg = Markdown.ToHtml(aiMsg);

                sb.Append($@"
            <div class='message user'>
                <div class='avatar'>{userEmail[0]}</div>
                <div class='bubble'>{userMsg}</div>
            </div>
            <div class='message assistant'>
                <div class='avatar'>AI</div>
                <div class='bubble'>{formattedAiMsg}</div>
            </div>");
            }
            con.Close();

            chatFeed.InnerHtml = sb.ToString();
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

        private void LoadChatSessions()
        {
            get_connection();
            string query = "SELECT ChatId, Title FROM chat_sessions WHERE UserId='" + userId + "' ORDER BY CreatedAt DESC";
            SqlCommand cmd = new SqlCommand(query, con);

            SqlDataReader dr = cmd.ExecuteReader();

            ChatRepeater.DataSource = dr;
            ChatRepeater.DataBind();

            con.Close();
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
                string deleteMessages = "DELETE FROM chat_messages WHERE ChatId='" + chatId + "'";
                SqlCommand cmd1 = new SqlCommand(deleteMessages, con);
                cmd1.ExecuteNonQuery();

                // Then delete the chat session
                string deleteSession = "DELETE FROM chat_sessions WHERE ChatId='" + chatId + "'";
                SqlCommand cmd2 = new SqlCommand(deleteSession, con);
                cmd2.ExecuteNonQuery();

                con.Close();
                Response.Redirect("Home.aspx");

                LoadChatSessions();
            }
        }
    }
}
