//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Ammar Saber on 30/05/2026.
//

import SwiftUI
import SwiftData

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Expense.self)
    }
}
