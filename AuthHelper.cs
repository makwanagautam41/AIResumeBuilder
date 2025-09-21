using System;
using System.Collections.Generic;
using System.Linq;
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
                string currentUrl = page.Request.Url.AbsolutePath;
                page.Response.Redirect("Login.aspx?ReturnUrl=" + HttpUtility.UrlEncode(currentUrl));
            }
        }

        public static void RequireAnonymous(Page page)
        {
            if (page.Session["userLoggedIn"] != null && page.Session["userLoggedIn"].ToString() == "true")
            {
                page.Response.Redirect("Home.aspx");
            }
        }
    }
}