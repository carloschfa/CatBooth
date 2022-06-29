import XCTest
@testable import CatBooth

class FetchDataInteractorTests: XCTestCase {
    var presenter: MockedCatListPresenter?
    var view: MockedCatListView?
    var service: ServiceFacade?
    var sut: FetchDataInteractor?
    
    override func setUp() {
        presenter = MockedCatListPresenter()
        view = MockedCatListView()
    }
    
    func testPerformGetCatsShouldSuccess() {
        guard let data = JSONUtil.loadData(fromResource: "Cats") else {
            XCTFail("JSON data error!")
            return
        }
        let session = MockedSession.simulate(success: data) { request in
            XCTAssertEqual(request.url?.absoluteString, "https://cataas.com/api/cats")
        }
        
        create(session: session)
        
        sut?.perform(.getAllCats)
        XCTAssertEqual(presenter?.counterOnCats, 1)
        XCTAssertEqual(presenter?.counterOnError, 0)
    }
    
    func testPerformGetTagsShouldSuccess() {
        guard let data = JSONUtil.loadData(fromResource: "Tags") else {
            XCTFail("JSON data error!")
            return
        }
        let session = MockedSession.simulate(success: data) { request in
            XCTAssertEqual(request.url?.absoluteString, "https://cataas.com/api/tags")
        }
        
        create(session: session)
        
        sut?.perform(.getAllTags)
        XCTAssertEqual(presenter?.counterOnTags, 1)
        XCTAssertEqual(presenter?.counterOnError, 0)
    }
    
    func testPerformGetCatsShouldFail() {
        let session = MockedSession.simulate(failure: MockedSessionError.invalidResponse) { request in
            XCTAssertEqual(request.url?.absoluteString, "https://cataas.com/api/cats")
        }
        
        create(session: session)
        
        sut?.perform(.getAllCats)
        XCTAssertEqual(presenter?.counterOnCats, 0)
        XCTAssertEqual(presenter?.counterOnError, 1)
    }
    
    func testPerformGetTagsShouldFail() {
        let session = MockedSession.simulate(failure: MockedSessionError.invalidResponse) { request in
            XCTAssertEqual(request.url?.absoluteString, "https://cataas.com/api/tags")
        }
        
        create(session: session)
        
        sut?.perform(.getAllTags)
        XCTAssertEqual(presenter?.counterOnTags, 0)
        XCTAssertEqual(presenter?.counterOnError, 1)
    }
    
    private func create(session: SessionProtocol) {
        let config = Configuration(baseUrl: "https://cataas.com/api/",
                                   service: Service(session: session,
                                                    dispatcher: SyncDispatcher()))
        service = ServiceFacade(configuration: config)
        
        guard let presenter = presenter,
            let service = service else {
                XCTFail("Mocks fail!")
                return
        }
        
        sut = FetchDataInteractor(service: service,
                                  presenter: presenter)
    }
}

