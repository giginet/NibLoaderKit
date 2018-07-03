import XCTest
@testable import NibLoaderKit

class TestView: NSView { }

class NSViewNibLoaderKitTests: XCTestCase {
    var bundle: Bundle!

    override func setUp() {
        super.setUp()
        bundle = Bundle(for: type(of: self))
    }

    func testLoadFromNibName() {
        let testView = try! TestView.view(from: "TestView",
                                          owner: self,
                                          bundle: bundle)

        XCTAssertEqual(testView.subviews.count, 1)
    }

    func testLoadFromClass() {
        let testView: TestView = try! TestView.view(with: self,
                                                    bundle: bundle)
        XCTAssertEqual(testView.subviews.count, 1)
    }

    func testNibNotFound() {
        func execute() throws {
            _ = try NSView.view(from: "UnknownNib",
                                owner: self,
                                bundle: bundle)
        }

        XCTAssertThrowsError(try execute()) { error in
            if let error = error as? NibLoadingError {
                XCTAssertEqual(error, NibLoadingError.nibNotFound)
            }
        }
    }

    func testTopLevelObjectNotFound() {
        func execute() throws {
            _ = try NSView.view(from: "NoTopLevelObjects",
                                owner: self,
                                bundle: bundle)
        }

        XCTAssertThrowsError(try execute()) { error in
            if let error = error as? NibLoadingError {
                XCTAssertEqual(error, NibLoadingError.topLevelObjectNotFound)
            }
        }
    }

    func testMultipleTopLevelObjectsFound() {
        func execute() throws {
            _ = try NSView.view(from: "MultipleTopLevelObjects", owner: self, bundle: bundle)
        }

        XCTAssertThrowsError(try execute()) { error in
            if let error = error as? NibLoadingError {
                XCTAssertEqual(error, NibLoadingError.multipleTopLevelObjectsFound)
            }
        }
    }
}
