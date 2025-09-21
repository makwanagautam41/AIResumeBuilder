<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ResumeBuilder.aspx.cs" Inherits="airesumebuilder.ResumeBuilder" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>AI Resume Builder</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet" />
    <style>
        :root {
            --indigo-600: #4f46e5;
            --indigo-700: #4338ca;
            --indigo-50: #eef2ff;
            --gray-50: #f8fafc;
            --gray-100: #f1f5f9;
            --gray-200: #e2e8f0;
            --gray-300: #cbd5e1;
            --gray-400: #94a3b8;
            --gray-500: #64748b;
            --gray-600: #475569;
            --gray-700: #334155;
            --gray-800: #1e293b;
            --gray-900: #0f172a;
            --white: #ffffff;
            --border-radius: 12px;
            --border-radius-lg: 16px;
            --shadow-sm: 0 1px 2px 0 rgb(0 0 0 / 0.05);
            --shadow-md: 0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1);
            --shadow-lg: 0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1);
            --sidebar-width: 260px;
        }

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            background-color: var(--gray-100); /* Slightly darker background for contrast */
            color: var(--gray-900);
            line-height: 1.6;
        }

        .page-wrapper {
            display: flex;
        }

        /* --- Sidebar Styles (Light Theme Redesign) --- */
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


        /* --- Main Content & Form Styles --- */
        .main-content {
            flex-grow: 1;
            margin-left: var(--sidebar-width);
            transition: margin-left 0.3s ease-in-out;
            width: calc(100% - var(--sidebar-width));
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 24px;
        }

        .card {
            background: var(--white);
            border: 1px solid var(--gray-200);
            border-radius: var(--border-radius-lg);
            box-shadow: var(--shadow-lg);
            overflow: hidden;
        }

        .header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 16px;
            padding: 24px;
            border-bottom: 1px solid var(--gray-200);
            background: linear-gradient(135deg, var(--white) 0%, var(--gray-50) 100%);
        }

        .header-main {
            display: flex;
            align-items: flex-start;
            gap: 16px;
        }

        .header-icon {
            background: var(--indigo-50);
            color: var(--indigo-600);
            width: 48px;
            height: 48px;
            border-radius: var(--border-radius);
            display: grid;
            place-items: center;
            font-size: 24px;
            flex-shrink: 0;
            box-shadow: var(--shadow-sm);
        }

        .header-content h1 {
            font-size: 28px;
            font-weight: 700;
            margin: 0 0 4px 0;
            color: var(--gray-900);
        }

        .sub {
            color: var(--gray-600);
            margin: 0;
            font-size: 16px;
        }

        /* --- Hamburger Menu & Responsive Toggle --- */
        .menu-toggle {
            display: none; /* Hide the checkbox */
        }

        .hamburger-menu {
            display: none; /* Hidden by default on large screens */
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
                background: var(--gray-800);
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


        /* --- Existing Responsive Styles & Other Tweaks --- */
        @media (max-width: 768px) {
            .container {
                padding: 16px;
            }

            .header-content h1 {
                font-size: 24px;
            }

            .form-section {
                padding: 24px;
            }

            .actions {
                padding: 20px 24px;
            }
        }

        @media (max-width: 640px) {
            .container {
                padding: 0;
            }

            .header {
                padding: 20px;
                gap: 12px;
            }

            .header-icon {
                width: 40px;
                height: 40px;
                font-size: 20px;
            }

            .header-content h1 {
                font-size: 20px;
            }

            .sub {
                font-size: 14px;
            }

            .form-section {
                padding: 20px;
            }
        }

        /* --- Original form component styles (mostly unchanged) --- */
        .form-section {
            padding: 16px;
        }

        .grid {
            display: grid;
            gap: 24px;
            margin-bottom: 32px;
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
                gap: 20px;
            }
        }

        .field {
            display: flex;
            flex-direction: column;
        }

            .field label {
                display: block;
                font-weight: 600;
                font-size: 14px;
                color: var(--gray-700);
                margin-bottom: 8px;
                line-height: 1.4;
            }

        .input, .textarea {
            width: 100%;
            border: 1px solid var(--gray-300);
            border-radius: var(--border-radius);
            padding: 14px 16px;
            font-size: 16px;
            outline: none;
            transition: all 0.2s ease;
            background: var(--white);
            font-family: inherit;
            color: var(--gray-900);
        }

            .input:focus, .textarea:focus {
                border-color: var(--indigo-600);
                box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.1);
            }

        .textarea {
            min-height: 120px;
            resize: vertical;
        }

        .section-title {
            font-size: 20px;
            font-weight: 700;
            margin: 0 0 8px 0;
            color: var(--gray-900);
            display: flex;
            align-items: center;
            gap: 8px;
        }

            .section-title::before {
                content: "";
                width: 4px;
                height: 20px;
                background: linear-gradient(135deg, var(--indigo-600), var(--indigo-700));
                border-radius: 2px;
            }

        .muted {
            color: var(--gray-500);
            font-size: 14px;
            margin: 0 0 20px 0;
        }

        .btn {
            appearance: none;
            border: 0;
            cursor: pointer;
            border-radius: var(--border-radius);
            padding: 14px 24px;
            font-weight: 600;
            font-size: 16px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            transition: all 0.2s ease;
            text-decoration: none;
            font-family: inherit;
            min-height: 48px;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--indigo-600), var(--indigo-700));
            color: var(--white);
            box-shadow: var(--shadow-md);
        }

            .btn-primary:hover {
                transform: translateY(-1px);
                box-shadow: var(--shadow-lg);
            }

        .btn-secondary {
            background: var(--gray-100);
            color: var(--gray-700);
            border: 1px solid var(--gray-300);
        }

            .btn-secondary:hover {
                background: var(--gray-200);
            }

        .actions {
            display: flex;
            gap: 16px;
            flex-wrap: wrap;
            padding: 24px 32px;
            border-top: 1px solid var(--gray-200);
            background: var(--gray-50);
        }

        .loading {
            display: none;
            padding: 60px 32px;
            text-align: center;
        }

        .spinner {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            border: 3px solid var(--gray-200);
            border-top-color: var(--indigo-600);
            animation: spin 1s linear infinite;
            margin: 16px auto;
        }

        @keyframes spin {
            to {
                transform: rotate(360deg);
            }
        }

        .loading-text {
            font-weight: 600;
            color: var(--gray-700);
            font-size: 18px;
            margin-bottom: 8px;
        }

        .loading-subtext {
            color: var(--gray-500);
            font-size: 14px;
        }

        .error {
            margin: 24px 32px;
            padding: 16px 20px;
            background: #fef2f2;
            border: 1px solid #fecaca;
            border-left: 4px solid #ef4444;
            border-radius: var(--border-radius);
            color: #991b1b;
        }

        .form-group {
            margin-bottom: 40px;
        }

            .form-group:last-child {
                margin-bottom: 0;
            }

        .field:focus-within label {
            color: var(--indigo-600);
        }

        @media (max-width: 640px) {
            .actions {
                padding: 20px;
                flex-direction: column;
            }

                .actions .btn {
                    width: 100%;
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
                        <div class="header">
                            <div class="header-main">
                                <div class="header-icon">📄</div>
                                <div class="header-content">
                                    <h1>AI Resume Builder</h1>
                                    <p class="sub">Enter your details and let AI create a professional resume for you.</p>
                                </div>
                            </div>
                            <label for="menu-toggle" class="hamburger-menu">
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                            </label>
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
                                <asp:Button ID="btnGenerate" runat="server" CssClass="btn btn-primary" Text="✨ Generate AI Resumes" OnClick="btnGenerate_Click" />
                                <asp:Button ID="btnReset" runat="server" CssClass="btn btn-secondary" Text="🔄 Reset Form" OnClientClick="this.form.reset(); return false;" />
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
                </div>
            </main>
        </div>
    </form>
</body>
</html>
