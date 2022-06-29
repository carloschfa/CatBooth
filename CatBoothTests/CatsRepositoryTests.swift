import XCTest
@testable import CatBooth

class ServiceFacadeTests: XCTestCase {
    
    func testGetCatsShouldSuccess() {
        guard let data = JSONUtil.loadData(fromResource: "Cats") else {
            XCTFail("JSON data error")
            return
        }
        
        let session = MockedSession.simulate(success: data) { request in
            XCTAssertEqual(request.url?.absoluteString, "https://cataas.com/api/cats")
        }
        
        ServiceFacade(configuration: configurate(session: session))
            .getCats(using: nil) { result in
                switch result {
                case .success(let response):
                    XCTAssertNotNil(response)
                    XCTAssertEqual(response.count, 5)
                    XCTAssertEqual(response.first?.id, "595f280c557291a9750ebf80")
                case .failure(let error):
                    XCTFail("Should be success but got: \(error)")
                }
            }
    }
    
    func testGetTagsShouldSuccess() {
        guard let data = JSONUtil.loadData(fromResource: "Tags") else {
            XCTFail("JSON data error")
            return
        }
        
        let session = MockedSession.simulate(success: data) { request in
            XCTAssertEqual(request.url?.absoluteString, "https://cataas.com/api/tags")
        }
        
        ServiceFacade(configuration: configurate(session: session))
            .getTags() { result in
                switch result {
                case .success(let response):
                    XCTAssertNotNil(response)
                    XCTAssertEqual(response.count, 6)
                    XCTAssertEqual(response.first, "2cats")
                case .failure(let error):
                    XCTFail("Should be success but got: \(error)")
                }
            }
    }
    
    func testGetCatsShouldFail() {
        let session = MockedSession.simulate(failure: MockedSessionError.invalidResponse) { request in
            XCTAssertEqual(request.url?.absoluteString, "https://cataas.com/api/cats")
        }
        
        ServiceFacade(configuration: configurate(session: session))
            .getCats(using: nil, completion: { result in
                switch result {
                case .success(_):
                    XCTFail("Should be fail! Got success.")
                case .failure(let error):
                    guard case MockedSessionError.invalidResponse = error else {
                        XCTFail("Unexpected error!")
                        return
                    }
                }
            })
    }
    
    func testGetTagsShouldFail() {
        let session = MockedSession.simulate(failure: MockedSessionError.invalidResponse) { request in
            XCTAssertEqual(request.url?.absoluteString, "https://cataas.com/api/tags")
        }
        
        ServiceFacade(configuration: configurate(session: session))
            .getTags(completion: { result in
                switch result {
                case .success(_):
                    XCTFail("Should be fail! Got success.")
                case .failure(let error):
                    guard case MockedSessionError.invalidResponse = error else {
                        XCTFail("Unexpected error!")
                        return
                    }
                }
            })
    }
    
    private func configurate(session: SessionProtocol) -> Configuration {
        let service = Service(session: session,
                              dispatcher: SyncDispatcher())
        return Configuration(baseUrl: "https://cataas.com/api/",
                             service: service)
    }
}
