
import XCTest
@testable import CatBooth

class CatsTests: XCTestCase {
    
    func testCatResponse() {
        do {
            let cat = try JSONUtil.loadClass(fromResource: "Cat", ofType: Cat.self)
            XCTAssertEqual(cat?.id, "595f280c557291a9750ebf80")
            XCTAssertEqual(cat?.createdAt, "2015-11-06T18:36:37.342Z")
            XCTAssertEqual(cat?.tags.count, 2)
        } catch {
            XCTFail("Failed to decode: \(error)")
        }
    }
    
    func testCatsResponse() {
        do {
            let cats = try JSONUtil.loadClass(fromResource: "Cats", ofType: [Cat].self)
            XCTAssertEqual(cats?.count, 5)
            let cat = cats?.first
            XCTAssertEqual(cat?.id, "595f280c557291a9750ebf80")
            XCTAssertEqual(cat?.createdAt, "2015-11-06T18:36:37.342Z")
            XCTAssertEqual(cat?.tags.count, 2)
        } catch {
            XCTFail("Failed to decode: \(error)")
        }
    }
    
    func testTagsResponse() {
        do {
            let tags = try JSONUtil.loadClass(fromResource: "Tags", ofType: [String].self)
            XCTAssertEqual(tags?.count, 6)
            XCTAssertEqual(tags?.first, "2cats")
        } catch {
            XCTFail("Failed to decode: \(error)")
        }
    }
}
