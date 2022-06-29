import Foundation
import UIKit

extension ImageFacade: ImageProtocol {
    func downloadImage(id: String,
                       completion: @escaping (_ image: UIImage?) -> Void) {
        
        let url = baseURL?
            .appendingPathComponent(id)
        
        guard let imageUrl = url else {
            self.dispatch {
                completion(nil)
            }
            return
        }
        
        performTask(with: imageUrl,
                    completion: completion)
    }
}

extension String {
    var url: URL? {
        return [self].compactMap({ URL(string: $0) }).first ?? nil
    }
}

