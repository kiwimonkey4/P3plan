import SwiftUI
import UIKit
import Foundation




class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var cameraPreview: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tappedCameraButton(_ sender: Any) {
        
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated:true)
        
    }
    
        
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]){
        
        //Put the image if chose "take image" into the image view seection
        cameraPreview.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
 
        saveToDirectory(cameraPreview.image)

        picker.dismiss(animated: true, completion: nil)
        
    }

    // Function takes in an image and saves it to the app's local directory
    func saveToDirectory (_ image: UIImage?) {


        // Create an image path so long as image is not nil
        if let picker_jpg = image!.jpegData(compressionQuality: 0.5), let image_path = documentDirectoryPath()?.appendingPathComponent("CurrentImage.jpg") {
            
            //Show image path
            print(image_path)
            world()
            sendImage(file_path: image_path.path)
            
            try? FileManager.default.removeItem(at: image_path)

            // Add image to the app's directory
            try? picker_jpg.write(to: image_path)
        }
    }

    func documentDirectoryPath() -> URL? {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path.first
    }

}


