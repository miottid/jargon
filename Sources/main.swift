import Foundation
import Commander
import CSV

/// The main command
let main = command(
    Argument<String>("projectName", description: "Project folder name"),
    Argument<String>("spreadsheetId", description: "Google spreadsheet id, you can find it on the URL")
) { projectName, spreadsheetId in
    do {
        let translations = try loadSpreadsheet(id: spreadsheetId)
        _ = try writeiOS(translations, for: projectName)
    } catch let err {
        print("Error while loading spreadsheet \(spreadsheetId): \(err.localizedDescription)\n\n \(err)")
    }
}

main.run()
