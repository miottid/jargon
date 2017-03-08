import Foundation
import Commander
import CSV

private func handleiOS(for project: String, spreadsheetId: String) throws {
    let translations = try loadSpreadsheet(id: spreadsheetId)
    _ = try writeiOS(translations, for: project)
}

private func handleAndroid(spreadsheetId: String) throws {
    let translations = try loadSpreadsheet(id: spreadsheetId)
    _ = try writeAndroid(translations)
}

let projectArg = Argument<String>("project", description: "Project folder name")
let spreadsheetIdArg = Argument<String>("id", description: "Google spreadsheet id, you can find it on the URL")

Group {
    $0.command("ios", projectArg, spreadsheetIdArg, handleiOS)
    $0.command("android", spreadsheetIdArg, handleAndroid)
}.run()
