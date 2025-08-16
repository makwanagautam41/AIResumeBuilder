<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditProfile.aspx.cs" Inherits="airesumebuilder.EditProfile" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Edit Profile</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet" />
</head>
<body class="min-h-screen flex items-center justify-center">
    <form id="form1" runat="server" class="w-full max-w-md bg-white/90 rounded-xl shadow-lg p-8">
        <h2 class="text-3xl font-bold text-center mb-6 text-blue-900">Edit Profile</h2>

        <p cssclass="mb-4">
            <asp:Label ID="LabelMessage" runat="server"></asp:Label>
        </p>

        <div class="mb-4">
            <asp:Label ID="UserId" runat="server" CssClass="block text-blue-900 font-semibold mb-2"></asp:Label>
            <asp:TextBox ID="TextBoxId" runat="server" Enabled="false" CssClass="w-full px-4 py-2 rounded-lg border border-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-900 transition"></asp:TextBox>
        </div>

        <div class="mb-4">
            <asp:Label ID="LabelName" runat="server" AssociatedControlID="TextBoxName" CssClass="block text-blue-900 font-semibold mb-2" Text="Name"></asp:Label>
            <asp:TextBox ID="TextBoxName" runat="server" CssClass="w-full px-4 py-2 rounded-lg border border-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-900 transition"
                placeholder="Your full name"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidatorName" runat="server" ControlToValidate="TextBoxName" ErrorMessage="Name is required." CssClass="text-red-600" Display="Dynamic" />
        </div>

        <div class="mb-4">
            <asp:Label ID="LabelEmail" runat="server" AssociatedControlID="TextBoxEmail" CssClass="block text-blue-900 font-semibold mb-2" Text="Email"></asp:Label>
            <asp:TextBox ID="TextBoxEmail" runat="server" CssClass="w-full px-4 py-2 rounded-lg border border-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-900 transition"
                placeholder="you@example.com" TextMode="Email"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidatorEmail" runat="server" ControlToValidate="TextBoxEmail" ErrorMessage="Email is required." CssClass="text-red-600" Display="Dynamic" />
            <asp:RegularExpressionValidator ID="RegexValidatorEmail" runat="server" ControlToValidate="TextBoxEmail"
                ValidationExpression="^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$" ErrorMessage="Invalid email format." CssClass="text-red-600" Display="Dynamic" />
        </div>

        <div class="mb-4">
            <asp:Label ID="LabelMobile" runat="server" AssociatedControlID="TextBoxMobile" CssClass="block text-blue-900 font-semibold mb-2" Text="Mobile"></asp:Label>
            <asp:TextBox ID="TextBoxMobile" runat="server" CssClass="w-full px-4 py-2 rounded-lg border border-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-900 transition"
                placeholder="Your mobile number" TextMode="Phone"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidatorMobile" runat="server" ControlToValidate="TextBoxMobile" ErrorMessage="Mobile number is required." CssClass="text-red-600" Display="Dynamic" />
            <asp:RegularExpressionValidator ID="RegexValidatorMobile" runat="server" ControlToValidate="TextBoxMobile"
                ValidationExpression="^\+?[0-9]{10,15}$" ErrorMessage="Invalid mobile number format." CssClass="text-red-600" Display="Dynamic" />
        </div>

        <div class="mb-6">
            <asp:Label ID="GenderLabel" runat="server" CssClass="block text-blue-900 font-semibold mb-2" Text="Gender"></asp:Label>
            <asp:RadioButtonList ID="GenderRadioButton" runat="server" RepeatDirection="Horizontal" CssClass="space-x-4 text-blue-900 font-medium">
                <asp:ListItem>Male</asp:ListItem>
                <asp:ListItem>Female</asp:ListItem>
            </asp:RadioButtonList>
        </div>

        <asp:Button ID="ButtonUpdate" runat="server" Text="Update Profile" CssClass="w-full bg-blue-900 hover:bg-blue-800 cursor-pointer text-white font-bold py-2 px-4 rounded-lg transition" OnClick="ButtonUpdate_Click" />

        <p class="mt-4 text-center text-gray-700">
            <a href="Profile.aspx" class="text-blue-900 underline">Back to Profile</a>
        </p>
    </form>
</body>
</html>
