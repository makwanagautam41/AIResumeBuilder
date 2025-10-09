<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Pricing.aspx.cs" Inherits="airesumebuilder.Pricing" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>AIRESUMSEBUILDER Pricing</title>
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
            --accent-orange: #ff9500;
        }

        body, html {
            font-family: "Söhne", -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            background-color: var(--surface-primary);
            color: var(--text-primary);
            margin: 0;
            padding: 0;
        }

        .pricing-container {
            background: linear-gradient(135deg, var(--surface-tertiary) 0%, var(--surface-primary) 100%);
            min-height: 100vh;
        }

        .pricing-card {
            background-color: var(--surface-secondary);
            border: 1px solid var(--border-light);
            transition: all 0.3s ease;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
        }

            .pricing-card:hover {
                box-shadow: 0 8px 32px rgba(0, 0, 0, 0.4);
                border-color: var(--border-medium);
            }

        .toggle-container {
            background-color: var(--surface-secondary);
            border: 1px solid var(--border-light);
        }

        .toggle-slider {
            background-color: var(--accent-main);
        }

        .toggle-btn {
            color: var(--text-secondary);
            transition: color 0.3s ease;
        }

            .toggle-btn.active {
                color: var(--text-primary);
            }

        .popular-badge {
            background-color: var(--accent-main);
            color: var(--text-primary);
        }

        .active-badge {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: var(--text-primary);
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
        }

        .purchased-badge {
            background-color: var(--accent-orange);
            color: var(--text-primary);
        }

        .plan-title {
            color: var(--text-primary);
        }

        .price-text {
            color: var(--text-primary);
        }

        .original-price {
            color: var(--text-secondary);
        }

        .period-text {
            color: var(--text-secondary);
        }

        .billed-text {
            color: var(--text-secondary);
        }

        .description-text {
            color: var(--text-secondary);
            line-height: 1.6;
        }

        .feature-included {
            background-color: var(--accent-main);
        }

        .feature-excluded {
            background-color: var(--border-light);
        }

        .feature-text {
            color: var(--text-secondary);
        }

        .cta-button {
            background-color: var(--surface-tertiary);
            border: 1px solid var(--border-medium);
            color: var(--text-primary);
            transition: all 0.2s ease;
        }

            .cta-button:hover:not(:disabled) {
                background-color: var(--accent-main);
                border-color: var(--accent-main);
                box-shadow: 0 4px 16px rgba(25, 195, 125, 0.3);
            }

            .cta-button.activate-btn:hover:not(:disabled) {
                background-color: var(--accent-orange);
                border-color: var(--accent-orange);
                box-shadow: 0 4px 16px rgba(255, 149, 0, 0.3);
            }

            .cta-button:disabled {
                background-color: var(--border-light);
                cursor: not-allowed;
                opacity: 0.6;
            }

        .main-title {
            color: var(--text-primary);
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
<body>
    <form id="form1" runat="server">
        <div class="pricing-container min-h-screen p-4 md:p-8">
            <div class="max-w-7xl mx-auto">

                <!-- Pricing Section -->
                <div class="mb-8">
                    <div class="flex items-center justify-between mb-6">
                        <h1 class="text-3xl font-bold main-title">Pricing</h1>

                        <!-- Toggle buttons -->
                        <div class="relative flex items-center toggle-container rounded-full p-1">
                            <div id="toggleSlider" 
                                 class="absolute left-1 w-20 h-8 toggle-slider rounded-full transition-transform duration-300 transform translate-x-full">
                            </div>
                            <button type="button" id="annualBtn" 
                                    class="relative z-10 px-4 py-2 text-sm font-medium rounded-full transition-colors duration-300 toggle-btn">
                                Annual
                            </button>
                            <button type="button" id="monthlyBtn" 
                                    class="relative z-10 px-4 py-2 text-sm font-medium rounded-full transition-colors duration-300 toggle-btn active">
                                Monthly
                            </button>
                        </div>
                    </div>
                    <asp:Label ID="lblActivePlan" runat="server" CssClass="text-green-500 font-bold mb-4 block" Visible="false"></asp:Label>


                    <!-- Pricing Cards Grid -->
                    <div id="pricingGrid" class="grid grid-cols-1 lg:grid-cols-3 gap-6">
                        <asp:Repeater ID="plansRepeater" runat="server" OnItemDataBound="plansRepeater_ItemDataBound">
                            <ItemTemplate>
                                <div class='relative pricing-card rounded-3xl p-8 transition-all duration-300'>

                                    <%-- Badge Section - Priority: Active > Purchased > Popular --%>
                                    <%# Convert.ToBoolean(Eval("IsActivePlan")) 
                                        ? "<div class='absolute -top-3 right-6'><span class=\"active-badge px-3 py-1 rounded-full text-xs font-medium\">Active Plan</span></div>" 
                                        : Convert.ToBoolean(Eval("IsPurchased")) 
                                            ? "<div class='absolute -top-3 right-6'><span class=\"purchased-badge px-3 py-1 rounded-full text-xs font-medium\">Purchased</span></div>"
                                            : Convert.ToBoolean(Eval("IsPopular")) 
                                                ? "<div class='absolute -top-3 right-6'><span class=\"popular-badge px-3 py-1 rounded-full text-xs font-medium\">Popular</span></div>" 
                                                : "" %>

                                    <%-- Plan Header --%>
                                    <div class="mb-6">
                                        <h3 class="text-xl font-bold mb-4 plan-title"><%# Eval("Name") %></h3>

                                        <div class="flex items-baseline mb-2">
                                            <%# Eval("OriginalPrice") != DBNull.Value 
                                                ? "<span class='text-lg original-price line-through mr-2'>₹" + Eval("OriginalPrice") + "</span>" 
                                                : "" %>
                                            <span class="text-4xl font-bold price-text price" 
                                                  data-monthly="<%# Eval("MonthlyPrice") %>" 
                                                  data-annual="<%# Eval("AnnualPrice") %>">
                                                ₹<%# Eval("MonthlyPrice") %>
                                            </span>
                                            <span class="ml-1 text-sm period-text period periodType"></span>
                                        </div>

                                        <p class="text-xs mb-4 billed-text billed">
                                            ₹<%# Eval("AnnualPrice") %> billed yearly
                                        </p>

                                        <p class="text-sm description-text">
                                            <%# Eval("Description") %>
                                        </p>
                                    </div>

                                    <%-- Features Repeater --%>
                                    <div class="space-y-3 mb-8">
                                        <asp:Repeater ID="featuresRepeater" runat="server">
                                            <ItemTemplate>
                                                <div class="flex items-center space-x-3">
                                                    <div class="w-5 h-5 rounded-full flex items-center justify-center <%# Convert.ToBoolean(Eval("IsIncluded")) ? "feature-included" : "feature-excluded" %>">
                                                        <svg class="w-3 h-3 text-white" fill="currentColor" viewBox="0 0 20 20">
                                                            <%# Convert.ToBoolean(Eval("IsIncluded")) 
                                                                ? "<path fill-rule='evenodd' d='M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z' clip-rule='evenodd'></path>" 
                                                                : "<path fill-rule='evenodd' d='M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z' clip-rule='evenodd'></path>" %>
                                                        </svg>
                                                    </div>
                                                    <span class="text-sm feature-text"><%# Eval("FeatureName") %></span>
                                                </div>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </div>

                                    <%-- CTA Button - Three States: Current Plan / Activate Plan / Start Trial --%>
                                    <%# Convert.ToBoolean(Eval("IsActivePlan")) 
                                        ? "<button type='button' class='w-full py-3 px-6 rounded-full font-medium cta-button' disabled>Current Plan</button>"
                                        : Convert.ToBoolean(Eval("IsPurchased"))
                                            ? "<button type='button' class='w-full py-3 px-6 rounded-full font-medium cta-button activate-btn' data-planid='" + Eval("PlanID") + "' onclick='activatePlan(" + Eval("PlanID") + ")'>Activate Plan</button>"
                                            : "<button type='button' class='w-full py-3 px-6 rounded-full font-medium cta-button start-trial-btn' data-planid='" + Eval("PlanID") + "'>Start 7-days Free Trial</button>" %>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <script src="https://js.stripe.com/v3/"></script>

    <script>
        const stripe = Stripe("<%= System.Configuration.ConfigurationManager.AppSettings["StripePublishableKey"] %>");

        // Activate Plan Function
        function activatePlan(planId) {
            if (!confirm("Are you sure you want to activate this plan? Your current active plan will be deactivated.")) {
                return;
            }

            fetch("Pricing.aspx/ActivatePlan", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({ planId: planId })
            })
                .then(res => res.json())
                .then(data => {
                    if (data.d.success) {
                        alert("Plan activated successfully!");
                        location.reload();
                    } else {
                        alert("Error: " + data.d.message);
                    }
                })
                .catch(err => {
                    console.error(err);
                    alert("An error occurred. Please try again.");
                });
        }

        // Start Trial / Purchase Plan Function
        document.addEventListener("DOMContentLoaded", function () {
            const buttons = document.querySelectorAll(".start-trial-btn");

            buttons.forEach((btn) => {
                btn.addEventListener("click", function () {
                    const planId = this.dataset.planid;
                    const cycle = isAnnual ? "annual" : "monthly";

                    fetch("Pricing.aspx/CreateCheckoutSession", {
                        method: "POST",
                        headers: { "Content-Type": "application/json" },
                        body: JSON.stringify({ planId: planId, cycle: cycle })
                    })
                        .then(res => res.json())
                        .then(data => {
                            stripe.redirectToCheckout({ sessionId: data.d.id });
                        })
                        .catch(err => console.error(err));
                });
            });
        });
    </script>

    <script>
        const annualBtn = document.getElementById("annualBtn");
        const monthlyBtn = document.getElementById("monthlyBtn");
        const toggleSlider = document.getElementById("toggleSlider");
        let isAnnual = false; // ✅ default monthly

        // Update prices
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

            document.querySelectorAll(".period").forEach(el => {
                el.textContent = isAnnual ? "/annual" : "/monthly";
            });
        }

        // Toggle buttons
        annualBtn.addEventListener("click", function () {
            toggleSlider.style.transform = "translateX(0)";
            annualBtn.classList.add("active");
            monthlyBtn.classList.remove("active");
            updatePrices(true);
            isAnnual = true;
        });

        monthlyBtn.addEventListener("click", function () {
            toggleSlider.style.transform = "translateX(calc(100% - 0.25rem))";
            monthlyBtn.classList.add("active");
            annualBtn.classList.remove("active");
            updatePrices(false);
            isAnnual = false;
        });

        // ✅ Run on load (default monthly)
        document.addEventListener("DOMContentLoaded", function () {
            updatePrices(false);
        });
    </script>
</body>
</html>