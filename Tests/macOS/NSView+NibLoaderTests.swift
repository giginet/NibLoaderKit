import XCTest
@testable import NibLoader

class TestClassView: NSView {
}

class NSView_NibLoaderTests: XCTestCase {
    var bundle: NSBundle!
    
    override func setUp() {
        super.setUp()
        bundle = NSBundle(forClass: self.dynamicType)
    }
    
    func testLoadFromNibName() {
        let testClassView = try! TestClassView.view(fromNibNamed: "TestClassView",
                                                    owner: self,
                                                    bundle: bundle)
        
        XCTAssertEqual(testClassView.subviews.count, 1)
    }
    
    func testLoadFromClass() {
        let testClassView: TestClassView = try! TestClassView.view(owner: self,
                                                                   bundle: bundle)
        XCTAssertEqual(testClassView.subviews.count, 1)
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
