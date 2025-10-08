<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Cancel.aspx.cs" Inherits="airesumebuilder.Cancel" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Payment Cancelled - AI Resume Builder</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body>
    <form id="form1" runat="server" class="w-full">
        <div class="max-w-xl mx-auto bg-white rounded-2xl shadow-lg p-10 text-center">
            <div class="flex justify-center mb-6">
                <svg class="w-20 h-20 text-red-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                        d="M6 18L18 6M6 6l12 12" />
                </svg>
            </div>

            <h1 class="text-3xl font-bold text-gray-800 mb-4">Payment Cancelled ❌</h1>

            <p class="text-gray-600 mb-6">
                Your subscription process was <span class="font-semibold">not completed</span>.
                No charges were made to your account. You can retry the payment anytime via 
                <span class="font-semibold">Pricing page</span>.
            </p>

            <div class="bg-red-50 border border-red-200 rounded-lg p-4 text-left mb-6">
                <h2 class="font-semibold text-red-700 mb-2">What you can do next?</h2>
                <ul class="list-disc list-inside text-red-700 space-y-1">
                    <li>Retry subscribing to AI Resume Builder.</li>
                    <li>Check your payment method for issues.</li>
                    <li>Contact support if you need assistance.</li>
                </ul>
            </div>

            <div class="flex flex-col sm:flex-row justify-center gap-4">
                <a href="Pricing.aspx"
                    class="px-6 py-3 bg-red-600 text-white rounded-lg shadow hover:bg-red-700 transition">Retry Payment
                </a>
                <a href="Home.aspx"
                    class="px-6 py-3 bg-gray-200 text-gray-800 rounded-lg shadow hover:bg-gray-300 transition">Go to Home
                </a>
            </div>
        </div>
    </form>
</body>
</html>
