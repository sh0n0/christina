import SwiftUI

struct PostImageView: View {
    let imageURL: URL
    @State private var isShowingFullImage = false

    var body: some View {
        Group {
            AsyncImage(url: imageURL) { phase in
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
                    fullImageURL: imageURL
                )
            }
        }
    }
}

#Preview("Post image view") {
    PostImageView(
        imageURL: URL(string: "https://i.4cdn.org/g/1700000000000.jpg")!
    )
    .padding()
}
