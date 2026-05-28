//
//  ContentView.swift
//  BetterRest
//
//  Created by Ammar Saber on 28/05/2026.
//

import CoreML
import SwiftUI

/*
 Challenges:
 1. Replace each VStack in our form with a Section, where the text view is the title of the section. Do you prefer this layout or the VStack layout? It’s your app – you choose!

 2. Replace the “Number of cups” stepper with a Picker showing the same range of values.

 3. Change the user interface so that it always shows their recommended bedtime using a nice and large font. You should be able to remove the “Calculate” button entirely.
 */

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp: Date = defaultWakeTime
    @State private var coffeeAmount = 1

    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0

        return Calendar.current.date(from: components) ?? .now
    }

    // MARK: Challenge 3
    var bedTime: String? {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)

            let components = Calendar.current.dateComponents(
                [.hour, .minute],
                from: wakeUp
            )
            let hoursInSeconds = (components.hour ?? 0) * 60 * 60
            let minutesInSeconds = (components.minute ?? 0) * 60

            let prediction = try model.prediction(
                wake: Double(hoursInSeconds + minutesInSeconds),
                estimatedSleep: sleepAmount,
                coffee: Double(coffeeAmount)
            )

            let sleepTime = wakeUp - prediction.actualSleep

            return sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            print("Sorry, something went wrong: \(error)")
        }

        return nil
    }

    var body: some View {
        NavigationStack {
            
            // MARK: Challenge 1
            Form {
                Section("When do you want to wake up?") {
                    DatePicker(
                        "Please enter a time",
                        selection: $wakeUp,
                        displayedComponents: .hourAndMinute
                    )
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                }

                Section("How much hours you want to sleep?") {
                    Stepper(
                        "\(sleepAmount.formatted()) hours",
                        value: $sleepAmount,
                        in: 4...12,
                        step: 0.25
                    )
                }

                //                Section("How many cups of coffee you want to drink?") {
                //                    Stepper("^[\(coffeeAmount) cup](inflect: true)", value: $coffeeAmount, in: 1...20)
                //                }

                // MARK: Challenge 2
                Picker("Number of cups", selection: $coffeeAmount) {
                    ForEach(1..<21, id: \.self) {
                        Text("^[\($0) cup](inflect: true)")
                            .tag($0)
                    }
                }
            }
            .navigationTitle("BetterRest")

            // MARK: Challenge 3
            if let bedTime {
                VStack {
                    Text("Your ideal bedtime is")
                    Text(bedTime)
                        .font(.system(size: 64))
                        .fontWeight(.bold)
                        .foregroundStyle(.orange)
                        .frame(maxWidth: .infinity)
                }
                .padding()
            }
        }
    }
}

#Preview {
    ContentView()
}
