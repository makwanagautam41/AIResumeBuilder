<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ResumeBuilder.aspx.cs" Inherits="airesumebuilder.ResumeBuilder" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>AI Resume Builder</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <style>
        /* ChatGPT Theme Variables */
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

        .hidden-checkbox {
            display: none;
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
            transition: left 0.25s ease;
        }

        .sidebar-header {
            padding: 14px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            border-bottom: 1px solid var(--border-light);
        }

        .sidebar-title {
            font-size: 16px;
            font-weight: 600;
            color: var(--text-primary);
        }

        .user-icon {
            width: 20px;
            height: 20px;
            border-radius: 50%;
            background-color: var(--accent-main);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 12px;
            font-weight: 600;
        }

        /* New Chat Button */
        .new-chat-btn {
            margin: 8px 14px;
            padding: 10px 14px;
            background-color: transparent;
            border: 1px solid var(--border-light);
            border-radius: 8px;
            color: var(--text-primary);
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: all 0.1s ease;
            text-align: left;
            width: calc(100% - 28px);
            text-decoration: none;
        }

        .new-chat-btn:hover {
            background-color: var(--surface-secondary);
            color: var(--text-primary);
            text-decoration: none;
        }

        .new-chat-btn:before {
            content: "";
            width: 16px;
            height: 16px;
            background: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 24 24' stroke-width='2' stroke='%23ffffff'%3e%3cpath stroke-linecap='round' stroke-linejoin='round' d='M12 4.5v15m7.5-7.5h-15'/%3e%3c/svg%3e") no-repeat center;
            background-size: contain;
            flex-shrink: 0;
        }

        /* Chat List */
        .sidebar-nav {
            flex: 1;
            overflow-y: auto;
            padding: 8px 0;
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
            margin: 2px 14px;
            border: none;
            justify-content: flex-start;
            padding: 12px 14px;
            background-color: transparent;
            position: relative;
            color: var(--text-primary);
            text-decoration: none;
            border-radius: 8px;
            transition: all 0.1s ease;
        }

        .sidebar-nav a:hover {
            background-color: var(--surface-secondary);
        }

        .sidebar-nav a.active {
            background-color: var(--surface-secondary);
        }

        .sidebar-nav a:before {
            content: "";
            width: 16px;
            height: 16px;
            background: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 24 24' stroke-width='1.5' stroke='%23ffffff'%3e%3cpath stroke-linecap='round' stroke-linejoin='round' d='M8.625 12a.375.375 0 11-.75 0 .375.375 0 01.75 0zm0 0H8.25m4.125 0a.375.375 0 11-.75 0 .375.375 0 01.75 0zm0 0H12m4.125 0a.375.375 0 11-.75 0 .375.375 0 01.75 0zm0 0h-.375M21 12c0 4.556-4.03 8.25-9 8.25a9.764 9.764 0 01-2.555-.337A5.972 5.972 0 015.41 20.97a5.969 5.969 0 01-.474-.065 4.48 4.48 0 00.978-2.025c.09-.457-.133-.901-.467-1.226C3.93 16.178 3 14.189 3 12c0-4.556 4.03-8.25 9-8.25s9 3.694 9 8.25z'/%3e%3c/svg%3e") no-repeat center;
            background-size: contain;
            margin-right: 8px;
            flex-shrink: 0;
        }

        /* Sidebar Footer */
        .sidebar-footer {
            padding: 14px;
            border-top: 1px solid var(--border-light);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .sidebar-footer-link {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 8px;
            border-radius: 8px;
            text-decoration: none;
            color: var(--text-secondary);
            font-size: 14px;
            transition: background-color 0.1s ease;
        }

        .sidebar-footer-link:hover {
            background-color: var(--surface-secondary);
            color: var(--text-primary);
        }

        .theme-toggle {
            padding: 8px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            color: var(--text-secondary);
            transition: background-color 0.1s ease;
        }

        .theme-toggle:hover {
            background-color: var(--surface-secondary);
        }

        /* Mobile Navbar */
        .navbar {
            display: none;
            height: 60px;
            border-bottom: 1px solid var(--border-light);
            background-color: var(--surface-tertiary);
            align-items: center;
            padding: 0 16px;
            justify-content: space-between;
        }

        .navbar .hamburger {
            width: 24px;
            height: 24px;
            cursor: pointer;
            background: none;
            border: none;
            padding: 0;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .navbar .hamburger span {
            display: block;
            position: absolute;
            height: 3px;
            width: 20px;
            background: var(--text-primary);
            border-radius: 3px;
            opacity: 1;
            left: 0;
            transform: rotate(0deg);
            transition: .25s ease-in-out;
        }

        .navbar .hamburger span:nth-child(1) {
            top: 0px;
        }

        .navbar .hamburger span:nth-child(2), .navbar .hamburger span:nth-child(3) {
            top: 8px;
        }

        .navbar .hamburger span:nth-child(4) {
            top: 16px;
        }

        .navbar span.title {
            font-size: 16px;
            font-weight: 600;
            color: var(--text-primary);
        }

        /* Main Content */
        .main-content {
            flex: 1;
            margin-left: 260px;
            display: flex;
            flex-direction: column;
            background-color: var(--surface-primary);
            min-height: 100vh;
            transition: margin-left 0.25s ease;
        }

        .container {
            max-width: 768px;
            margin: 0 auto;
            padding: 32px 20px;
            width: 100%;
        }

        /* Header */
        .header {
            text-align: center;
            margin-bottom: 48px;
            padding: 32px 0;
        }

        .header h1 {
            font-size: 28px;
            font-weight: 400;
            color: var(--text-primary);
            margin-bottom: 16px;
        }

        .header .sub {
            color: var(--text-secondary);
            font-size: 16px;
            line-height: 1.6;
        }

        /* Form Sections */
        .form-section {
            background: transparent;
        }

        .form-group {
            margin-bottom: 32px;
        }

        .section-title {
            font-size: 18px;
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .section-title::before {
            content: "";
            width: 3px;
            height: 16px;
            background: var(--accent-main);
            border-radius: 2px;
        }

        .muted {
            color: var(--text-secondary);
            font-size: 14px;
            margin-bottom: 20px;
            line-height: 1.5;
        }

        /* Grid Layout */
        .grid {
            display: grid;
            gap: 20px;
        }

        .grid-1 {
            grid-template-columns: 1fr;
        }

        .grid-2 {
            grid-template-columns: 1fr;
        }

        @media (min-width: 640px) {
            .grid-2 {
                grid-template-columns: 1fr 1fr;
            }
        }

        /* Form Fields */
        .field {
            display: flex;
            flex-direction: column;
        }

        .field label {
            display: block;
            font-weight: 500;
            font-size: 14px;
            color: var(--text-primary);
            margin-bottom: 8px;
            line-height: 1.4;
        }

        .input, .textarea {
            width: 100%;
            border: 1px solid var(--border-medium);
            border-radius: 8px;
            padding: 12px 16px;
            font-size: 16px;
            outline: none;
            transition: all 0.1s ease;
            background: var(--surface-secondary);
            font-family: inherit;
            color: var(--text-primary);
        }

        .input:focus, .textarea:focus {
            border-color: var(--accent-main);
            box-shadow: 0 0 0 1px var(--accent-main);
        }

        .input::placeholder, .textarea::placeholder {
            color: var(--text-secondary);
        }

        .textarea {
            min-height: 100px;
            resize: vertical;
        }

        /* Buttons */
        .btn {
            appearance: none;
            border: 1px solid var(--border-medium);
            cursor: pointer;
            border-radius: 8px;
            padding: 12px 20px;
            font-weight: 500;
            font-size: 14px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            transition: all 0.1s ease;
            text-decoration: none;
            font-family: inherit;
            min-height: 44px;
            background: var(--surface-secondary);
            color: var(--text-primary);
        }

        .btn:hover {
            background: var(--surface-primary);
        }

        .btn-primary {
            background: var(--accent-main);
            color: white;
            border-color: var(--accent-main);
        }

        .btn-primary:hover {
            background: var(--accent-hover);
            border-color: var(--accent-hover);
        }

        .actions {
            display: flex;
            gap: 16px;
            flex-wrap: wrap;
            padding: 32px 0;
            justify-content: center;
        }

        /* Loading State */
        .loading {
            display: none;
            padding: 60px 20px;
            text-align: center;
        }

        .spinner {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            border: 3px solid var(--border-light);
            border-top-color: var(--accent-main);
            animation: spin 1s linear infinite;
            margin: 16px auto;
        }

        @keyframes spin {
            to {
                transform: rotate(360deg);
            }
        }

        .loading-text {
            font-weight: 500;
            color: var(--text-primary);
            font-size: 16px;
            margin-bottom: 8px;
        }

        .loading-subtext {
            color: var(--text-secondary);
            font-size: 14px;
        }

        /* Error State */
        .error {
            margin: 24px 0;
            padding: 16px 20px;
            background: rgba(239, 68, 68, 0.1);
            border: 1px solid rgba(239, 68, 68, 0.3);
            border-left: 4px solid #ef4444;
            border-radius: 8px;
            color: #fca5a5;
        }

        /* Mobile Responsive */
        @media (max-width: 768px) {
            .navbar {
                display: flex;
            }

            .sidebar {
                left: -260px;
            }

            #menu-toggle:checked ~ .page-wrapper .sidebar {
                left: 0;
            }

            .main-content {
                margin-left: 0;
                width: 100%;
            }

            .container {
                padding: 20px 16px;
            }

            .header {
                padding: 20px 0;
                margin-bottom: 32px;
            }

            .header h1 {
                font-size: 24px;
            }

            .actions {
                flex-direction: column;
            }

            .btn {
                width: 100%;
            }
        }

        .overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100vw;
            height: 100vh;
            background-color: rgba(0, 0, 0, 0.6);
            z-index: 500;
            display: none;
        }

        #menu-toggle:checked ~ .page-wrapper .overlay {
            display: block;
        }

        @media (min-width: 769px) {
            .overlay {
                display: none !important;
            }
            .navbar {
                display: none !important;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <input type="checkbox" id="menu-toggle" class="hidden-checkbox" />
        <div class="page-wrapper">
            <!-- Mobile Navbar -->
            <nav class="navbar">
                <label for="menu-toggle" class="hamburger">
                    <span></span>
                    <span></span>
                    <span></span>
                    <span></span>
                </label>
                <span class="title">AI Resume Builder</span>
                <div></div>
            </nav>

            <!-- Overlay for Mobile -->
            <div class="overlay" onclick="document.getElementById('menu-toggle').checked = false;"></div>

            <!-- Sidebar -->
            <aside class="sidebar">
                <div class="sidebar-header">
                    <span class="sidebar-title">My Resumes</span>
                    <div class="user-icon">U</div>
                </div>

                <a href="#" class="new-chat-btn">
                    New Resume
                </a>
                <a href="Home.aspx" class="new-chat-btn">
                    New Chat
                </a>

                <nav class="sidebar-nav">
                    <a href="#" class="active">
                        Software Engineer Role
                    </a>
                    <a href="#">
                        Marketing Manager CV
                    </a>
                </nav>

                <div class="sidebar-footer">
                    <a href="#" class="sidebar-footer-link">
                        <span>⭐</span>
                        Upgrade
                    </a>
                    <span class="theme-toggle">🌙</span>
                </div>
            </aside>

            <!-- Main Content -->
            <main class="main-content">
                <div class="container">
                    <div class="header">
                        <h1>AI Resume Builder</h1>
                        <p class="sub">Enter your details and let AI create a professional resume for you.</p>
                    </div>

                    <div id="resumeFormContainer">
                        <div class="form-section">
                            <div class="form-group">
                                <div class="grid grid-1">
                                    <div class="field">
                                        <label for="txtFullName">Full Name *</label>
                                        <asp:TextBox ID="txtFullName" runat="server" CssClass="input" placeholder="Enter your full name" />
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="grid grid-2">
                                    <div class="field">
                                        <label for="txtEmail">Email Address *</label>
                                        <asp:TextBox ID="txtEmail" runat="server" CssClass="input" TextMode="Email" placeholder="your.email@example.com" />
                                    </div>
                                    <div class="field">
                                        <label for="txtPhone">Phone Number *</label>
                                        <asp:TextBox ID="txtPhone" runat="server" CssClass="input" placeholder="+1 (555) 123-4567" />
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="grid grid-1">
                                    <div class="field">
                                        <label for="txtLocation">Location</label>
                                        <asp:TextBox ID="txtLocation" runat="server" CssClass="input" placeholder="City, State, Country" />
                                    </div>
                                </div>
                            </div>

                            <!-- Professional Summary -->
                            <div class="form-group">
                                <h3 class="section-title">Professional Summary</h3>
                                <p class="muted">Write a brief overview of your experience, key strengths, and career objectives.</p>
                                <div class="grid grid-1">
                                    <div class="field">
                                        <label for="txtSummary">Summary *</label>
                                        <asp:TextBox ID="txtSummary" runat="server" CssClass="textarea" TextMode="MultiLine"
                                            placeholder="Experienced professional with expertise in... Proven track record of... Seeking opportunities to..." />
                                    </div>
                                </div>
                            </div>

                            <!-- Work Experience -->
                            <div class="form-group">
                                <h3 class="section-title">Work Experience</h3>
                                <p class="muted">Add your most recent work experience to help AI generate relevant content.</p>
                                <div class="grid grid-2">
                                    <div class="field">
                                        <label for="txtJobTitle">Job Title *</label>
                                        <asp:TextBox ID="txtJobTitle" runat="server" CssClass="input" placeholder="Senior Software Engineer" />
                                    </div>
                                    <div class="field">
                                        <label for="txtCompany">Company *</label>
                                        <asp:TextBox ID="txtCompany" runat="server" CssClass="input" placeholder="Tech Solutions Inc." />
                                    </div>
                                </div>
                                <div class="grid grid-2">
                                    <div class="field">
                                        <label for="txtDuration">Employment Duration *</label>
                                        <asp:TextBox ID="txtDuration" runat="server" CssClass="input" placeholder="January 2023 - Present" />
                                    </div>
                                    <div class="field">
                                        <label for="txtJobDescription">Key Responsibilities</label>
                                        <asp:TextBox ID="txtJobDescription" runat="server" CssClass="input"
                                            placeholder="Led team of 5 developers, implemented new features..." />
                                    </div>
                                </div>
                            </div>

                            <!-- Education -->
                            <div class="form-group">
                                <h3 class="section-title">Education</h3>
                                <p class="muted">Include your highest level of education or most relevant degree.</p>
                                <div class="grid grid-2">
                                    <div class="field">
                                        <label for="txtDegree">Degree *</label>
                                        <asp:TextBox ID="txtDegree" runat="server" CssClass="input" placeholder="Bachelor of Science in Computer Science" />
                                    </div>
                                    <div class="field">
                                        <label for="txtInstitution">Institution *</label>
                                        <asp:TextBox ID="txtInstitution" runat="server" CssClass="input" placeholder="University of Technology" />
                                    </div>
                                </div>
                                <div class="grid grid-2">
                                    <div class="field">
                                        <label for="txtGradYear">Graduation Year *</label>
                                        <asp:TextBox ID="txtGradYear" runat="server" CssClass="input" placeholder="2022" />
                                    </div>
                                    <div class="field">
                                        <label for="txtGPA">GPA / Grade</label>
                                        <asp:TextBox ID="txtGPA" runat="server" CssClass="input" placeholder="3.8 GPA" />
                                    </div>
                                </div>
                            </div>

                            <!-- Skills -->
                            <div class="form-group">
                                <h3 class="section-title">Skills</h3>
                                <p class="muted">List your key skills separated by commas. Include both technical and soft skills.</p>
                                <div class="grid grid-2">
                                    <div class="field">
                                        <label for="txtTechnicalSkills">Technical Skills *</label>
                                        <asp:TextBox ID="txtTechnicalSkills" runat="server" CssClass="input"
                                            placeholder="JavaScript, Python, React, Node.js, AWS, SQL" />
                                    </div>
                                    <div class="field">
                                        <label for="txtSoftSkills">Soft Skills</label>
                                        <asp:TextBox ID="txtSoftSkills" runat="server" CssClass="input"
                                            placeholder="Leadership, Communication, Problem Solving, Team Collaboration" />
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="actions">
                            <asp:Button ID="btnGenerate" runat="server" CssClass="btn btn-primary" Text="Generate AI Resumes" OnClick="btnGenerate_Click" />
                            <asp:Button ID="btnReset" runat="server" CssClass="btn" Text="Reset Form" OnClientClick="this.form.reset(); return false;" />
                        </div>
                    </div>

                    <div id="loadingContainer" class="loading">
                        <div class="loading-text">Generating your resumes with AI...</div>
                        <div class="spinner"></div>
                        <div class="loading-subtext">This may take 30-60 seconds. Please wait.</div>
                    </div>

                    <asp:Panel ID="pnlError" runat="server" Visible="false">
                        <div class="error">
                            <asp:Literal ID="litError" runat="server" />
                        </div>
                    </asp:Panel>
                </div>
            </main>
        </div>
    </form>
</body>
</html>