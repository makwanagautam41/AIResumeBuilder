<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="airesumebuilder.Checkout" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Credit Card Checkout Page</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
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
      .complete-payment-btn:hover {
        background-color: #1d4ed8;
        transform: scale(1.02);
      }
      .complete-payment-btn {
        transition: all 0.2s;
      }
    </style>

</head>
<body  class="bg-gray-100">
    <form id="form1" runat="server">
        <div class="min-h-screen">
            <!-- Main Content -->
            <div class="fade-in-up">
                <!-- Header Section -->
                <div class="bg-white shadow-sm">
                    <div class="max-w-6xl mx-auto px-4 py-6">
                        <div class="flex items-center justify-between mb-6">
                            <h1 class="text-2xl md:text-3xl font-bold text-gray-900">Go Back To Pricing
              </h1>
                        </div>
                    </div>
                </div>

                <!-- Checkout Form -->
                <div class="max-w-6xl mx-auto px-4 py-8">
                    <div class="grid md:grid-cols-2 gap-8">
                        <!-- Left Column - Form -->
                        <div class="space-y-6">
                            <!-- Attendee Details -->
                            <div
                                class="bg-white rounded-lg shadow-sm border p-6 transform hover:shadow-md transition-shadow duration-300">
                                <h3 class="text-lg font-semibold mb-4">Attendee details:</h3>
                                <div class="space-y-4">
                                    <div>
                                        <label class="block text-sm text-gray-600 mb-2">
                                            Murith Zable</label>
                                        <div
                                            class="flex items-center gap-2 p-3 bg-blue-50 border border-blue-200 rounded">
                                            <span class="text-blue-600 text-sm">ℹ</span>
                                            <span class="text-sm text-blue-700">Your ticket will be sent to: murith.zab@gmail.com</span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Payment Method -->
                            <div
                                class="bg-white rounded-lg shadow-sm border p-6 transform hover:shadow-md transition-shadow duration-300">
                                <h3 class="text-lg font-semibold mb-4">Select payment method
                </h3>

                                <!-- Payment Options -->
                                <div class="flex gap-3 mb-6">
                                    <div
                                        class="p-3 border-2 border-blue-500 bg-blue-50 rounded-lg">
                                        <div
                                            class="w-20 h-8 rounded bg-blue-600 flex items-center justify-center text-white text-xs font-bold">
                                            MASTERCARD ONLY
                   
                                        </div>
                                    </div>
                                </div>

                                <!-- Form Fields -->
                                <div class="space-y-4">
                                    <div>
                                        <label class="block text-sm text-gray-600 mb-2">
                                            Name on Card</label>
                                        <input
                                            type="text"
                                            value="Murith Zable"
                                            class="w-full p-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all" />
                                    </div>

                                    <div>
                                        <label class="block text-sm text-gray-600 mb-2">
                                            Card Number</label>
                                        <input
                                            type="text"
                                            value="4444 0000 0000 0000"
                                            maxlength="19"
                                            class="w-full p-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all" />
                                    </div>

                                    <div class="grid grid-cols-2 gap-4">
                                        <div>
                                            <label class="block text-sm text-gray-600 mb-2">
                                                Expiration Date</label>
                                            <input
                                                type="text"
                                                value="09/2032"
                                                placeholder="MM/YYYY"
                                                class="w-full p-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all" />
                                        </div>
                                        <div>
                                            <label class="block text-sm text-gray-600 mb-2">
                                                CVV</label>
                                            <input
                                                type="text"
                                                value="000"
                                                maxlength="3"
                                                class="w-full p-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Right Column - Summary -->
                        <div class="space-y-6">
                            <div
                                class="bg-white rounded-lg shadow-sm border p-6 sticky top-4">
                                <h3 class="text-lg font-semibold mb-4">Summary</h3>

                                <div class="space-y-4 mb-6">
                                    <div>
                                        <h4 class="font-medium text-gray-900">Tropical Purple Party
                    </h4>
                                        <a href="#" class="text-blue-600 text-sm hover:underline">Add Promo Code?</a>
                                    </div>

                                    <div class="space-y-3">
                                        <div class="flex justify-between">
                                            <span class="text-gray-600">3 x Advance Tickets</span>
                                            <span class="font-medium">KES 7,500</span>
                                        </div>
                                        <div class="flex justify-between">
                                            <span class="text-gray-600">3 x VVIP Tickets</span>
                                            <span class="font-medium">KES 15,500</span>
                                        </div>
                                        <hr class="border-gray-200" />
                                        <div class="flex justify-between text-lg font-semibold">
                                            <span>Total:</span>
                                            <span>22,500</span>
                                        </div>
                                    </div>
                                </div>

                                <div class="text-xs text-gray-500 mb-4 space-y-1">
                                    <p>By clicking pay:</p>
                                    <p>• I accept the terms and conditions of Zab's</p>
                                    <p>
                                        • I agree to the processing and use of my data in accordance
                    with the Zable's Privacy Policy
                 
                                    </p>
                                </div>

                                <button
                                    class="complete-payment-btn w-full bg-blue-600 text-white py-3 px-4 rounded-lg font-medium">
                                    Complete Payment
               
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Bottom Section Preview -->
            <div class="bg-gray-800 text-white py-8 mt-12">
                <div class="max-w-6xl mx-auto px-4 text-center">
                    <p class="text-gray-300 mb-4">
                        Payment method, input their card information, view the payment
            amount, and then proceed to click on the
           
                        <span class="bg-blue-600 px-3 py-1 rounded font-medium">"Complete Payment"</span>
                        button to finalize the transaction.
         
                    </p>
                </div>
            </div>
        </div>

    </form>
</body>
</html>
