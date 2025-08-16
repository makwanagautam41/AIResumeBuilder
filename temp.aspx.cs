using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace airesumebuilder
{
    public partial class temp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["geminiResponse"] != null)
            {
                lblResponse.Text = Session["geminiResponse"].ToString();
            }
            else
            {
                lblResponse.Text = "No response available.";
            }
        }
    }
}