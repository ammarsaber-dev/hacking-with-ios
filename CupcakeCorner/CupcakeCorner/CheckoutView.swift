//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Ammar Saber on 14/06/2026.
//

import SwiftUI

struct CheckoutView: View {
    var order: Order

    @State private var alertMessage = ""
    @State private var showingConfirmation = false
    
    @State private var showingNetworkError = false
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(
                    url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"),
                    scale: 3
                ) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)

                Text(
                    "Your total cost is \(order.cost, format: .currency(code: "USD"))"
                )
                .font(.title)
                .fontWidth(.expanded)

                Button("Place Order") {
                    Task {
                        await placeOrder()
                    }
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .scrollBounceBehavior(.basedOnSize)
        .alert("Thank you!", isPresented: $showingConfirmation) {
            Button("OK") {}
        } message: {
            Text(alertMessage)
        }
        .alert("Oops!", isPresented: $showingNetworkError) {
            Button("OK") {}
        } message: {
            Text(alertMessage)
        }

        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
    }

    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }

        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(
            "free_user_3F9ISV6mtsiLymMN3rGRFPOTepg",
            forHTTPHeaderField: "x-api-key"
        )
        request.httpMethod = "POST"

        do {
            let (data, _) = try await URLSession.shared.upload(
                for: request,
                from: encoded
            )
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            alertMessage =
                "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            showingConfirmation = true

        } catch {
            print("Checkout failed: \(error.localizedDescription)")
            alertMessage =
                "Error: Failed to request the server. Please try again later."
            showingNetworkError = true
        }
    }
}

#Preview {
    CheckoutView(order: Order())
}
