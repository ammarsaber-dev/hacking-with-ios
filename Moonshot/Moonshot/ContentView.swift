//
//  ContentView.swift
//  Moonshot
//
//  Created by Ammar Saber on 03/06/2026.
//

/*
 Challenges:

 1. Add the launch date to MissionView, below the mission badge. You might choose to format this differently given that more space is available, but it’s down to you.

 2. Extract one or two pieces of view code into their own new SwiftUI views – the horizontal scroll view in MissionView is a great candidate, but if you followed my styling then you could also move the Rectangle dividers out too.

 3. For a tough challenge, add a toolbar item to ContentView that toggles between showing missions as a grid and as a list.
 */

import SwiftUI

struct ContentView: View {
    // Challenge 3 Done
    enum MissionLayout {
        case grid, list
    }
    @State private var missionLayout: MissionLayout = .grid

    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")

    var body: some View {
        NavigationStack {
            Group {
                if missionLayout == .grid {
                    ScrollView {
                        GridLayout(missions: missions, astronauts: astronauts)
                    }
                } else {
                    ListLayout(missions: missions, astronauts: astronauts)
                }
            }
            // Challenge 3 Done
            .toolbar {
                Button {
                    missionLayout = missionLayout == .grid ? .list : .grid
                } label: {
                    Image(
                        systemName:
                            missionLayout == .grid
                            ? "list.bullet"
                            : "square.grid.3x3"
                    )
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
        }
    }
}

struct ListLayout: View {
    let missions: [Mission]
    let astronauts: [String: Astronaut]

    var body: some View {
        List(missions) { mission in
            NavigationLink {
                MissionView(mission: mission, astronauts: astronauts)
            } label: {
                HStack(spacing: 16) {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 72, height: 72)
                    VStack(alignment: .leading, spacing: 4) {
                        Text(mission.displayName)
                            .font(.headline)
                            .foregroundStyle(.white)
                        Text(mission.formattedLaunchDate)
                            .font(.caption)
                            .foregroundStyle(.white.opacity(0.6))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(12)
                .background(.lightBackground)
                .clipShape(.rect(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.lightBackground)
                )
                .contentShape(Rectangle())
            }
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
        }
        .listStyle(.plain)
    }
}

struct GridLayout: View {
    let missions: [Mission]
    let astronauts: [String: Astronaut]

    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]

    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(missions) { mission in
                NavigationLink {
                    MissionView(mission: mission, astronauts: astronauts)
                } label: {
                    VStack {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .padding()
                        VStack {
                            Text(mission.displayName)
                                .font(.headline)
                                .foregroundStyle(.white)

                            Text(mission.formattedLaunchDate)
                                .font(.caption)
                                .foregroundStyle(.white.opacity(0.5))
                        }
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(.lightBackground)
                    }
                    .clipShape(.rect(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.lightBackground)
                    )
                }
            }
        }
        .padding([.horizontal, .bottom])
    }
}

#Preview {
    ContentView()
}
