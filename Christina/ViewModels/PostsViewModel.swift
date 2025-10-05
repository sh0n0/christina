import Foundation
import Observation

@Observable
final class PostsViewModel {
    private let client: FourChanClientProtocol
    let board: Board
    let thread: ChanThread
    var posts: [Post] = []
    var isLoading: Bool = false
    var errorMessage: String?

    init(board: Board, thread: ChanThread, client: FourChanClientProtocol = FourChanClient()) {
        self.board = board
        self.thread = thread
        self.client = client
    }

    @MainActor
    func load() async {
        isLoading = true
        errorMessage = nil
        do {
            let posts = try await client.fetchPosts(board: board.board, threadNo: thread.no)
            self.posts = posts
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
