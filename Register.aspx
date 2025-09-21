<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="airesumebuilder.Register" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Create Account</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <style>
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
            --danger-main: #ef4444;
            --danger-hover: #dc2626;
            --input-bg: #40414f;
            --input-focus: #565869;
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
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .register-container {
            width: 100%;
            max-width: 480px;
            background-color: var(--surface-secondary);
            border: 1px solid var(--border-light);
            border-radius: 16px;
            padding: 40px 32px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.5);
            margin: 20px 0;
        }

        .register-header {
            text-align: center;
            margin-bottom: 32px;
        }

        .register-title {
            font-size: 32px;
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 8px;
        }

        .register-subtitle {
            font-size: 16px;
            color: var(--text-secondary);
        }

        .message-container {
            background-color: var(--surface-tertiary);
            border: 1px solid var(--border-medium);
            border-radius: 8px;
            padding: 12px 16px;
            margin-bottom: 24px;
            color: var(--text-secondary);
            font-size: 14px;
            display: none;
        }

            .message-container.show {
                display: block;
            }

        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            display: block;
            font-size: 14px;
            font-weight: 500;
            color: var(--text-primary);
            margin-bottom: 6px;
        }

        .form-input {
            width: 100%;
            padding: 12px 16px;
            background-color: var(--input-bg);
            border: 1px solid var(--border-medium);
            border-radius: 8px;
            color: var(--text-primary);
            font-size: 16px;
            font-family: inherit;
            outline: none;
            transition: all 0.2s ease;
        }

            .form-input::placeholder {
                color: var(--text-secondary);
                opacity: 0.7;
            }

            .form-input:focus {
                border-color: var(--accent-main);
                box-shadow: 0 0 0 2px rgba(25, 195, 125, 0.2);
                background-color: var(--input-focus);
            }

            .form-input:hover {
                border-color: var(--border-light);
            }

        .validation-error {
            color: var(--danger-main);
            font-size: 12px;
            margin-top: 4px;
            display: block;
        }

        .file-upload-container {
            position: relative;
            overflow: hidden;
            display: inline-block;
            width: 100%;
        }

        .file-upload {
            width: 100%;
            padding: 12px 16px;
            background-color: var(--input-bg);
            border: 1px solid var(--border-medium);
            border-radius: 8px;
            color: var(--text-primary);
            font-size: 14px;
            cursor: pointer;
            transition: all 0.2s ease;
        }

            .file-upload:hover {
                border-color: var(--border-light);
                background-color: var(--input-focus);
            }

        .gender-container {
            display: flex;
            gap: 20px;
            margin-top: 6px;
        }

        .gender-option {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .gender-radio {
            width: 18px;
            height: 18px;
            accent-color: var(--accent-main);
        }

        .gender-label {
            font-size: 14px;
            color: var(--text-primary);
            cursor: pointer;
        }

        .register-button {
            width: 100%;
            padding: 14px 20px;
            background-color: var(--accent-main);
            color: var(--text-primary);
            border: 1px solid var(--accent-main);
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s ease;
            font-family: inherit;
            margin: 24px 0;
        }

            .register-button:hover {
                background-color: var(--accent-hover);
                border-color: var(--accent-hover);
                transform: translateY(-1px);
                box-shadow: 0 4px 16px rgba(25, 195, 125, 0.3);
            }

            .register-button:active {
                transform: translateY(0);
            }

            .register-button:focus-visible {
                outline: 2px solid var(--accent-main);
                outline-offset: 2px;
            }

            .register-button:disabled {
                background-color: var(--surface-tertiary);
                border-color: var(--border-light);
                color: var(--text-secondary);
                cursor: not-allowed;
                transform: none;
                box-shadow: none;
            }

        .login-link {
            text-align: center;
            padding-top: 20px;
            border-top: 1px solid var(--border-light);
        }

            .login-link p {
                color: var(--text-secondary);
                font-size: 14px;
                margin: 0;
            }

            .login-link a {
                color: var(--accent-main);
                text-decoration: none;
                font-weight: 500;
                transition: color 0.2s ease;
            }

                .login-link a:hover {
                    color: var(--accent-hover);
                    text-decoration: underline;
                }

        /* Loading animation for button */
        .register-button.loading {
            position: relative;
            color: transparent;
        }

            .register-button.loading:after {
                content: "";
                position: absolute;
                width: 20px;
                height: 20px;
                top: 50%;
                left: 50%;
                margin-left: -10px;
                margin-top: -10px;
                border-radius: 50%;
                border: 2px solid transparent;
                border-top-color: currentColor;
                animation: button-loading-spinner 1s ease infinite;
            }

        @keyframes button-loading-spinner {
            from {
                transform: rotate(0turn);
            }

            to {
                transform: rotate(1turn);
            }
        }

        /* Mobile Responsive */
        @media (max-width: 600px) {
            body {
                padding: 16px;
            }

            .register-container {
                padding: 32px 24px;
                border-radius: 12px;
                max-width: 100%;
            }

            .register-title {
                font-size: 28px;
            }

            .register-subtitle {
                font-size: 14px;
            }

            .form-input {
                padding: 12px 14px;
                font-size: 16px;
            }

            .register-button {
                padding: 12px 20px;
                font-size: 16px;
            }

            .gender-container {
                gap: 16px;
            }
        }

        @media (max-width: 400px) {
            .register-container {
                padding: 24px 20px;
                margin: 10px 0;
            }

            .gender-container {
                flex-direction: column;
                gap: 12px;
            }
        }

        /* Focus management */
        .form-input:invalid {
            box-shadow: none;
        }

        .form-group.error .form-input {
            border-color: var(--danger-main);
        }

            .form-group.error .form-input:focus {
                border-color: var(--danger-main);
                box-shadow: 0 0 0 2px rgba(239, 68, 68, 0.2);
            }

        /* Custom file upload styling */
        .file-upload input[type="file"] {
            position: absolute;
            left: -9999px;
        }

        .file-upload-label {
            display: block;
            padding: 12px 16px;
            background-color: var(--input-bg);
            border: 1px solid var(--border-medium);
            border-radius: 8px;
            color: var(--text-primary);
            font-size: 14px;
            cursor: pointer;
            transition: all 0.2s ease;
            text-align: center;
        }

            .file-upload-label:hover {
                border-color: var(--border-light);
                background-color: var(--input-focus);
            }

            .file-upload-label::before {
                content: "📎 ";
                margin-right: 8px;
            }

        /* Smooth transitions */
        .register-container * {
            transition: all 0.2s ease;
        }
    </style>
</head>
<body>
    <form id="register" runat="server">
        <div class="register-container">
            <div class="register-header">
                <h1 class="register-title">Create Account</h1>
                <p class="register-subtitle">Join us today</p>
            </div>

            <div class='message-container <%= !string.IsNullOrEmpty(LabelMessage.Text) ? "show" : "" %>'>
                <asp:Label ID="LabelMessage" runat="server"></asp:Label>
            </div>

            <div class="form-group">
                <asp:Label ID="LabelName" runat="server" AssociatedControlID="TextBoxName" CssClass="form-label" Text="Full Name"></asp:Label>
                <asp:TextBox ID="TextBoxName" runat="server" CssClass="form-input"
                    placeholder="Your full name"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidatorName" runat="server" ControlToValidate="TextBoxName"
                    ErrorMessage="Name is required." CssClass="validation-error" Display="Dynamic" />
            </div>

            <div class="form-group">
                <asp:Label ID="LabelEmail" runat="server" AssociatedControlID="TextBoxEmail" CssClass="form-label" Text="Email"></asp:Label>
                <asp:TextBox ID="TextBoxEmail" runat="server" CssClass="form-input"
                    placeholder="you@example.com" TextMode="Email"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidatorEmail" runat="server" ControlToValidate="TextBoxEmail"
                    ErrorMessage="Email is required." CssClass="validation-error" Display="Dynamic" />
                <asp:RegularExpressionValidator ID="RegexValidatorEmail" runat="server" ControlToValidate="TextBoxEmail"
                    ValidationExpression="^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$" ErrorMessage="Invalid email format."
                    CssClass="validation-error" Display="Dynamic" />
            </div>

            <div class="form-group">
                <asp:Label ID="LabelMobile" runat="server" AssociatedControlID="TextBoxMobile" CssClass="form-label" Text="Mobile"></asp:Label>
                <asp:TextBox ID="TextBoxMobile" runat="server" CssClass="form-input"
                    placeholder="Your mobile number" TextMode="Phone"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidatorMobile" runat="server" ControlToValidate="TextBoxMobile"
                    ErrorMessage="Mobile number is required." CssClass="validation-error" Display="Dynamic" />
                <asp:RegularExpressionValidator ID="RegexValidatorMobile" runat="server" ControlToValidate="TextBoxMobile"
                    ValidationExpression="^\+?[0-9]{10,15}$" ErrorMessage="Invalid mobile number format."
                    CssClass="validation-error" Display="Dynamic" />
            </div>

            <div class="form-group">
                <asp:Label ID="LabelPassword" runat="server" AssociatedControlID="TextBoxPassword" CssClass="form-label" Text="Password"></asp:Label>
                <asp:TextBox ID="TextBoxPassword" runat="server" CssClass="form-input"
                    TextMode="Password" placeholder="Choose a strong password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidatorPassword" runat="server" ControlToValidate="TextBoxPassword"
                    ErrorMessage="Password is required." CssClass="validation-error" Display="Dynamic" />
            </div>

            <div class="form-group">
                <asp:Label ID="LabelImage" runat="server" CssClass="form-label" Text="Profile Picture (Optional)"></asp:Label>
                <div class="file-upload-container">
                    <asp:FileUpload ID="ImageFile" runat="server" CssClass="file-upload" />
                </div>
            </div>

            <div class="form-group">
                <asp:Label ID="Gender" runat="server" CssClass="form-label" Text="Gender"></asp:Label>
                <asp:RadioButtonList ID="genderRadioButton" runat="server" RepeatDirection="Horizontal" CssClass="gender-container">
                    <asp:ListItem CssClass="gender-option" Text="Male" Value="Male"></asp:ListItem>
                    <asp:ListItem CssClass="gender-option" Text="Female" Value="Female"></asp:ListItem>
                </asp:RadioButtonList>
            </div>

            <asp:Button ID="ButtonRegister" runat="server" Text="Create Account" CssClass="register-button" OnClick="ButtonRegister_Click" />

            <div class="login-link">
                <p>
                    Already have an account? 
                    <a href="Login.aspx">Sign in</a>
                </p>
            </div>
        </div>
    </form>
</body>
</html>
