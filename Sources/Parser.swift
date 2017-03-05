//
//  Parser.swift
//  jargon
//
//  Created by David Miotti on 02/03/2017.
//
//

import Foundation
import CSV

/// Error that happen while parsing
///
/// - malformedUrl: The url used is malformed
enum ParserError: Error {
    case malformedUrl
}

/// Load synschronously a remote Google Spreadsheet
///
/// - Parameter id: The spreadsheet id, you can find it in the url
/// - Returns: a spreadsheet
/// - Throws: A ParserError or error from CSV library
func loadSpreadsheet(id: String) throws -> [Translation] {
    let str = "https://docs.google.com/spreadsheets/d/\(id)/pub?output=csv"
    guard let url = URL(string: str) else {
        throw ParserError.malformedUrl
    }
    
    let string = try String(contentsOf: url)
    var csv = try CSV(string: string, hasHeaderRow: true)
    
    let translations = csv.headerRow?.flatMap { value -> Translation? in
        guard Locale.availableIdentifiers.contains(value) else {
            return nil
        }
        return Translation(lang: value)
    } ?? []
    
    while var line = csv.next() {
        _ = line.removeFirst() // Remove the context
        let key = line.removeFirst() // Get the translation key
        for (index, val) in line.enumerated() {
            guard index < translations.count, !val.isEmpty else {
                continue
            }
            translations[index].translations[key] = val
        }
    }
    
    return translations
}
