<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="airesumebuilder.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
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

        .login-container {
            width: 100%;
            max-width: 400px;
            background-color: var(--surface-secondary);
            border: 1px solid var(--border-light);
            border-radius: 16px;
            padding: 40px 32px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.5);
        }

        .login-header {
            text-align: center;
            margin-bottom: 32px;
        }

        .login-title {
            font-size: 32px;
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 8px;
        }

        .login-subtitle {
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
            margin-bottom: 24px;
        }

        .form-label {
            display: block;
            font-size: 14px;
            font-weight: 500;
            color: var(--text-primary);
            margin-bottom: 8px;
        }

        .form-input {
            width: 100%;
            padding: 14px 16px;
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
            margin-top: 6px;
            display: block;
        }

        .login-button {
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
            margin-bottom: 24px;
        }

        .login-button:hover {
            background-color: var(--accent-hover);
            border-color: var(--accent-hover);
            transform: translateY(-1px);
            box-shadow: 0 4px 16px rgba(25, 195, 125, 0.3);
        }

        .login-button:active {
            transform: translateY(0);
        }

        .login-button:focus-visible {
            outline: 2px solid var(--accent-main);
            outline-offset: 2px;
        }

        .login-button:disabled {
            background-color: var(--surface-tertiary);
            border-color: var(--border-light);
            color: var(--text-secondary);
            cursor: not-allowed;
            transform: none;
            box-shadow: none;
        }

        .register-link {
            text-align: center;
            padding-top: 24px;
            border-top: 1px solid var(--border-light);
        }

        .register-link p {
            color: var(--text-secondary);
            font-size: 14px;
            margin: 0;
        }

        .register-link a {
            color: var(--accent-main);
            text-decoration: none;
            font-weight: 500;
            transition: color 0.2s ease;
        }

        .register-link a:hover {
            color: var(--accent-hover);
            text-decoration: underline;
        }

        /* Loading animation for button */
        .login-button.loading {
            position: relative;
            color: transparent;
        }

        .login-button.loading:after {
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
        @media (max-width: 480px) {
            body {
                padding: 16px;
            }

            .login-container {
                padding: 32px 24px;
                border-radius: 12px;
            }

            .login-title {
                font-size: 28px;
            }

            .login-subtitle {
                font-size: 14px;
            }

            .form-input {
                padding: 12px 14px;
                font-size: 16px;
            }

            .login-button {
                padding: 12px 20px;
                font-size: 16px;
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

        /* Smooth transitions */
        .login-container * {
            transition: all 0.2s ease;
        }
    </style>
</head>
<body>
    <form id="login" runat="server">
        <div class="login-container">
            <div class="login-header">
                <h1 class="login-title">Welcome back</h1>
                <p class="login-subtitle">Sign in to your account</p>
            </div>

            <div class="message-container">
                <asp:Label ID="LabelMessage" runat="server"></asp:Label>
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
                <asp:Label ID="LabelPassword" runat="server" AssociatedControlID="TextBoxPassword" CssClass="form-label" Text="Password"></asp:Label>
                <asp:TextBox ID="TextBoxPassword" runat="server" CssClass="form-input"
                    TextMode="Password" placeholder="Your password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidatorPassword" runat="server" ControlToValidate="TextBoxPassword" 
                    ErrorMessage="Password is required." CssClass="validation-error" Display="Dynamic" />
            </div>

            <asp:Button ID="ButtonLogin" runat="server" Text="Sign In" CssClass="login-button" OnClick="ButtonLogin_Click" />

            <div class="register-link">
                <p>
                    Don't have an account? 
                    <a href="Register.aspx">Create account</a>
                </p>
            </div>
        </div>
    </form>
</body>
</html>