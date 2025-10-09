# AI Resume Builder

This is an AI-powered resume builder web application built with ASP.NET. It allows users to input their professional information and generate multiple resume designs using the Google Gemini API. The application also features a chatbot for interactive assistance.

## Features

* **User Authentication**: Users can register and log in to the application.
* **AI-Powered Resume Generation**:
    * Input fields for personal details, professional summary, work experience, education, and skills.
    * Generates three distinct resume designs (Modern Professional, Creative Design, and Executive Classic) using the Gemini API.
    * Saves generated resumes for future access.
* **Interactive Chatbot**:
    * A chatbot powered by the Gemini API to assist users.
    * Maintains conversation history for each chat session.
* **User Profile Management**: Users can view and edit their profile information.
* **Subscription Plans**: The application includes functionality for creating and managing subscription plans for users and used STRIPE payment gateway.

## Tech Stack

* **Backend**: C#, ASP.NET Web Forms
* **Database**: Microsoft SQL Server
* **Frontend**: HTML, CSS, JavaScript
* **AI**: Google Gemini API
* **Payment Gateway**: Stripe Test Account
### Libraries & Packages
```
Markdig              - Markdown to HTML conversion
Newtonsoft.Json      - JSON serialization/deserialization
Stripe.net           - Payment processing
```

### Setup Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/makwanagautam41/airesumebuilder.git
   cd airesumebuilder
   ```

2. **Open in Visual Studio**
   ```
   Double-click on airesumebuilder.sln
   ```

3. **Restore NuGet Packages**
   - Right-click on the solution in Solution Explorer
   - Select "Restore NuGet Packages"
   - Wait for all packages to download

4. **Configure Database**
   
   The project uses a local SQL Server database file (`ai_resume_builder_db.mdf`) in the `App_Data` directory.
   
   **Connection String** (Web.config):
   ```xml
   <connectionStrings>
     <add name="constr" connectionString="Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|ai_resume_builder_db.mdf;Integrated Security=True" />
   </connectionStrings>
   ```

5. **Configure API Keys**

   **Gemini API Key** (Gemini_Class.cs):
   ```csharp
   private const string API_KEY = "YOUR_GEMINI_API_KEY_HERE";
   ```
   
   **Stripe API Key** (Web.config):
   > Setup this STRIPE api keys only for local if you push this code then will not be pushed so use only for local
   ```xml
   <appSettings>
     <add key="StripeSecretKey" value="YOUR_STRIPE_SECRET_KEY" />
     <add key="StripePublishableKey" value="YOUR_STRIPE_PUBLISHABLE_KEY" />
   </appSettings>
   ```

7. **Build the Solution**
   ```
   Build > Build Solution (Ctrl+Shift+B)
   ```

8. **Run the Application**
   ```
   Debug > Start Debugging (F5)
   ```

The application will launch in your default browser at `https://localhost:XXXX/`

---  **Run the application**: Press F5 or click the "Start" button in Visual Studio to run the application.

## Usage

### Resume Builder

1.  Navigate to the **Resume Builder** page.
2.  Fill in the form with your personal and professional details.
3.  Click the **Generate** button.
4.  You will be redirected to the **Resume Playground**, where you can view and choose from the three generated resume designs.

### Chatbot

1.  From the **Home** page, you can start a new chat by typing a message in the textbox and clicking **Submit**.
2.  You can view your past chat sessions and continue conversations.

## 🤝 Contributing

Contributions are what make the open-source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

### How to Contribute

1. **Fork the Project**
2. **Create your Feature Branch**
   ```bash
   git checkout -b feature/AmazingFeature
   ```
3. **Commit your Changes**
   ```bash
   git commit -m 'Add some AmazingFeature'
   ```
4. **Push to the Branch**
   ```bash
   git push origin feature/AmazingFeature
   ```
5. **Open a Pull Request**

### Contribution Guidelines

- Follow existing code style and conventions
- Write clear commit messages
- Update documentation for new features
- Add tests for new functionality
- Ensure all tests pass before submitting PR

---

<div align="center">

## 👥 Meet The Team

<table>
  <tr>
    <td align="center">
      <a href="https://github.com/makwanagautam41">
        <img src="https://github.com/makwanagautam41.png" width="100px;" alt="Gautam Makwana"/><br />
        <sub><b>Gautam Makwana</b></sub>
      </a><br />
      <sub>Lead Developer</sub>
    </td>
    <td align="center">
      <a href="https://github.com/DhruvrajZala46">
        <img src="https://github.com/DhruvrajZala46.png" width="100px;" alt="Dhruvraj Zala"/><br />
        <sub><b>Dhruvraj Zala</b></sub>
      </a><br />
      <sub>Full Stack Developer</sub>
    </td>
    <td align="center">
      <a href="https://github.com/tushal33">
        <img src="https://github.com/tushal33.png" width="100px;" alt="Tushal Bhadani"/><br />
        <sub><b>Tushal Bhadani</b></sub>
      </a><br />
      <sub>Frontend Developer</sub>
    </td>
  </tr>
</table>

</div>

---

<div align="center">

### 💝 Made with passion and dedication

**© 2025 AI Resume Builder Team. All rights reserved.**

*Empowering careers through AI-driven resume solutions*

</div>
