import XCTest
@testable import WeatherApp

class InfoModelAndServiceTest: XCTestCase {
    var info:LocationInfo!
    
    override func setUp() {
        let expectation = self.expectation(description: #function)
        let mockNetworkService = APITest(fileName: "SearchInfo")
        let service = Service(networking: mockNetworkService)
        service.fetchLocationInfo("test",completion: { info in
            XCTAssertEqual(info?.count, 59)
            self.info = info?.first
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 1)
    }
 
    func testParsing() {
        XCTAssertNotNil(self.info.id)
        XCTAssertEqual(self.info.weather_state_abbr, "c")
        XCTAssertEqual(self.info.wind_direction_compass, "E")
        XCTAssertEqual(self.info.weather_state_name, "Clear")
        XCTAssertEqual(self.info.created, "2020-11-27T07:43:34.965016Z")
        XCTAssertEqual(self.info.applicable_date, "2020-11-28")
        XCTAssertNotNil(self.info.min_temp)
        XCTAssertNotNil(self.info.max_temp)
        XCTAssertNotNil(self.info.the_temp)
        XCTAssertNotNil(self.info.wind_speed)
        XCTAssertNotNil(self.info.wind_direction)
        XCTAssertNotNil(self.info.air_pressure)
        XCTAssertNotNil(self.info.humidity)
        XCTAssertNotNil(self.info.visibility)
        XCTAssertNotNil(self.info.predictability)

     }
    
}
