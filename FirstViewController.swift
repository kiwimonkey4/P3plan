import UIKit
import SwiftUI
import Foundation

class FirstViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var scanButton: UIButton!
    var selectedImage: UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func tappedScanButton(_ sender: Any) {
        
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated:true)
    }
    
    func documentDirectoryPath() -> URL? {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path.first
    }
    
    
    func saveToDirectory (_ image: UIImage?) {


        // Create an image path so long as image is not nil
        if let picker_jpg = image!.jpegData(compressionQuality: 0.5), let image_path = documentDirectoryPath()?.appendingPathComponent("CurrentImage.jpg") {
            
            //Show image path
            print(image_path)
            try? picker_jpg.write(to: image_path)
            sendImage(file_path: image_path.path)
            //sendImage(file_path: "/Users/muhammadabdullahshuaib/Downloads/kernel.jpg")
            
            try? FileManager.default.removeItem(at: image_path)

            // Add image to the app's directory
            //try? picker_jpg.write(to: image_path)
        }
    }

    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true) {
            if let pickedImage = info[.editedImage] as? UIImage {
                self.selectedImage = pickedImage
                self.navigateToSecondViewController()
            }
        }
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
    }

    func navigateToSecondViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let secondVC = storyboard.instantiateViewController(withIdentifier: "second_viewcontroller") as? SecondViewController {
                secondVC.passedImage = self.selectedImage  // Pass the image
                self.present(secondVC, animated: true, completion: nil)
            saveToDirectory(secondVC.passedImage)
            
            }
    }
    
    

    
    
    @IBAction func settingButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let thirdController = storyboard.instantiateViewController(withIdentifier: "third_viewcontroller")
        self.present(thirdController, animated: true, completion: nil)
        
    }
    
    
    
}

