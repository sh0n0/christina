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

extension Post {
    /// Thumbnail URL for this post's attachment on a given board.
    /// 4chan thumbnail URL: https://i.4cdn.org/{board}/{tim}s.jpg
    func thumbnailURL(board: Board) -> URL? {
        guard let tim = self.tim else { return nil }
        return URL(string: "https://i.4cdn.org/\(board.board)/\(tim)s.jpg")
    }

    /// Full image URL for this post's attachment on a given board.
    /// 4chan full image URL: https://i.4cdn.org/{board}/{tim}{ext}
    func fullImageURL(board: Board) -> URL? {
        guard let tim = self.tim, let ext = self.ext else { return nil }
        return URL(string: "https://i.4cdn.org/\(board.board)/\(tim)\(ext)")
    }
}
