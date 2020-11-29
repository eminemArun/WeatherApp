import Foundation

protocol Networking {

  /// Fetch data from url and parameters query
  ///
  /// - Parameters:
  ///   - url: The url
  ///   - parameters: Parameters as query items
  ///   - completion: Called when operation finishes
  /// - Returns: The data task
  @discardableResult func fetch(resource: APIUrl, completion: @escaping (Data?,Int) -> Void) -> URLSessionTask?
}
