//
//  JournalEntry.swift
//  Journali
//
//  Created by sara on 30/04/1447 AH.
//

import SwiftData
import Foundation

@Model
class JournalEntry {
    var id: UUID
    var title: String
    var date: Date
    var content: String
    var isBookmarked: Bool
    
    init(title: String, content: String) {
        self.id = UUID()
        self.title = title
        self.date = Date()
        self.content = content
        self.isBookmarked = false
    }
}
