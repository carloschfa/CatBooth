import Foundation

class FetchDataInteractor {
    
    enum RequestType {
        case getAllCats
        case getAllTags
    }
    
    private let service: FacadeProtocol
    private let presenter: CatListPresenterProtocol
    
    init(service: FacadeProtocol,
         presenter: CatListPresenterProtocol) {
        self.service = service
        self.presenter = presenter
    }
}

extension FetchDataInteractor: FetchDataInteractorProtocol {
    func perform(_ requestType: RequestType) {
        switch requestType {
        case .getAllCats:
            getAllCats()
        case .getAllTags:
            getAllTags()
        }
    }
    
    private func getAllCats() {
        service.getCats(using: nil, completion: { result in
            switch result {
            case .success(let response):
                self.presenter.on(cats: response)
            case .failure(let error):
                self.presenter.on(error: error)
            }
        })
    }
    
    private func getAllTags() {
        service.getTags(completion: { result in
            switch result {
            case .success(let response):
                let tags = response.filter { !$0.isEmpty }
                self.presenter.on(tags: tags)
            case .failure(let error):
                self.presenter.on(error: error)
            }
        })
    }
}

