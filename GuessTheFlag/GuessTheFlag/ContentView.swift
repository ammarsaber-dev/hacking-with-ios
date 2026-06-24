//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Ammar Saber on 23/05/2026.
//

/*
 // MARK: Challenges From View and Modifiers Section

 1. Go back to project 2 and replace the Image view used for flags with a new FlagImage() view that renders one flag image using the specific set of modifiers we had.

 2. Create a custom ViewModifier (and accompanying View extension) that makes a view have a large, blue font suitable for prominent titles in a view.
 */

/*
 // MARK: Challenges From Animation Section

 1. When you tap a flag, make it spin around 360 degrees on the Y axis.

 2. Make the other two buttons fade out to 25% opacity.

 3. Add a third effect of your choosing to the two flags the user didn’t choose – maybe make them scale down? Or flip in a different direction? Experiment!
 */

import SwiftUI

// Task 2: Done
struct LargeBlueFont: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 48))
            .fontWeight(.black)
            .foregroundStyle(.background)  // customized to make it suitable with the current design
    }
}
extension Text {
    func largeBlueFont() -> some View {
        modifier(LargeBlueFont())
    }
}

struct ContentView: View {
    let maxNumberOfQuestions = 8
    let levels = [
        "Easy": 3,
        "Medium": 4,
        "Hard": 5,
    ].sorted(by: { $0.value < $1.value })

    let labels = [
        "Estonia":
            "Flag with three horizontal stripes. Top stripe blue, middle stripe black, bottom stripe white.",
        "France":
            "Flag with three vertical stripes. Left stripe blue, middle stripe white, right stripe red.",
        "Germany":
            "Flag with three horizontal stripes. Top stripe black, middle stripe red, bottom stripe gold.",
        "Ireland":
            "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe orange.",
        "Italy":
            "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe red.",
        "Nigeria":
            "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe green.",
        "Poland":
            "Flag with two horizontal stripes. Top stripe white, bottom stripe red.",
        "Spain":
            "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red.",
        "UK":
            "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background.",
        "Ukraine":
            "Flag with two horizontal stripes. Top stripe blue, bottom stripe yellow.",
        "US":
            "Flag with many red and white stripes, with white stars on a blue background in the top-left corner.",
    ]

    @State private var countries = [
        "US", "UK", "France", "Ukraine", "Germany", "Nigeria", "Monaco",
        "Italy", "Estonia", "Poland", "Spain", "Ireland",
    ].shuffled()

    @State private var correctAnswer = Int.random(in: 0...2)

    @State private var showScore = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""

    @State private var currentQuestionNumber = 0
    @State private var score = 0

    @State private var showReset = false

    @State private var currentLevel = "Easy"
    @State private var numberOfAnswers = 3

    @State private var selectedIndex: Int? = nil
    @State private var animationRotation = 0.0

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.indigo, .indigo.opacity(0.75)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack {
                Spacer()

                VStack {
                    Text("Score: \(score) out of \(maxNumberOfQuestions)")
                        .foregroundStyle(.white)
                        .font(.title2)
                        .fontWeight(.semibold)

                    Picker("Level", selection: $currentLevel) {
                        ForEach(levels, id: \.key) { key, value in
                            Text(key)
                        }
                    }
                    .pickerStyle(.segmented)
                    .onChange(of: currentLevel) { _, newValue in
                        if let match = levels.first(where: {
                            $0.key == newValue
                        }) {
                            numberOfAnswers = match.value
                            reset()
                        }
                    }
                }

                Spacer()

                VStack {
                    Text("Tap the flag of")
                    Text(countries[correctAnswer])
                        .largeBlueFont()  // Task 2: Done
                }
                .foregroundStyle(.white)

                ForEach(0..<numberOfAnswers, id: \.self) { number in
                    Button {
                        buttonTapped(number)
                        selectedIndex = number
                        withAnimation(.spring) {
                            animationRotation += 360
                        }
                    } label: {
                        FlagImage(country: countries[number])  // Challenge 1: Done
                    }
                    .accessibilityLabel(labels[countries[number], default: "Unknown flag"])

                    // Animation Challenges
                    .rotation3DEffect(
                        .degrees(
                            selectedIndex == number ? animationRotation : 0
                        ),
                        axis: (x: 0, y: 1, z: 0)
                    )
                    .opacity(
                        selectedIndex == nil || selectedIndex == number
                            ? 1.0 : 0.25
                    )
                    .scaleEffect(
                        selectedIndex == nil || selectedIndex == number
                            ? 1.0 : 0.75
                    )
                    .animation(.spring.speed(0.75), value: selectedIndex)
                }

                Spacer()
            }
            .padding()
        }.alert(scoreTitle, isPresented: $showScore) {
            Button("Continue") {
                if currentQuestionNumber == maxNumberOfQuestions {
                    showReset = true
                } else {
                    askQuestion()
                }
            }
        } message: {
            Text(scoreMessage)
        }
        .alert("Reset the game?", isPresented: $showReset) {
            Button("Yeah!") {
                reset()
            }
        }
    }

    func buttonTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct!"
            score += 1
        } else {
            scoreTitle = "Wrong!"
        }

        currentQuestionNumber += 1

        scoreMessage = "You chose \(countries[number])"
        showScore = true

    }

    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        selectedIndex = nil
        animationRotation = 0

    }

    func reset() {
        score = 0
        scoreTitle = ""
        currentQuestionNumber = 0
        askQuestion()
    }
}

struct FlagImage: View {
    let country: String

    var body: some View {
        Image(country)
            .clipShape(.capsule)
            .shadow(radius: 10)
    }
}

#Preview {
    ContentView()
}
