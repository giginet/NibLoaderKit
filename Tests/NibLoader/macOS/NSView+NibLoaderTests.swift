import XCTest
@testable import NibLoader

class TestView: NSView { }

class NSViewNibLoaderTests: XCTestCase {
    var bundle: NSBundle!

    override func setUp() {
        super.setUp()
        bundle = NSBundle(forClass: self.dynamicType)
    }

    func testLoadFromNibName() {
        let testView = try! TestView.view(fromNibNamed: "TestView",
                                          owner: self,
                                          bundle: bundle)

        XCTAssertEqual(testView.subviews.count, 1)
    }

    func testLoadFromClass() {
        let testView: TestView = try! TestView.view(withOwner: self,
                                                    bundle: bundle)
        XCTAssertEqual(testView.subviews.count, 1)
    }

    func testNibNotFound() {
        func execute() throws {
            try NSView.view(fromNibNamed: "UnknownNib",
                            owner: self,
                            bundle: bundle)
        }

        XCTAssertThrowsError(try execute()) { error in
            if let error = error as? NibLoadingError {
                XCTAssertEqual(error, NibLoadingError.NibNotFound)
            }
        }
    }

    func testTopLevelObjectNotFound() {
        func execute() throws {
            try NSView.view(fromNibNamed: "NoTopLevelObjects",
                            owner: self,
                            bundle: bundle)
        }

        XCTAssertThrowsError(try execute()) { error in
            if let error = error as? NibLoadingError {
                XCTAssertEqual(error, NibLoadingError.TopLevelObjectNotFound)
            }
        }
    }

    func testMultipleTopLevelObjectsFound() {
        func execute() throws {
            try NSView.view(fromNibNamed: "MultipleTopLevelObjects", owner: self, bundle: bundle)
        }

        XCTAssertThrowsError(try execute()) { error in
            if let error = error as? NibLoadingError {
                XCTAssertEqual(error, NibLoadingError.MultipleTopLevelObjectsFound)
            }
        }
    }
}
