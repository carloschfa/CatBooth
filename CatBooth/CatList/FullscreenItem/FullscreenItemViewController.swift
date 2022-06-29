import UIKit

class FullscreenItemViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        imageView.image = nil
    }
    
    func setup(image: UIImage?) {
        imageView.image = image
    }
}
