//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by Ammar Saber on 16/06/2026.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
