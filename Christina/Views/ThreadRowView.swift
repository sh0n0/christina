import SwiftUI

struct ThreadRowView: View {
    let thread: ChanThread

    private var titleText: String {
        if let sub = thread.sub, !sub.isEmpty { return sub.htmlDecoded }
        if let com = thread.com, !com.isEmpty { return com.htmlDecoded }
        return "(no subject)"
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(titleText)
                .font(.headline)
                .lineLimit(3)

            HStack(spacing: 12) {
                if let replies = thread.replies {
                    Label("\(replies)", systemImage: "bubble.right")
                }
                if let images = thread.images {
                    Label("\(images)", systemImage: "photo")
                }
                if let last = thread.last_modified {
                    Text(Date(timeIntervalSince1970: TimeInterval(last)), style: .relative)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            }
            .font(.footnote)
            .foregroundStyle(.secondary)
        }
    }
}

#Preview("Thread row", traits: .sizeThatFitsLayout) {
    let sample = ChanThread(
        no: 123_456_789,
        sub: "Sample thread title",
        com: "This is a <b>comment</b> &amp; preview.",
        time: 1_700_000_000,
        last_modified: 1_700_000_100,
        replies: 42,
        images: 5,
        name: "Anonymous",
        trip: nil,
        semantic_url: "sample-thread",
        sticky: nil,
        closed: nil
    )
    return ThreadRowView(thread: sample)
        .padding()
}
