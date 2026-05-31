//
//  AddView.swift
//  iExpense
//
//  Created by Ammar Saber on 31/05/2026.
//

import SwiftUI

struct AddView: View {
    var expenses: Expenses

    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @State private var type: ExpenseType = .personal
    @State private var amount = 0.0

    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)

                Picker("Type", selection: $type) {
                    ForEach(ExpenseType.allCases) { type in
                        Text(type.rawValue)
                    }
                }

                TextField(
                    "Amount",
                    value: $amount,
                    format: .currency(
                        code: Locale.current.currency?.identifier ?? "USD"
                    )
                )
                .keyboardType(.decimalPad)
            }

            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(
                        name: name,
                        type: type,
                        amount: amount
                    )
                    expenses.items.append(item)

                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}
