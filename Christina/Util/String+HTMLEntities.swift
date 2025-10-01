//
//  String+HTMLEntities.swift
//
//  Created by sh0n0 on 2025/10/01.
//

import Foundation
import UIKit

extension String {
    /// Returns a version of the string with common HTML entities decoded.
    /// Uses HTML parsing via NSAttributedString first, falling back to manual replacements for a few common entities.
    public var htmlDecoded: String {
        guard let data = self.data(using: .utf8) else { return self }
        if let attributed = try? NSAttributedString(
            data: data,
            options: [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue,
            ],
            documentAttributes: nil
        ) {
            return attributed.string
        }
        // Fallback replacements for common entities if HTML parsing fails
        return
            self
            .replacingOccurrences(of: "&quot;", with: "\"")
            .replacingOccurrences(of: "&#34;", with: "\"")
            .replacingOccurrences(of: "&#39;", with: "'")
            .replacingOccurrences(of: "&apos;", with: "'")
            .replacingOccurrences(of: "&amp;", with: "&")
            .replacingOccurrences(of: "&lt;", with: "<")
            .replacingOccurrences(of: "&gt;", with: ">")
    }
}
