//
//  AstronautView.swift
//  Moonshot
//
//  Created by Ammar Saber on 03/06/2026.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    //    let missions: [Mission]
    var body: some View {
        ScrollView {
            VStack {
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                    .clipShape(
                        RoundedRectangle(cornerRadius: 16)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .strokeBorder(.white, lineWidth: 0.5)
                    )
                    .padding()

                Text(astronaut.description)
                    .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(astronaut.name)
        }
        .background(.darkBackground)
    }
}

#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

    return AstronautView(astronaut: astronauts["aldrin"]!)
        .preferredColorScheme(.dark)
}
