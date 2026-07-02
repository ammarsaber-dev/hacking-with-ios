//
//  HotProspectsApp.swift
//  HotProspects
//
//  Created by Ammar Saber on 02/07/2026.
//

import SwiftUI
import SwiftData

@main
struct HotProspectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Prospect.self)
    }
}
