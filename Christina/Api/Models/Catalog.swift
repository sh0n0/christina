import Foundation

struct CatalogResponse: Decodable {
    let page: Int
    let threads: [ChanThread]
}

struct ChanThread: Decodable, Identifiable, Hashable {
    var id: Int { no }
    let no: Int
    let sub: String?
    let com: String?
    let time: Int?
    let last_modified: Int?
    let replies: Int?
    let images: Int?
    let name: String?
    let trip: String?
    let semantic_url: String?
    let sticky: Int?
    let closed: Int?
}

extension ChanThread {
    func navigationTitle() -> String {
        if let sub = self.sub, !sub.isEmpty {
            return sub
        }
        if let com = self.com?.htmlDecoded, !com.isEmpty {
            let lines = com.split(separator: "\n", omittingEmptySubsequences: true)
            if let first = lines.first {
                return String(first)
            }
        }
        return "Thread #\(self.no)"
    }
}
