//
//  Writer.swift
//  MobileLocalizer
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
        let data = loc.translations.map { "\"\($0)\" = \"\($1)\";" }
            .joined(separator: "\n").data(using: .utf8)
        try data?.write(to: fileUrl)
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
