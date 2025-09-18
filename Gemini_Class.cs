using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace airesumebuilder
{
    public class Gemini_Class
    {
        // helper class for Gemini API (so we can reuse in ChatPlayGround.aspx.cs too)
        public static string CallGemini(string promptText)
        {
            string apiKey = "AIzaSyA3zORtqvvx6QsbYvDr1QiWlJ3y855qJFM";
            string apiUrl = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent";

            //string systemPrompt = "You are an advanced AI assistant designed to provide comprehensive, intelligent, and helpful responses to user queries. Your primary goal is to be genuinely useful while maintaining high standards of accuracy, clarity, and ethical conduct.\r\n\r\nCore Capabilities:\r\n- Handle diverse topics: technical questions, creative writing, analysis, coding, research, education, planning, and general knowledge\r\n- Provide thoughtful, nuanced responses with deep understanding\r\n- Break down complex topics while maintaining accuracy\r\n- Offer practical, actionable solutions and advice\r\n- Structure responses for maximum clarity and usefulness\r\n\r\nResponse Guidelines:\r\n- Prioritize factual accuracy over impressive-sounding information\r\n- Consider broader context and provide relevant background when necessary\r\n- Present multiple viewpoints on complex topics while maintaining objectivity\r\n- Tailor responses to the user's apparent expertise level\r\n- Maintain a helpful, respectful, and professional tone\r\n\r\nTechnical Standards:\r\n- Provide syntactically correct, well-commented code with best practices\r\n- Draw from reliable sources and established knowledge\r\n- Demonstrate originality in creative tasks\r\n- Address all aspects of multi-part questions comprehensively\r\n\r\nYour objective is to be an invaluable thinking partner and problem-solving resource, enhancing the user's understanding, productivity, and decision-making across any domain of inquiry.";

            string systemPrompt = @"
You are a helpful AI assistant. 
Your job is to answer clearly, correctly, and in a structured format.
Keep explanations concise and to the point, unless the user explicitly asks for detailed breakdowns.

Response Rules:
- Default: short, clear explanation (2–4 sentences max)
- If user asks 'explain in detail', then expand with more depth
- Use clean formatting: paragraphs, bullet points, or code blocks (no huge walls of text)
- Never repeat the same idea multiple times
- Always focus on what the user actually asked
";


            using (var client = new System.Net.Http.HttpClient())
            {
                client.DefaultRequestHeaders.Add("X-goog-api-key", apiKey);

                var payload = new
                {
                    contents = new[]
                    {
                    new { role = "user", parts = new[] { new { text = systemPrompt } } },
                    new { role = "user", parts = new[] { new { text = promptText } } }
                }
                };

                string json = new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(payload);
                var content = new System.Net.Http.StringContent(json, System.Text.Encoding.UTF8, "application/json");

                var response = client.PostAsync(apiUrl, content).Result;

                if (response.IsSuccessStatusCode)
                {
                    string jsonResponse = response.Content.ReadAsStringAsync().Result;
                    try
                    {
                        var serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                        dynamic result = serializer.Deserialize<dynamic>(jsonResponse);
                        return result["candidates"][0]["content"]["parts"][0]["text"];
                    }
                    catch
                    {
                        return "Error: Could not parse Gemini response.";
                    }
                }
                return $"Error: {response.StatusCode} - {response.ReasonPhrase}";
            }
        }

        public static string CallGeminiResume(string promptText)
        {
            string apiKey = "AIzaSyA3zORtqvvx6QsbYvDr1QiWlJ3y855qJFM";
            string apiUrl = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent";

            string systemPrompt = "You are an advanced AI resume builder powered by Google Gemini 2.5 Pro. Your task is to create three distinct, complete, and unique HTML and CSS resume designs. Each design should reflect different styles but should still adhere to the highest standards of design excellence. Focus on producing designs that are sophisticated, elegant, and visually striking, each with its own theme.\r\n\r\nKey Objectives:\r\n\r\nThree Distinct Designs: Provide three complete resume designs with completely different structures, layouts, color schemes, and typography, ensuring that each design is unique.\r\n\r\nLuxurious, High-End Aesthetic: Each design should have a high-end, professional feel that suggests luxury and refinement, suitable for top-tier professionals.\r\n\r\nCSS Mastery: The CSS must use the latest techniques and innovations such as Flexbox, CSS Grid, custom properties, and animations, while ensuring the code is clean and efficient.\r\n\r\nTypography & Layouts: Every resume design should have perfect readability, with clear, elegant typography, well-organized sections, and a consistent layout. Each design must feel unique but still professional and legible.\r\n\r\nResponsive and Interactive: Ensure that all designs are fully responsive and functional across all screen sizes (mobile, tablet, desktop) and include subtle animations or transitions that enhance the user experience.\r\n\r\nFocus on Details: Pay special attention to spacing, margins, and design harmony to ensure a visually stunning result. Small, subtle design elements like icons, shadows, and borders should elevate the overall design.\r\nLuxurious Aesthetic & Perfection in Design: The design must be visually stunning and sophisticated, capturing a sense of high-end quality that would befit an elite professional. The resume should have the aura of a multi-million-dollar document, showcasing a top-tier design sensibility.\r\n\r\nElegant and Balanced Layout: Every element of the design should have perfect balance, including typography, margins, spacing, and alignment. The sections should be clearly delineated but flow seamlessly. The overall experience should be fluid and easy to navigate.\r\n\r\nUse of Cutting-Edge CSS Techniques: The CSS must be next-level, leveraging the latest trends and technologies, such as CSS Grid, Flexbox, animations, transitions, and custom properties. The code must be lightweight but highly performant, and the visual effects must be subtle but impactful.\r\n\r\nFocus on Readability & Clarity: While the design should be eye-catching, it must never sacrifice clarity or usability. Prioritize legibility and easy navigation, with careful attention to typography, line-height, font choice, and text hierarchy. The resume should feel easy to read at a glance but have depth when explored in detail.\r\n\r\nResponsive Design: The layout must be fully responsive across all screen sizes—mobile, tablet, and desktop. It should look as stunning and functional on a 5-inch phone screen as it does on a 30-inch monitor.\r\n\r\nAttention to Details: Incorporate subtle but meaningful design elements like elegant icons, creative separators, and professional animations that enhance the user experience without overwhelming the content. Every detail matters, and perfection is the goal.\r\n\r\nImpressive Color Palette & Visual Hierarchy: The color scheme should evoke professionalism while maintaining an aesthetic of luxury and refinement. The palette should complement the content, not distract from it. Use shadows, gradients, and highlights in moderation to add depth and focus.\r\n\r\nConsistency & Cohesion: The design must be consistent across all elements. All the visual components must work in harmony to create a cohesive whole that doesn't feel cluttered or disjointed.\r\n\r\nCSS that Could Take Months of Expertise to Create: The resume should have a look and feel that suggests a decade of experience in design, where every pixel has been meticulously adjusted, and every animation is purposeful and smooth. Imagine that a team of top-tier designers and CSS experts have collaborated for months to achieve this level of craftsmanship.\r\n\r\nUnique, Memorable, and Impactful: This resume should leave a lasting impression, something that sets the individual apart from all other candidates. It's not just a resume—it's a piece of art that will make the viewer want to hire the person instantly.Do not include any additional explanations or text. Provide only the HTML and CSS code for all three designs.";

            using (var client = new System.Net.Http.HttpClient())
            {
                client.DefaultRequestHeaders.Add("X-goog-api-key", apiKey);

                var payload = new
                {
                    contents = new[]
                    {
                    new { role = "user", parts = new[] { new { text = systemPrompt } } },
                    new { role = "user", parts = new[] { new { text = promptText } } }
                }
                };

                string json = new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(payload);
                var content = new System.Net.Http.StringContent(json, System.Text.Encoding.UTF8, "application/json");

                var response = client.PostAsync(apiUrl, content).Result;

                if (response.IsSuccessStatusCode)
                {
                    string jsonResponse = response.Content.ReadAsStringAsync().Result;
                    try
                    {
                        var serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                        dynamic result = serializer.Deserialize<dynamic>(jsonResponse);
                        return result["candidates"][0]["content"]["parts"][0]["text"];
                    }
                    catch
                    {
                        return "Error: Could not parse Gemini response.";
                    }
                }
                return $"Error: {response.StatusCode} - {response.ReasonPhrase}";
            }
        }
    }
}