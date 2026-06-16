//
//  AddBookView.swift
//  Bookworm
//
//  Created by Ammar Saber on 15/06/2026.
//

import SwiftData
import SwiftUI

struct AddBookView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre: Genre = .fantasy
    @State private var review = ""

    var isValidBook: Bool {
        return ![title, author, review]
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .contains(where: \.isEmpty)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)

                    Picker("Genre", selection: $genre) {
                        ForEach(Genre.allCases, id: \.self) { genre in
                            Text(genre.rawValue)
                        }
                    }
                }

                Section("Write a review") {
                    TextEditor(text: $review)

                    RatingView(rating: $rating)
                }

                Section {
                    Button("Save") {
                        let book = Book(
                            title: title,
                            author: author,
                            genre: genre,
                            review: review,
                            rating: rating
                        )
                        modelContext.insert(book)
                        dismiss()
                    }
                    // challenge 1 done
                    .disabled(!isValidBook)
                    .buttonSizing(.flexible)
                    .buttonStyle(.glassProminent)
                }
            }
            .navigationTitle("Add Book")
        }
    }
}

#Preview {
    AddBookView()
}
