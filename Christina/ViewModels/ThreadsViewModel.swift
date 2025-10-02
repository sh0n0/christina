//
//  ThreadsViewModel.swift
//
//  Created by sh0n0 on 2025/10/02.
//

import Foundation
import Observation

@Observable
final class ThreadsViewModel {
    private let client: FourChanClientProtocol
    let board: Board

    init(board: Board, client: FourChanClientProtocol = FourChanClient()) {
        self.board = board
        self.client = client
    }

    var threads: [ChanThread] = []
    var isLoading: Bool = false
    var errorMessage: String?

    @MainActor
    func load() async {
        if isLoading { return }

        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        do {
            let items = try await client.fetchThreads(board: board.board)
            self.threads = items.sorted { (lhs, rhs) in
                (lhs.last_modified ?? 0) > (rhs.last_modified ?? 0)
            }
        } catch {
            self.errorMessage = (error as NSError).localizedDescription
        }
    }
}
