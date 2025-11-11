using System;
using System.Configuration;
using System.IO;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using System.Web.UI;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace airesumebuilder
{
    public partial class Gen_Headshot : Page
    {
        protected void Page_Load(object sender, EventArgs e) { }

        protected void BtnGenerate_Click(object sender, EventArgs e)
        {
            RegisterAsyncTask(new PageAsyncTask(GenerateAsync));
        }

        private async Task GenerateAsync()
        {
            try
            {
                if (!FileUpload1.HasFile)
                {
                    LblStatus.Text = "Please select an image to generate headshot.";
                    return;
                }

                string apiKey = ConfigurationManager.AppSettings["GEMINI_API_KEY"];
                if (string.IsNullOrWhiteSpace(apiKey))
                {
                    LblStatus.Text = "Missing Gemini API Key in Web.config.";
                    return;
                }

                ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;

                string prompt =
@"Generate a professional studio-quality headshot of this person.

The photo should preserve their real facial features, skin tone, and proportions accurately — without altering identity.  
Use soft, natural, and flattering lighting to enhance clarity, sharpness, and depth.  
Set the background to a clean, neutral tone (light gray, beige, or softly blurred office or studio background).  
Ensure the person’s face is centered, in focus, and well-lit with even exposure and no harsh shadows.  
Style the image as a corporate portrait suitable for a tech entrepreneur’s LinkedIn, portfolio, or company website — polished yet natural.  
Avoid artistic filters, distortions, or unrealistic enhancements. The final image should look authentic, confident, and approachable.
";

                byte[] imageBytes = FileUpload1.FileBytes;
                string mime = FileUpload1.PostedFile.ContentType;
                if (string.IsNullOrWhiteSpace(mime)) mime = "image/jpeg";

                // REST payload: ONLY `contents` with text + inline_data. No responseModalities.
                var payload = new
                {
                    contents = new object[]
                    {
                        new
                        {
                            parts = new object[]
                            {
                                new { text = prompt },
                                new
                                {
                                    inline_data = new
                                    {
                                        mime_type = mime,
                                        data = Convert.ToBase64String(imageBytes)
                                    }
                                }
                            }
                        }
                    }
                };

                string jsonBody = JsonConvert.SerializeObject(payload);

                var url = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash-image:generateContent";

                byte[] outBytes = null;
                string outMime = null;

                using (var client = new HttpClient())
                using (var content = new StringContent(jsonBody, Encoding.UTF8, "application/json"))
                {
                    // Prefer header for API key (matches docs)
                    client.DefaultRequestHeaders.Remove("x-goog-api-key");
                    client.DefaultRequestHeaders.Add("x-goog-api-key", apiKey);

                    var response = await client.PostAsync(url, content).ConfigureAwait(false);
                    var responseString = await response.Content.ReadAsStringAsync().ConfigureAwait(false);

                    if (!response.IsSuccessStatusCode)
                    {
                        LblStatus.Text = "Error from Gemini API: " + responseString;
                        return;
                    }

                    var json = JObject.Parse(responseString);

                    // Find first part that has inlineData (the generated image)
                    var parts = json["candidates"]?[0]?["content"]?["parts"];
                    if (parts != null)
                    {
                        foreach (var p in parts)
                        {
                            var inline = p["inlineData"];
                            if (inline != null)
                            {
                                outMime = inline["mimeType"]?.ToString();
                                var base64 = inline["data"]?.ToString();
                                if (!string.IsNullOrEmpty(base64))
                                {
                                    outBytes = Convert.FromBase64String(base64);
                                    break;
                                }
                            }
                        }
                    }
                }

                if (outBytes == null)
                {
                    LblStatus.Text = "No image returned from Gemini.";
                    return;
                }

                string ext = outMime == "image/png" ? ".png"
                           : outMime == "image/jpeg" ? ".jpg"
                           : ".png";

                string folderPath = Server.MapPath("~/generated-images");
                if (!Directory.Exists(folderPath)) Directory.CreateDirectory(folderPath);

                string uniqueFileName = Guid.NewGuid().ToString("N") + ext;
                string fullPath = Path.Combine(folderPath, uniqueFileName);
                File.WriteAllBytes(fullPath, outBytes);

                ImgResult.ImageUrl = "~/generated-images/" + uniqueFileName;
                ImgResult.Visible = true;
                LblStatus.Text = "Headshot generated successfully!";
            }
            catch (Exception ex)
            {
                LblStatus.Text = "Unexpected error: " + ex.Message;
            }
        }
    }
}
