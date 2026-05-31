//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Ammar Saber on 31/05/2026.
//

import Foundation

enum ExpenseType: String, Codable, CaseIterable, Identifiable {
    case personal = "Personal"
    case business = "Business"

    var id: Self { self }
}

struct ExpenseItem: Codable, Identifiable {
    var id = UUID()
    let name: String
    let type: ExpenseType
    let amount: Double
}
