<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Success.aspx.cs" Inherits="airesumebuilder.Success" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Payment Successful - AI Resume Builder</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body>
    <form id="form1" runat="server" class="w-full">
        <div class="max-w-xl mx-auto bg-white rounded-2xl shadow-lg p-10 text-center">
            <!-- Success Icon -->
            <div class="flex justify-center mb-6">
                <svg class="w-20 h-20 text-green-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                        d="M9 12l2 2l4-4m6 2a9 9 0 11-18 0a9 9 0 0118 0z" />
                </svg>
            </div>

            <!-- Title -->
            <h1 class="text-3xl font-bold text-gray-800 mb-4">Payment Successful 🎉</h1>

            <!-- Details -->
            <p class="text-gray-600 mb-6">
                Thank you for subscribing to <span class="font-semibold">AI Resume Builder</span>.
             Your payment has been processed securely via <span class="font-semibold">Stripe</span>.
            </p>

            <!-- Next Steps -->
            <div class="bg-green-50 border border-green-200 rounded-lg p-4 text-left mb-6">
                <h2 class="font-semibold text-green-700 mb-2">What happens next?</h2>
                <ul class="list-disc list-inside text-green-700 space-y-1">
                    <li>Your subscription is now active.</li>
                    <li>You can start using premium features immediately.</li>
                    <li>A confirmation email has been sent to your inbox.</li>
                </ul>
            </div>

            <!-- Buttons -->
            <div class="flex flex-col sm:flex-row justify-center gap-4">
                <a href="Login.aspx"
                    class="px-6 py-3 bg-green-600 text-white rounded-lg shadow hover:bg-green-700 transition">Go to Login
                </a>
                <a href="Pricing.aspx"
                    class="px-6 py-3 bg-gray-200 text-gray-800 rounded-lg shadow hover:bg-gray-300 transition">Back to Pricing
                </a>
            </div>
        </div>
    </form>
</body>
</html>
