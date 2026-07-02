# Hacking with iOS

Projects built while working through Hacking with Swift's 100 Days of SwiftUI by Paul Hudson.
Each section below covers what the project taught and what I added beyond the standard course challenges.

---

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

---

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

---

## Views and Modifiers (Technique Project)
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

---

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

---

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

---

## Animation (Technique Project)

A technique project focused on SwiftUI's animation system — no standalone app, 
but the challenges were applied directly to Guess the Flag.

**What I learned:**
- Implicit vs explicit animations and when to use each
- Driving animations from state with `withAnimation`
- `rotation3DEffect` for 3D axis-based transitions
- Chaining `.opacity`, `.scaleEffect`, and `.animation` for coordinated effects
- Using `.spring` and controlling its speed
- `ViewModifier` and custom `View` extensions for reusable styling

---

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

---

## Moonshot

A NASA mission browser that introduced custom layouts, JSON decoding, generics, 
and multi-screen navigation in SwiftUI.

**What I learned:**
- Loading and decoding JSON from the app bundle using `Codable`
- Creating reusable decoding helpers with generics (`<T: Codable>`)
- Building adaptive layouts with `ScrollView` and `LazyVGrid`
- Using `NavigationStack` with `NavigationLink(value:)` and `navigationDestination` 
  for value-based navigation
- Adding `Hashable` conformance to structs to enable value-based navigation
- Passing model data between views and organizing larger apps into multiple files
- Working with dictionaries to efficiently relate data models

**What I added beyond the challenges:**
- Used a `MissionLayout` enum instead of a Boolean to represent layout state
- Refactored the toolbar toggle into a single adaptive button
- Styled the list layout to match the app's custom dark theme
- Registered two `navigationDestination` handlers — one for `Mission`, one for 
  `Astronaut` — so tapping a crew member navigates directly to their profile

---

## Navigation (Technique Project)

A technique project focused on SwiftUI's navigation system, with challenges 
applied back to iExpense and Moonshot.

**What I learned:**
- The difference between destination-closure `NavigationLink` and `NavigationLink(value:)`
- Why `Hashable` conformance is required for value-based navigation
- Hiding the back button with `navigationBarBackButtonHidden` to enforce explicit actions
- Editing the navigation title inline with a `Binding<String>` and `.toolbarRole(.editor)`

**What I applied in iExpense:**
- Replaced the sheet with a `NavigationLink` push to `AddView`
- Replaced the name `TextField` with an editable `navigationTitle($name)`, 
  defaulting to "Your expense"

---

## Cupcake Corner

A cupcake ordering app that introduced networking, async/await, and sending/receiving 
JSON data to and from a remote server.

**What I learned:**
- Sending data to a server with `URLRequest`, `URLSession.shared.upload`, and `async/await`
- Decoding server responses back into Swift models with `Codable`
- Using `@Observable` with `Codable` — and why the backing store property names 
  require explicit `CodingKeys` mapping (`_name = "name"`)
- Loading remote images with `AsyncImage` and handling the placeholder state
- Using `@Bindable` to mutate an `@Observable` class passed into a child view
- Disabling navigation based on form validation state

**What I added beyond the challenges:**
- Whitespace-aware address validation using `trimmingCharacters(in:)` across 
  all four fields in a single pipeline
- Network error alert with a separate Boolean so success and failure states 
  are handled independently
- Persisted the full order to `UserDefaults` using static `load()` and instance 
  `save()` methods — avoiding getter/setter conflicts with `Codable` by keeping 
  persistence logic inside the model
- Saved on every meaningful change via `onChange` modifiers rather than only on dismiss

---

## Bookworm

A book tracking app that introduced SwiftData for persistent storage and 
custom reusable SwiftUI components.

**What I learned:**
- Setting up SwiftData with `@Model`, `modelContainer`, and `modelContext`
- Querying and sorting persisted data with `@Query` and `SortDescriptor`
- Inserting and deleting model objects via `modelContext`
- Building custom UI components with `@Binding` — a star `RatingView` and 
  an emoji `EmojiRatingView`
