//
//  ExpensesView.swift
//  iExpense
//
//  Created by Ammar Saber on 17/06/2026.
//

import SwiftUI
import SwiftData

struct ExpensesView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var expenses: [Expense]
    
    var body: some View {
        List {
            ForEach(expenses) { expense in
                ItemView(expense: expense)
            }
            .onDelete(perform: removeItem)
        }
    }
    
    func removeItem(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(expenses[index])
        }
    }
    
    init(filter: Predicate<Expense>, sort: [SortDescriptor<Expense>]) {
        _expenses = Query(filter: filter, sort: sort)
    }
}

#Preview {
    ExpensesView(filter: #Predicate<Expense> {expense in expense.type == ""}, sort: [])
}
