<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="temp.aspx.cs" Inherits="airesumebuilder.temp" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Gemini Response</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #ece9e6, #ffffff);
            margin: 0;
            padding: 0;
        }
        .container {
            width: 80%;
            max-width: 800px;
            margin: 50px auto;
            background: #fff;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        h2 {
            color: #333;
            text-align: center;
            margin-bottom: 20px;
        }
        .response-box {
            padding: 15px;
            border: 1px solid #ccc;
            border-radius: 8px;
            background: #f9f9f9;
            white-space: pre-wrap;
        }
        .back-btn {
            display: block;
            margin: 20px auto 0;
            text-align: center;
        }
        .back-btn a {
            background: #007BFF;
            color: white;
            padding: 10px 18px;
            border-radius: 8px;
            text-decoration: none;
        }
        .back-btn a:hover {
            background: #0056b3;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2>Gemini Response</h2>
            <asp:Label ID="lblResponse" runat="server" CssClass="response-box"></asp:Label>
            <div class="back-btn">
                <a href="Home.aspx">⬅ Back</a>
            </div>
        </div>
    </form>
</body>
</html>
