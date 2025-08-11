<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="airesumebuilder.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Register</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet" />
</head>
<body class="bg-gray-100 min-h-screen flex items-center justify-center">
    <form id="register" runat="server" class="w-full max-w-md bg-white/90 rounded-xl shadow-lg p-8">
        <h2 class="text-3xl font-bold text-center mb-6 text-blue-900">Create Account</h2>
        <%--<asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="text-red-600 mb-4" />--%>
        <p cssclass="mb-4">
            <asp:Label ID="LabelMessage" runat="server"></asp:Label>
        </p>

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
            <asp:Label ID="LabelPassword" runat="server" AssociatedControlID="TextBoxPassword" CssClass="block text-blue-900 font-semibold mb-2" Text="Password"></asp:Label>
            <asp:TextBox ID="TextBoxPassword" runat="server" CssClass="w-full px-4 py-2 rounded-lg border border-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-900 transition"
                TextMode="Password" placeholder="Choose a password"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidatorPassword" runat="server" ControlToValidate="TextBoxPassword" ErrorMessage="Password is required." CssClass="text-red-600" Display="Dynamic" />
        </div>

        <asp:Button ID="ButtonRegister" runat="server" Text="Register" CssClass="w-full bg-blue-900 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded-lg transition" OnClick="ButtonRegister_Click" />

        <p class="mt-4 text-center text-gray-700">
            Already have an account? 
        <a href="Login.aspx" class="text-blue-900 underline">Login</a>
        </p>
    </form>
</body>
</html>
