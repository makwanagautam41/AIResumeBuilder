<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ResumePlayGround.aspx.cs" Inherits="airesumebuilder.ResumePlayGround" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Resume Playground — AI Generated</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <style>
        /* ChatGPT Theme Variables - Exact Match */
        :root {
            --text-primary: #ffffff;
            --text-secondary: #c5c5d2;
            --surface-primary: #212121;
            --surface-secondary: #2f2f2f;
            --surface-tertiary: #171717;
            --border-light: #4e4f60;
            --border-medium: #565869;
            --accent-main: #19c37d;
            --accent-hover: #0fa968;
            --user-message-bg: #2f2f2f;
            --assistant-message-bg: #212121;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body, html {
            font-family: "Söhne", -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            font-size: 14px;
            line-height: 1.5;
            color: var(--text-primary);
            background-color: var(--surface-primary);
            height: 100%;
            overflow-x: hidden;
        }

        .page-wrapper {
            display: flex;
            height: 100vh;
            width: 100vw;
            background-color: var(--surface-primary);
        }

        /* Sidebar - Exact ChatGPT Styling */
        .sidebar {
            width: 260px;
            background-color: var(--surface-tertiary);
            display: flex;
            flex-direction: column;
            border-right: 1px solid var(--border-light);
            position: fixed;
            top: 0;
            left: 0;
            height: 100vh;
            z-index: 1000;
            transition: transform 0.3s ease-in-out;
            padding: 16px;
        }

        .sidebar-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 8px;
            margin-bottom: 16px;
        }

        .sidebar-title {
            font-size: 16px;
            font-weight: 600;
            color: var(--text-primary);
        }

        .new-chat-btn {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 8px;
            border: 1px solid var(--border-light);
            background-color: transparent;
            color: var(--text-primary);
            font-weight: 500;
            text-decoration: none;
            transition: all 0.1s ease;
            font-size: 14px;
        }

            .new-chat-btn:hover {
                background-color: var(--surface-secondary);
                color: var(--text-primary);
                text-decoration: none;
            }

        .sidebar-nav {
            flex-grow: 1;
            overflow-y: auto;
        }

            .sidebar-nav::-webkit-scrollbar {
                width: 8px;
            }

            .sidebar-nav::-webkit-scrollbar-track {
                background: transparent;
            }

            .sidebar-nav::-webkit-scrollbar-thumb {
                background: var(--border-light);
                border-radius: 4px;
            }

            .sidebar-nav a {
                display: flex;
                align-items: center;
                gap: 12px;
                padding: 12px 16px;
                margin-bottom: 8px;
                border-radius: 8px;
                color: var(--text-primary);
                text-decoration: none;
                font-weight: 500;
                transition: all 0.1s ease;
            }

                .sidebar-nav a:hover {
                    background-color: var(--surface-secondary);
                    color: var(--text-primary);
                }

                .sidebar-nav a.active {
                    background-color: var(--surface-secondary);
                    color: var(--text-primary);
                }

        .sidebar-footer {
            border-top: 1px solid var(--border-light);
            padding-top: 16px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .sidebar-footer-link {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 8px 12px;
            border-radius: 8px;
            text-decoration: none;
            color: var(--text-secondary);
            font-weight: 500;
            transition: all 0.1s ease;
        }

            .sidebar-footer-link:hover {
                background-color: var(--surface-secondary);
                color: var(--text-primary);
            }

        .theme-toggle {
            cursor: pointer;
            color: var(--text-secondary);
            transition: background-color 0.1s ease;
            padding: 8px;
            border-radius: 8px;
        }

            .theme-toggle:hover {
                background-color: var(--surface-secondary);
            }

        /* Main Content */
        .main-content {
            flex-grow: 1;
            margin-left: 260px;
            transition: margin-left 0.3s ease-in-out;
            width: calc(100% - 260px);
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 16px;
        }

        /* Hamburger Menu */
        .menu-toggle {
            display: none;
        }

        .hamburger-menu {
            display: none;
            cursor: pointer;
            width: 32px;
            height: 24px;
            position: relative;
            z-index: 1001;
        }

            .hamburger-menu span {
                display: block;
                position: absolute;
                height: 3px;
                width: 100%;
                background: var(--text-primary);
                border-radius: 3px;
                opacity: 1;
                left: 0;
                transform: rotate(0deg);
                transition: .25s ease-in-out;
            }

                .hamburger-menu span:nth-child(1) {
                    top: 0px;
                }

                .hamburger-menu span:nth-child(2), .hamburger-menu span:nth-child(3) {
                    top: 10px;
                }

                .hamburger-menu span:nth-child(4) {
                    top: 20px;
                }

        #menu-toggle:checked + .page-wrapper .hamburger-menu span:nth-child(1) {
            top: 10px;
            width: 0%;
            left: 50%;
        }

        #menu-toggle:checked + .page-wrapper .hamburger-menu span:nth-child(2) {
            transform: rotate(45deg);
        }

        #menu-toggle:checked + .page-wrapper .hamburger-menu span:nth-child(3) {
            transform: rotate(-45deg);
        }

        #menu-toggle:checked + .page-wrapper .hamburger-menu span:nth-child(4) {
            top: 10px;
            width: 0%;
            left: 50%;
        }

        /* Card */
        .card {
            background: var(--surface-secondary);
            border: 1px solid var(--border-light);
            border-radius: 16px;
            overflow: hidden;
        }

        /* Header */
        .hdr {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 20px 24px;
            border-bottom: 1px solid var(--border-light);
            background: var(--surface-tertiary);
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .badge {
            width: 44px;
            height: 44px;
            border-radius: 12px;
            display: grid;
            place-items: center;
            background: rgba(25, 195, 125, 0.1);
            color: var(--accent-main);
            font-size: 22px;
        }

        h1 {
            margin: 0;
            font-size: 18px;
            color: var(--text-primary);
            font-weight: 600;
        }

        .sub {
            margin: 2px 0 0;
            color: var(--text-secondary);
            font-size: 12px;
        }

        /* Tabs */
        .tabs {
            display: flex;
            gap: 10px;
            padding: 14px 16px;
            border-bottom: 1px solid var(--border-light);
            overflow: auto;
            background: var(--surface-secondary);
        }

        .tab {
            appearance: none;
            border: 1px solid var(--border-light);
            background: transparent;
            cursor: pointer;
            padding: 10px 14px;
            border-radius: 8px;
            font-weight: 500;
            color: var(--text-secondary);
            white-space: nowrap;
            transition: all 0.1s ease;
            text-decoration: none;
            font-size: 14px;
        }

            .tab:hover {
                color: var(--text-primary);
                background: var(--surface-primary);
            }

            .tab.active {
                color: var(--accent-main);
                background: rgba(25, 195, 125, 0.1);
                border-color: var(--accent-main);
            }

        /* Content */
        .content {
            padding: 20px;
            background: var(--surface-secondary);
        }

        .frameWrap {
            width: 100%;
            height: 800px;
            background: #fff;
            border: 1px solid var(--border-light);
            border-radius: 12px;
            overflow: hidden;
        }

        /* Actions */
        .actions {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
            justify-content: flex-end;
            padding: 16px 20px;
            border-top: 1px solid var(--border-light);
            background: var(--surface-tertiary);
        }

        /* Buttons */
        .btn {
            appearance: none;
            border: 1px solid var(--border-light);
            border-radius: 8px;
            padding: 10px 14px;
            font-weight: 500;
            font-size: 14px;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
            transition: all 0.1s ease;
            background: var(--surface-secondary);
            color: var(--text-primary);
        }

            .btn:hover {
                background: var(--surface-primary);
            }

            .btn.primary {
                background: var(--accent-main);
                color: white;
                border-color: var(--accent-main);
            }

                .btn.primary:hover {
                    background: var(--accent-hover);
                    border-color: var(--accent-hover);
                }

            .btn.neutral {
                background: var(--surface-primary);
                color: var(--text-primary);
                border-color: var(--border-medium);
            }

                .btn.neutral:hover {
                    background: var(--surface-tertiary);
                }

            .btn.ghost {
                background: transparent;
                color: var(--text-secondary);
                border-color: var(--border-light);
            }

                .btn.ghost:hover {
                    background: var(--surface-primary);
                    color: var(--text-primary);
                }

        /* Error */
        .error {
            margin: 16px;
            background: rgba(239, 68, 68, 0.1);
            border-left: 4px solid #ef4444;
            border-radius: 12px;
            border: 1px solid rgba(239, 68, 68, 0.3);
            padding: 20px 24px;
        }

            .error h3 {
                margin: 0 0 8px;
                color: #fca5a5;
                font-size: 16px;
                font-weight: 600;
            }

            .error p {
                color: var(--text-secondary);
                margin: 0;
            }

        /* Responsive */
        @media (max-width: 992px) {
            .sidebar {
                transform: translateX(-100%);
            }

            .main-content {
                margin-left: 0;
                width: 100%;
            }

            .hamburger-menu {
                display: block;
            }

            #menu-toggle:checked + .page-wrapper .sidebar {
                transform: translateX(0);
            }
        }

        @media(max-width:640px) {
            .container {
                padding: 0px;
            }

            .hdr {
                flex-direction: row;
                align-items: center;
            }

            .brand h1 {
                font-size: 16px;
            }

            .brand .sub {
                display: none;
            }

            .actions {
                justify-content: center;
            }

            .frameWrap {
                height: 600px;
            }
        }

        /* Icons using Unicode */
        .material-symbols-outlined {
            font-size: 20px;
        }

        .sidebar-header .img-div {
            display: flex;
            align-items: center;
        }

            .sidebar-header .img-div a {
                display: flex;
                align-items: center;
                gap: 8px;
                text-decoration: none;
                color: var(--text-primary);
                padding: 8px;
                border-radius: 8px;
                transition: background-color 0.1s ease;
            }

                .sidebar-header .img-div a:hover {
                    background-color: var(--surface-secondary);
                }

            .sidebar-header .img-div img {
                width: 20px;
                height: 20px;
                border-radius: 50%;
                object-fit: cover;
            }

            .sidebar-header .img-div span {
                font-size: 14px;
                font-weight: 500;
            }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <input type="checkbox" id="menu-toggle" class="menu-toggle" />
        <div class="page-wrapper">
            <aside class="sidebar">
                <div class="sidebar-header">
                    <div class="img-div">
                        <a href="Profile.aspx">
                            <img src="https://res.cloudinary.com/djbqtwzyf/image/upload/v1744042607/default_img_gszetk.png" alt="MyChat Logo" class="logo-img" />
                            <span>Profile</span>
                        </a>
                    </div>
                    <span class="logo-text">MyChat</span>
                </div>
                <a href="#" class="new-chat-btn"> + New Resume
                </a>
                <a href="Home.aspx" class="new-chat-btn"> + New Chat
                </a>

                <nav class="sidebar-nav">
                    <a href="#" class="active">
                        <span>💬</span>
                        Software Engineer Role
                    </a>
                    <a href="#">
                        <span>💬</span>
                        Marketing Manager CV
                    </a>
                </nav>

                <div class="sidebar-footer">
                    <a href="Pricing.aspx" class="sidebar-footer-link">Upgrade
                    </a>
                    <span class="theme-toggle">🌙</span>
                </div>
            </aside>

            <main class="main-content">
                <div class="container">
                    <div class="card">
                        <div class="hdr">
                            <div class="brand">
                                <div class="badge">📄</div>
                                <div>
                                    <h1>Resume Playground</h1>
                                    <p class="sub">Isolated preview of AI‑generated resume templates</p>
                                </div>
                            </div>
                            <label for="menu-toggle" class="hamburger-menu">
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                            </label>
                        </div>

                        <asp:PlaceHolder ID="phError" runat="server" Visible="false">
                            <div class="error">
                                <h3>There was a problem</h3>
                                <p>
                                    <asp:Literal ID="litError" runat="server" />
                                </p>
                                <div style="margin-top: 12px">
                                    <a class="btn ghost" href="ResumeBuilder.aspx">Go Back and Try Again</a>
                                </div>
                            </div>
                        </asp:PlaceHolder>

                        <asp:Panel ID="pnlContent" runat="server">
                            <div class="tabs">
                                <asp:LinkButton ID="lnkTab1" runat="server" CssClass="tab" OnClick="lnkTab_Click" CommandArgument="1">📘 Modern Professional</asp:LinkButton>
                                <asp:LinkButton ID="lnkTab2" runat="server" CssClass="tab" OnClick="lnkTab_Click" CommandArgument="2">🎨 Creative Design</asp:LinkButton>
                                <asp:LinkButton ID="lnkTab3" runat="server" CssClass="tab" OnClick="lnkTab_Click" CommandArgument="3">👔 Executive Classic</asp:LinkButton>
                            </div>

                            <div class="content">
                                <div class="frameWrap">
                                    <asp:Literal ID="litResumeFrame" runat="server" />
                                </div>
                            </div>

                            <div class="actions">
                                <asp:Button ID="btnDownload" runat="server" CssClass="btn primary" Text="💾 Download HTML" OnClick="btnDownload_Click" />
                                <asp:Button ID="btnPrint" runat="server" CssClass="btn neutral" Text="🖨️ Print" OnClick="btnPrint_Click" />
                            </div>
                        </asp:Panel>
                    </div>
                </div>
            </main>
        </div>
    </form>
</body>
</html>
