//
//  NewJournalView.swift
//  Journali
//
//  Created by sara on 30/04/1447 AH.
//
import SwiftUI
import SwiftData

struct NewJournalView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Environment(JournalViewModel.self) private var viewModel
    
    @State private var title = ""
    @State private var content = ""
    @State private var showDiscardAlert = false
    
    var body: some View {
        ZStack {
            Color(red: 0.11, green: 0.11, blue: 0.11).ignoresSafeArea()
            
            VStack(spacing: 0) {
                HStack {
                    Button(action: {
                        if !title.isEmpty || !content.isEmpty {
                            showDiscardAlert = true
                        } else {
                            dismiss()
                        }
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                            .frame(width: 44, height: 44)
                            .background(Color.gray.opacity(0.3))
                            .clipShape(Circle())
                            .glassEffect(.clear)
                            .alert("Are you sure you want to discard changes on this journal?", isPresented: $showDiscardAlert) {
                                Button("Keep Editing", role: .cancel) { }
                                Button("Discard Changes", role: .destructive) {
                                    dismiss()
                                }
                            }
                    }
                    
                    Spacer()
                    
                    Text("New Journal")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Button(action: saveJournal) {
                        Image(systemName: "checkmark")
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                            .frame(width: 44, height: 44)
                            .background(
                                Circle()
                                    .fill(Color(red: 0.55, green: 0.55, blue: 1.0))
                                    .glassEffect(.clear)
                            )
                    }
                }
                .padding()
                
                VStack(alignment: .leading, spacing: 15) {
                    TextField("", text: $title, prompt: Text("Title").foregroundColor(Color(white: 0.25)))
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(Color(red: 0.55, green: 0.55, blue: 1.0))
                        .tint(Color(red: 0.55, green: 0.55, blue: 1.0))
                    
                    Text(formattedDate())
                        .foregroundColor(.gray)
                        .font(.system(size: 14))
                    
                    TextEditor(text: $content)
                        .font(.system(size: 18))
                        .foregroundColor(.white)
                        .scrollContentBackground(.hidden)
                        .background(Color.clear)
                        .tint(Color(red: 0.55, green: 0.55, blue: 1.0))
                }
                .padding()
                
                Spacer()
            }
        }
    }
    
    func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: Date())
    }
    
    func saveJournal() {
        viewModel.saveJournal(title: title, content: content, context: modelContext)
        dismiss()
    }
}

#Preview {
    NewJournalView()
        .modelContainer(for: JournalEntry.self)
        .environment(JournalViewModel())
}

