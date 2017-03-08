import Foundation
import Commander
import CSV

private func handleiOS(for project: String, spreadsheetId: String, baseLang: String) throws {
    let translations = try loadSpreadsheet(id: spreadsheetId)
    _ = try writeiOS(translations, for: project)
}

private func handleAndroid(spreadsheetId: String, baseLang: String) throws {
    let translations = try loadSpreadsheet(id: spreadsheetId)
    _ = try writeAndroid(translations)
}

let projectArg = Argument<String>("project", description: "Project folder name")
let spreadsheetIdArg = Argument<String>("id", description: "Google spreadsheet id, you can find it on the URL")
let baseLangArg = Option<String>("baseLang", "default", description: "The lang that should be used for Base (iOS) or default (Android) language. By default, it use the first found in the spreadsheet")

Group {
    $0.command("ios", projectArg, spreadsheetIdArg, baseLangArg, handleiOS)
    $0.command("android", spreadsheetIdArg, baseLangArg, handleAndroid)
}.run()
