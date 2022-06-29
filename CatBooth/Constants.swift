import Foundation

struct Constants {
    struct URL {
        static let baseUrl = "https://cataas.com/api/"
        static let baseUrlImages = "https://cataas.com/cat/"
        
    }
    
    struct Endpoint {
        static let allCats = "cats"
        static let allTags = "tags"
    }
    
    struct Error {
        static let responseError = "An error has occurred"
        static let noData = "No data fetched"
        static let wrongUrl = "Unexpected URL creation exception"
    }
    
    struct Cache {
        static let standard = 36000
    }
}

