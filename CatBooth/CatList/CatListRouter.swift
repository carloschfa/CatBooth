import Foundation
import UIKit

class CatListRouter {
    let view: CatListViewController?

    init() {
        view = CatListViewController(nibName: "CatListViewController", bundle: nil)
        
        let presenter = CatListPresenter()
        view?.presenter = presenter
        view?.imageService = imageService()
        presenter.view = view
        
        let fetchData = FetchDataInteractor(service: serviceFacade(),
                                            presenter: presenter)
        presenter.fetchData = fetchData
    }
}

private func serviceFacade() -> FacadeProtocol {
    let service = Service(session: Session(),
                          cache: CacheFacade())
    let config = Configuration(baseUrl: Constants.URL.baseUrl,
                               service: service)
    return ServiceFacade(configuration: config)
}

private func imageService() -> ImageProtocol {
    let service = ImageService(baseUrl: Constants.URL.baseUrlImages, cache: CacheFacade())
    return ImageFacade(configuration: service)
}
