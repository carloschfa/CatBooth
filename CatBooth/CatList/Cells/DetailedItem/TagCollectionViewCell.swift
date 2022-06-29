import UIKit

class TagCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var tagView: UIView!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        tagView.layer.cornerRadius = 12
        tagView.clipsToBounds = true
        tagView.backgroundColor = .random()
    }
}
