import Foundation

struct Cat: Codable {
    let id: String
    let createdAt: String
    let tags: [String]
    
    private enum CodingKeys : String, CodingKey {
        case id, createdAt = "created_at", tags
    }
    
}
