import Foundation

protocol FacadeProtocol {
    func getCats(using tags: [String]?, completion: @escaping ((Result<[Cat], Error>) -> Void))
    func getTags(completion: @escaping ((Result<[String], Error>) -> Void))
}

struct ServiceFacade {
    private let configuration: Configuration
    
    var baseURL: URL? {
        return URL(string: configuration.baseUrl)
    }
    
    init(configuration: Configuration) {
        self.configuration = configuration
    }
    
    func makeRequest<T: Decodable>(_ url: URL?,
                                   method: String,
                               map: T.Type,
                               completion: @escaping ((Result<T, Error>) -> Void)) throws {
        
        guard let url = url else {
            throw ServiceError.wrongUrl
        }
        
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = method
        
        if let data = configuration.service.object(for: url.absoluteString) as? T {
            configuration.service.dispatch {
                completion(.success(data))
            }
            return
        }
        
        configuration
            .service
            .performTask(with: request) { data, response, error in
                completion(self.decode(response: data,
                                       map: map,
                                       error: error,
                                       url: url))
                
            }
    }
    
    private func decode<T: Decodable>(response: Data?,
                                      map: T.Type,
                                      error: Error?,
                                      url: URL) -> (Result<T, Error>) {
        if let error = error {
            return (.failure(error))
        }

        guard let jsonData = response else {
            return (.failure(ServiceError.noData))
        }

        do {
            let decoded = try JSONDecoder().decode(map,
                                                   from: jsonData)
            configuration.service.set(obj: decoded, for: url.absoluteString)
            return (.success(decoded))
        } catch {
            return (.failure(error))
        }
    }
    
}

func performTry(_ function: @escaping (() throws -> Void)) {
    do {
        return try function()
    } catch {
        print("ERROR: \(#function) \(error)")
    }
}
