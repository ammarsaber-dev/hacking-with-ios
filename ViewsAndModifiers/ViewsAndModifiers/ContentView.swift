//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Ammar Saber on 27/05/2026.
//

import SwiftUI


// Custom Modifiers
struct CapsuleTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding()
            .background(.blue)
            .clipShape(.capsule)
    }
}

extension Text {
    func capsuleTitle() -> some View {
        modifier(CapsuleTitle())
    }
}


// Custom Containers
struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    
    let content: (Int, Int) -> Content
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(0..<rows, id: \.self) { row in
                HStack {
                    ForEach(0..<columns, id: \.self) { column in
                        content(row, column)
                    }
                }
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        Text("Hello World!")
            .modifier(CapsuleTitle())
        
        Text("Another Hello World!")
            .capsuleTitle()
        
        
        GridStack(rows: 4, columns: 4) { r, c in
            HStack {
                Image(systemName: "\(r * 4 + c).circle")
                Text("R\(r) C\(c)")
            }
        }
    }
}

#Preview {
    ContentView()
}
