//
//  ContentView.swift
//  WordScramble
//
//  Created by Ammar Saber on 29/05/2026.
//

import SwiftUI

/*
 Challenges:
 
 1. Disallow answers that are shorter than three letters or are just our start word.
 
 2. Add a toolbar button that calls startGame(), so users can restart with a new word whenever they want to.
 
 3. Put a text view somewhere so you can track and show the player’s score for a given root word. How you calculate score is down to you, but something involving number of words and their letter count would be reasonable.
 */

struct WordError {
    var title: String
    var description: String
    var showError: Bool
}

struct ContentView: View {
    @State private var usedWords: [String] = []
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var score = 0
    
    @State private var error = WordError(title: "", description: "", showError: false)
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .onSubmit(addNewWord)
                }
                
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Text(word)
                            Spacer()
                            Image(systemName: "\(word.count).circle.fill")
                        }
                    }
                }
            }
            
            VStack {
                Text("You scored ^[\(score) point](inflect: true)")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .foregroundStyle(.orange)
                    .frame(maxWidth: .infinity)
                    .contentTransition(.numericText())
                
                Text("Each word scores: letters × words found so far")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .padding()
            .navigationTitle(rootWord)
            .toolbar {
                Button("Restart", action: startGame)
            }
        }
        .onAppear(perform: startGame)
        .alert(error.title, isPresented: $error.showError) {
            Button("Ok") {}
        } message: {
            Text(error.description)
        }

    }
    
    func startGame() {
        /*
         1. Find start.txt in our bundle
         
         2. Load it into a string
         
         3. Split that string into array of strings, with each element being one word
         
         4. Pick one random word from there to be assigned to rootWord, or use a sensible default if the array is empty.
         */
        
        if let fileURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let fileContents = try? String(contentsOf: fileURL, encoding: .utf8) {
                let words = fileContents.components(separatedBy: "\n")
                rootWord = words.randomElement() ?? "silkworm"
                
                newWord = ""
                usedWords.removeAll()
                score = 0
                
                return
            }
            
        }
        
        fatalError("Could not load start.txt from bundle.")
    }
    
    func addNewWord() {
        // Lowercase newWord and remove any whitespace
        let word = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        // MARK: Challenge 1
        guard word.count >= 3 else {
            error.title = "Word is short"
            error.description = "It should have 3 or more characters"
            error.showError = true
            
            return
        }
        
        // MARK: Challenge 1
        guard word != rootWord else {
            error.title = "Same word"
            error.description = "Be creative"
            error.showError = true
            
            return
        }
        
        guard isUnique(word: word) else {
            error.title = "Word used already"
            error.description = "Be more original"
            error.showError = true
            
            return
        }
        
        guard isAllowed(word: word) else {
            error.title = "Word not possible"
            error.description = "You can't spell '\(word)' from '\(rootWord)'!"
            error.showError = true
            
            return
        }
        
        guard isReal(word: word) else {
            error.title = "Word not recognized"
            error.description = "You can't just make them up, you know!"
            error.showError = true
            
            return
        }
        
        withAnimation {
            usedWords.insert(word, at: 0)
            // Later words are worth more. Rewarding who keep finding words.
            score += word.count * usedWords.count
        }
        
        newWord = ""
    }
    
    func isUnique(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isAllowed(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        
        let range = NSRange(location: 0, length: word.utf16.count)
        
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
}

#Preview {
    ContentView()
}
