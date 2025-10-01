//
//  BoardRowView.swift
//
//  Created by sh0n0 on 2025/10/01.
//

import SwiftUI

struct BoardRowView: View {
    let board: Board

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("/\(board.board)/")
                .font(.headline)
            Text(board.title)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            if let desc = board.meta_description, !desc.isEmpty {
                Text(desc.htmlDecoded)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview("Board row", traits: .sizeThatFitsLayout) {
    let sample = Board(
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
        meta_description: "He said &quot;Hello&quot; &amp; waved — 5 &lt; 10 &amp;&amp; 10 &gt; 5. It&#39;s fine &apos;indeed&apos;."
    )
    return BoardRowView(board: sample)
        .padding()
}