- Using `TextEditor` for multi-line text input
- Making enums work with SwiftData using `Codable` conformance
- Using `@Environment(\.modelContext)` and `@Environment(\.dismiss)` in child views

**What I added beyond the challenges:**
- Form validation in `AddBookView` using the same trimming pipeline from previous 
  projects — Save button stays disabled until title, author, and review are all filled
- Highlighted 1-star books with a red row background using `.listRowBackground` 
  instead of just coloring the text — subtler and more polished
- Added `date` to the `Book` model with a default of `Date.now`, displayed in 
  `DetailView` with both date and time formatted
- Used a `Genre` enum with `CaseIterable` and `Codable` instead of raw strings, 
  making genre handling type-safe throughout

---

## SwiftData Project (Technique Project)

A technique project focused on SwiftData fundamentals — relationships, cascading
deletes, and dynamic queries — using a Users/Jobs model.

**What I learned:**
- Defining one-to-many relationships between `@Model` classes (`User` has many `Job`s)
- Cascade delete rules with `@Relationship(deleteRule: .cascade)` and how they
  propagate through nested relationships
- Filtering `@Query` results with `#Predicate` based on a dynamic date threshold
- Sorting with multiple `SortDescriptor`s, including a secondary tiebreaker field
- Bulk deleting all instances of a model with `modelContext.delete(model:)`
- Driving `@Query` parameters (filter, sort) through a child view's `init`

**What I added beyond the challenges:**
- A toggle button to switch between showing all users and only those joining
  in the future, using `.distantPast` vs `.now` as the predicate threshold
- Animated sort order changes with `$sortOrder.animation()`
- A job count badge next to each user in the list

---

## iExpense (SwiftData Upgrade)

Challenges from the SwiftData technique project, applied back to iExpense —
migrating it from UserDefaults to SwiftData with dynamic sorting and filtering.

**What I learned:**
- Migrating a `Codable` + `UserDefaults` model to a SwiftData `@Model`
- Using `@Query` with dynamic `filter` and `sort` parameters passed through init
- Building predicates with `#Predicate` macros
- Driving `@Query` reactively from parent-owned `@State` (filter/sort can't be
  mutated directly on an existing `@Query`)
- Setting up `.modelContainer` at the app entry point

**What I added beyond the challenges:**
- Filter menu (All / Personal / Business) built from an `ExpenseFilter` enum
  that maps to `#Predicate` cases
- Sort menu (by name / by price) using tagged `SortDescriptor` arrays, with
  price sort using a reverse order plus name as a secondary tiebreaker
- Kept currency formatting and color-coded amount styling from the original version

---

## Instafilter

A photo filter app using Core Image to apply real-time effects, introducing 
PhotosPicker, confirmation dialogs, and App Store review prompts.

**What I learned:**
- Picking photos with `PhotosPicker` and loading them via `loadTransferable`
- The Core Image pipeline: `UIImage` → `CIImage` → apply filter → `CGImage` → `UIImage`
- Why `CIContext` should be created once and reused across renders, not recreated per-image
- Why widening `currentFilter`'s type to `CIFilter` loses filter-specific properties 
  (like `.intensity`), and using `setValue(forKey:)` with `inputKeys` checks as the fix
- Presenting a `confirmationDialog` to let users pick between several filters
- Showing `ContentUnavailableView` for empty states
- Sharing images with `ShareLink` and `SharePreview`
- Requesting App Store reviews with `@Environment(\.requestReview)`, gated by 
  a `@AppStorage` counter

**What I added beyond the challenges:**
- Four independent sliders (Intensity, Radius, Scale, Amount) instead of one, 
  each only applied if the current filter actually supports that input key
- Ten Core Image filters in the picker instead of the minimum three 
  (Crystallize, Edges, Gaussian Blur, Pixellate, Sepia Tone, Unsharp Mask, 
  Vignette, Bloom, Thermal, Vibrance)

---

## Bucket List

A travel planning app combining MapKit, biometric authentication, secure local 
storage, and a live Wikipedia API integration — the biggest project in the 
course so far.

