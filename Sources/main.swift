import Foundation
import Commander
import CSV

final class Localization {
    var lang: String
    var translations = [String: String]()
    init(lang: String) {
        self.lang = lang
    }
}

private let outputFilename = "Localizable.strings"

let main = command { (projectName: String, id: String) in
    do {
        let str = "https://docs.google.com/spreadsheets/d/\(id)/pub?output=csv"
        let url = URL(string: str)!
        let string = try String(contentsOf: url)
        var csv = try CSV(string: string, hasHeaderRow: true)

        let localizations = csv.headerRow?.flatMap { value -> Localization? in
            guard Locale.availableIdentifiers.contains(value) else { return nil }
            return Localization(lang: value)
        } ?? []

        let supportedLangs = localizations.map({ $0.lang }).joined(separator: ",")
        print("Supported languages: \(supportedLangs)")
        
        while var line = csv.next() {
            _ = line.removeFirst() // Remove the context
            let key = line.removeFirst() // Get the translation key
            for (index, val) in line.enumerated() {
                guard index < localizations.count, !val.isEmpty else { continue }
                var trans = localizations[index].translations
                localizations[index].translations[key] = val
            }
        }

        // Writes files
        let fileManager = FileManager.default
        let currDir = URL(fileURLWithPath: fileManager.currentDirectoryPath)
        let projDir = currDir.appendingPathComponent(projectName)

        try localizations.forEach { loc in
            let transDir = projDir.appendingPathComponent("\(loc.lang).lproj")
            try fileManager.createDirectory(at: transDir, withIntermediateDirectories: true, attributes: nil)
            let fileUrl = transDir.appendingPathComponent(outputFilename)
            let data = loc.translations.map { (key: String, value: String) -> String in
                "\"\(key)\" = \"\(value)\";"
            }.joined(separator: "\n").data(using: .utf8)
            try data?.write(to: fileUrl)
        }
    } catch let err {
        print("Error while loading spreadsheet \(id): \(err)")
    }
}

main.run()
