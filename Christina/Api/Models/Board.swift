//
//  FourChanModels.swift
//
//  Created by sh0n0 on 2025/10/01.
//

import Foundation

struct BoardsResponse: Decodable {
    let boards: [Board]
}

struct Board: Decodable, Identifiable, Hashable {
    var id: String { board }
    let board: String
    let title: String
    let ws_board: Int?
    let per_page: Int?
    let pages: Int?
    let max_filesize: Int?
    let max_webm_filesize: Int?
    let max_comment_chars: Int?
    let bump_limit: Int?
    let image_limit: Int?
    let meta_description: String?
}