**What I learned:**
- Displaying interactive maps with `Map`, `MapReader`, and `Annotation`
- Converting tap coordinates to real-world coordinates with `proxy.convert`
- Biometric authentication using `LAContext` and `LocalAuthentication`
- Securely writing data to disk with `Data.write(options: [.atomic, .completeFileProtection])`
- Finding the documents directory via `URL.documentsDirectory`
- Conforming to `Comparable` on a custom type (`Page`) to sort API results
- Fetching and decoding live data from the Wikipedia API with nested `Codable` structs
- Splitting a single screen into separate view models (`ContentView.ViewModel` 
  and `EditView.ViewModel`) and correctly keeping `dismiss`/`onSave` in the view 
  layer rather than the model

**What I added beyond the challenges:**
- Map style toggle (standard / hybrid) via a `MapView` enum and `.mapStyle` modifier, 
  with the toolbar button icon and label swapping based on current mode
- A custom `Error` struct on the view model to drive a unified alert for both 
  biometric and other failure states
- A `LoadingState` enum (`.loading` / `.loaded` / `.failed`) driving the nearby 
  places section instead of just a Boolean flag

---

## Accessibility

A technique project exploring VoiceOver, Voice Control, and other accessibility 
APIs in SwiftUI, with a sandbox of annotated examples and fixes applied back to 
Cupcake Corner, iExpense, and Moonshot.

**What I learned:**
- `.accessibilityLabel` and `.accessibilityHint` to control what VoiceOver reads, 
  and the difference between label (read immediately) and hint (read after a delay)
- Preferring `Button` over `.onTapGesture` so VoiceOver correctly identifies 
  interactive elements without needing manually added/removed traits
- Hiding purely decorative images from the accessibility tree with 
  `Image(decorative:)` or `.accessibilityHidden(true)`
- Grouping related views into a single accessibility element with 
  `.accessibilityElement(children: .combine)` vs `.ignore`
- Separating a control's label from its value using `.accessibilityValue`, and 
  supporting VoiceOver swipe gestures with `.accessibilityAdjustableAction`
- Supporting Voice Control with `.accessibilityInputLabels`, letting users 
  trigger controls with alternate phrases ("Tap JFK" instead of the full label)

**What I applied across previous projects:**
- **Cupcake Corner:** hid the decorative cupcake image and loading spinner from 
  VoiceOver with `.accessibilityHidden(true)`
- **iExpense:** combined each expense row into a single accessibility element — 
  name and formatted amount read together as the label, with the expense type 
  moved into the hint instead of being read as a separate line
- **Moonshot:** added accessibility labels to every meaningful image across the 
  app — mission images in both grid and list layouts, the mission detail badge, 
  crew member thumbnails in the horizontal scroll, and the astronaut profile image

---

## Hot Prospects

A conference networking app for scanning and tracking contacts via QR codes, 
the largest project in the course so far.

**What I learned:**
- Using `TabView` with the new `Tab` API for multi-screen navigation
- Integrating a Swift Package dependency (CodeScanner) for QR code scanning
- Generating QR codes with `CIFilter.qrCodeGenerator()` and `.interpolation(.none)`
- Scheduling local notifications with `UNUserNotificationCenter`, handling 
  permission requests and fallback flows
- Using `@AppStorage` to persist simple user data across app launches
- Multi-selection in `List` with `EditButton` and a `Set<Prospect>` selection binding
- Context menus and swipe actions on list rows
- Filtering `@Query` results through a predicate built in the view's `init`
- Adding `dateAdded` to a SwiftData model and sorting by it

**What I added beyond the challenges:**
- `ProspectRowView` as a separate extracted view for the row layout
- Contacted/uncontacted icon shown only on the "Everyone" tab, hidden on 
  the filtered tabs — driven by the `FilterType` passed into the row
- Sort picker (by name / by date added, newest first) in a toolbar `Menu`
- Bulk delete of selected prospects via a toolbar button that appears only 
  when items are selected
- `EditProspectView` using `@Bindable` for zero-boilerplate persistent edits 
  — no Save button needed since SwiftData persists changes automatically
