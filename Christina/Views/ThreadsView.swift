//
//  ThreadsView.swift
//
//  Created by sh0n0 on 2025/10/02.
//

import SwiftUI

struct ThreadsView: View {
    @State private var viewModel: ThreadsViewModel

    init(board: Board) {
        _viewModel = State(initialValue: ThreadsViewModel(board: board))
    }

    var body: some View {
        Group {
            if viewModel.isLoading && viewModel.threads.isEmpty {
                ProgressView("Loading threads…")
            } else if let message = viewModel.errorMessage, viewModel.threads.isEmpty {
                ErrorView(message: message) {
                    await viewModel.load()
                }
            } else {
                List(viewModel.threads) { thread in
                    NavigationLink {
                        PostsView(board: viewModel.board, thread: thread)
                    } label: {
                        ThreadRowView(thread: thread)
                            .padding(.vertical, 6)
                    }
                }
                .refreshable {
                    await viewModel.load()
                }
            }
        }
        .navigationTitle("/\(viewModel.board.board)/")
        .task { await viewModel.load() }
    }
}

#Preview {
    NavigationStack {
        ThreadsView(
            board: Board(
                board: "g", title: "Technology", ws_board: nil, per_page: nil, pages: nil,
                max_filesize: nil, max_webm_filesize: nil, max_comment_chars: nil, bump_limit: nil,
                image_limit: nil, meta_description: nil))
    }
}
