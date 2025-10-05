import SwiftUI

struct PostsView: View {
    @State private var viewModel: PostsViewModel

    init(board: Board, thread: ChanThread) {
        _viewModel = State(initialValue: PostsViewModel(board: board, thread: thread))
    }

    var body: some View {
        Group {
            if viewModel.isLoading && viewModel.posts.isEmpty {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let message = viewModel.errorMessage {
                ErrorView(message: message) {
                    await viewModel.load()
                }
            } else {
                List(viewModel.posts) { post in
                    PostRowView(post: post, board: viewModel.board)
                        .padding(.vertical, 6)
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle(viewModel.thread.navigationTitle())
        .task {
            await viewModel.load()
        }
    }
}
