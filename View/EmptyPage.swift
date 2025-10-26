//
//  EmptyPage.swift
//  Journali
//
//  Created by sara on 30/04/1447 AH.
//
//
//  EmptyPage.swift
//  Journali
//
//  Created by sara on 30/04/1447 AH.
//
//
//  EmptyPage.swift
//  Journali
//
//  Created by sara on 30/04/1447 AH.
//
import SwiftUI
import SwiftData

struct EmptyPage: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \JournalEntry.date, order: .reverse) private var journals: [JournalEntry]
    
    @State private var viewModel = JournalViewModel()
    @State private var journalToDelete: JournalEntry?
    @State private var showDeleteAlert = false
    
    var filteredJournals: [JournalEntry] {
        viewModel.filteredJournals(from: journals)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                
                if filteredJournals.isEmpty && viewModel.searchText.isEmpty && !viewModel.filterBookmarked {
                    emptyStateView
                } else if filteredJournals.isEmpty {
                    Text("No journals found")
                        .foregroundColor(.gray)
                        .font(.system(size: 18))
                } else {
                    journalListView
                }
            }
            .overlay(alignment: .top) {
                headerView
            }
            .searchable(text: $viewModel.searchText, prompt: "Search")
            .sheet(isPresented: $viewModel.showNewJournal) {
                NewJournalView()
                    .environment(viewModel)
                    .presentationBackground(Color(red: 0.11, green: 0.11, blue: 0.11))
            }
            .alert("Delete Journal?", isPresented: $showDeleteAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Delete", role: .destructive) {
                    if let journal = journalToDelete {
                        deleteJournal(journal)
                    }
                }
            } message: {
                Text("Are you sure you want to delete this journal?")
            }
        }
        .environment(viewModel)
    }
    
    var headerView: some View {
        HStack {
            Text("Journal")
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(.white)
            
            Spacer()
            
            HStack(spacing: 15) {
                Menu {
                    Button("Sort by Bookmark") {
                        viewModel.toggleBookmarkFilter()
                    }
                    
                    Button("Sort by Entry Date") {
                        // مرتب أصلاً حسب التاريخ
                    }
                } label: {
                    Image(systemName: "line.horizontal.3.decrease")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                }
                
                Button(action: viewModel.openNewJournal) {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                }
            }
            .padding(.horizontal, 18)
            .padding(.vertical, 12)
            .background(Color(white: 0.2, opacity: 0.6))
            .clipShape(Capsule())
            .glassEffect(.clear)
        }
        .padding(.horizontal, 24)
        .padding(.top, -40)
    }
    
    var emptyStateView: some View {
        VStack(spacing: 0) {
            Image("Obook")
                .resizable()
                .scaledToFit()
                .frame(width: 153, height: 304.78)
                .padding(.top, 17)
            
            Text("Begin Your Journal")
                .foregroundColor(Color(red: 200/255, green: 180/255, blue: 255/255))
                .font(.system(size: 24).bold())
                .padding(.top, -90)
                .padding()
            
            Text("Craft your personal diary, tap the\nplus icon to begin")
                .foregroundColor(.white)
                .font(.system(size: 18))
                .multilineTextAlignment(.center)
                .frame(maxWidth: 280)
                .padding(.top, -60)
        }
    }
    
    var journalListView: some View {
        List {
            ForEach(filteredJournals) { journal in
                JournalRowView(journal: journal, viewModel: viewModel)
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button(role: .destructive) {
                            journalToDelete = journal
                            showDeleteAlert = true
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .background(Color.clear)
        .padding(.top, 100)
    }
    
    func deleteJournal(_ journal: JournalEntry) {
        modelContext.delete(journal)
        journalToDelete = nil
    }
}

struct JournalRowView: View {
    @Bindable var journal: JournalEntry
    var viewModel: JournalViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(journal.title)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                
                Spacer()
                
                Button(action: {
                    viewModel.toggleBookmark(for: journal)
                }) {
                    Image(systemName: journal.isBookmarked ? "bookmark.fill" : "bookmark")
                        .foregroundColor(journal.isBookmarked ? Color(red: 200/255, green: 180/255, blue: 255/255) : .gray)
                }
            }
            
            Text(journal.date, style: .date)
                .font(.system(size: 14))
                .foregroundColor(.gray)
            
            Text(journal.content)
                .font(.system(size: 16))
                .foregroundColor(.gray)
                .lineLimit(2)
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(15)
    }
}

#Preview {
    EmptyPage()
        .modelContainer(for: JournalEntry.self)
}
