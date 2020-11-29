import XCTest
@testable import WeatherApp


class DetailViewControllerTest: XCTestCase {

    var viewController: DetailViewController!

    override func setUp() {
        
        let expectation = self.expectation(description: #function)
        let mockNetworkService = APITest(fileName: "SearchInfo")
        let service = Service(networking: mockNetworkService)
        service.fetchLocationInfo("test",completion: { info in
            XCTAssertEqual(info?.count, 59)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            self.viewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
            self.viewController.loadView()
            self.viewController.viewDidLoad()
            self.viewController.locationInfo(info)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1)

    }

    func testHasATableView() {
        XCTAssertNotNil(viewController.tableView)
    }
    
    func testTableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertTrue(viewController.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(viewController.responds(to: #selector(viewController.numberOfSections(in:))))
        XCTAssertTrue(viewController.responds(to: #selector(viewController.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(viewController.responds(to: #selector(viewController.tableView(_:cellForRowAt:))))
    }
    
    func testNumberOfSectionInTableView(){
        XCTAssertEqual(viewController.tableView.numberOfSections, 59, "Should be 59 section")
    }
    
    func testShowItemsFromService() {
        let tableView = viewController.tableView
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = tableView?.cellForRow(at: indexPath) as? DetailTableViewCell
        XCTAssertEqual("Clear", cell?.summaryLabel.text)

    }
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

 


}
