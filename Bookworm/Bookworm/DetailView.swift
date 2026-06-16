//
//  DetailView.swift
//  Bookworm
//
//  Created by Ammar Saber on 16/06/2026.
//

import SwiftData
import SwiftUI

struct DetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var showingDeleteAlert = false

    let book: Book

    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre.rawValue)
                    .resizable()
                    .scaledToFit()

                Text(book.genre.rawValue.uppercased())
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundStyle(.white)
                    .background(.black.opacity(0.8))
                    .clipShape(.capsule)
                    .offset(x: -5, y: -5)
            }

            Text(book.author)
                .font(.title)
                .foregroundStyle(.secondary)

            Text(book.review)
            
            // challenge 3 done
            Text(book.date.formatted(date: .abbreviated, time: .shortened))
                .padding()

            RatingView(rating: .constant(book.rating))
                .font(.largeTitle)
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Delete Book", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Are you sure?")
        }
        .toolbar {
            Button("Delete this book", systemImage: "trash") {
                showingDeleteAlert = true
            }
        }
    }

    func deleteBook() {
        modelContext.delete(book)
        dismiss()
    }
}

#Preview {
    //    do {
    //        let config = ModelConfiguration(isStoredInMemoryOnly: true)
    //        let container = try ModelContainer(for: Book.self, configurations: config)
    let book = Book(
        title: "Test Book",
        author: "Test Author",
        genre: .fantasy,
        review: "Nice book",
        rating: 4,
    )

    return DetailView(book: book)
    //            .modelContainer(container)
    //    } catch {
    //        return Text("Failed to create preview: \(error.localizedDescription)")
    //    }
}
