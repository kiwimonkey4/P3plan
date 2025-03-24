// Import necessary libraries
import Foundation


var outputImage : String? // Variable holds result of POST request as an optional variable

// This function takes in a path to an image as a string, converts it into a multipart-form request and prints labeled image output to the console
func sendImage(file_path: String) {
    
    // Define important constants
    let url = URL(string: "http://172.17.41.247:8000/")! // This URL is where the backend server is located. Must be on same network to use this for now
    let boundary = "monkeysareawesomesauce" // Boundary string to separate each part of multipart request
    let newline = "\r\n".data(using: .utf8)
    let file = URL(fileURLWithPath: file_path)
    
    // Handle possible errors with opening the file 
    if let file_binary = try?Data(contentsOf:file) {

        // Define what the HTTP request will look like 
        var http_request = URLRequest(url:url)
        http_request.httpMethod = "POST"
        http_request.setValue("multipart/form-data; boundary = \(boundary)",forHTTPHeaderField: "Content-Type")
        http_request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        // Define all parts of the multipart form request
        var request_body = Data()
        request_body.append("--\(boundary)".data(using: .utf8)!)
        request_body.append(newline!)
        request_body.append("Content-Disposition: form-data; name=\"file\"; filename=\"image.jpg\"".data(using: .utf8)!)
        request_body.append(newline!)
        request_body.append("Content-Type: image/jpeg".data(using: .utf8)!)
        request_body.append(newline!)
        request_body.append(newline!)
        request_body.append(file_binary)
        request_body.append(newline!)
        request_body.append("--\(boundary)--".data(using: .utf8)!)
        request_body.append(newline!)
        http_request.httpBody = request_body

        // Set up the POST request
        let task = URLSession.shared.dataTask(with: http_request) {(data,response,error) in
    
            // Handle potential errors
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }

            // Output labeled image response from backend server
            if let data = data {
                let responseString = String(data: data, encoding: .utf8)
                outputImage = "\(responseString ?? "")"
                return
            }
        }

        // Actually send the POST request 
        task.resume()

    } else {
        outputImage = "THERE WAS ERROR"
    }
}
