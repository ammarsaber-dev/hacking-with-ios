//
//  ContentView.swift
//  HotProspects
//
//  Created by Ammar Saber on 02/07/2026.
//

import SwiftUI
import SwiftData

/*
Challenges:
 
 1. Add an icon to the “Everyone” screen showing whether a prospect was contacted or not.
 
 2. Add an editing screen, so users can adjust the name and email address of someone they scanned previously. (Tip: Use the simple form of NavigationLink rather than navigationDestination(), to avoid your list selection code confusing the navigation link.)
 
 3. Allow users to customize the way contacts are sorted – by name or by most recent.
*/


struct ContentView: View {
    
    var body: some View {
        TabView {
            Tab("Everyone", systemImage: "person.3") {
                ProspectsView(filter: .none)
            }
            
            Tab("Contacted", systemImage: "person.crop.circle.fill.badge.checkmark") {
                ProspectsView(filter: .contacted)
            }
            
            Tab("Uncontacted", systemImage: "person.crop.circle.badge.xmark") {
                ProspectsView(filter: .uncontacted)
            }
            
            Tab("Me", systemImage: "person.circle.fill") {
                MeView()
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Prospect.self)
}
