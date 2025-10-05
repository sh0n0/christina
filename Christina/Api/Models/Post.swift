import Foundation

struct PostsResponse: Decodable {
    let posts: [Post]
}

struct Post: Decodable, Identifiable, Hashable {
    var id: Int { no }
    let no: Int
    let com: String?
    let time: Int?
    let name: String?
    let trip: String?
    let filename: String?
    let ext: String?
    let tim: Int?
    let replies: Int?
}
