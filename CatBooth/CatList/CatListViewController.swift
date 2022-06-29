import UIKit

class CatListViewController: UIViewController {
    
    @IBOutlet weak var storiesCollectionView: UICollectionView!
    @IBOutlet weak var detailedItemsTableView: UITableView!
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    var presenter: CatListPresenterProtocol?
    var imageService: ImageProtocol?
    
    
    var cats: [Cat]? {
        didSet {
            detailedItemsTableView?.reloadData()
        }
    }
    
    var tags: [String]? {
        didSet {
            storiesCollectionView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarLogo()

        storiesCollectionView.dataSource = self
        storiesCollectionView.delegate = self
        
        let storyCellNib = UINib(nibName: "StoryCollectionViewCell", bundle: nil)
        storiesCollectionView.register(storyCellNib, forCellWithReuseIdentifier: "StoryCellIdentifier")
        
        let detailedItemCellNib = UINib(nibName: "DetailedItemTableViewCell", bundle: nil)
        detailedItemsTableView.register(detailedItemCellNib, forCellReuseIdentifier: "DetailedItemCellIdentifier")
        
        detailedItemsTableView.dataSource = self
        detailedItemsTableView.delegate = self
        detailedItemsTableView.separatorStyle = .none
        
        startLoading()
        presenter?.fetchCats()
        presenter?.fetchTags()
        
    }
    
    func startLoading() {
        activityIndicator.center = self.view.center
        activityIndicator.color = .gray
        
        self.view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()   
    }

    func stopLoading() {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }
}

extension CatListViewController: CatListViewProtocol {
    func show(cats: [Cat]) {
        self.cats = cats
    }
    
    func show(tags: [String]) {
        self.tags = tags
        stopLoading()
    }
    
    func show(error: Error) {
        print(error)
    }
    
    func show(image: UIImage?) {
        let viewController = FullscreenItemViewController(nibName: "FullscreenItemViewController", bundle: nil)
        present(viewController, animated: true) {
            viewController.setup(image: image)
        }
    }
    
    func share(image: UIImage?) {
        let items = [image!]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }
}
