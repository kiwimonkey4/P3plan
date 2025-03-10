import UIKit
import UIImage

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

    func imagePickerController( picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]){
        
        //Put the image if chose "take image" into the image view seection
        cameraPreview.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage

        saveToDirectory(image: cameraPreview.image)
        picker.dismiss(animated: true, completion: nil)
        
        
    }

    // Function takes in an image and saves it to the app's local directory
    func saveToDirectory (_ image: UIImage?) { 


        // Create an image path so long as image is not nil 
        if let image_jpg = image.jpegData(compressionQuality: 0.5), let image_path = documentDirectoryPath()?.appendingPathComponent("CurrentImage.jpg") {
            
            //Show image path
            print(image_path)
            // Add image to the app's directory 
            try? jpgData.write(to: image_path)
        }
    }

}
