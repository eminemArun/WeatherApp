import Foundation

// Represent a Location info from API response
struct LocationSearch: Decodable {
    let title: String
    let location_type: String
    let latt_long: String
    let woeid: Int
}


