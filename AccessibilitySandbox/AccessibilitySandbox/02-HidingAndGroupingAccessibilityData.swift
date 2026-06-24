//
//  02-HidingAndGroupingAccessibilityData.swift
//  AccessibilitySandbox
//
//  Created by Ammar Saber on 24/06/2026.
//

import SwiftUI

struct _2_HidingAndGroupingAccessibilityData: View {
    var body: some View {
        // Rule of thumb: Ensure that you remove as much UI clutter as possible so that users can navigate through it quickly and not have to listen to VoiceOver reading unhelpful descriptions (as VoiceOver just reads everything on the screen)

        // We could tell VoiceOver what to read or not. Some ways like:
        // - Marking images as being unimportant for VoiceOver.
        // - Hiding views from the accessibility system.
        // - Grouping several views as one.

        // If we have an image that doesn't add anything to the screen other than to make UI look better, we could tell VoiceOver to ignore it like so:

        Image(decorative: "character")  // Creates an unlabeled, decorative image.
            .resizable()
            .scaledToFit()

        // You can get the same result for all other views (and images as well) by using .accessibilityHidden()

        Image(.character)
            .resizable()
            .scaledToFit()
            .accessibilityHidden(true)

        // NOTE: only use this if the view doesn't add anything.

        // ------------------------------------------------------------

        // The last way to hide content from VoiceOver is through grouping, which lets us control how the system reads several views that are related. for example:
        VStack {
            Text("Your score is")
            Text("1000")
                .font(.title)
        }
        
        // VoiceOver sees that as two unrelated text views, and so it will either read “Your score is” or “1000” depending on what the user has selected.
        
        // .accessibilityElement(children:) modifier comes in: we can apply it to a parent view, and ask it to combine children into a single accessibility element.
        
        // For example, this will cause both text views to be read together, with a short pause between them:
        VStack {
            Text("Your score is")
            Text("1000")
                .font(.title)
        }
        .accessibilityElement(children: .combine)
        
        // That works really well when the child views contain separate information, but in our case the children really should be read as a single entity.
        
        // So Use .accessibilityElement(children: .ignore) when multiple child views should be read as one item. This hides the children from VoiceOver and lets you provide a single custom label:
        VStack {
            Text("Your score is")
            Text("1000")
                .font(.title)
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Your score is 1000")
        
        // VoiceOver will read: “Your score is 1000” as one element instead of reading each text separately.
        
        
        // Tip: .ignore is the default parameter for children, so you can get the same results as .accessibilityElement(children: .ignore) just by saying .accessibilityElement().
    }
}

#Preview {
    _2_HidingAndGroupingAccessibilityData()
}
