//
//  Expenses.swift
//  iExpense
//
//  Created by Ammar Saber on 17/06/2026.
//

import Foundation
import SwiftData

@Model
class Expense {
    var name: String
    var type: String
    var amount: Double

    init(name: String, type: String, amount: Double) {
        self.name = name
        self.type = type
        self.amount = amount
    }
}
