import Foundation
import UIKit

protocol ImageProtocol {
    func downloadImage(id: String,
                       completion: @escaping (_ image: UIImage?) -> Void)
}

struct ImageService {
    let baseUrl: String
    let session: URLSession
    let cache: Cacheable
    let dispatcher: Dispatcher
    
    init(baseUrl: String,
        urlSession: URLSession = URLSession.shared,
         cache: Cacheable = DefaultCache(),
         dispatcher: Dispatcher = DefaultDispatcher()) {
        self.baseUrl = baseUrl
        self.session = urlSession
        self.cache = cache
        self.dispatcher = dispatcher
    }
}

struct ImageFacade {
    private let configuration: ImageService
    
    var baseURL: URL? {
        return URL(string: configuration.baseUrl)
    }
    
    init(configuration: ImageService) {
        self.configuration = configuration
    }
    
    func performTask(with url: URL, completion: @escaping (_ image: UIImage?) -> Void) {
        
        if let dataImage = configuration.cache.object(for: url.absoluteString) as? Data,
           let cachedImage = UIImage.gif(data: dataImage) {
            self.dispatch {
                completion(cachedImage)
            }
            return
        }
        
        configuration.session.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage.gif(data: data) else {
                    self.dispatch {
                        completion(nil)
                    }
                    return
            }
            
            self.dispatch {
                let imageData = image.pngData() as Any
                self.configuration.cache.set(obj: imageData, for: url.absoluteString)
                completion(image)
            }
            
            }.resume()
    }
}

extension ImageFacade {
    func dispatch(completion: @escaping () -> Void) {
        configuration.dispatcher.dispatch {
            completion()
        }
    }
}

