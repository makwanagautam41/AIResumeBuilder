<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="airesumebuilder.Index" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder1">
                <!DOCTYPE html>
                <html>
                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0"><title>Intro Page</title>
                    <link rel="stylesheet" href="css/index.css">
                </head>
                <body>
                    <header class="navbar">
                        <div class="logo">
                            MyLogo</div>
                        <nav class="nav-links">
                            <a href="Login.aspx">Login</a> <a href="Register.aspx">Register</a>
                        </nav>
                    </header>
                    <main class="intro-section">
                    <div class="intro-content">
                        <h1>Welcome to Our AIResumeBuilder Website</h1>
                         <a href="Home.aspx">Get Started</a>
                        <p>
                            This is a simple introduction page inspired by ChatGPT’s clean and minimal design.
        Everything is done using only HTML and CSS, fully responsive for all devices.
                        </p>
                    </div>
                    </main>
                </body>
    </html>
</asp:Content>

