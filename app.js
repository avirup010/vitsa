// File: app.js
const express = require('express');
const axios = require('axios');
const cors = require('cors');
const bodyParser = require('body-parser');
require('dotenv').config();

const app = express();
const port = process.env.PORT || 5500;

// Middleware with expanded CORS options
app.use(cors({
  origin: '*', // Allow all origins
  methods: ['GET', 'POST'],
  allowedHeaders: ['Content-Type', 'Authorization']
}));
app.use(bodyParser.json());
app.use(express.static('public'));

// DeepSeek API handler with better error handling
async function callDeepSeekAPI(prompt, modelName = 'deepseek-chat') {
  try {
    console.log('Calling DeepSeek API with model:', modelName);
    const response = await axios.post(
      'https://api.deepseek.com/v1/chat/completions',
      {
        model: modelName,
        messages: [{ role: 'user', content: prompt }],
        temperature: 0.7,
      },
      {
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${process.env.DEEPSEEK_API_KEY}`
        }
      }
    );
    
    return response.data.choices[0].message.content;
  } catch (error) {
    console.error('Error calling DeepSeek API:');
    if (error.response) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx
      console.error('Response data:', error.response.data);
      console.error('Response status:', error.response.status);
      console.error('Response headers:', error.response.headers);
      throw new Error(`DeepSeek API error: ${error.response.status} - ${JSON.stringify(error.response.data)}`);
    } else if (error.request) {
      // The request was made but no response was received
      console.error('No response received:', error.request);
      throw new Error('No response received from DeepSeek API');
    } else {
      // Something happened in setting up the request that triggered an Error
      console.error('Error setting up request:', error.message);
      throw new Error(`Request setup error: ${error.message}`);
    }
  }
}

// Chat endpoint with detailed logging
app.post('/api/chat', async (req, res) => {
  console.log('Received chat request');
  try {
    const { message, model, history } = req.body;
    console.log(`Processing message with model: ${model}`);
    
    // Construct prompt with conversation history
    const formattedHistory = history.map(msg => 
      `${msg.role === 'user' ? 'Human' : 'Vitsa'}: ${msg.content}`
    ).join('\n');
    
    const prompt = formattedHistory 
      ? `${formattedHistory}\nHuman: ${message}\nVitsa:`
      : `Human: ${message}\nVitsa:`;
    
    const response = await callDeepSeekAPI(prompt, model);
    console.log('Successfully got response from DeepSeek');
    res.json({ success: true, reply: response });
  } catch (error) {
    console.error('Error processing chat request:', error.message);
    res.status(500).json({ success: false, error: error.message });
  }
});

// Available models endpoint
app.get('/api/models', async (req, res) => {
  console.log('Received models request');
  try {
    // You could fetch this dynamically from DeepSeek if they provide such an endpoint
    const models = [
      { id: 'deepseek-chat', name: 'DeepSeek Chat' },
      { id: 'deepseek-coder', name: 'DeepSeek Coder' },
      { id: 'deepseek-llama-3', name: 'DeepSeek Llama 3' }
    ];
    res.json({ success: true, models });
  } catch (error) {
    console.error('Error fetching models:', error.message);
    res.status(500).json({ success: false, error: error.message });
  }
});

// Add a test endpoint to verify server is working
app.get('/api/test', (req, res) => {
  res.json({ success: true, message: 'Vitsa server is running correctly!' });
});

app.listen(port, () => {
  console.log(`Vitsa server running on port ${port}`);
  console.log(`Access your chatbot at http://localhost:${port}`);
});