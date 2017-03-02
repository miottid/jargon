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
        try writeiOS(translations, for: projectName)
        debugPrint(translations)
    } catch let err {
        print("Error while loading spreadsheet \(spreadsheetId): \(err)")
    }
}

main.run()
