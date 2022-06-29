import Foundation

extension ServiceFacade: FacadeProtocol {
    
    func getCats(using tags: [String]?, completion: @escaping ((Result<[Cat], Error>) -> Void)) {
        var urlString = baseURL!.absoluteString + Constants.Endpoint.allCats
            
        
        var tagParameter = ""
        if let tags = tags {
            tagParameter = "?tags="
            for tag in tags {
                tagParameter.append("\(tag),")
            }
        }
        urlString.append(tagParameter)
        let url = URL(string: urlString)
        
        performTry {
            try self.makeRequest(url,
                                 method: "GET",
                                 map: [Cat].self,
                                 completion: completion)
            
        }
    }
    
    func getTags(completion: @escaping ((Result<[String], Error>) -> Void)) {
        let urlString = baseURL!.absoluteString + Constants.Endpoint.allTags
        let url = URL(string: urlString)
        
        performTry {
            try self.makeRequest(url,
                                 method: "GET",
                                 map: [String].self,
                                 completion: completion)
        
        }
    }
}
