import SwiftUI

struct PostRowView: View {
    let post: Post

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
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
                    filename: nil,
                    ext: nil,
                    tim: nil,
                    replies: nil
                )
            )
            .padding(.vertical, 6)
        }
        .listStyle(.plain)
        .navigationTitle("Preview")
    }
}
