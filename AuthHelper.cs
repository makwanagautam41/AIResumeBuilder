using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;

namespace airesumebuilder
{
    public class AuthHelper
    {
        public static void RequireLogin(Page page)
        {
            if (page.Session["userLoggedIn"] == null || page.Session["userLoggedIn"].ToString() != "true")
            {
                string currentUrl = page.Request.Url.PathAndQuery;
                page.Response.Redirect("Login.aspx?ReturnUrl=" + HttpUtility.UrlEncode(currentUrl));
            }
        }

        public static void RequireAnonymous(Page page)
        {
            if (page.Session["userLoggedIn"] != null && page.Session["userLoggedIn"].ToString() == "true")
            {
                page.Response.Redirect("Home.aspx");
            }
            if (page.Session["userAdminIn"] != null && page.Session["userAdminIn"].ToString() == "true")
            {
                page.Response.Redirect("/admin/dashboard.aspx");
            }
        }

        public static void isAdmin(Page page)
        {
            if (page.Session["adminLoggedIn"] == null || page.Session["adminLoggedIn"].ToString() != "true")
            {
                string currentUrl = page.Request.Url.PathAndQuery;
                page.Response.Redirect("/Login.aspx?ReturnUrl=" + HttpUtility.UrlEncode(currentUrl));
            }
        }

        public static async Task SendEmailAsync(string to, string subject, string html)
        {
            try
            {
                using (var client = new HttpClient())
                {
                    string apiUrl = "https://smtp-service-server.vercel.app/api/email/send";
                    string apiKey = "dd3b47fb84853b72046d6a95ac4c02e3e35aee6a6a4f28474d4f4a470b1757c8"; //gautammakwana671@gmail.com (SMTP-LITE EMAIL) 

                    var emailData = new
                    {
                        to,
                        subject,
                        html
                    };

                    string json = JsonConvert.SerializeObject(emailData);

                    var content = new StringContent(json, Encoding.UTF8, "application/json");
                    client.DefaultRequestHeaders.Add("x-api-key", apiKey);

                    var response = await client.PostAsync(apiUrl, content);
                    string responseString = await response.Content.ReadAsStringAsync();
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"🚨 Error sending email: {ex.Message}");
            }
        }
    }
}