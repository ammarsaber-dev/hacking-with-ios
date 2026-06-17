//
//  ContentView.swift
//  iExpense
//
//  Created by Ammar Saber on 30/05/2026.
//

/*
 Challenges:
 1. Use the user’s preferred currency, rather than always using US dollars.

 2. Modify the expense amounts in ContentView to contain some styling depending on their value – expenses under $10 should have one style, expenses under $100 another, and expenses over $100 a third style. What those styles are depend on you.

 3. For a bigger challenge, try splitting the expenses list into two sections: one for personal expenses, and one for business expenses. This is tricky for a few reasons, not least because it means being careful about how items are deleted!


 Navigation Challenges:

 1. Change project 7 (iExpense) so that it uses NavigationLink for adding new expenses rather than a sheet. (Tip: The dismiss() code works great here, but you might want to add the navigationBarBackButtonHidden() modifier so they have to explicitly choose Cancel.)

 2. Try changing project 7 so that it lets users edit their issue name in the navigation title rather than a separate textfield. Which option do you prefer?

 SwiftData Challenges:
 1. Start by upgrading it to use SwiftData.

 2. Add a customizable sort order option: by name or by amount.

 3. Add a filter option to show all expenses, just personal expenses, or just business expenses.
 */

import SwiftData
import SwiftUI

struct ContentView: View {

    @State private var sortOrder: [SortDescriptor<Expense>] = []
    @State private var filter: ExpenseFilter = .all

    var body: some View {
        NavigationStack {
            ExpensesView(filter: filter.predicate, sort: sortOrder)
                .navigationTitle("iExpense")
                .toolbar {
                    NavigationLink {
                        AddView()
                    } label: {
                        Label("Add expense", systemImage: "plus")
                    }

                    Menu("Filter", systemImage: "line.3.horizontal.decrease") {
                        Picker("Filter", selection: $filter) {
                            Text("All").tag(ExpenseFilter.all)
                            Text("Personal").tag(ExpenseFilter.personal)
                            Text("Business").tag(ExpenseFilter.business)
                        }
                    }

                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Sort by Name")
                                .tag([
                                    SortDescriptor(\Expense.name),
                                    SortDescriptor(\Expense.amount),
                                ])

                            Text("Sort by Price")
                                .tag([
                                    SortDescriptor(\Expense.amount, order: .reverse),
                                    SortDescriptor(\Expense.name),
                                ])
                        }
                    }
                }
        }
    }

}

private enum ExpenseFilter: String, CaseIterable {
    case all = "All"
    case personal = "Personal"
    case business = "Business"

    var predicate: Predicate<Expense> {
        switch self {
        case .all:
            return #Predicate<Expense> { _ in true }
        case .personal:
            return #Predicate<Expense> { expense in expense.type == "Personal" }
        case .business:
            return #Predicate<Expense> { expense in expense.type == "Business" }
        }
    }
}

#Preview {
    ContentView()
}
