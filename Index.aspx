<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="airesumebuilder.Index" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="css/index.css" />
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <header class="navbar">
        <div class="logo">AIResumeBuilder</div>
        <nav class="nav-links">
            <a href="Login.aspx">Login</a>
            <a href="Register.aspx">Register</a>
        </nav>
    </header>

    <main class="intro-section">
        <div class="intro-content">
            <h1>Welcome to Our AI Resume Builder</h1>
            <p>
                Create professional resumes in minutes using AI-powered templates. 
                Choose from modern, classic, or creative designs — optimized for all devices.
            </p>
            <a class="cta-btn" href="Home.aspx">Get Started</a>
        </div>
    </main>
</asp:Content>
