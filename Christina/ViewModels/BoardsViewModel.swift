//
//  BoardsViewModel.swift
//
//  Created by sh0n0 on 2025/10/01.
//

import Foundation
import Observation

@Observable
final class BoardsViewModel {
    private let client: FourChanClient

    init(client: FourChanClient = FourChanClient()) {
        self.client = client
    }

    var boards: [Board] = []
    var isLoading: Bool = false
    var errorMessage: String?

    @MainActor
    func load() async {
        if isLoading { return }
        
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }
        
        do {
            let boards = try await client.fetchBoards()
            self.boards = boards.sorted { $0.board < $1.board }
        } catch {
            self.errorMessage = (error as NSError).localizedDescription
        }
    }
}
