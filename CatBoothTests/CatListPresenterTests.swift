import XCTest
@testable import CatBooth

class CatListPresenterTests: XCTestCase {
    var fetchData: MockedFetchDataInteractor?
    
    var view: MockedCatListView?
    var sut: CatListPresenter?
    
    var mockedCat: Cat {
        return Cat(id: "123", createdAt: "2022-01-01T11:51:30.730Z", tags: ["fast", "kitten"])
    }
    
    override func setUp() {
        sut = CatListPresenter()
        view = MockedCatListView()
        fetchData = MockedFetchDataInteractor()
        
        sut?.fetchData = fetchData
        sut?.view = view
    }
    
    func testFetchCatsShouldPerform() {
        sut?.fetchCats()
        XCTAssertEqual(fetchData?.counterPerformAllCats, 1)
        XCTAssertEqual(fetchData?.counterPerformAllTags, 0)
    }
    
    func testFetchTagsShouldPerform() {
        sut?.fetchCats()
        XCTAssertEqual(fetchData?.counterPerformAllCats, 1)
        XCTAssertEqual(fetchData?.counterPerformAllTags, 0)
    }
    
    func testOnCatsShouldShowCats() {
        sut?.on(cats: [])
        XCTAssertEqual(view?.counterShowCats, 1)
        XCTAssertEqual(view?.counterShowTags, 0)
        XCTAssertEqual(view?.counterShowError, 0)
        XCTAssertEqual(view?.counterShowImage, 0)
    }
    
    func testOnTagsShouldShowTags() {
        sut?.on(tags: [])
        XCTAssertEqual(view?.counterShowCats, 0)
        XCTAssertEqual(view?.counterShowTags, 1)
        XCTAssertEqual(view?.counterShowError, 0)
        XCTAssertEqual(view?.counterShowImage, 0)
    }
    
    func testOnErrorShouldShowError() {
        sut?.on(error: MockedError.fake)
        XCTAssertEqual(view?.counterShowCats, 0)
        XCTAssertEqual(view?.counterShowTags, 0)
        XCTAssertEqual(view?.counterShowError, 1)
        XCTAssertEqual(view?.counterShowImage, 0)
    }
}
