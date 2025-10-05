//
//  FourChanAPI.swift
//
//  Created by sh0n0 on 2025/10/01.
//

import Alamofire
import Foundation
import Moya

enum FourChanAPI {
    case boards
    case catalog(board: String)
    case thread(board: String, no: Int)
}

extension FourChanAPI: TargetType {
    var baseURL: URL { URL(string: "https://a.4cdn.org")! }

    var path: String {
        switch self {
        case .boards:
            return "/boards.json"
        case .catalog(let board):
            return "/\(board)/catalog.json"
        case .thread(let board, let no):
            return "/\(board)/thread/\(no).json"
        }
    }

    var method: Moya.Method { .get }

    var task: Task { .requestPlain }

    var headers: [String: String]? {
        ["Accept": "application/json"]
    }
}

protocol FourChanClientProtocol {
    func fetchBoards() async throws -> [Board]
    func fetchThreads(board: String) async throws -> [ChanThread]
    func fetchPosts(board: String, threadNo: Int) async throws -> [Post]
}

enum FourChanClientError: Error {
    case notImplemented
}

extension FourChanClientProtocol {
    func fetchPosts(board: String, threadNo: Int) async throws -> [Post] {
        throw FourChanClientError.notImplemented
    }
}

final class FourChanClient: FourChanClientProtocol {
    private let provider = MoyaProvider<FourChanAPI>()

    func fetchBoards() async throws -> [Board] {
        let response = try await provider.asyncRequest(.boards)
        let decoded = try JSONDecoder().decode(BoardsResponse.self, from: response.data)
        return decoded.boards
    }

    func fetchThreads(board: String) async throws -> [ChanThread] {
        let response = try await provider.asyncRequest(.catalog(board: board))
        let decoded = try JSONDecoder().decode([CatalogResponse].self, from: response.data)
        return decoded.flatMap { $0.threads }
    }

    func fetchPosts(board: String, threadNo: Int) async throws -> [Post] {
        let response = try await provider.asyncRequest(.thread(board: board, no: threadNo))
        let decoded = try JSONDecoder().decode(PostsResponse.self, from: response.data)
        return decoded.posts
    }
}

extension MoyaProvider {
    func asyncRequest(_ target: Target) async throws -> Response {
        try await withCheckedThrowingContinuation { continuation in
            self.request(target) { result in
                switch result {
                case .success(let response):
                    continuation.resume(returning: response)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
