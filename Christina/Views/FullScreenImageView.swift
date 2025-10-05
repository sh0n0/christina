import SwiftUI

struct FullScreenImageView: View {
    let thumbnailURL: URL?
    let fullImageURL: URL?
    @Environment(\.dismiss) private var dismiss

    private var displayURL: URL? { fullImageURL ?? thumbnailURL }

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Color.black.ignoresSafeArea()

            if let url = displayURL {
                ScrollView([.vertical, .horizontal], showsIndicators: false) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .tint(.white)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        case .failure:
                            VStack(spacing: 12) {
                                Image(systemName: "photo")
                                    .font(.largeTitle)
                                    .foregroundStyle(.white.opacity(0.7))
                                Text("Failed to load image")
                                    .foregroundStyle(.white.opacity(0.7))
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        @unknown default:
                            EmptyView()
                        }
                    }
                }
            } else {
                VStack(spacing: 12) {
                    Image(systemName: "photo")
                        .font(.largeTitle)
                        .foregroundStyle(.white.opacity(0.7))
                    Text("No image available")
                        .foregroundStyle(.white.opacity(0.7))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black)
            }

            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 28, weight: .semibold))
                    .foregroundStyle(.white)
                    .padding(12)
                    .background(.ultraThinMaterial, in: Circle())
            }
            .padding(16)
        }
    }
}

#Preview {
    FullScreenImageView(
        thumbnailURL: URL(string: "https://i.4cdn.org/g/1700000000000s.jpg"),
        fullImageURL: URL(string: "https://i.4cdn.org/g/1700000000000.jpg")
    )
}
