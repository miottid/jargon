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
    return try translations.map {
        try write(translation: $0)
    }
}

/// Write a translation on disk
///
/// - Parameters:
///   - translation: The translation to be written
///   - project: The project name that describe the directory where Localizable.string should reside
/// - Throws: Most of the time a filesystem permission problem or insufficient disk space
private func write(translation: Translation) throws -> URL {
    let fileUrl = try buildFilePath(lang: translation.lang)
    let contents = fileContents(for: translation)
    let data = contents.data(using: .utf8)
    try data?.write(to: fileUrl)
    return fileUrl
}

/// Transform a Translation object to a string content
///
/// - Parameter translation: The translation to be transformed
/// - Returns: The string containing the translation text
private func fileContents(for translation: Translation) -> String {
    let lines = translation.translations.map(buildLine)
    let header = "<?xml version=\"1.0\" encoding=\"utf-8\">\n\t<resources>\n\t"
    let footer = "\n\t</resources>\n"
    return header + lines.joined(separator: "\n\t\t") + footer
}

/// Construct a line from a translation entry that is conform with Android
///
/// - Parameters:
///   - key: The current key
///   - value: The value for the provided key
/// - Returns: A line that is conform with Android projects
private func buildLine(for key: String, value: String) -> String {
    let normalized = normalize(value)
    return "<string name=\"\(key)\">\(normalized)</string>"
}

/// Transform the string into correct parseable Android format
///
/// - Parameter string: The parsed to be formatted
/// - Returns: The formatted string
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

/// Construct the file url of translation
///
/// - Parameters:
///   - name: The name
///   - lang: The lang description
/// - Returns: The url of the file
/// - Throws: An error if directories failed to creates
private func buildFilePath(lang: String?) throws -> URL {
    let fileManager = FileManager.default
    let currDir = URL(fileURLWithPath: fileManager.currentDirectoryPath)
    var dirs = [ "app", "src", "main", "res" ]
    if let lang = lang {
        dirs.append("values-\(lang)")
    } else {
        dirs.append("values")
    }
    let destDir = dirs.reduce(currDir) {
        $0.appendingPathComponent($1)
    }
    try fileManager.createDirectory(at: destDir, withIntermediateDirectories: true, attributes: nil)
    return destDir.appendingPathComponent("strings.xml")
}
