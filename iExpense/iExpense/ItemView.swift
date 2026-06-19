//
//  ItemView.swift
//  iExpense
//
//  Created by Ammar Saber on 17/06/2026.
//

import SwiftUI

struct ItemView: View {
    var expense: Expense

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(expense.name)
                    .font(.headline)
            }

            Spacer()

            // Challenge 1 Done
            Text(
                expense.amount,
                format: .currency(
                    code: Locale.current.currency?.identifier
                        ?? "USD"
                )
            )
            .foregroundStyle(styleAmount(expense.amount))
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
    ItemView(expense: Expense(name: "Blah", type: "Personal", amount: 100))
}
