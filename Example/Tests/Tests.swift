import XCTest
import ViewXtended

class Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testKeyboardLayoutConstraintStoresConstantValues() {
        let view = UIView()
        let innerView = UIView()
        view.addSubview(innerView)

        let a = KeyboardLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: innerView, attribute: .bottom, multiplier: 1, constant: 10)
        XCTAssertEqual(a.originalConstant, 10)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
