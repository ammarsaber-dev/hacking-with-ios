//
//  04-HandlingVoiceInput.swift
//  AccessibilitySandbox
//
//  Created by Ammar Saber on 24/06/2026.
//

import SwiftUI

struct _4_HandlingVoiceInput: View {
    var body: some View {
        // Did you know users can control your app by speaking to it? This is possible thanks to Apple's Voice Control technology.
        
        // Users can activate controls through names or numbers, with the names being generated automatically based on what you present. Here's an example:
        
        Button("Tap Me") {
            print("Button tapped")
        }
        
        // Because "Tap Me" is on the screen, it can be activated by saying "Press Tap Me". That's neat, but things are often more complicated.
        
        // Lets say you had buttons with the names of various presidents, like this:
        Button("John Fitzgerald Kennedy") {
            print("Button tapped")
        }
        
        // The user must say "Press John Fitzgerald Kennedy" to be pressed, wouldn't it be great to also recognize "Tap Kennedy" or perhaps even "Tap JFK"? How about recognizing all three?
        
        // accessibilityInputLabels() modifier came for help. It accepts an array of strings that can be attached to our button, so the user can trigger it in a variety of ways.
        Button("John Fitzgerald Kennedy") {
            print("Button tapped")
        }
        .accessibilityInputLabels(["John Fitzgerald Kennedy", "Kennedy", "JFK"])
        
        // The goal is to help the user activate your controls using whatever seems natural to them – you can provide as many strings as you want, and iOS will listen for all of them.
    }
}

#Preview {
    _4_HandlingVoiceInput()
}
