//
//  01-ViewsWithUsefulLabels.swift
//  AccessibilitySandbox
//
//  Created by Ammar Saber on 24/06/2026.
//

import SwiftUI

struct _1_ViewsWithUsefulLabels: View {
    let pictures = [
        "ales-krivec-15949",
        "galina-n-189483",
        "kevin-horstmann-141705",
        "nicolas-tissot-335096",
    ]

    let labels = [
        "Tulips",
        "Frozen tree buds",
        "Sunflowers",
        "Fireworks",
    ]
    
    @State private var selectedPicture = Int.random(in: 0...3)

    var body: some View {
        
        // When VoiceOver is enabled, the user will hear something like
        // Kevin Horstmann one four one seven zero five image.
        // Yes it's an image but we add an onTapGesture which made it act like a button
        // We can control what VoiceOver reads for a given view by attaching two modifiers:  .accessibilityLabel() and .accessibilityHint()
        // The label is read immediately, The hint is read after a short delay
        Image(pictures[selectedPicture])
            .resizable()
            .scaledToFit()
            .onTapGesture {
                selectedPicture = Int.random(in: 0...3)
            }
            // This will fix our first problem
            .accessibilityLabel(labels[selectedPicture])
            // Now the voice over reads the label + "image" instead of the image name.
            
            // The second problem is we said it's an image but it acts like a button. we want to says it's not longer an image and it's a button.
            .accessibilityAddTraits(.isButton) // it's now a button.
            .accessibilityRemoveTraits(.isImage) // it's not an image (in VoiceOver) anymore
        
        
        // MARK: BETTER VERSION
        // of course our previous example is overall bad.
        // Rule to follow: don't use onTapGesture as much as possible, use buttons instead.
        
        Button {
            selectedPicture = Int.random(in: 0...3)
        } label: {
            Image(pictures[selectedPicture])
                .resizable()
                .scaledToFit()
        }
        .accessibilityLabel(labels[selectedPicture])
        
        // Look how much cleaner and better this is.
    }
}

#Preview {
    _1_ViewsWithUsefulLabels()
}
