<%@ Page Language="C#" Async="true" AutoEventWireup="true" CodeBehind="Gen_Headshot.aspx.cs" Inherits="airesumebuilder.Gen_Headshot" %>
<!DOCTYPE html>
<html>
<head runat="server">
  <title>AI Headshot Generator</title>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <script src="https://cdn.tailwindcss.com"></script>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet" />
  <style>
    body {
      font-family: 'Inter', sans-serif;
    }
    .gradient-bg {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    }
    .file-upload-wrapper {
      position: relative;
      overflow: hidden;
      display: inline-block;
    }
    .file-upload-wrapper input[type=file] {
      position: absolute;
      left: -9999px;
    }
    .upload-animation {
      transition: all 0.3s ease;
    }
    .upload-animation:hover {
      transform: translateY(-2px);
      box-shadow: 0 10px 25px rgba(0,0,0,0.1);
    }
  </style>
</head>
<body class="bg-gradient-to-br from-purple-50 via-white to-blue-50 min-h-screen">
  <form id="form1" runat="server" enctype="multipart/form-data">
    
    <!-- Header -->
    <div class="gradient-bg text-white py-8 shadow-lg">
      <div class="container mx-auto px-4">
        <div class="flex items-center justify-center space-x-3">
          <svg class="w-10 h-10" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14.828 14.828a4 4 0 01-5.656 0M9 10h.01M15 10h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
          </svg>
          <h1 class="text-4xl font-bold">AI Headshot Generator</h1>
        </div>
        <p class="text-center mt-2 text-purple-100">Transform your photos into professional headshots using AI</p>
      </div>
    </div>

    <!-- Main Content -->
    <div class="container mx-auto px-4 py-12">
      <div class="max-w-2xl mx-auto">
        
        <!-- Upload Card -->
        <div class="bg-white rounded-2xl shadow-xl p-8 mb-8 upload-animation">
          <div class="text-center mb-8">
            <div class="inline-flex items-center justify-center w-20 h-20 bg-purple-100 rounded-full mb-4">
              <svg class="w-10 h-10 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
              </svg>
            </div>
            <h2 class="text-2xl font-bold text-gray-800 mb-2">Upload Your Photo</h2>
            <p class="text-gray-600">Choose a clear photo of yourself to get started</p>
          </div>

          <!-- File Upload Section -->
          <div class="mb-6">
            <div class="border-3 border-dashed border-purple-300 rounded-xl p-8 text-center bg-purple-50 hover:bg-purple-100 transition-colors cursor-pointer">
              <div class="file-upload-wrapper w-full">
                <label for="<%= FileUpload1.ClientID %>" class="cursor-pointer block">
                  <svg class="w-12 h-12 mx-auto mb-3 text-purple-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M15 13l-3-3m0 0l-3 3m3-3v12"></path>
                  </svg>
                  <span class="text-purple-600 font-semibold text-lg">Click to upload</span>
                  <span class="text-gray-500 text-sm block mt-1">or drag and drop</span>
                  <span class="text-gray-400 text-xs block mt-2">PNG, JPG or JPEG (MAX. 10MB)</span>
                </label>
                <asp:FileUpload ID="FileUpload1" runat="server" CssClass="hidden" />
              </div>
            </div>
          </div>

          <!-- Generate Button -->
          <div class="text-center">
            <asp:Button ID="BtnGenerate" runat="server" Text="✨ Generate Headshot" OnClick="BtnGenerate_Click" 
              CssClass="bg-gradient-to-r from-purple-600 to-blue-600 text-white font-bold py-4 px-8 rounded-xl hover:from-purple-700 hover:to-blue-700 transform hover:scale-105 transition-all duration-200 shadow-lg hover:shadow-xl cursor-pointer text-lg" />
          </div>
        </div>

        <!-- Status Message -->
        <div class="mb-8">
          <asp:Label ID="LblStatus" runat="server" CssClass="block text-center text-lg font-semibold py-3 px-6 rounded-lg bg-green-50 text-green-700 border border-green-200"></asp:Label>
        </div>

        <!-- Result Image -->
        <div class="text-center" id="resultContainer" runat="server" visible="false">
          <div class="bg-white rounded-2xl shadow-xl p-8 upload-animation">
            <h3 class="text-2xl font-bold text-gray-800 mb-6">Your AI Headshot</h3>
            <div class="flex justify-center">
              <asp:Image ID="ImgResult" runat="server" CssClass="rounded-xl shadow-2xl max-w-md w-full h-auto border-4 border-purple-200" />
            </div>
            <div class="mt-6 flex justify-center space-x-4">
              <button type="button" class="bg-purple-600 text-white font-semibold py-3 px-6 rounded-lg hover:bg-purple-700 transition-colors">
                Download
              </button>
              <button type="button" class="bg-gray-200 text-gray-700 font-semibold py-3 px-6 rounded-lg hover:bg-gray-300 transition-colors">
                Generate Another
              </button>
            </div>
          </div>
        </div>

      </div>
    </div>

    <!-- Footer -->
    <div class="text-center py-8 text-gray-600">
      <p class="text-sm">Powered by Advanced AI Technology</p>
    </div>

  </form>

  <script>
    // Display selected file name
    document.getElementById('<%= FileUpload1.ClientID %>').addEventListener('change', function (e) {
          if (this.files.length > 0) {
              const fileName = this.files[0].name;
              const label = this.closest('.file-upload-wrapper').querySelector('label');
              label.innerHTML = `
          <svg class="w-12 h-12 mx-auto mb-3 text-green-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
          </svg>
          <span class="text-green-600 font-semibold text-lg">${fileName}</span>
          <span class="text-gray-500 text-sm block mt-1">Click to change file</span>
        `;
          }
      });
  </script>
</body>
</html>