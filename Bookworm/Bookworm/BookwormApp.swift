//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Ammar Saber on 15/06/2026.
//

import SwiftUI
import SwiftData

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
