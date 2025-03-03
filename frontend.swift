import Foundation 
/*
Function takes in binary image data and creates+sends an HTTP request to the backend server for a response
*/

// Define all relevant constants 
let url = URL(string: "http://172.18.103.39:8000") // Backend server URL
let boundary = "bitchasschimpanzee".data(using: .utf8) // Boundary string converted to binary to separate multipart form data
let new_line = "\r\n".data(using: .utf8)

// Create an HTTP request and define that it is a POST request (sends data)
let http_request = URLRequest(url: url!) // Exclamation mark for force-unwrapping
http_request.httpMethod = "POST"

func sendImage(image: Data) {
  
  // Define content as multipart form-data to the server
  let content_type = "multipart/form-data; boundary=\(boundary!)"
  http_request.setValue(content_type, forHTTPHeaderField: "Content-Type")

  var request_body = Data()
  
  request_body.append(boundary!) // Indicates beginning of data part 
  request_body.append(new_line!)
  request_body.append("Content-Disposition: form-data; name=\"file\"; filename=\"image.jpg\"") // Name of the file to be uploaded
  request_body.append(new_line!)
  request_body.append("Content-Type: image/jpeg") // Specifies that image is uploaded as jpeg 
  request_body.append(new_line!)
  request_body.append(image) // Add image data to request body
  request_body.append(new_line!)
  request_body.append(boundary!) // Indicates end of data part 

  http_request.httpBody = request_body // Set body of HTTP request equal to the body as defined above 

  /*
  data -> response data from the server
  response -> HTTP response number
  error -> error message if there is one

  */

  // Create a task to send the request to the server
  let task = URLSession.shared.dataTask(with: http_request) { (data, response, error) in
                                                        
    // Print error to console if there is one while interacting with the server
    if let error = error {
        print("Error: \(error.localizedDescription)")
        return
    }

    // Print server response to the console
    if let data = data {
        let responseString = String(data: data, encoding: .utf8)
        print("Response: \(responseString ?? "")")
    }
  }

  // Start the URLSession task
  task.resume()
  
}

// Creates URL for image stored on disk 
let file = URL(fileURLWithPath: "cinnamon.jpg") // Note that fileURLWithPath is the constructor for the URL object and the colon corresponds to the instance variable

// Convert image file into binary format 
if let file_binary = try?Data(contentsOf: file) {
  print("Image converted to Data: \(file_binary.count) bytes")
  
  // Send image to backend server
  sendImage(image: file_binary)
  
} else {
  print("Error: Could not convert image to Data!!") // Executed if missing file exception is caught 
}
