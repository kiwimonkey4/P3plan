# Import necessary libraries and packages
import openai 
from flask import Flask, request, jsonify 
from flask_cors import CORS
import os 
import dotenv
import base64

# Instantiate flask object
app = Flask(__name__) 

# Enable cross-origin resource sharing -> Important for info sharing w/ iPhone frontend
CORS(app)

# Load sensitive variables from .env file and set up OpenAI client in program
dotenv.load_dotenv()
client = openai.OpenAI(api_key = os.getenv("gpt_key"))
gpt_model = "gpt-4o-mini" # WARNING WARNING WARNING -> DO NOT CHANGE THIS MODEL

# Function takes in image and converts it through binary -> base64 -> utf-8 to be processed by API 
def image_converter(img):
    return base64.b64encode(img.read()).decode("utf-8")

# Create route for URL and ensure route only handles POST request
@app.route('/', methods = ['POST'])

# Function sends labeled image back to client
def home():

    # Access image file in HTTP request and encode to send over HTTP 
    file = request.files["file"]
    converted_image = image_converter(file) # Convert image into format usable to send via HTTP 

    # Define parameters for API request and describe what the output should look like 
    response = client.chat.completions.create(
        model = gpt_model,
            messages=[
                {
                    "role": "system",
                    "content": [
                        {"type": "text",
                        "text": "Your role is to label images"
                        }
                    ],
                },
                {
                    "role": "user",
                    "content": [
                        {
                            "type":"text",
                            "text": "Give me the label with brand name and no more information than necessary"
                        },
                        {
                            "type": "image_url",
                            "image_url": 
                                {
                                    "url": f"data:image/jpg;base64,{converted_image}"
                                }
                        }
                    ]
                }
            ],
            max_tokens = 15 # Sets a maximum value on length of response 
        )
    
    # Extract image's label from the JSON object
    label = response.choices[0].message.content
    return jsonify({"image label":label})
    

# Starts the Flask application 
if __name__ == "__main__":
    app.run(host = "0.0.0.0",port = 8000, debug = True) # Set flask to listen for input on port 8000 and ensure requests can be accepted from any device on a given network