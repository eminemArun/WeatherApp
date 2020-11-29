import Foundation
@testable import WeatherApp

final class APITest: Networking {
    @discardableResult func fetch(resource: APIUrl, completion: @escaping (Data?, Int) -> Void) -> URLSessionTask?{
        completion(data,0)
        return nil
    }
    
    let data: Data
    init(fileName: String) {
        let bundle = Bundle(for: APITest.self)
        let url = bundle.url(forResource: fileName, withExtension: "json")!
        self.data = try! Data(contentsOf: url)
    }
}
