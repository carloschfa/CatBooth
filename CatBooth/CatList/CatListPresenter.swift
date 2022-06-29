import Foundation
import UIKit

class CatListPresenter {
    weak var view: CatListViewProtocol?
    var fetchData: FetchDataInteractorProtocol?

    private var cats: [Cat]?
    private var tags: [String]?
}

extension CatListPresenter: CatListPresenterProtocol {
    func fetchCats() {
        fetchData?.perform(.getAllCats)
    }

    func fetchTags() {
        fetchData?.perform(.getAllTags)
    }
    
    func reset() {
        view?.show(cats: cats ?? [])
    }

    func on(cats: [Cat]) {
        self.cats = cats
        view?.show(cats: cats)
    }
    
    func on(tags: [String]) {
        self.tags = tags
        view?.show(tags: tags)
    }
    
    func on(error: Error) {
        view?.show(error: error)
    }
}
