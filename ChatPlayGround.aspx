<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="ChatPlayGround.aspx.cs" Inherits="airesumebuilder.ChatPlayGround" Async="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="css/style.css" />
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">

    <input type="checkbox" id="sidebar-toggle" class="hidden-checkbox" />
    <input type="checkbox" id="theme-toggle-checkbox" class="hidden-checkbox" />

    <div class="container">
        <!-- Sidebar -->
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
            <asp:Button ID="Button1" runat="server" Text="+ New Chat" class="new-chat-btn" OnClick="Button1_Click" />
            <div class="chat-list">
                <asp:Repeater ID="ChatRepeater" runat="server" OnItemCommand="ChatRepeater_ItemCommand">
                    <ItemTemplate>
                        <div style="display: flex; justify-content: center; align-items: center; gap: 12px; margin-bottom: 4px;">
                            <p style="margin: 0;">
                                <a href='<%# "ChatPlayGround.aspx?chatid=" + Eval("ChatId") %>'>
                                    <%# Eval("Title") %>
                                </a>
                            </p>
                            <asp:Button ID="DeleteBtn" runat="server"
                                Style="padding: 4px; border-radius: 5px; height: 30px; cursor: pointer;"
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

        <!-- Overlay for small screens -->
        <label for="sidebar-toggle" class="overlay"></label>

        <!-- Main chat area -->
        <main class="main">
            <header class="navbar" aria-label="Navigation">
                <label for="sidebar-toggle" class="hamburger" aria-label="Show sidebar">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                            d="M4 6h16M4 12h16M4 18h16" />
                    </svg>
                </label>
                <span>Chat Playground</span>
            </header>

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
        </main>
    </div>

</asp:Content>
