import UIKit
import AVFoundation

class ViewController: UIViewController {

    let synthesizer = AVSpeechSynthesizer()
    var speechRate: Float = 1.0  // Default to normal speed

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func setSlowSpeed(_ sender: UIButton) {
        speechRate = 0.5
        print("Speech speed set to Slow (0.5x)")
    }

    @IBAction func setNormalSpeed(_ sender: UIButton) {
        speechRate = 1.0
        print("Speech speed set to Normal (1x)")
    }

    @IBAction func setFastSpeed(_ sender: UIButton) {
        speechRate = 1.5
        print("Speech speed set to Fast (1.5x)")
    }

}
