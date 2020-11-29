import Foundation


// MARK: - View model for Detail screen

protocol WeatherViewModelDelegate: AnyObject{
    func locationSearchData(_ locationSearch: LocationSearch?)
    func locationInfo(_ info: [LocationInfo]?)

}

class WeatherViewModel: NSObject {
    private let service: Service
    weak var delegate: WeatherViewModelDelegate?
    
    init(service: Service) {
        self.service = service
        super.init()
    }
    
    //Get Location Search data
    internal func searchLocationFor(_ city:String) {
        WALOG("Calling get location search API")
        service.fetchLocationSearch(city, completion: { [weak self] locationData in
            self?.delegate?.locationSearchData(locationData)
        })
    }
    
    //Get Location Info data
    internal func getLocationInfoFor(_ query:String) {
        WALOG("Calling get location search API")
        service.fetchLocationInfo(query, completion: { [weak self] locationInfo in
            self?.delegate?.locationInfo(locationInfo)
        })
     }
    
}

