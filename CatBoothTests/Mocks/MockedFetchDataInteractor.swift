import Foundation
@testable import CatBooth

class MockedFetchDataInteractor: FetchDataInteractorProtocol {
    
    
    var counterPerformAllCats: Int = 0
    var counterPerformAllTags: Int = 0
    
    var performHandler: (() -> Void)?

    func perform(_ requestType: FetchDataInteractor.RequestType) {
        switch requestType {
        case .getAllCats:
            counterPerformAllCats += 1
        case .getAllTags:
            counterPerformAllTags += 1
        }
        
        if let performHandler = performHandler {
            return performHandler()
        }
    }
}

