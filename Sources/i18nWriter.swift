//
//  i18nWriter.swift
//  jargon
//
//  Created by David Miotti on 18/03/2017.
//
//

import Foundation

/// Write translations files in the current directory
///
/// - Parameters:
///   - translations: Translations to write
/// - Throws: Error writing the translation
func writei18n(_ translations: [Translation]) throws -> [URL] {
    return try translations.map {
        try write(translation: $0)
    }
}

/// Write a translation on disk based on the project name
///
/// - Parameters:
///   - translation: The translation to be written
/// - Throws: Most of the time a filesystem permission problem or insufficient disk space
private func write(translation: Translation) throws -> URL {
    let fileUrl = buildFilePath(for: translation)
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
    let locales = translation.translations
    let sorted = locales.keys.sorted()
    return ""
}

/// Transform a Translation object to a string content
///
/// - Parameter translation: The translation to be transformed
/// - Returns: The string containing the translation text
func buildFilePath(for translation: Translation) -> URL {
    let fileManager = FileManager.default
    let currDir = URL(fileURLWithPath: fileManager.currentDirectoryPath)
    let localesDir = currDir.appendingPathComponent("config/locales", isDirectory: true)
    return localesDir.appendingPathComponent("\(translation.lang).yml")
}
