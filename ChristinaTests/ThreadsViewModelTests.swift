import Testing

@testable import Christina

@MainActor
@Suite("ThreadsViewModel sorting")
struct ThreadsViewModelSortingTests {

    // MARK: - Fake clients

    final class FakeClientUnsorted: FourChanClientProtocol {
        func fetchBoards() async throws -> [Board] { return [] }
        func fetchThreads(board: String) async throws -> [ChanThread] {
            // last_modified: [100, nil, 300, 200, nil]
            return [
                ChanThread(
                    no: 1,
                    sub: "a",
                    com: nil,
                    time: 1_700_000_001,
                    last_modified: 100,
                    replies: 1,
                    images: 0,
                    name: "Anon",
                    trip: nil,
                    semantic_url: "a",
                    sticky: nil,
                    closed: nil
                ),
                ChanThread(
                    no: 2,
                    sub: "b",
                    com: nil,
                    time: 1_700_000_002,
                    last_modified: nil,
                    replies: 2,
                    images: 0,
                    name: "Anon",
                    trip: nil,
                    semantic_url: "b",
                    sticky: nil,
                    closed: nil
                ),
                ChanThread(
                    no: 3,
                    sub: "c",
                    com: nil,
                    time: 1_700_000_003,
                    last_modified: 300,
                    replies: 3,
                    images: 0,
                    name: "Anon",
                    trip: nil,
                    semantic_url: "c",
                    sticky: nil,
                    closed: nil
                ),
                ChanThread(
                    no: 4,
                    sub: "d",
                    com: nil,
                    time: 1_700_000_004,
                    last_modified: 200,
                    replies: 4,
                    images: 0,
                    name: "Anon",
                    trip: nil,
                    semantic_url: "d",
                    sticky: nil,
                    closed: nil
                ),
                ChanThread(
                    no: 5,
                    sub: "e",
                    com: nil,
                    time: 1_700_000_005,
                    last_modified: nil,
                    replies: 5,
                    images: 0,
                    name: "Anon",
                    trip: nil,
                    semantic_url: "e",
                    sticky: nil,
                    closed: nil
                ),
            ]
        }
    }

    final class FakeClientAlreadySorted: FourChanClientProtocol {
        func fetchBoards() async throws -> [Board] { return [] }
        func fetchThreads(board: String) async throws -> [ChanThread] {
            // last_modified already sorted: [400, 350, 100, nil]
            return [
                ChanThread(
                    no: 11,
                    sub: "aa",
                    com: nil,
                    time: 1_700_001_001,
                    last_modified: 400,
                    replies: 10,
                    images: 1,
                    name: "Anon",
                    trip: nil,
                    semantic_url: "aa",
                    sticky: nil,
                    closed: nil
                ),
                ChanThread(
                    no: 12,
                    sub: "bb",
                    com: nil,
                    time: 1_700_001_002,
                    last_modified: 350,
                    replies: 9,
                    images: 1,
                    name: "Anon",
                    trip: nil,
                    semantic_url: "bb",
                    sticky: nil,
                    closed: nil
                ),
                ChanThread(
                    no: 13,
                    sub: "cc",
                    com: nil,
                    time: 1_700_001_003,
                    last_modified: 100,
                    replies: 8,
                    images: 1,
                    name: "Anon",
                    trip: nil,
                    semantic_url: "cc",
                    sticky: nil,
                    closed: nil
                ),
                ChanThread(
                    no: 14,
                    sub: "dd",
                    com: nil,
                    time: 1_700_001_004,
                    last_modified: nil,
                    replies: 7,
                    images: 1,
                    name: "Anon",
                    trip: nil,
                    semantic_url: "dd",
                    sticky: nil,
                    closed: nil
                ),
            ]
        }
    }

    // MARK: - Tests

    @Test("Sorts by last_modified descending with nils last")
    func testSortByLastModifiedDescending() async throws {
        let board = Board(
            board: "g",
            title: "Technology",
            ws_board: nil,
            per_page: nil,
            pages: nil,
            max_filesize: nil,
            max_webm_filesize: nil,
            max_comment_chars: nil,
            bump_limit: nil,
            image_limit: nil,
            meta_description: nil
        )
        let vm = ThreadsViewModel(board: board, client: FakeClientUnsorted())

        await vm.load()

        let result = vm.threads.map { $0.last_modified }
        #expect(result == [300, 200, 100, nil, nil])
    }

    @Test("Keeps order when already sorted")
    func testStableWhenAlreadySorted() async throws {
        let board = Board(
            board: "g",
            title: "Technology",
            ws_board: nil,
            per_page: nil,
            pages: nil,
            max_filesize: nil,
            max_webm_filesize: nil,
            max_comment_chars: nil,
            bump_limit: nil,
            image_limit: nil,
            meta_description: nil
        )
        let vm = ThreadsViewModel(board: board, client: FakeClientAlreadySorted())

        await vm.load()

        let result = vm.threads.map { $0.last_modified }
        #expect(result == [400, 350, 100, nil])
    }
}
