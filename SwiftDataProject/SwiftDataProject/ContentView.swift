//
//  ContentView.swift
//  SwiftDataProject
//
//  Created by Ammar Saber on 16/06/2026.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext

    @State private var showingUpcomingOnly = false
    @State private var sortOrder = [
        SortDescriptor(\User.name),
        SortDescriptor(\User.joinDate),
    ]

    var body: some View {
        NavigationStack {
            UsersView(
                minimumJoinDate: showingUpcomingOnly ? .now : .distantPast,
                sortOrder: sortOrder
            )
            .navigationTitle("Users")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Add samples", systemImage: "plus") {
                        try? modelContext.delete(model: User.self)

                        let first = User(
                            name: "Ed Sheeran",
                            city: "London",
                            joinDate: .now.addingTimeInterval(86400 * -10)  // 10 days ago
                        )
                        let second = User(
                            name: "Rosa Diaz",
                            city: "New York",
                            joinDate: .now.addingTimeInterval(86400 * -5)  // 5 days ago
                        )
                        let third = User(
                            name: "Roy Kent",
                            city: "London",
                            joinDate: .now.addingTimeInterval(86400 * 5)  // after 5 days
                        )
                        let fourth = User(
                            name: "Johnny English",
                            city: "London",
                            joinDate: .now.addingTimeInterval(86400 * 10)  // after 10 days
                        )

                        modelContext.insert(first)
                        modelContext.insert(second)
                        modelContext.insert(third)
                        modelContext.insert(fourth)
                    }
                }

                ToolbarItem(placement: .topBarLeading) {
                    Button(showingUpcomingOnly ? "Show Everyone" : "Show Upcoming") {
                        withAnimation {
                            showingUpcomingOnly.toggle()
                        }
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder.animation()) {
                            Text("Sort by Name")
                                .tag([
                                    SortDescriptor(\User.name),
                                    SortDescriptor(\User.joinDate),
                                ])

                            Text("Sort by Join Date")
                                .tag([
                                    SortDescriptor(\User.joinDate),
                                    SortDescriptor(\User.name),
                                ])
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
