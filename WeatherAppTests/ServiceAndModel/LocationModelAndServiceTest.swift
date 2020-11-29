import XCTest
@testable import WeatherApp

class LocationModelAndServiceTest: XCTestCase {
    var location:LocationSearch!
    
    override func setUp() {
        let expectation = self.expectation(description: #function)
        let mockNetworkService = APITest(fileName: "SearchLocation")
        let service = Service(networking: mockNetworkService)
        service.fetchLocationSearch("Gothenburg", completion: { location in
            XCTAssertNotNil(location)
            self.location = location
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 1)
    }
 
    func testParsing() {
        XCTAssertEqual(self.location.title, "Gothenburg")
        XCTAssertEqual(self.location.location_type, "City")
        XCTAssertNotNil(self.location.woeid)
        XCTAssertEqual(self.location.latt_long, "57.701328,11.96689")

     }
    
}
