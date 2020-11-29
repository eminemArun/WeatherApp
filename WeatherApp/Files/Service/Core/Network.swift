import Foundation

// Used to fetch data from network
final class Network: Networking {
  private let session: URLSession

  init(configuration: URLSessionConfiguration = URLSessionConfiguration.default) {
    self.session = URLSession(configuration: configuration)
  }

  @discardableResult func fetch(resource: APIUrl, completion: @escaping (Data?,Int) -> Void) -> URLSessionTask? {
    guard let request = makeRequest(resource: resource) else {
      completion(nil,0)
      return nil
    }
    WALOG("Url Info = \(request.url!)")

    let task = session.dataTask(with: request, completionHandler: { data, response, error in
      guard let data = data, error == nil else {
        completion(nil,0)
        return
      }
      
        let statusCode = response as? HTTPURLResponse
        completion(data,statusCode?.statusCode ?? 0)
    })

    task.resume()
    return task
  }

  
// - Parameters:
//   - resource: Network resource
// - Returns: Constructed URL request
  private func makeRequest(resource: APIUrl) -> URLRequest? {
    let url = resource.path.map({ resource.url.appendingPathComponent($0) }) ?? resource.url
    guard var component = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
      assertionFailure()
      return nil
    }

    component.queryItems = resource.parameters.map({
      return URLQueryItem(name: $0, value: $1)
    })

    guard let resolvedUrl = component.url else {
      assertionFailure()
      return nil
    }

    var request = URLRequest(url: resolvedUrl)
    request.httpMethod = resource.httpMethod
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    return request
  }
}
