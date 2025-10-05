import SwiftUI

struct BoardsView: View {
    @State private var viewModel = BoardsViewModel()

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading && viewModel.boards.isEmpty {
                    ProgressView("Loading boards…")
                } else if let message = viewModel.errorMessage, viewModel.boards.isEmpty {
                    ErrorView(message: message) {
                        await viewModel.load()
                    }
                } else {
                    List(viewModel.boards) { board in
                        NavigationLink {
                            ThreadsView(board: board)
                        } label: {
                            BoardRowView(board: board)
                                .padding(.vertical, 4)
                        }
                    }
                    .refreshable {
                        await viewModel.load()
                    }
                }
            }
            .navigationTitle("4chan Boards")
        }
        .task {
            await viewModel.load()
        }
    }
}

#Preview {
    BoardsView()
}
