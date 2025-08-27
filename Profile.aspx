<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="airesumebuilder.Profile" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Your Profile</title>
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

        .profile-container {
            width: 100%;
            max-width: 900px;
            background-color: var(--surface-secondary);
            border: 1px solid var(--border-light);
            border-radius: 12px;
            padding: 32px;
            box-shadow: 0 4px 24px rgba(0, 0, 0, 0.4);
        }

        .profile-header {
            text-align: center;
            margin-bottom: 32px;
            padding-bottom: 24px;
            border-bottom: 1px solid var(--border-light);
        }

        .profile-title {
            font-size: 28px;
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 8px;
        }

        .profile-subtitle {
            font-size: 16px;
            color: var(--text-secondary);
        }

        .message-label {
            background-color: var(--surface-tertiary);
            border: 1px solid var(--border-medium);
            border-radius: 8px;
            padding: 12px 16px;
            margin-bottom: 24px;
            color: var(--text-secondary);
            font-size: 14px;
        }

        .profile-table-container {
            background-color: var(--surface-tertiary);
            border: 1px solid var(--border-light);
            border-radius: 12px;
            overflow: hidden;
            margin-bottom: 32px;
        }

        .profile-table {
            width: 100%;
            border-collapse: collapse;
        }

        .table-header {
            background-color: var(--surface-secondary);
            border-bottom: 1px solid var(--border-light);
        }

        .table-header th {
            padding: 16px 20px;
            text-align: left;
            font-size: 12px;
            font-weight: 600;
            color: var(--text-secondary);
            text-transform: uppercase;
            letter-spacing: 0.5px;
            border-right: 1px solid var(--border-light);
        }

        .table-header th:last-child {
            border-right: none;
        }

        .table-body td {
            padding: 16px 20px;
            color: var(--text-primary);
            font-size: 14px;
            border-right: 1px solid var(--border-light);
            vertical-align: middle;
        }

        .table-body td:last-child {
            border-right: none;
        }

        .table-body td:first-child {
            font-weight: 600;
            color: var(--accent-main);
        }

        .button-container {
            display: flex;
            gap: 16px;
            justify-content: center;
            flex-wrap: wrap;
        }

        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            min-width: 140px;
            justify-content: center;
            font-family: inherit;
        }

        .btn-primary {
            background-color: var(--accent-main);
            color: var(--text-primary);
            border: 1px solid var(--accent-main);
        }

        .btn-primary:hover {
            background-color: var(--accent-hover);
            border-color: var(--accent-hover);
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(25, 195, 125, 0.3);
        }

        .btn-secondary {
            background-color: var(--surface-secondary);
            color: var(--text-primary);
            border: 1px solid var(--border-light);
        }

        .btn-secondary:hover {
            background-color: var(--surface-primary);
            border-color: var(--border-medium);
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
        }

        .btn-danger {
            background-color: var(--danger-main);
            color: var(--text-primary);
            border: 1px solid var(--danger-main);
        }

        .btn-danger:hover {
            background-color: var(--danger-hover);
            border-color: var(--danger-hover);
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
        }

        .btn:active {
            transform: translateY(0);
        }

        .btn:focus-visible {
            outline: 2px solid var(--accent-main);
            outline-offset: 2px;
        }

        /* Mobile Responsive */
        @media (max-width: 768px) {
            .profile-container {
                padding: 24px 20px;
                margin: 10px;
            }

            .profile-title {
                font-size: 24px;
            }

            .profile-table-container {
                overflow-x: auto;
            }

            .table-header th,
            .table-body td {
                padding: 12px 16px;
                font-size: 12px;
                min-width: 120px;
            }

            .table-header th {
                white-space: nowrap;
            }

            .table-body td {
                white-space: nowrap;
            }

            .button-container {
                flex-direction: column;
                align-items: center;
            }

            .btn {
                width: 100%;
                max-width: 280px;
            }
        }

        @media (max-width: 480px) {
            body {
                padding: 10px;
            }

            .profile-container {
                padding: 20px 16px;
            }

            .table-header th,
            .table-body td {
                padding: 10px 12px;
                font-size: 11px;
                min-width: 100px;
            }
        }

        /* Loading animation for buttons */
        .btn.loading {
            position: relative;
            color: transparent;
        }

        .btn.loading:after {
            content: "";
            position: absolute;
            width: 16px;
            height: 16px;
            top: 50%;
            left: 50%;
            margin-left: -8px;
            margin-top: -8px;
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
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="profile-container">
            <div class="profile-header">
                <h1 class="profile-title">Your Profile</h1>
                <p class="profile-subtitle">Manage your account information</p>
            </div>

            <div class="message-label">
                <asp:Label ID="LabelMessage" runat="server"></asp:Label>
            </div>

            <div class="profile-table-container">
                <table class="profile-table">
                    <thead class="table-header">
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Mobile</th>
                            <th>Gender</th>
                        </tr>
                    </thead>
                    <tbody class="table-body">
                        <tr>
                            <td>
                                <asp:Label ID="Idtxt" runat="server"></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="Nametxt" runat="server"></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="Emailtxt" runat="server"></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="Mobiletxt" runat="server"></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="Gendertxt" runat="server"></asp:Label>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <div class="button-container">
                <asp:Button ID="BtnGoHome" runat="server" Text="Back To Home" CssClass="btn btn-secondary" OnClick="BtnGoHome_Click" />
                <asp:Button ID="BtnEditProfile" runat="server" Text="Edit Profile" CssClass="btn btn-primary" OnClick="BtnEditProfile_Click" />
                <asp:Button ID="BtnLogout" runat="server" Text="Log Out" CssClass="btn btn-danger" OnClick="BtnLogout_Click" />
            </div>
        </div>
    </form>
</body>
</html>