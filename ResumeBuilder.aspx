<!--3. ResumeBuilder.aspx-->

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ResumeBuilder.aspx.cs" Inherits="airesumebuilder.ResumeBuilder" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Resume Builder - AI Resume Builder</title>
    <link rel="stylesheet" href="css/style.css" />
    <link rel="stylesheet" href="css/resume-style.css" />
</head>
<body>
    <form id="form1" runat="server">

        <input type="checkbox" id="sidebar-toggle" class="hidden-checkbox" />
        <input type="checkbox" id="theme-toggle-checkbox" class="hidden-checkbox" />

        <div class="container">
            <!-- Sidebar -->
            <aside class="sidebar" aria-label="Sidebar">
                <div class="sidebar-header">
                    <div class="img-div">
                        <a href="../Profile.aspx">
                            <img src="https://res.cloudinary.com/djbqtwzyf/image/upload/v1744042607/default_img_gszetk.png" alt="Profile" class="logo-img" />
                            <span>Profile</span>
                        </a>
                    </div>
                    <span class="logo-text">Resume Builder</span>
                </div>

                <div class="nav-buttons">
                    <a href="ChatPlayGround.aspx" class="new-chat-btn nav-btn">💬 Chat Interface</a>
                    <a href="ResumeBuilder.aspx" class="new-chat-btn nav-btn">📄 Resume Builder</a>
                </div>

                <div class="chat-list">
                    <div class="resume-history-header">
                    </div>
                    <%--<asp:Repeater ID="ResumeRepeater" runat="server" OnItemCommand="ResumeRepeater_ItemCommand">
                        <ItemTemplate>
                            <div class="resume-history-item">
                                <div class="resume-item-content">
                                    <div class="resume-title">
                                        <a style="text-decoration:none; color:white;" href='<%# "ResumeBuilder.aspx?resumeid=" + Eval("ResumeId") %>'>
                                            <span class="resume-icon">📄</span>
                                            <%# Eval("Title") %>
                                        </a>
                                    </div>
                                    <div class="resume-date"><%# Eval("CreatedDate", "{0:MMM dd}") %></div>
                                </div>
                                <asp:Button ID="DeleteResumeBtn" runat="server"
                                    Style="padding: 4px 8px; background-color:#dc3545; color:white; border-radius: 4px; font-size: 12px; cursor: pointer; border: none;"
                                    Text="×" CommandName="DeleteResume" CommandArgument='<%# Eval("ResumeId") %>' />
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>--%>
                </div>

                <div class="sidebar-footer">
                    <span>Upgrade</span>
                    <label for="theme-toggle-checkbox" class="theme-toggle" title="Toggle theme">
                        🌙</label>
                </div>
            </aside>

            <!-- Overlay for small screens -->
            <label for="sidebar-toggle" class="overlay"></label>

            <!-- Main resume area -->
            <main class="main">
                <header class="navbar" aria-label="Navigation">
                    <label for="sidebar-toggle" class="hamburger" aria-label="Show sidebar">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M4 6h16M4 12h16M4 18h16" />
                        </svg>
                    </label>
                    <span>Resume Builder</span>
                </header>

                <!-- Resume Content -->
                <div class="main-content">
                    <!-- Resume Form -->
                    <div class="resume-form-container" id="resumeFormContainer" runat="server">
                        <div class="form-header">
                            <h2>Create Your Professional Resume</h2>
                            <p>Fill in your details and let AI create amazing resume templates for you</p>
                        </div>

                        <div class="resume-form">
                            <!-- Personal Information Section -->
                            <div class="form-section">
                                <h3>Personal Information</h3>
                                <div class="form-row">
                                    <div class="form-group">
                                        <label>Full Name *</label>
                                        <asp:TextBox ID="txtFullName" runat="server" placeholder="Enter your full name" CssClass="form-input" required></asp:TextBox>
                                    </div>
                                    <div class="form-group">
                                        <label>Email *</label>
                                        <asp:TextBox ID="txtEmail" runat="server" placeholder="your.email@example.com" CssClass="form-input" TextMode="Email" required></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group">
                                        <label>Phone Number *</label>
                                        <asp:TextBox ID="txtPhone" runat="server" placeholder="+1 (555) 123-4567" CssClass="form-input" required></asp:TextBox>
                                    </div>
                                    <div class="form-group">
                                        <label>Location</label>
                                        <asp:TextBox ID="txtLocation" runat="server" placeholder="City, State" CssClass="form-input"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label>Professional Summary</label>
                                    <asp:TextBox ID="txtSummary" runat="server" placeholder="Brief overview of your professional background..." CssClass="form-textarea" TextMode="MultiLine" Rows="3"></asp:TextBox>
                                </div>
                            </div>

                            <!-- Experience Section -->
                            <div class="form-section">
                                <h3>Work Experience</h3>
                                <div class="form-group">
                                    <label>Job Title *</label>
                                    <asp:TextBox ID="txtJobTitle" runat="server" placeholder="e.g., Software Developer" CssClass="form-input" required></asp:TextBox>
                                </div>
                                <div class="form-row">
                                    <div class="form-group">
                                        <label>Company Name *</label>
                                        <asp:TextBox ID="txtCompany" runat="server" placeholder="Company name" CssClass="form-input" required></asp:TextBox>
                                    </div>
                                    <div class="form-group">
                                        <label>Duration</label>
                                        <asp:TextBox ID="txtDuration" runat="server" placeholder="Jan 2020 - Present" CssClass="form-input"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label>Job Description</label>
                                    <asp:TextBox ID="txtJobDescription" runat="server" placeholder="Describe your key responsibilities and achievements..." CssClass="form-textarea" TextMode="MultiLine" Rows="4"></asp:TextBox>
                                </div>
                            </div>

                            <!-- Education Section -->
                            <div class="form-section">
                                <h3>Education</h3>
                                <div class="form-row">
                                    <div class="form-group">
                                        <label>Degree *</label>
                                        <asp:TextBox ID="txtDegree" runat="server" placeholder="e.g., Bachelor of Computer Science" CssClass="form-input" required></asp:TextBox>
                                    </div>
                                    <div class="form-group">
                                        <label>Institution *</label>
                                        <asp:TextBox ID="txtInstitution" runat="server" placeholder="University name" CssClass="form-input" required></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group">
                                        <label>Graduation Year</label>
                                        <asp:TextBox ID="txtGradYear" runat="server" placeholder="2020" CssClass="form-input"></asp:TextBox>
                                    </div>
                                    <div class="form-group">
                                        <label>GPA (Optional)</label>
                                        <asp:TextBox ID="txtGPA" runat="server" placeholder="3.8/4.0" CssClass="form-input"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <!-- Skills Section -->
                            <div class="form-section">
                                <h3>Skills</h3>
                                <div class="form-group">
                                    <label>Technical Skills</label>
                                    <asp:TextBox ID="txtTechnicalSkills" runat="server" placeholder="e.g., JavaScript, Python, React, Node.js (separate with commas)" CssClass="form-input"></asp:TextBox>
                                </div>
                                <div class="form-group">
                                    <label>Soft Skills</label>
                                    <asp:TextBox ID="txtSoftSkills" runat="server" placeholder="e.g., Leadership, Communication, Problem-solving" CssClass="form-input"></asp:TextBox>
                                </div>
                            </div>

                            <!-- Generate Button - Updated to use client-side click -->
                            <div class="form-submit">
                                <button type="button" id="generateResumeBtn" class="generate-btn" onclick="generateResumeTemplates()">
                                    🚀 Generate Resume Templates
                                </button>
                            </div>
                        </div>
                    </div>

                    <!-- Loading State -->
                    <div class="loading-container" id="loadingContainer" style="display: none;">
                        <div class="loading-content">
                            <div class="loading-spinner">
                                <div class="spinner-ring"></div>
                                <div class="spinner-ring"></div>
                                <div class="spinner-ring"></div>
                            </div>
                            <h3>Creating Your Resume Templates</h3>
                            <p>Our AI is crafting beautiful resume designs for you...</p>
                            <div class="loading-steps">
                                <div class="step active">📝 Processing your information</div>
                                <div class="step">🎨 Designing templates</div>
                                <div class="step">✨ Adding final touches</div>
                            </div>
                        </div>
                    </div>

                    <!-- Resume Templates Display -->
                    <div class="templates-container" id="templatesContainer" style="display: none;">
                        <div class="templates-header">
                            <h2>Choose Your Resume Template</h2>
                            <p>Select from our AI-generated professional resume designs</p>
                        </div>

                        <div class="templates-grid">
                            <div class="template-card" data-template="modern">
                                <div class="template-preview">
                                    <div class="template-thumb modern-thumb">
                                        <div class="thumb-header"></div>
                                        <div class="thumb-content">
                                            <div class="thumb-line long"></div>
                                            <div class="thumb-line medium"></div>
                                            <div class="thumb-line short"></div>
                                        </div>
                                    </div>
                                </div>
                                <h4>Modern Professional</h4>
                                <p>Clean and contemporary design</p>
                                <button class="template-select-btn" type="button" onclick="selectTemplate('modern')">Select Template</button>
                            </div>

                            <div class="template-card" data-template="creative">
                                <div class="template-preview">
                                    <div class="template-thumb creative-thumb">
                                        <div class="thumb-sidebar"></div>
                                        <div class="thumb-main">
                                            <div class="thumb-line long"></div>
                                            <div class="thumb-line medium"></div>
                                            <div class="thumb-line short"></div>
                                        </div>
                                    </div>
                                </div>
                                <h4>Creative Edge</h4>
                                <p>Stand out with unique styling</p>
                                <button class="template-select-btn" type="button" onclick="selectTemplate('creative')">Select Template</button>
                            </div>

                            <div class="template-card" data-template="executive">
                                <div class="template-preview">
                                    <div class="template-thumb executive-thumb">
                                        <div class="thumb-header executive"></div>
                                        <div class="thumb-content">
                                            <div class="thumb-line long"></div>
                                            <div class="thumb-line medium"></div>
                                        </div>
                                    </div>
                                </div>
                                <h4>Executive</h4>
                                <p>Professional and authoritative</p>
                                <button class="template-select-btn" type="button" onclick="selectTemplate('executive')">Select Template</button>
                            </div>

                            <div class="template-card" data-template="minimalist">
                                <div class="template-preview">
                                    <div class="template-thumb minimalist-thumb">
                                        <div class="thumb-content">
                                            <div class="thumb-line long"></div>
                                            <div class="thumb-line short"></div>
                                            <div class="thumb-line medium"></div>
                                        </div>
                                    </div>
                                </div>
                                <h4>Minimalist</h4>
                                <p>Simple and elegant design</p>
                                <button class="template-select-btn" type="button" onclick="selectTemplate('minimalist')">Select Template</button>
                            </div>

                            <div class="template-card" data-template="technical">
                                <div class="template-preview">
                                    <div class="template-thumb technical-thumb">
                                        <div class="thumb-grid">
                                            <div class="thumb-cell"></div>
                                            <div class="thumb-cell"></div>
                                            <div class="thumb-cell full"></div>
                                        </div>
                                    </div>
                                </div>
                                <h4>Technical Pro</h4>
                                <p>Perfect for IT professionals</p>
                                <button class="template-select-btn" type="button" onclick="selectTemplate('technical')">Select Template</button>
                            </div>
                        </div>

                        <div class="templates-actions">
                            <button type="button" id="backToFormBtn" class="back-btn" onclick="backToForm()">← Edit Details</button>
                            <asp:Button ID="SaveResumeBtn" runat="server" Text="💾 Save Selected Resume" CssClass="save-btn" />
                        </div>
                    </div>
                </div>
            </main>
        </div>

        <!-- Hidden field to store selected template -->
        <asp:HiddenField ID="hdnSelectedTemplate" runat="server" />

        <script type="text/javascript">
            // Form validation function
            function validateForm() {
                var requiredFields = [
                    { id: '<%= txtFullName.ClientID %>', name: 'Full Name' },
                    { id: '<%= txtEmail.ClientID %>', name: 'Email' },
                    { id: '<%= txtPhone.ClientID %>', name: 'Phone Number' },
                    { id: '<%= txtJobTitle.ClientID %>', name: 'Job Title' },
                    { id: '<%= txtCompany.ClientID %>', name: 'Company Name' },
                    { id: '<%= txtDegree.ClientID %>', name: 'Degree' },
                    { id: '<%= txtInstitution.ClientID %>', name: 'Institution' }
                ];

                for (var i = 0; i < requiredFields.length; i++) {
                    var field = document.getElementById(requiredFields[i].id);
                    if (!field.value.trim()) {
                        alert('Please fill in the ' + requiredFields[i].name + ' field.');
                        field.focus();
                        return false;
                    }
                }

                // Email validation
                var email = document.getElementById('<%= txtEmail.ClientID %>').value;
                var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailRegex.test(email)) {
                    alert('Please enter a valid email address.');
                    document.getElementById('<%= txtEmail.ClientID %>').focus();
                    return false;
                }

                return true;
            }

            // Generate resume templates function
            function generateResumeTemplates() {
                // Validate form first
                if (!validateForm()) {
                    return;
                }

                // Hide form and show loading
                var formContainer = document.getElementById('<%= resumeFormContainer.ClientID %>');
                var loadingContainer = document.getElementById('loadingContainer');
                var templatesContainer = document.getElementById('templatesContainer');

                formContainer.style.display = 'none';
                loadingContainer.style.display = 'block';
                templatesContainer.style.display = 'none';

                // Start loading animation
                var loadingInterval = animateLoadingSteps();

                // Simulate processing time and show templates
                setTimeout(function () {
                    clearInterval(loadingInterval);
                    loadingContainer.style.display = 'none';
                    templatesContainer.style.display = 'block';
                }, 3000); // 3 seconds loading time
            }

            // Back to form function
            function backToForm() {
                var formContainer = document.getElementById('<%= resumeFormContainer.ClientID %>');
                var loadingContainer = document.getElementById('loadingContainer');
                var templatesContainer = document.getElementById('templatesContainer');

                formContainer.style.display = 'block';
                loadingContainer.style.display = 'none';
                templatesContainer.style.display = 'none';
            }

            // Template selection functionality
            function selectTemplate(templateType) {
                // Remove previous selection
                var cards = document.querySelectorAll('.template-card');
                cards.forEach(function (card) {
                    card.classList.remove('selected');
                });

                // Add selection to clicked template
                var selectedCard = document.querySelector('[data-template="' + templateType + '"]');
                if (selectedCard) {
                    selectedCard.classList.add('selected');
                }

                // Store selection in hidden field
                var hdnField = document.getElementById('<%= hdnSelectedTemplate.ClientID %>');
                if (hdnField) {
                    hdnField.value = templateType;
                }
            }

            // Loading animation steps
            function animateLoadingSteps() {
                var steps = document.querySelectorAll('.step');
                var currentStep = 0;

                var interval = setInterval(function () {
                    if (currentStep < steps.length) {
                        steps.forEach(function (step) {
                            step.classList.remove('active');
                        });
                        steps[currentStep].classList.add('active');
                        currentStep++;
                    } else {
                        currentStep = 0;
                    }
                }, 1000);

                return interval;
            }

            // Initialize page
            document.addEventListener('DOMContentLoaded', function () {
                // Reset form to initial state
                var formContainer = document.getElementById('<%= resumeFormContainer.ClientID %>');
                var loadingContainer = document.getElementById('loadingContainer');
                var templatesContainer = document.getElementById('templatesContainer');

                formContainer.style.display = 'block';
                loadingContainer.style.display = 'none';
                templatesContainer.style.display = 'none';
            });
        </script>

    </form>
</body>
</html>
