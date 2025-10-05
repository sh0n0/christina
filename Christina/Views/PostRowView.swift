import SwiftUI

struct PostRowView: View {
    let post: Post
    let board: Board

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            PostImageView(post: post, board: board)

            Text(post.com?.htmlDecoded ?? "")
                .font(.body)
                .lineLimit(nil)
            HStack(spacing: 10) {
                if let name = post.name, !name.isEmpty {
                    Text(name)
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
                if let trip = post.trip, !trip.isEmpty {
                    Text(trip)
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
                Spacer()
                if let time = post.time {
                    Text(Date(timeIntervalSince1970: TimeInterval(time)), style: .relative)
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        List {
            PostRowView(
                post: Post(
                    no: 123,
                    com: "<b>Hello</b> &amp; welcome!<br>Second line.",
                    time: Int(Date().timeIntervalSince1970) - 3600,
                    name: "anoynmous",
                    trip: "◆abc123",
                    filename: "sample",
                    ext: ".jpg",
                    tim: 1_700_000_000_000,
                    replies: nil
                ),
                board: Board(
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
            )
            .padding(.vertical, 6)
        }
        .listStyle(.plain)
        .navigationTitle("Preview")
    }
}
