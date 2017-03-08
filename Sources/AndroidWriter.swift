//
//  AndroidWriter.swift
//  jargon
//
//  Created by David Miotti on 08/03/2017.
//
//

import Foundation

/// Write translations files in the current directory
///
/// - Parameters:
///   - translations: Translations to write
///   - project: Project folder name
/// - Throws: Error writing the translation
func writeAndroid(_ translations: [Translation]) throws -> [URL] {
    throw NSError(domain: "Android Writer", code: 0, userInfo: [
        NSLocalizedDescriptionKey: "Not implemented" ]
    )
}

private func buildAndroidLine(for key: String, value: String) -> String {
    let normalized = normalize(value)
    return "<string name=\"\(key)\">\(normalized)</string>"
}

private func normalize(_ string: String) -> String {
    let replaceTable = [
        "%@": "%s",
        "%([0-9]\\$)+@": "%$1s",
        "%newline%": "\\\\n",
        "\"": "\\\\\"",
        "&": "&amp;"
    ]
    return replaceTable.reduce(string) {
        $0.replacingOccurrences(
            of: $1.key,
            with: $1.value,
            options: [.regularExpression, .caseInsensitive]
        )
    }
}
