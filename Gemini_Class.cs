using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace airesumebuilder
{
    public class Gemini_Class
    {
        // helper class for Gemini API (so we can reuse in ChatPlayGround.aspx.cs too)
        public static string CallGemini(string promptText)
        {
            //string apiKey = "AIzaSyDyIMwEVv1fimGDa94nEWH-9WmfVFQfdEA";
            string apiKey = "AIzaSyDHk1MSLzl1z4XgJZRciZKreYeUPnVoRAk";
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
            //string apiKey = "AIzaSyDyIMwEVv1fimGDa94nEWH-9WmfVFQfdEA";
            string apiKey = "AIzaSyDHk1MSLzl1z4XgJZRciZKreYeUPnVoRAk";
            string apiUrl = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent";

            string systemPrompt =
@"You are an elite AI resume builder. Generate EXACTLY three COMPLETE, SELF-CONTAINED HTML documents (Design A, B, C) with embedded CSS only.
Do not include explanations, markdown fences, or any text outside the three HTML documents.

Data and enrichment rules:
- Use the provided user details as the single source of truth; infer missing but realistic items that align with the profile.
- Add meaningful fields where absent: Key Achievements (quantified), Core Competencies, Tools & Technologies, Certifications, Notable Projects, Awards, Languages, Links (Portfolio/GitHub/LinkedIn if hinted), Interests (subtle).
- Convert bullet content to action-driven, quantified statements where possible.
- Normalize contact data and section ordering for clarity.

Design and engineering requirements (apply to all three):
- Responsiveness: Must render beautifully on mobile, tablet, and desktop. Use modern CSS (Grid/Flex), container queries if helpful, and fluid typography.
- Accessibility: Use semantic landmarks, sensible heading hierarchy, sufficient contrast, focus styles, aria-labels where relevant, alt text placeholders if needed.
- Print styles: Include @media print rules to ensure crisp one- to two-page printouts, hiding non-essential UI flourishes.
- Performance: No external fonts/CSS/JS. Use system font stacks and CSS variables. Keep CSS compact but clear.
- Microdata: Add schema.org Person microdata on the root resume container. Mark email, telephone, address where present.
- Consistency: Ensure all user details appear consistently across all three designs. Fill with tasteful placeholders ONLY if a field is missing.

Style variety:
- Design A: Modern Professional — clean typographic rhythm, subtle accent color, CSS Grid-based layout.
- Design B: Creative — bold headings, sidebar layout using Flexbox, tasteful gradient or soft shadows.
- Design C: Executive Classic — refined serif headings, minimal color, traditional structure, hybrid Grid/Flex.

Output format constraints:
- Output THREE standalone HTML documents back-to-back; each begins with <!DOCTYPE html> and contains <html>, <head>, <meta name='viewport'>, <style>, and <body>.
- Each document must validate as HTML5 and contain only inline CSS in a single <style> tag.
- Never include code fences or commentary.";


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