//
//  Catalog.swift
//
//  Created by sh0n0 on 2025/10/02.
//

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
