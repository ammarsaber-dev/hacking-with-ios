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
 */

import SwiftUI

@Observable
class Expenses {
    var items: [ExpenseItem] = [] {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }

    var personalItems: [ExpenseItem] {
        items.filter { $0.type == .personal }
    }

    var businessItems: [ExpenseItem] {
        items.filter { $0.type == .business }
    }

    init() {
        // 1. get the saved items from UserDefaults
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            // 2. if you found the items decode them and set items to the loaded items
            if let loadedItems = try? JSONDecoder().decode(
                [ExpenseItem].self,
                from: savedItems
            ) {
                items = loadedItems
                return
            }
        }
        // 3. if no items found in UserDefaults set items back to []
        items = []
    }
}

struct ContentView: View {
    @State private var expenses = Expenses()

//    @State private var showAddExpenseSheet = false
    
    var body: some View {
        NavigationStack {
            List {
                if !expenses.personalItems.isEmpty {
                    Section("Personal") {
                        ForEach(expenses.personalItems) { item in
                            ItemView(item: item)
                        }
                        .onDelete(perform: deletePersonal)
                    }
                }
                
                if !expenses.businessItems.isEmpty {
                    Section("Business") {
                        ForEach(expenses.businessItems) { item in
                            ItemView(item: item)
                        }
                        .onDelete(perform: deleteBusiness)
                    }
                }
            }

            .navigationTitle("iExpense")
            .toolbar {
//                Button("Add expense", systemImage: "plus") {
//                    showAddExpenseSheet = true
//                }
                
                NavigationLink {
                    AddView(expenses: expenses)
                } label: {
                    Label("Add expense", systemImage: "plus")
                }

                if !expenses.items.isEmpty {
                    EditButton()
                }
            }
//            .sheet(isPresented: $showAddExpenseSheet) {
//                AddView(expenses: expenses)
//            }
        }
    }

    func deletePersonal(at offsets: IndexSet) {
        let itemsToDelete = offsets.map { expenses.personalItems[$0] }

        expenses.items.removeAll { item in
            itemsToDelete.contains { $0.id == item.id }
        }
    }

    func deleteBusiness(at offsets: IndexSet) {
        let itemsToDelete = offsets.map { expenses.businessItems[$0] }

        expenses.items.removeAll { item in
            itemsToDelete.contains { $0.id == item.id }
        }
    }

}

struct ItemView: View {
    var item: ExpenseItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
//                Text(item.type.rawValue)
//                    .font(.footnote)
            }

            Spacer()

            // Challenge 1 Done
            Text(
                item.amount,
                format: .currency(
                    code: Locale.current.currency?.identifier
                        ?? "USD"
                )
            )
            .foregroundStyle(styleAmount(item.amount))
        }
    }
    
    // Challenge 2 Done
    func styleAmount(_ amount: Double) -> Color {
        if amount < 10 {
            return .green
        } else if amount < 100 {
            return .yellow
        } else {
            return .red
        }
    }
}

#Preview {
    ContentView()
}
