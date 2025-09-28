<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="airesumebuilder.Checkout" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Credit Card Checkout Page</title>
    <script src="https://cdn.tailwindcss.com"></script>
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
            --accent-blue: #4285f4;
            --accent-blue-hover: #3367d6;
        }

        body, html {
            font-family: "Söhne", -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            background-color: var(--surface-primary);
            color: var(--text-primary);
            margin: 0;
            padding: 0;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(16px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .fade-in-up {
            animation: fadeInUp 0.7s ease-out forwards;
        }

        .checkout-container {
            background: linear-gradient(135deg, var(--surface-tertiary) 0%, var(--surface-primary) 100%);
            min-height: 100vh;
        }

        .header-section {
            background-color: var(--surface-secondary);
            border-bottom: 1px solid var(--border-light);
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
        }

        .main-title {
            color: var(--text-primary);
        }

        .checkout-card {
            background-color: var(--surface-secondary);
            border: 1px solid var(--border-light);
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
            transition: all 0.3s ease;
        }

            .checkout-card:hover {
                box-shadow: 0 8px 32px rgba(0, 0, 0, 0.4);
                border-color: var(--border-medium);
            }

        .section-title {
            color: var(--text-primary);
        }

        .label-text {
            color: var(--text-secondary);
        }

        .info-box {
            background-color: var(--surface-tertiary);
            border: 1px solid var(--accent-main);
            color: var(--text-secondary);
        }

        .info-icon {
            color: var(--accent-main);
        }

        .payment-method-card {
            background-color: var(--surface-tertiary);
            border: 2px solid var(--accent-main);
        }

        .payment-brand {
            background-color: var(--accent-main);
            color: var(--text-primary);
        }

        .form-input {
            background-color: var(--surface-tertiary);
            border: 1px solid var(--border-light);
            color: var(--text-primary);
            transition: all 0.3s ease;
        }

            .form-input:focus {
                border-color: var(--accent-main);
                box-shadow: 0 0 0 2px rgba(25, 195, 125, 0.2);
                outline: none;
            }

            .form-input::placeholder {
                color: var(--text-secondary);
            }

        .summary-item {
            color: var(--text-secondary);
        }

        .summary-value {
            color: var(--text-primary);
        }

        .total-text {
            color: var(--text-primary);
        }

        .promo-link {
            color: var(--accent-main);
            transition: color 0.2s ease;
        }

            .promo-link:hover {
                color: var(--accent-hover);
            }

        .terms-text {
            color: var(--text-secondary);
            font-size: 12px;
        }

        .complete-payment-btn {
            background-color: var(--accent-main);
            color: var(--text-primary);
            transition: all 0.2s ease;
            border: none;
        }

            .complete-payment-btn:hover {
                background-color: var(--accent-hover);
                transform: scale(1.02);
                box-shadow: 0 4px 16px rgba(25, 195, 125, 0.3);
            }

        .bottom-section {
            background-color: var(--surface-tertiary);
            border-top: 1px solid var(--border-light);
        }

        .bottom-text {
            color: var(--text-secondary);
        }

        .highlight-badge {
            background-color: var(--accent-main);
            color: var(--text-primary);
        }

        .divider {
            border-color: var(--border-light);
        }

        /* Custom scrollbar */
        ::-webkit-scrollbar {
            width: 8px;
        }

        ::-webkit-scrollbar-track {
            background: var(--surface-tertiary);
        }

        ::-webkit-scrollbar-thumb {
            background: var(--border-light);
            border-radius: 4px;
        }

            ::-webkit-scrollbar-thumb:hover {
                background: var(--border-medium);
            }
    </style>
</head>
<body class="checkout-container">
    <form id="form1" runat="server">
        <div class="min-h-screen">
            <!-- Main Content -->
            <div class="fade-in-up">

                <!-- Checkout Form -->
                <div class="max-w-6xl mx-auto px-4 py-8">
                    <div class="grid md:grid-cols-2 gap-8">
                        <!-- Left Column - Form -->
                        <div class="space-y-6">
                            <!-- Attendee Details -->
                            <div class="checkout-card rounded-lg p-6 transform transition-shadow duration-300">
                                <h3 class="text-lg font-semibold mb-4 section-title">Attendee details:</h3>
                                <div class="space-y-4">
                                    <div>
                                        <div class="flex items-center gap-2 p-3 mb-2 info-box rounded">
                                            <label class="block text-sm label-text">
                                                Name:
                                                <asp:Label ID="lblUserName" runat="server" Text="User Name"></asp:Label>
                                            </label>
                                        </div>
                                        <div class="flex items-center gap-2 p-3 info-box rounded">
                                            <label class="block text-sm label-text">
                                                Email: 
                                                <asp:Label ID="lblUserEmail" runat="server" Text="user@example.com"></asp:Label>
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>


                            <!-- Payment Method -->
                            <div class="checkout-card rounded-lg p-6 transform transition-shadow duration-300">
                                <h3 class="text-lg font-semibold mb-4 section-title">Currently the Card Only Payment is Available</h3>

                                <!-- Form Fields -->
                                <div class="space-y-4">
                                    <div>
                                        <label class="block text-sm label-text mb-2">Name on Card</label>
                                        <input
                                            type="text"
                                            value="Murith Zable"
                                            class="w-full p-3 form-input rounded-lg" />
                                    </div>

                                    <div>
                                        <label class="block text-sm label-text mb-2">Card Number</label>
                                        <input
                                            type="text"
                                            value="4444 0000 0000 0000"
                                            maxlength="19"
                                            class="w-full p-3 form-input rounded-lg" />
                                    </div>

                                    <div class="grid grid-cols-2 gap-4">
                                        <div>
                                            <label class="block text-sm label-text mb-2">Expiration Date</label>
                                            <input
                                                type="text"
                                                value="09/2032"
                                                placeholder="MM/YYYY"
                                                class="w-full p-3 form-input rounded-lg" />
                                        </div>
                                        <div>
                                            <label class="block text-sm label-text mb-2">CVV</label>
                                            <input
                                                type="text"
                                                value="000"
                                                maxlength="3"
                                                class="w-full p-3 form-input rounded-lg" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Right Column - Summary -->
                        <div class="space-y-6">
                            <div class="checkout-card rounded-lg p-4 sticky top-4">
                                <h3 class="text-lg font-semibold mb-4 section-title">Summary of Selected Plan   </h3>

                                <div class="checkout-card rounded-lg p-2 mb-2">
                                    <div class="space-y-2">
                                        <div>
                                            <strong>Plan Name:</strong>
                                            <asp:Label ID="lblPlanName" runat="server" Text=""></asp:Label>
                                        </div>
                                        <div>
                                            <strong>Description:</strong>
                                            <asp:Label ID="lblDescription" runat="server" Text=""></asp:Label>
                                        </div>
                                        <div>
                                            <strong>Monthly Price:</strong> ₹<asp:Label ID="lblMonthly" runat="server" Text=""></asp:Label>
                                        </div>
                                        <div>
                                            <strong>Annual Price:</strong> ₹<asp:Label ID="lblAnnual" runat="server" Text=""></asp:Label>
                                        </div>
                                    </div>
                                </div>

                                <div class="terms-text mb-4 space-y-1">
                                    <p>By clicking pay:</p>
                                    <p>• I accept the terms and conditions of Zab's</p>
                                    <p>• I agree to the processing and use of my data in accordance with the Zable's Privacy Policy</p>
                                </div>

                                <button class="complete-payment-btn w-full py-3 px-4 rounded-lg font-medium">
                                    Complete Payment
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Bottom Section Preview -->
            <div class="bottom-section py-8 mt-12">
                <div class="max-w-6xl mx-auto px-4 text-center">
                    <p class="bottom-text mb-4">
                        Payment method, input their card information, view the payment amount, and then proceed to click on the
                        <span class="highlight-badge px-3 py-1 rounded font-medium">"Complete Payment"</span>
                        button to finalize the transaction.
                    </p>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
