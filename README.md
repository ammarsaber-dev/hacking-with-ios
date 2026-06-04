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
- Creating reusable views with `FlagImage`
- Writing custom `ViewModifier` and extending `View` (and `Text`) with it

**What I added beyond the challenges:**
- A difficulty picker (Easy / Medium / Hard) that controls how many flags are shown,
  built with a sorted dictionary and `onChange` to reset the game on level change
- Flag spin on tap using `rotation3DEffect` on the Y axis
- Unchosen flags fade to 25% opacity and scale down to 75%

## Views and Modifiers
A technique project that went deep on how SwiftUI views and modifiers actually work under the hood.

**What I learned:**
- Why SwiftUI uses structs for views instead of classes
- Why `some View` is necessary and how opaque return types work
- How modifier order matters and affects layout and rendering
- How to compose small, reusable views as building blocks for larger UIs
- How to create custom `ViewModifier`s and `View` extensions

**Challenges completed:**
- Added a conditional modifier to WeSplit that turns the total amount text red when 0% tip is selected
- Extracted a `FlagImage()` view in Guess the Flag to encapsulate the flag's modifiers
- Created a custom `ViewModifier` with a `View` extension for a large, blue title font style

## BetterRest
A sleep recommendation app that introduced date/time inputs and on-device machine learning via Core ML.

**What I learned:**
- Using `DatePicker` and `Stepper` for structured user input
- Working with `Date` and `DateComponents` to handle time
- Placing buttons in the navigation bar with `.toolbar`
- Training a model with Create ML and integrating it using Core ML
- How on-device machine learning works entirely in private, with no server involved

**Challenges completed:**
- Replaced `VStack` groupings with `Section` views for a cleaner form layout
- Swapped the cups stepper for a `Picker` covering the same range
- Removed the Calculate button entirely, showing the recommended bedtime persistently in a large font

## Word Scramble

A word game where players build words from a randomly chosen root word, 
introducing how SwiftUI handles lists, app bundles, and system APIs.

**What I learned:**
- Building dynamic lists with `List` and `ForEach`
- Loading files from the app bundle using `Bundle.main.url` and `String(contentsOf:)`
- Using `UITextChecker` to validate real English words
- Triggering logic on view appearance with `onAppear`
- Using `fatalError()` for truly impossible states
- Adding toolbar buttons with `.toolbar`
- Animated insertions with `withAnimation`

**What I added beyond the challenges:**
- A scoring system where later words are worth more — rewarding players 
  who keep finding words rather than stopping early (`word.count × words found so far`)
- A score display with `contentTransition(.numericText())` for a smooth animated counter
- A custom `WordError` struct to group alert state cleanly

## Animation

A technique project focused on SwiftUI's animation system — no standalone app, 
but the challenges were applied directly to Guess the Flag.

**What I learned:**
- Implicit vs explicit animations and when to use each
- Driving animations from state with `withAnimation`
- `rotation3DEffect` for 3D axis-based transitions
- Chaining `.opacity`, `.scaleEffect`, and `.animation` for coordinated effects
- Using `.spring` and controlling its speed
- `ViewModifier` and custom `View` extensions for reusable styling

## iExpense

An expense tracker that introduced data persistence, observable classes, 
and sheet-based navigation in SwiftUI.

**What I learned:**
- Using `@Observable` to create a reference-type model that drives the UI
- Persisting data with `UserDefaults` and encoding/decoding using `Codable`
- Presenting sheets with `.sheet` and dismissing them via `@Environment(\.dismiss)`
- Deleting items from a `List` with `onDelete` and `IndexSet`
- Separating model logic into its own file (`ExpenseItem.swift`)
- Using `enum` with `CaseIterable` and `Identifiable` for type-safe pickers

**What I added beyond the challenges:**
- Split the list into Personal and Business sections with independent delete 
  logic — mapping filtered offsets back to the main array by ID to avoid 
  index mismatches
- Color-coded amounts (green / yellow / red) based on value thresholds
- Locale-aware currency formatting using `Locale.current.currency`
- EditButton that only appears when the list has items
- Replaced the instructor's plain string array for expense types with a proper `enum` (`ExpenseType`) conforming to `CaseIterable`, `Identifiable`, and `Codable` — making the picker type-safe and the model serialization cleaner

## Moonshot

A NASA-themed app that introduced custom layouts, JSON decoding, generics, and multi-screen navigation in SwiftUI.

**What I learned:**
- Loading and decoding JSON from the app bundle using `Codable`
- Creating reusable decoding helpers with generics (`<T: Codable>`)
- Building adaptive layouts with `ScrollView` and `LazyVGrid`
- Using `NavigationStack` and `NavigationLink` to navigate between screens
- Passing model data between views
- Organizing larger SwiftUI apps into multiple files and reusable views
- Working with dictionaries to efficiently relate data models

**Challenges completed:**
- Added mission launch dates to the detail screen
- Extracted layout code into reusable views (`GridLayout` and `ListLayout`)
- Added a toolbar button to toggle between grid and list layouts

**What I added beyond the challenges:**
- Used a `MissionLayout` enum instead of a Boolean to represent layout state
- Refactored the toolbar toggle into a single adaptive button
- Styled the list layout to match the app's custom dark theme
