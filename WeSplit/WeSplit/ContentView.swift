//
//  ContentView.swift
//  WeSplit
//
//  Created by Ammar Saber on 23/05/2026.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var selectedTip = 20

    @FocusState private var amountIsFocused: Bool

    let tipPercentages = [10, 15, 20, 25, 0]

    var totalAmount: Double {
        let tipValue = checkAmount / 100 * Double(selectedTip)
        let total = checkAmount + tipValue

        return total
    }

    var amountPerPerson: Double {
        totalAmount / Double(numberOfPeople)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField(
                        "Amount",
                        value: $checkAmount,
                        format: .currency(
                            code: Locale.current.currency?.identifier ?? "USD"
                        )
                    )
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                }

                Section {
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<101) {
                            Text("\($0) people")
                                .tag($0)
                        }
                    }
                }

                Section("How much tip do you want to leave?") {
                    Picker("Tip Percentage", selection: $selectedTip) {
                        ForEach(0..<101, id: \.self) {
                            Text($0, format: .percent)
                                .tag($0)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }

                Section("Total amount") {
                    Text(
                        totalAmount,
                        format: .currency(
                            code: Locale.current.currency?.identifier ?? "USD"
                        )
                    )
                }

                Section("Total amount per person") {
                    Text(
                        amountPerPerson,
                        format: .currency(
                            code: Locale.current.currency?.identifier ?? "USD"
                        )
                    )
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
