import SnapshotTesting
import XCTest
@testable import CatBooth

class CatListViewControllerTests: XCTestCase {
    func testCatListViewController() {
        let vc = CatBooth.CatListViewController()
        vc.show(cats: [Cat(id: "595f280a557291a9750ebf58", createdAt: "2015-11-06T18:36:37.342Z", tags: [])])
        vc.show(tags: ["Testing", "OtherTesting"])
        let navController = UINavigationController(rootViewController: vc)
        
        let expectation = self.expectation(description: "")

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            assertSnapshot(matching: navController, as: .image)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 7)
    }
}
