//
//  Book.swift
//  Bookworm
//
//  Created by Ammar Saber on 15/06/2026.
//

import Foundation
import SwiftData

@Model
final class Book {
    var title: String
    var author: String
    var genre: Genre
    var review: String
    var rating: Int
    var date: Date
    
    init(title: String, author: String, genre: Genre, review: String, rating: Int, date: Date = .now) {
        self.title = title
        self.author = author
        self.genre = genre
        self.review = review
        self.rating = rating
        self.date = date
    }
}

// CaseIterable is here it make it work well with ForEach.
// Codable is here to make it work well with Observation/Swift Data
enum Genre: String, CaseIterable, Codable {
    case fantasy = "Fantasy"
    case horror = "Horror"
    case kids = "Kids"
    case mystery = "Mystery"
    case poetry = "Poetry"
    case romance = "Romance"
    case thriller = "Thriller"
}
