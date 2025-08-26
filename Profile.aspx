<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="airesumebuilder.Profile" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Your Profile</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet" />
</head>
<body class="bg-gray-50 min-h-screen flex items-center justify-center p-4">
    <form id="form1" runat="server" class="w-full max-w-4xl">
        <div class="bg-white shadow-lg rounded-lg p-6 sm:p-8 w-full">
            <h2 class="text-2xl sm:text-3xl font-extrabold text-blue-900 mb-6 text-center">Profile</h2>

            <p cssclass="mb-4">
                <asp:Label ID="LabelMessage" runat="server"></asp:Label>
            </p>

            <!-- Responsive Table Container -->
            <div class="overflow-x-auto">
                <table class="min-w-full divide-y divide-gray-200">
                    <thead class="bg-gray-100">
                        <tr>
                            <th class="px-4 py-3 text-left text-xs sm:text-sm font-semibold text-blue-900 uppercase tracking-wider">Id</th>
                            <th class="px-4 py-3 text-left text-xs sm:text-sm font-semibold text-blue-900 uppercase tracking-wider">Name</th>
                            <th class="px-4 py-3 text-left text-xs sm:text-sm font-semibold text-blue-900 uppercase tracking-wider">Email</th>
                            <th class="px-4 py-3 text-left text-xs sm:text-sm font-semibold text-blue-900 uppercase tracking-wider">Mobile</th>
                            <th class="px-4 py-3 text-left text-xs sm:text-sm font-semibold text-blue-900 uppercase tracking-wider">Gender</th>
                            <th class="px-4 py-3 text-left text-xs sm:text-sm font-semibold text-blue-900 uppercase tracking-wider">Mobile</th>
                            <th class="px-4 py-3 text-left text-xs sm:text-sm font-semibold text-blue-900 uppercase tracking-wider">Gender</th>
                        </tr>
                    </thead>
                    <tbody class="bg-white divide-y divide-gray-100">
                        <tr>
                            <td class="px-4 py-3 text-blue-900 font-medium whitespace-nowrap">
                                <asp:Label ID="Idtxt" runat="server"></asp:Label>
                            </td>
                            <td class="px-4 py-3 text-gray-800 whitespace-nowrap">
                                <asp:Label ID="Nametxt" runat="server"></asp:Label>
                            </td>
                            <td class="px-4 py-3 text-gray-800 whitespace-nowrap">
                                <asp:Label ID="Emailtxt" runat="server"></asp:Label>
                            </td>
                            <td class="px-4 py-3 text-gray-800 whitespace-nowrap">
                                <asp:Label ID="Mobiletxt" runat="server"></asp:Label>
                            </td>
                            <td class="px-4 py-3 text-gray-800 whitespace-nowrap">
                                <asp:Label ID="Gendertxt" runat="server"></asp:Label>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <div class="mt-6 flex flex-col sm:flex-row gap-4 justify-center">
                <asp:Button ID="BtnGoHome" runat="server" Text="Back To Home" CssClass="bg-blue-900 hover:bg-blue-800 cursor-pointer text-white font-semibold py-2 px-6 rounded-lg shadow-md transition duration-200" Style="height: 38px" OnClick="BtnGoHome_Click" />
                <asp:Button ID="BtnEditProfile" runat="server" Text="Edit Profile" CssClass="bg-blue-900 hover:bg-blue-800 cursor-pointer text-white font-semibold py-2 px-6 rounded-lg shadow-md transition duration-200" Style="height: 38px" OnClick="BtnEditProfile_Click" />
                <asp:Button ID="BtnLogout" runat="server" Text="Log Out" CssClass="bg-red-600 hover:bg-red-700 text-white cursor-pointer font-semibold py-2 px-6 rounded-lg shadow-md transition duration-200" OnClick="BtnLogout_Click" />
            </div>
        </div>
    </form>
</body>
</html>
