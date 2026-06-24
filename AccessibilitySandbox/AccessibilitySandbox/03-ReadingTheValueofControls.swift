//
//  03-ReadingTheValueofControls.swift
//  AccessibilitySandbox
//
//  Created by Ammar Saber on 24/06/2026.
//

import SwiftUI

struct _3_ReadingTheValueofControls: View {
    @State private var value = 10

    var body: some View {
        // SwiftUI provides default VoiceOver support for UI controls, but when it doesn’t meet your needs, you can customize accessibility using accessibilityValue() to separate a control’s value from its label, and accessibilityAdjustableAction() to define custom swipe actions.

        // For example, you might build a view that shows some kind of input controlled by various buttons, like a custom stepper:
        VStack {
            Text("Value: \(value)")

            Button("Increment") {
                value += 1
            }

            Button("Decrement") {
                value -= 1
            }
        }

        // That might work just the way you want with tap interactions, but it’s not a great experience with VoiceOver because all users will hear is “Increment” or “Decrement” every time they tap one of the buttons.

        // A better approach is to group the controls into a single accessibility element, provide a label and value, and handle swipe gestures:
        VStack {
            Text("Value: \(value)")

            Button("Increment") {
                value += 1
            }

            Button("Decrement") {
                value -= 1
            }
        }
        .accessibilityElement()  // Creates a new accessibility element
        .accessibilityLabel("Value")  // Adds a label to the view that describes its contents.
        .accessibilityValue(String(value))  // Adds a textual description of the value that the view contains.
        .accessibilityAdjustableAction { direction in
            switch direction {
            case .increment:
                value += 1
            case .decrement:
                value -= 1
            default:
                print("Not handled.")
            }
        }

        // Adjustable actions hand us the direction the user swiped, and we can respond however we want. There is one proviso: yes, we can choose between increment and decrement swipes, but we also need a special default case to handle unknown future values – Apple has reserved the right to add other kinds of adjustments in the future.

        // That lets users select the whole VStack to have “Value: 10” read out, but then they can swipe up or down to manipulate the value and have just the numbers read out – it’s a much more natural way of working.

    }
}

#Preview {
    _3_ReadingTheValueofControls()
}
