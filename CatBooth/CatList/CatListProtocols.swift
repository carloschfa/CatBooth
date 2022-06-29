import Foundation
import UIKit

protocol CatListPresenterProtocol {
    func fetchCats()
    func fetchTags()
    
    func on(cats: [Cat])
    func on(tags: [String])
    func on(error: Error)
}

protocol CatListViewProtocol: class {
    func show(cats: [Cat])
    func show(tags: [String])
    func show(error: Error)
    func show(image: UIImage?)
    func share(image: UIImage?)
}

protocol FetchDataInteractorProtocol {
    func perform(_ requestType: FetchDataInteractor.RequestType)
}
