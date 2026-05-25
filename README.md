# Hacking with iOS
Hacking with iOS: SwiftUI Edition, Projects.

## WeSplit

WeSplit was the first app in the course — a bill-splitting utility that introduced 
the core building blocks of SwiftUI development.

**What I learned:**
- How SwiftUI apps are structured at a foundational level
- Building forms and sections to organize user input
- Using `NavigationStack` and setting navigation bar titles
- Managing state with `@State` and `@FocusState` property wrappers
- Creating input controls like `TextField` and `Picker`
- Rendering views dynamically using `ForEach`

## Guess the Flag

A flag-guessing game that introduced SwiftUI's layout system and how the framework 
thinks about state-driven UI.

**What I learned:**
- Composing layouts with `VStack`, `HStack`, and `ZStack`
- Using `Image` and `clipShape` to style visual elements
- How alerts work in SwiftUI — state-driven rather than imperatively triggered
- Shuffling and indexing into arrays to randomize game content
- Tracking score and question count with `@State`

**What I added beyond the challenges:**
- A difficulty picker (Easy / Medium / Hard) that controls how many flags are shown,
  built with a sorted dictionary and `onChange` to reset the game on level change
