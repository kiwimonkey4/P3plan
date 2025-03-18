import UIKit
import AVFoundation
import Foundation

class SecondViewController: UIViewController {

    
    var passedImage: UIImage?
    
    @IBOutlet weak var cameraPreview: UIImageView!
    
    @IBOutlet weak var speakButton: UIButton!
    
    let synthesizer = AVSpeechSynthesizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let image = passedImage {
            cameraPreview.image = image  // Set the image to the ImageView
            }
        // Do any additional setup after loading the view.
    }
    
    /*func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]){
        
        //Put the image if chose "take image" into the image view seection
        cameraPreview.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
 
        saveToDirectory(cameraPreview.image)

        picker.dismiss(animated: true, completion: nil)
        
    }*/
    

    /*func saveToDirectory (_ image: UIImage?) {


        // Create an image path so long as image is not nil
        if let picker_jpg = image!.jpegData(compressionQuality: 0.5), let image_path = documentDirectoryPath()?.appendingPathComponent("CurrentImage.jpg") {
            
            //Show image path
            print(image_path)
            try? picker_jpg.write(to: image_path)
            sendImage(file_path: image_path.path)
            
            try? FileManager.default.removeItem(at: image_path)

            // Add image to the app's directory
            //try? picker_jpg.write(to: image_path)
        }
    }
    
    func documentDirectoryPath() -> URL? {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path.first
    }*/
    

    
    
    
    
    @IBAction func spokenButton(_ sender: Any) {
        DispatchQueue.global(qos: .background).async { // Run in the background to prevent freezing
            /*let capturedOutput = captureConsoleOutput {
                sendImage(file_path: "frontend/Current.jpg")
                
            }*/
            
            
            

            /*if let outputString = String(data: capturedOutput, encoding: .utf8)?
                .trimmingCharacters(in: .whitespacesAndNewlines), !outputString.isEmpty {
                
                DispatchQueue.main.async { // Move back to the main thread for UI updates
                    self.speakText(outputString)
                }
            }*/
        }
        
        guard let outputString = outputImage, !outputString.isEmpty else {
                return
            }
        speakText(outputImage!)
    }
    
    func speakText(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        synthesizer.speak(utterance)
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

/*func captureConsoleOutput(_ closure: () -> Void) -> Data {
    let pipe = Pipe()
    let oldStdOut = dup(fileno(stdout)) // Save old stdout
    dup2(pipe.fileHandleForWriting.fileDescriptor, fileno(stdout)) // Redirect stdout

    closure() // Execute the closure

    fflush(stdout) // Flush stdout
    dup2(oldStdOut, fileno(stdout)) // Restore old stdout

    return pipe.fileHandleForReading.availableData // Read non-blocking data
}*/

