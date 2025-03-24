# Import necessary libraries and packages
import openai 
from flask import Flask, request, jsonify 
from flask_cors import CORS
import os 
import dotenv
import base64

# Instantiate Flask app 
app = Flask(__name__) 

# Load sensitive variables from .env file and set up OpenAI client in program
dotenv.load_dotenv()
client = openai.OpenAI(api_key = os.getenv("gpt_key"))
gpt_model = "gpt-4o-mini" # WARNING WARNING WARNING -> DO NOT CHANGE THIS MODEL

def image_converter(img):
    '''Function takes in an image as input and converts it to binary -> base64 and then returns utf-8 for API processing ''
    return base64.b64encode(img.read()).decode("utf-8")

# Create route for URL and ensure route only handles POST request
@app.route('/', methods = ['POST'])

def home():
    '''This functions sends a labeled image back to the client'''
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
                            #"text": "Give me the label with brand name and no more information than necessary"
                            "text": "Give me the item im looking at with a brand name and no extra information"
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

    # Send the image label to the client
    label = response.choices[0].message.content
    return label

# Start the Flask application 
if __name__ == "__main__":
    app.run(host = "0.0.0.0",port = 8000, debug = True) # Set flask to listen for input on port 8000 and ensure requests can be accepted from any device on a given network
