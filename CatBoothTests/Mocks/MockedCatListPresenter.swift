import Foundation
@testable import CatBooth

class MockedCatListPresenter: CatListPresenterProtocol {
    var counterFetchCats: Int =  0
    var counterFetchTags: Int =  0
    
    var counterOnCats: Int =  0
    var counterOnTags: Int =  0
    var counterOnError: Int =  0

    var fetchCatsHandler: (() -> Void)?
    var fetchTagsHandler: (() -> Void)?
    var onCatsHandler: (([Cat]) -> Void)?
    var onTagsHandler: (([String]) -> Void)?
    var onErrorHandler: ((Error) -> Void)?

    func fetchCats() {
        counterFetchCats += 1
        if let fetchCatsHandler = fetchCatsHandler {
            return fetchCatsHandler()
        }
    }
    
    func fetchTags() {
        counterFetchTags += 1
        if let fetchTagsHandler = fetchTagsHandler {
            return fetchTagsHandler()
        }
    }
    
    func on(cats: [Cat]) {
        counterOnCats += 1
        if let onCatsHandler = onCatsHandler {
            return onCatsHandler(cats)
        }
    }
    
    func on(tags: [String]) {
        counterOnTags += 1
        if let onTagsHandler = onTagsHandler {
            return onTagsHandler(tags)
        }
    }
    
    func on(error: Error) {
        counterOnError += 1
        if let onErrorHandler = onErrorHandler {
            return onErrorHandler(error)
        }
    }
}
