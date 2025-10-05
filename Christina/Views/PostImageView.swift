import SwiftUI

struct PostImageView: View {
    let post: Post
    let board: Board
    @State private var isShowingFullImage = false

    var body: some View {
        Group {
            if let url = post.fullImageURL(board: board) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.secondary.opacity(0.1))
                            ProgressView()
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 150)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    case .failure:
                        HStack(spacing: 8) {
                            Image(systemName: "photo")
                            Text("Image unavailable")
                        }
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                    @unknown default:
                        EmptyView()
                    }
                }
                .onTapGesture { isShowingFullImage = true }
                .fullScreenCover(isPresented: $isShowingFullImage) {
                    FullScreenImageView(
                        thumbnailURL: post.thumbnailURL(board: board),
                        fullImageURL: post.fullImageURL(board: board)
                    )
                }
            }
        }
    }
}

#Preview("Post image view") {
    PostImageView(
        post: Post(
            no: 123,
            com: nil,
            time: Int(Date().timeIntervalSince1970),
            name: nil,
            trip: nil,
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
    .padding()
}
