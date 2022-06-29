import Foundation
import UIKit
@testable import CatBooth

class MockedCatListView: CatListViewProtocol {
    var counterShowCats: Int =  0
    var counterShowTags: Int =  0
    var counterShowError: Int =  0
    var counterShowImage: Int =  0
    
    var showCatsHandler: (([Cat]) -> Void)?
    var showTagsHandler: (([String]) -> Void)?
    var showErrorHandler: ((Error) -> Void)?
    var showImageHandler: ((UIImage?) -> Void)?
    
    func show(cats: [Cat]) {
        counterShowCats += 1
        if let showCatsHandler = showCatsHandler {
            return showCatsHandler(cats)
        }
    }
    
    func show(tags: [String]) {
        counterShowTags += 1
        if let showTagsHandler = showTagsHandler {
            return showTagsHandler(tags)
        }
    }
    
    func show(error: Error) {
        counterShowError += 1
        if let showErrorHandler = showErrorHandler {
            return showErrorHandler(error)
        }
    }
    
    func show(image: UIImage?) {
        counterShowImage += 1
        if let showImageHandler = showImageHandler {
            return showImageHandler(image)
        }
    }
}
