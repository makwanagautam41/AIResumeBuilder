<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="airesumebuilder.Home1" Async="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <!DOCTYPE html>
    <html>
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>AI Resume Builder</title>
        <link rel="stylesheet" href="css/style.css" />
        <link rel="stylesheet" href="css/index.css" />
    </head>
    <body>
        <input type="checkbox" id="sidebar-toggle" class="hidden-checkbox" />
        <input type="checkbox" id="theme-toggle-checkbox" class="hidden-checkbox" />
        <div class="container">
            <aside class="sidebar" aria-label="Sidebar">
                <div class="sidebar-header">
                    <div class="img-div">
                        <a href="Profile.aspx">
                            <img src="https://res.cloudinary.com/djbqtwzyf/image/upload/v1744042607/default_img_gszetk.png" alt="MyChat Logo" class="logo-img" />
                            <span>Profile</span>
                        </a>
                    </div>
                    <span class="logo-text">AI Resume Builder</span>
                </div>

                <!-- Navigation Buttons -->
                <div class="nav-buttons">
                    <a href="ChatPlayGround.aspx" class="new-chat-btn nav-btn">💬 Chat Interface</a>
                    <a href="ResumePlayGround.aspx" class="new-chat-btn nav-btn">📄 Resume Builder</a>
                </div>

                <div class="chat-list">
                    <asp:Repeater ID="ChatRepeater" runat="server" OnItemCommand="ChatRepeater_ItemCommand">
                        <ItemTemplate>
                            <div class="new-chat-btn" style="display: flex; justify-content: center; align-items: center; gap: 12px; margin-bottom: 4px;">
                                <p style="margin: 0;">
                                    <a style="text-decoration: none; color: white;" href='<%# "ChatPlayGround.aspx?chatid=" + Eval("ChatId") %>'>
                                        <%# Eval("Title") %>
                                    </a>
                                </p>
                                <asp:Button ID="DeleteBtn" runat="server"
                                    Style="padding: 4px; background-color: red; color: white; border-radius: 5px; height: 30px; cursor: pointer;"
                                    Text="Delete" CommandName="DeleteChat" CommandArgument='<%# Eval("ChatId") %>' />
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
                <div class="sidebar-footer">
                    <span>Upgrade</span>
                    <label for="theme-toggle-checkbox" class="theme-toggle" title="Toggle theme">
                        🌙</label>
                </div>
            </aside>
            <label for="sidebar-toggle" class="overlay">
            </label>

            <!-- Main area with navbar for small screens -->
            <main class="main">
                <header class="navbar" aria-label="Navigation">
                    <label for="sidebar-toggle" class="hamburger" aria-label="Show sidebar">
                        <svg
                            xmlns="http://www.w3.org/2000/svg"
                            fill="none"
                            viewBox="0 0 24 24">
                            <path
                                stroke-linecap="round"
                                stroke-linejoin="round"
                                stroke-width="2"
                                d="M4 6h16M4 12h16M4 18h16" />
                        </svg>
                    </label>
                    <span>AI Resume Builder</span> <span></span>
                </header>
                <div class="main-content">
                    <div class="welcome">
                        <svg
                            xmlns="http://www.w3.org/2000/svg"
                            fill="none"
                            stroke="currentColor"
                            viewBox="0 0 24 24">
                            <circle cx="12" cy="12" r="10" stroke-width="2" />
                            <path stroke-width="2" d="M8 12h8M12 8v8" />
                        </svg>
                        <h1>Welcome to AI Resume Builder!</h1>
                        <p>Choose your preferred tool to get started</p>
                        <div class="feature-cards">
                            <div class="feature-card">
                                <div class="feature-icon">💬</div>
                                <h3>Chat Interface</h3>
                                <p>Interact with our AI assistant for personalized guidance and support.</p>
                                <a href="ChatPlayGround.aspx" class="feature-btn">Start Chatting</a>
                            </div>
                            <div class="feature-card">
                                <div class="feature-icon">📄</div>
                                <h3>Resume Builder</h3>
                                <p>Create professional resumes with AI-powered templates and suggestions.</p>
                                <a href="ResumePlayGround.aspx" class="feature-btn">Build Resume</a>
                            </div>
                        </div>
                    </div>
                    <!-- Chat feed -->
                    <div class="main-content">
                        <div class="chat-feed" id="chatFeed" runat="server">
                            <!-- Messages will be loaded from DB in code-behind -->
                        </div>

                        <!-- Composer -->
                        <div class="composer">
                            <asp:TextBox ID="txtMessageBox" runat="server"
                                Style="width: 100%; padding: 8px; border-radius: 5px;"
                                placeholder="Type a message..."></asp:TextBox>
                            <asp:Button ID="Submit" runat="server"
                                Style="padding: 7px; border-radius: 5px; cursor: pointer;"
                                Text="Send message" OnClick="Submit_Click" />
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </body>
    </html>
</asp:Content>
