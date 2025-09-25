<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Pricing.aspx.cs" Inherits="airesumebuilder.Pricing" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>AIRESUMSEBUILDER Pricing</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="min-h-screen bg-gradient-to-br from-gray-100 to-gray-200 p-4 md:p-8">
            <div class="max-w-7xl mx-auto">

                <!-- Pricing Section -->
                <div class="mb-8">
                    <div class="flex items-center justify-between mb-6">
                        <h1 class="text-3xl font-bold text-gray-800">Pricing</h1>

                        <!-- Toggle buttons -->
                        <div class="relative flex items-center bg-gray-200 rounded-full p-1">
                            <div id="toggleSlider" class="absolute left-1 w-20 h-8 bg-gray-800 rounded-full transition-transform duration-300 transform"></div>
                            <button type="button" id="annualBtn" class="relative z-10 px-4 py-2 text-sm font-medium rounded-full transition-colors duration-300 text-white">
                                Annual
                            </button>
                            <button type="button" id="monthlyBtn" class="relative z-10 px-4 py-2 text-sm font-medium rounded-full transition-colors duration-300 text-gray-600">
                                Monthly
                            </button>
                        </div>
                    </div>

                    <!-- Pricing Cards Grid -->
                    <div id="pricingGrid" class="grid grid-cols-1 lg:grid-cols-3 gap-6">
                        <asp:Repeater ID="plansRepeater" runat="server" OnItemDataBound="plansRepeater_ItemDataBound">
                            <ItemTemplate>
                                <div class='relative rounded-3xl p-8 transition-all duration-300 hover:shadow-lg bg-white shadow-lg border border-gray-200'>

                                    <%-- Popular Badge --%>
                                    <%# Convert.ToBoolean(Eval("IsPopular")) 
                                        ? "<div class='absolute -top-3 right-6'><span class=\"bg-green-500 text-white px-3 py-1 rounded-full text-xs font-medium\">Popular</span></div>" 
                                        : "" %>

                                    <%-- Plan Header --%>
                                    <div class="mb-6">
                                        <h3 class="text-xl font-bold mb-4 text-gray-800"><%# Eval("Name") %></h3>

                                        <div class="flex items-baseline mb-2">
                                            <%# Eval("OriginalPrice") != DBNull.Value 
                                                ? "<span class='text-lg text-gray-400 line-through mr-2'>₹" + Eval("OriginalPrice") + "</span>" 
                                                : "" %>
                                            <span class="text-4xl font-bold text-gray-800 price" 
                                                  data-monthly="<%# Eval("MonthlyPrice") %>" 
                                                  data-annual="<%# Eval("AnnualPrice") %>">
                                                ₹<%# Eval("MonthlyPrice") %>
                                            </span>
                                            <span class="ml-1 text-sm text-gray-500 period">/ month</span>
                                        </div>

                                        <p class="text-xs mb-4 text-gray-500 billed">
                                            ₹<%# Eval("AnnualPrice") %> billed yearly
                                        </p>

                                        <p class="text-sm leading-relaxed text-gray-600">
                                            <%# Eval("Description") %>
                                        </p>
                                    </div>

                                    <%-- Features Repeater --%>
                                    <asp:Repeater ID="featuresRepeater" runat="server">
                                        <ItemTemplate>
                                            <div class="flex items-center space-x-3">
                                                <div class="w-5 h-5 rounded-full flex items-center justify-center <%# Convert.ToBoolean(Eval("IsIncluded")) ? "bg-green-500" : "bg-gray-300" %>">
                                                    <svg class="w-3 h-3 <%# Convert.ToBoolean(Eval("IsIncluded")) ? "text-white" : "text-gray-500" %>" fill="currentColor" viewBox="0 0 20 20">
                                                        <%# Convert.ToBoolean(Eval("IsIncluded")) 
                                                            ? "<path fill-rule='evenodd' d='M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z' clip-rule='evenodd'></path>" 
                                                            : "<path fill-rule='evenodd' d='M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z' clip-rule='evenodd'></path>" %>
                                                    </svg>
                                                </div>
                                                <span class="text-sm text-gray-700"><%# Eval("FeatureName") %></span>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>

                                    <%-- CTA Button --%>
                                    <button class="w-full py-3 px-6 rounded-full font-medium transition-all duration-200 bg-gray-800 text-white hover:bg-gray-700">
                                        Start 7-days Free Trial
                                    </button>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <script>
        // Toggle functionality
        const annualBtn = document.getElementById("annualBtn");
        const monthlyBtn = document.getElementById("monthlyBtn");
        const toggleSlider = document.getElementById("toggleSlider");

        annualBtn.addEventListener("click", function () {
            toggleSlider.style.transform = "translateX(0)";
            annualBtn.classList.add("text-white");
            annualBtn.classList.remove("text-gray-600");
            monthlyBtn.classList.add("text-gray-600");
            monthlyBtn.classList.remove("text-white");
            updatePrices(true);
        });

        monthlyBtn.addEventListener("click", function () {
            toggleSlider.style.transform = "translateX(calc(100% - 0.25rem))";
            monthlyBtn.classList.add("text-white");
            monthlyBtn.classList.remove("text-gray-600");
            annualBtn.classList.add("text-gray-600");
            annualBtn.classList.remove("text-white");
            updatePrices(false);
        });

        function updatePrices(isAnnual) {
            const prices = document.querySelectorAll(".price");
            const billeds = document.querySelectorAll(".billed");

            prices.forEach((price) => {
                const value = isAnnual ? price.dataset.annual : price.dataset.monthly;
                price.innerText = "₹" + value;
            });

            billeds.forEach((billed) => {
                const priceEl = billed.previousElementSibling.querySelector(".price");
                billed.innerText = isAnnual
                    ? "₹" + priceEl.dataset.annual + " billed yearly"
                    : "";
            });
        }
    </script>
</body>
</html>
