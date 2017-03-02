//
//  Localization.swift
//  MobileLocalizer
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


/// Prints debug information about translations, that cool how pattern matching is working
///
/// - Parameter translations: translations to show
func debugPrint(_ translations: [Translation]) {
    let supportedTranslations = translations.map({ $0.lang }).joined(separator: ",")
    print("Supported languages: \(supportedTranslations)")
}
