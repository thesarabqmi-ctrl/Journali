//
//  JournalViewModel.swift
//  Journali
//
//  Created by sara on 30/04/1447 AH.
//
import SwiftUI
import SwiftData

@Observable
class JournalViewModel {
    var searchText = ""
    var showNewJournal = false
    var filterBookmarked = false
    
    func filteredJournals(from journals: [JournalEntry]) -> [JournalEntry] {
        var result = journals
        
        if !searchText.isEmpty {
            result = result.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
        
        if filterBookmarked {
            result = result.filter { $0.isBookmarked }
        }
        
        return result
    }
    
    func saveJournal(title: String, content: String, context: ModelContext) {
        guard !title.isEmpty else { return }
        let newEntry = JournalEntry(title: title, content: content)
        context.insert(newEntry)
    }
    
    func toggleBookmark(for journal: JournalEntry) {
        journal.isBookmarked.toggle()
    }
    
    func openNewJournal() {
        showNewJournal = true
    }
    
    func toggleBookmarkFilter() {
        filterBookmarked.toggle()
    }
}

