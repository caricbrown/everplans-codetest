import Foundation

// MARK: - Feed
struct Feed: Codable {
    let id: String
    let url: String
    let feedDescription: String
    let votes: Int
    let createdAt: String
    let postedBy: PostedBy

    enum CodingKeys: String, CodingKey {
        case id, url
        case feedDescription = "description"
        case votes, createdAt, postedBy
    }
}
