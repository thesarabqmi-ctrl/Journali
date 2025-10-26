//
//  JournaliApp.swift
//  Journali
//
//  Created by sara on 30/04/1447 AH.
//

import SwiftUI
import SwiftData

@main
struct JournaliApp: App {
    var body: some Scene {
        WindowGroup {
            Splash()
        }
        .modelContainer(for: JournalEntry.self)
    }
}
