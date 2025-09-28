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

        
    }
}