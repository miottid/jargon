//
//  Translation.swift
//  jargon
//
//  Created by David Miotti on 01/03/2017.
//
//

import Foundation

/// Represent a supported translation
final class Translation {
    /// The concerned lang, should be in range of Locale.availableIdentifiers
    private(set) var lang: String
    /// The key-value translation strings, for exemple "introduction.title" = "Welcome"
    var translations = [String: String]()
    /// Initialize a Localization object
    ///
    /// - Parameters:
    ///   - lang: The lang (should be contained in Locale.availableIdentifiers)
    ///   - translations: translations
    init(lang: String, translations: [String: String] = [:]) {
        self.lang = lang
        self.translations = translations
    }
}
