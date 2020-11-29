import Foundation
import UIKit

//API values form calling web service
struct APIValue {
    static let base = "https://www.metaweather.com/api/"
    static let PathLocationSearch = "api/location/search/"
    static let PathLocationDay = "/api/location/"
}

// Harcoded cities to get weather details
let weatherCities = ["Gothenburg","Stockholm","Mountain View","London","New York","Berlin"]

let iconPreURL = "https://www.metaweather.com/static/img/weather/png/64/"
