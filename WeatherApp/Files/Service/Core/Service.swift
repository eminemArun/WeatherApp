import Foundation

enum HTTPMethod: String {
    case GET,POST,DELETE
}

// For dependency injection if needed
protocol Injectable {
  func inject(data: Service)
}

final class Service {
  private let baseUrl = URL(string: APIValue.base)!
  private let networking: Networking
    
  init(networking: Networking) {
    self.networking = networking
  }

// Fetch Location information for get the woeid
//
// - Parameter - Location - Place name
    func fetchLocationSearch(_ location:String,completion: @escaping (LocationSearch?) -> Void) {
        let parameter = ["query":location]
        let resource = APIUrl(url: baseUrl, path: APIValue.PathLocationSearch ,parameters: parameter)
        _ = networking.fetch(resource: resource, completion: { data,_ in
          DispatchQueue.main.async {
            if let data = data {
                let locationSearch = try? JSONDecoder().decode([LocationSearch].self, from: data)
                completion(locationSearch?.first)
                return
            }
            completion(nil)
          }
      })
 }
    

// Fetch Location Full info for get the woeid
//
// - Parameter - query - which contain (woeid)/(date)
    func fetchLocationInfo(_ query:String,completion: @escaping ([LocationInfo]?) -> Void) {
        let path = "\(APIValue.PathLocationDay)\(query)"
        let resource = APIUrl(url: baseUrl, path: path)
        _ = networking.fetch(resource: resource, completion: { data,_ in
          DispatchQueue.main.async {
            if let data = data {
                let info = try? JSONDecoder().decode([LocationInfo].self, from: data)
                completion(info)
                return
            }
            completion([])
          }
      })
 }
    
    
}



