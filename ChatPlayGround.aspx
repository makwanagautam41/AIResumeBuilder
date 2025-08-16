<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="ChatPlayGround.aspx.cs" Inherits="airesumebuilder.ChatPlayGround" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <!DOCTYPE html>
    <html>
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Chat UI</title>
        <link rel="stylesheet" href="css/style.css" />
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
                    <span class="logo-text">MyChat</span>
                </div>
                <button class="new-chat-btn">
                    + New Chat
                </button>
                <div class="chat-list">
                    <button class="active">
                        New Chat
                    </button>
                    <button>
                        Project Chat
                    </button>
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
                    <span>MyChat</span> <span></span>
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
                        <h1>Welcome!</h1>
                        <div class="example-prompts">
                            <p>
                                Explain quantum computing in simple terms.
                            </p>
                            <p>
                                Give me ideas for a birthday party.
                            </p>
                        </div>
                    </div>
                    <div class="chat-feed">
                        <div class="message user">
                            <div class="avatar">
                                U
                            </div>
                            <div class="bubble">
                                Hello! How are you?
                            </div>
                        </div>
                        <div class="message assistant">
                            <div class="avatar">
                                A
                            </div>
                            <div class="bubble">
                                I'm good! How can I help you today?
                            </div>
                        </div>
                    </div>
                    <div class="composer">
                        <%--<textarea
                        rows="1"
                        placeholder="Type a message..."
                        aria-label="Message"
                        >Static chat UI. No input.</textarea>
                    <button aria-label="Send message">
                        ➤
                    </button>--%>
                        <asp:TextBox ID="txtMessageBox" runat="server" Style="width: 100%; padding: 8px; border-radius: 5px;" placeholder="Type a message..."></asp:TextBox>
                        <asp:Button ID="Submit" runat="server" Style="padding: 7px; border-radius: 5px; cursor: pointer;" Text="Send message" />
                    </div>
                </div>
            </main>
        </div>
    </body>
    </html>
</asp:Content>

