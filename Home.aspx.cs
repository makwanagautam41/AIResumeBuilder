using System;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using System.Web.Script.Serialization;
using System.Web.UI;

namespace airesumebuilder
{
    public partial class Home1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userLoggedIn"] != "true")
            {
                Response.Redirect("Login.aspx");
            }
        }

        protected async void Submit_Click(object sender, EventArgs e)
        {
            string userInput = txtMessageBox.Text;
            if (!string.IsNullOrEmpty(userInput))
            {
                string response = await CallGeminiApi(userInput);
                if (!string.IsNullOrEmpty(response) && !response.StartsWith("Error:"))
                {
                    Session["geminiResponse"] = response;
                    Response.Redirect("temp.aspx");
                }
                else
                {
                    Session["geminiResponse"] = "Something went wrong or no response from Gemini.";
                    Response.Redirect("temp.aspx");
                }
            }
        }

        private static async Task<string> CallGeminiApi(string promptText)
        {
            string apiKey = "AIzaSyBprS3Y9gAS1BA61_niS1rpNgwxYHwc7yU";
            string requestUrl = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-pro:generateContent";

            using (HttpClient client = new HttpClient())
            {
                client.DefaultRequestHeaders.Clear();
                client.DefaultRequestHeaders.Add("X-goog-api-key", apiKey);

                var payloadObj = new
                {
                    contents = new[]
                    {
                        new {
                            parts = new[]
                            {
                                new { text = promptText }
                            }
                        }
                    }
                };

                string jsonPayload = new JavaScriptSerializer().Serialize(payloadObj);
                var content = new StringContent(jsonPayload, Encoding.UTF8, "application/json");

                HttpResponseMessage response = await client.PostAsync(requestUrl, content);

                if (response.IsSuccessStatusCode)
                {
                    string jsonResponse = await response.Content.ReadAsStringAsync();
                    try
                    {
                        var serializer = new JavaScriptSerializer();
                        dynamic result = serializer.Deserialize<dynamic>(jsonResponse);
                        string textResponse = result["candidates"][0]["content"]["parts"][0]["text"];
                        return textResponse;
                    }
                    catch
                    {
                        return "Error: Could not parse Gemini response.";
                    }
                }
                else
                {
                    return $"Error: {response.StatusCode} - {response.ReasonPhrase}";
                }
            }
        }
    }
}
