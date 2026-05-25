//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Ammar Saber on 23/05/2026.
//

import SwiftUI

struct ContentView: View {
    let maxNumberOfQuestions = 8
    let levels = [
        "Easy": 3,
        "Medium": 4,
        "Hard": 5,
    ].sorted(by: { $0.value < $1.value } )

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
                        if let match = levels.first(where: { $0.key == newValue }) {
                            numberOfAnswers = match.value
                            reset()
                        }
                    }
                }

                Spacer()

                VStack {
                    Text("Tap the flag of")
                    Text(countries[correctAnswer])
                        .font(.system(size: 48))
                        .fontWeight(.black)
                }
                .foregroundStyle(.white)

                ForEach(0..<numberOfAnswers, id: \.self) { number in
                    Button {
                        buttonTapped(number)
                    } label: {
                        Image(countries[number])
                    }
                    .clipShape(.capsule)
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
    }

    func reset() {
        score = 0
        scoreTitle = ""
        currentQuestionNumber = 0
        askQuestion()
    }
}

#Preview {
    ContentView()
}
