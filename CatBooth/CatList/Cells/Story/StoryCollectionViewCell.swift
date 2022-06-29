import UIKit

class StoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    var imageService: ImageProtocol?
    weak var delegate: CatListViewProtocol?
    
    var tagText: String? {
        didSet {
            load(tagText)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.red.cgColor

        let gesture = UITapGestureRecognizer(target: self, action:  #selector(openImage))
        contentView.addGestureRecognizer(gesture)
    }
    
    func load(_ tag: String?) {
        guard let tag = tag else { return }
        self.label.text = tag
        
        imageService?.downloadImage(id: tag, completion: { image in
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        })
    }
    
    @objc func openImage(_ sender:UITapGestureRecognizer){
        delegate?.show(image: imageView.image)
    }
}
