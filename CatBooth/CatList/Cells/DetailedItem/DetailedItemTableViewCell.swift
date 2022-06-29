import UIKit
import CoreAudio

class DetailedItemTableViewCell: UITableViewCell {

    var tags: [String] = []
    
    @IBOutlet weak var tagCollectionView: UICollectionView!
    @IBOutlet weak var detailedImageView: UIImageView!
    @IBOutlet weak var postedAtLabel: UILabel!
    
    var imageService: ImageProtocol?
    weak var delegate: CatListViewProtocol?
    
    var cat: Cat? {
        didSet {
            load(cat)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let cellNib = UINib(nibName: "TagCollectionViewCell", bundle: nil)
        tagCollectionView.register(cellNib, forCellWithReuseIdentifier: "TagCellIdentifier")
        
        tagCollectionView.dataSource = self
        tagCollectionView.delegate = self
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(openImage))
        contentView.addGestureRecognizer(gesture)
        
        let longTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(share))
        contentView.addGestureRecognizer(longTapGesture)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        detailedImageView.image = nil
    }
    
    func load(_ cat: Cat?) {
        guard let cat = cat else { return }
        imageService?.downloadImage(id: cat.id, completion: { image in
            DispatchQueue.main.async {
                self.detailedImageView.image = image
            }
        })
        
        self.tags = cat.tags
        formatDate()
        tagCollectionView?.reloadData()
    }
    
    private func formatDate() {
        if let createdAt = cat?.createdAt {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            if let localDate = formatter.date(from: createdAt) {
                let dateFormatterPrint = DateFormatter()
                dateFormatterPrint.dateFormat = "MM-dd-yyyy HH:mm"
                
                postedAtLabel?.text = "Posted at: \(dateFormatterPrint.string(from: localDate))"
            }
        }
    }
    
    @objc func openImage(_ sender:UITapGestureRecognizer){
        delegate?.show(image: detailedImageView.image)
    }
    
    @objc func share(_ sender:UITapGestureRecognizer){
        delegate?.share(image: detailedImageView.image)
    }
    
}

extension DetailedItemTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCellIdentifier",
                                                                 for: indexPath) as? TagCollectionViewCell {
            cell.label.text = tags[indexPath.row]
            return cell
        }
        return UICollectionViewCell()
    }
    
}

extension DetailedItemTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: tags[indexPath.item].size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)]).width + 25, height: 24)

    }
}

extension DetailedItemTableViewCell: UICollectionViewDelegateFlowLayout { }
