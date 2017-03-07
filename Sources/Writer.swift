//
//  Writer.swift
//  jargon
//
//  Created by David Miotti on 02/03/2017.
//
//

import Foundation

/// Write translations in the xcode project
///
/// - Parameters:
///   - translations: the translation to write
///   - projectName: the project folder name
/// - Throws: Error writing the translation
func writeiOS(_ translations: [Translation], for projectName: String) throws {
    try translations.forEach { loc in
        let fileUrl = try buildFilePath(forProject: projectName, lang: loc.lang)
        // Transform our object to ios data
        let lines = loc.translations.map { key, value in
            "\"\(key)\" = \"\(sanitize(value))\";"
        }
        let content = lines.joined(separator: "\n")
        let data = content.data(using: .utf8)
        try data?.write(to: fileUrl)
    }
}

/// Transform the string into correct parseable iOS format
///
/// - Parameter string: The parsed to be formatted
/// - Returns: The formatted string
func sanitize(_ string: String) -> String {
    let replaceTable = [
        "%s": "%@",
        "\"": "\\\"",
        "%newline%": "\\n"
    ]
    return replaceTable.reduce(string) {
        $0.replacingOccurrences(of: $1.key, with: $1.value)
    }
}

/// Construct the file url of translation
///
/// - Parameters:
///   - name: The name
///   - lang: The lang description
/// - Returns: The url of the Localization.string based on the project name
/// - Throws: An error if directories failed to creates
func buildFilePath(forProject name: String, lang: String) throws -> URL {
    let fileManager = FileManager.default
    let currDir = URL(fileURLWithPath: fileManager.currentDirectoryPath)
    let projDir = currDir.appendingPathComponent(name)
    let transDir = projDir.appendingPathComponent("\(lang).lproj")
    try fileManager.createDirectory(at: transDir, withIntermediateDirectories: true, attributes: nil)
    return transDir.appendingPathComponent("Localizable.strings")
}
