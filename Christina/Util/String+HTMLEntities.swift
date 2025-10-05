//
//  String+HTMLEntities.swift
//
//  Created by sh0n0 on 2025/10/01.
//

import Foundation
import SwiftSoup
import UIKit

extension String {
    public var htmlDecoded: String {
        do {
            let doc = try SwiftSoup.parse(self)
            return try doc.text()
        } catch {
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
}
