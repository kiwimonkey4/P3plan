@IBOutlet weak var loadingIndicator: UIActivityIndicatorView!


override func viewDidLoad() {
    super.viewDidLoad()
    loadingIndicator.isHidden = true // make sure it's hidden initially
}

func showLoadingForFewSeconds() {
    loadingIndicator.isHidden = false
    loadingIndicator.startAnimating()

    // Hide after 2.5 seconds
    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
        self.loadingIndicator.stopAnimating()
        self.loadingIndicator.isHidden = true
    }
}
