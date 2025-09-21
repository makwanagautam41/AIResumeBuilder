<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ResumePlayGround.aspx.cs" Inherits="airesumebuilder.ResumePlayGround" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Resume Playground — AI Generated</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet" />
    <style>
        :root {
            /* Variables from original file */
            --bg: #f6f7fb;
            --surface: #ffffff;
            --border: #e5e7eb;
            --muted: #6b7280;
            --text: #0f172a;
            --primary: #4f46e5;
            --success: #10b981;
            /* Variables for sidebar */
            --indigo-600: #4f46e5;
            --indigo-700: #4338ca;
            --indigo-50: #eef2ff;
             --gray-50: #f8fafc;
            --gray-100: #f1f5f9;
            --gray-200: #e2e8f0;
            --gray-300: #cbd5e1;
            --gray-700: #334155;
            --gray-800: #1e293b;
            --gray-900: #0f172a;
            --white: #ffffff;
            --border-radius: 12px;
            --sidebar-width: 260px;
        }

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            background-color: var(--bg);
            font-family: -apple-system,BlinkMacSystemFont,"Segoe UI",Roboto,sans-serif;
            color: var(--text);
        }

        .page-wrapper {
            display: flex;
        }

        /* --- Sidebar Styles (from ResumeBuilder.aspx) --- */
        .sidebar {
            width: var(--sidebar-width);
            height: 100vh;
            background-color: var(--gray-50);
            border-right: 1px solid var(--gray-200);
            color: var(--gray-800);
            position: fixed;
            top: 0;
            left: 0;
            display: flex;
            flex-direction: column;
            padding: 16px;
            transition: transform 0.3s ease-in-out;
            z-index: 1000;
        }

        .sidebar-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 8px;
            margin-bottom: 16px;
        }

        .sidebar-title {
            font-weight: 700;
            font-size: 20px;
            color: var(--gray-900);
        }

        .new-chat-btn {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border-radius: var(--border-radius);
            border: 1px solid var(--gray-300);
            background-color: transparent;
            color: var(--gray-700);
            font-weight: 600;
            text-decoration: none;
            transition: all 0.2s ease;
        }

            .new-chat-btn:hover {
                border-color: var(--gray-400);
                background-color: var(--gray-100);
            }

        .sidebar-nav {
            flex-grow: 1;
            overflow-y: auto;
        }

            .sidebar-nav a {
                display: flex;
                align-items: center;
                gap: 12px;
                padding: 12px 16px;
                margin-bottom: 8px;
                border-radius: var(--border-radius);
                color: var(--gray-600);
                text-decoration: none;
                font-weight: 500;
                transition: background-color 0.2s ease, color 0.2s ease;
            }

                .sidebar-nav a:hover {
                    background-color: var(--gray-200);
                    color: var(--gray-800);
                }

                .sidebar-nav a.active {
                    background-color: var(--gray-800);
                    color: var(--white);
                }

                    .sidebar-nav a.active:hover {
                        background-color: var(--gray-900);
                    }

        .sidebar-footer {
            border-top: 1px solid var(--gray-200);
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
            color: var(--gray-600);
            font-weight: 500;
            transition: background-color 0.2s ease, color 0.2s ease;
        }

            .sidebar-footer-link:hover {
                background-color: var(--gray-200);
                color: var(--gray-800);
            }

        .theme-toggle {
            cursor: pointer;
        }

        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24
        }

        /* --- Main Content & Layout Styles --- */
        .main-content {
            flex-grow: 1;
            margin-left: var(--sidebar-width);
            transition: margin-left 0.3s ease-in-out;
            width: calc(100% - var(--sidebar-width));
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 16px;
        }

        /* --- Hamburger Menu & Responsive Toggle --- */
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
                background: var(--text);
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

        /* --- Original Component Styles --- */
        .card {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: 16px;
            box-shadow: 0 4px 16px rgba(15,23,42,.06);
            overflow: hidden;
        }

        .hdr {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 20px 24px;
            border-bottom: 1px solid var(--border);
            background: linear-gradient(180deg,#fff 0%,#fafbff 100%);
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
            background: #eef2ff;
            color: #4f46e5;
            font-size: 22px;
            box-shadow: inset 0 0 0 1px rgba(79,70,229,.15);
        }

        h1 {
            margin: 0;
            font-size: 18px;
        }

        .sub {
            margin: 2px 0 0;
            color: var(--muted);
            font-size: 12px;
        }

        .tabs {
            display: flex;
            gap: 10px;
            padding: 14px 16px;
            border-bottom: 1px solid var(--border);
            overflow: auto;
        }

        .tab {
            appearance: none;
            border: 1px solid transparent;
            background: transparent;
            cursor: pointer;
            padding: 10px 14px;
            border-radius: 10px;
            font-weight: 700;
            color: #64748b;
            white-space: nowrap;
            transition: all .2s;
        }

            .tab:hover {
                color: #4f46e5;
            }

            .tab.active {
                color: #4f46e5;
                background: #eef2ff;
                border-color: #e0e7ff;
            }

        .content {
            padding: 20px;
        }

        .frameWrap {
            width: 100%;
            height: 800px;
            background: #fff;
            border: 1px solid var(--border);
            border-radius: 12px;
            overflow: hidden;
        }

        .actions {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
            justify-content: flex-end;
            padding: 16px 20px;
            border-top: 1px solid var(--border);
            background: #fafbff;
        }

        .btn {
            appearance: none;
            border: 1px solid transparent;
            border-radius: 10px;
            padding: 10px 14px;
            font-weight: 700;
            font-size: 14px;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
        }

            .btn.primary {
                background: linear-gradient(90deg,var(--success),#0ea37a);
                color: #fff;
            }

            .btn.neutral {
                background: #6b7280;
                color: #fff;
            }

            .btn.ghost {
                background: #f3f4f6;
                color: #111827;
                border-color: #e5e7eb;
            }

        .error {
            margin: 16px;
            background: #fff0f0;
            border-left: 4px solid #dc2626;
            border-radius: 12px;
            border: 1px solid #fee2e2;
            padding: 20px 24px;
        }

            .error h3 {
                margin: 0 0 8px;
                color: #dc2626;
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
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <input type="checkbox" id="menu-toggle" class="menu-toggle" />
        <div class="page-wrapper">
            <aside class="sidebar">
                <div class="sidebar-header">
                    <span class="sidebar-title">My Resumes</span>
                    <span class="material-symbols-outlined">account_circle</span>
                </div>

                <a href="#" class="new-chat-btn">
                    <span class="material-symbols-outlined">add</span>
                    New Resume
                </a>
                <a href="Home.aspx" class="new-chat-btn">
                    <span class="material-symbols-outlined">add</span>
                    New Chat
                </a>

                <nav class="sidebar-nav">
                    <a href="#" class="active">
                        <span class="material-symbols-outlined">chat_bubble</span>
                        Software Engineer Role
                    </a>
                    <a href="#">
                        <span class="material-symbols-outlined">chat_bubble</span>
                        Marketing Manager CV
                    </a>
                </nav>

                <div class="sidebar-footer">
                    <a href="#" class="sidebar-footer-link">
                        <span class="material-symbols-outlined">workspace_premium</span>
                        Upgrade
                    </a>
                    <span class="material-symbols-outlined theme-toggle">light_mode</span>
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
