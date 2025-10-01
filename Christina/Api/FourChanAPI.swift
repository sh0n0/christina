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
}

extension FourChanAPI: TargetType {
    var baseURL: URL { URL(string: "https://a.4cdn.org")! }

    var path: String {
        switch self {
        case .boards:
            return "/boards.json"
        }
    }

    var method: Moya.Method { .get }

    var task: Task { .requestPlain }

    var headers: [String: String]? {
        ["Accept": "application/json"]
    }
}

class FourChanClient {
    private let provider = MoyaProvider<FourChanAPI>()

    func fetchBoards() async throws -> [Board] {
        let response = try await provider.asyncRequest(.boards)
        let decoded = try JSONDecoder().decode(BoardsResponse.self, from: response.data)
        return decoded.boards
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
