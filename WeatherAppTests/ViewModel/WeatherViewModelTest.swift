import XCTest
@testable import WeatherApp

class WeatherViewModelTest: XCTestCase {

    var viewModel : WeatherViewModel!
    fileprivate var service : Service!
    fileprivate var expectation:XCTestExpectation!
    override func setUp() {
        let mockNetworkService = APITest(fileName: "SearchLocation")
        self.service = Service(networking: mockNetworkService)
        self.viewModel = WeatherViewModel(service: service)
        self.viewModel.delegate = self
    }

    override func tearDown() {
        self.viewModel = nil
        self.service = nil
        super.tearDown()
    }
    
    
    func testFetchWithService() {
        //This method should get called its delegate
        self.expectation = self.expectation(description: #function)
        self.viewModel.searchLocationFor("Gothenburg")
        wait(for: [expectation], timeout: 1)
    }
    

}

extension WeatherViewModelTest:WeatherViewModelDelegate{
    func locationSearchData(_ locationSearch: LocationSearch?) {
        XCTAssertNotNil(locationSearch)
        self.expectation.fulfill()
    }
    
    func locationInfo(_ info: [LocationInfo]?) {
    }
    
    
}
