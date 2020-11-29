import XCTest

class WeatherAppUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRunApp() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let citytableView = app.tables["cityTableView"]
        
        XCTAssertTrue(citytableView.exists, "The City tableview exists")

        let tableCells = citytableView.cells

        if tableCells.count > 0 {
            let count: Int = (tableCells.count)
         
            let promise = expectation(description: "Wait for table cells")
         
            for i in stride(from: 0, to: count , by: 1) {
                let tableCell = tableCells.element(boundBy: i)
                XCTAssertTrue(tableCell.exists, "The \(i) cell is in place on the table")
                tableCell.tap()
         
                if i == (count - 1) {
                    promise.fulfill()
                }
                //wait to view get loaded
                sleep(3)
                // Back to main table view
                if (UIDevice.current.userInterfaceIdiom == .phone) {
                    // only for iPhone coz in ipad we are in the split screen
                    app.navigationBars.buttons.element(boundBy: 0).tap()
                }
            }
            waitForExpectations(timeout: 20, handler: nil)
            XCTAssertTrue(true, "Finished validating the table cells")
         
        } else {
            XCTAssert(false, "Was not able to find any table cells")
        }

    }
    

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
