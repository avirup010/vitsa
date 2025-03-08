
{
    "name": "vitsa-chatbot",
    "version": "1.0.0",
    "description": "An all-in-one chatbot using DeepSeek API",
    "main": "app.js",
    "scripts": {
      "start": "node app.js",
      "dev": "nodemon app.js"
    },
    "keywords": [
      "chatbot",
      "AI",
      "DeepSeek",
      "Vitsa"
    ],
    "author": "",
    "license": "MIT",
    "dependencies": {
      "axios": "^1.6.2",
      "body-parser": "^1.20.2",
      "cors": "^2.8.5",
      "dotenv": "^16.3.1",
      "express": "^4.18.2"
    },
    "devDependencies": {
      "nodemon": "^3.0.1"
    }
  }
  
  
  PORT=5500
  DEEPSEEK_API_KEY=sk-54dce2ff3e1e4d0e84ec4bd20099c360
  
  // File: README.md
  # Vitsa - All-in-One AI Chatbot
  
  Vitsa is a dynamic and versatile AI chatbot powered by DeepSeek's API. It features a responsive UI with multiple themes and customization options.
  
  ## Features
  
  - Interactive chat interface with animated messages
  - Multiple AI model selection
  - Adjustable AI temperature parameter
  - Light and dark theme options
  - Responsive design for all devices
  - Markdown-like text formatting
  
  ## Setup Instructions
  
  1. Clone this repository
  2. Install dependencies:
     ```
     npm install
     ```
  3. Create a `.env` file based on `.env.example` and add your DeepSeek API key
  4. Start the server:
     ```
     npm start
     ```
  5. Access the application at `http://localhost:3000`
  
  ## Technology Stack
  
  - **Backend**: Node.js, Express
  - **Frontend**: HTML, CSS, JavaScript
  - **Styling**: Tailwind CSS
  - **Icons**: Font Awesome
  - **API**: DeepSeek API
  
  ## Customization
  
  You can customize Vitsa by:
  - Adding more models in the `/api/models` endpoint
  - Changing the color themes in CSS variables
  - Adding additional settings in the settings panel
  
  ## License
  
  MIT