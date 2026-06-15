//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Ammar Saber on 14/06/2026.
//

/*
 ## Challenges:

 1. Our address fields are currently considered valid if they contain anything, even if it’s just only whitespace. Improve the validation to make sure a string of pure whitespace is invalid.
 
 2. If our call to placeOrder() fails – for example if there is no internet connection – show an informative alert for the user. To test this, try commenting out the request.httpMethod = "POST" line in your code, which should force the request to fail.
 
 3. For a more challenging task, try updating the Order class so it saves data such as the user's delivery address to UserDefaults. This takes a little thinking, because @AppStorage won't work here, and you'll find getters and setters cause problems with Codable support. Can you find a middle ground?
*/

import SwiftUI

struct ContentView: View {
    @State private var order = Order.load()
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.type) {
                        ForEach(Order.types.indices, id: \.self) {
                            Text(Order.types[$0])
                        }
                    }

                    Stepper(
                        "Number of cakes: \(order.quantity)",
                        value: $order.quantity,
                        in: 3...20
                    )
                }

                Section {
                    Toggle(
                        "Any special request?",
                        isOn: $order.specialRequestEnabled.animation()
                    )

                    if order.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $order.extraFrosting)
                        Toggle("Add extra sprinkles", isOn: $order.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink("Delivery details") {
                        AddressView(order: order)
                    }
                }
            }
            .onChange(of: order.name) { order.save() }
            .onChange(of: order.quantity) { order.save() }
            .onChange(of: order.type) { order.save() }
            .onChange(of: order.streetAddress) { order.save() }
            .onChange(of: order.addSprinkles) { order.save() }
            .onChange(of: order.extraFrosting) { order.save() }
            .onChange(of: order.zip) { order.save() }
            .onChange(of: order.specialRequestEnabled) { order.save() }
            .navigationTitle("Cupcake Corner")
        }
    }
}

#Preview {
    ContentView()
}
