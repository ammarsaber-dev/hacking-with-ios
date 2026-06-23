//
//  ContentView-ViewModel.swift
//  BucketList
//
//  Created by Ammar Saber on 22/06/2026.
//

import CoreLocation
import Foundation
import LocalAuthentication

extension ContentView {
    @Observable
    final class ViewModel {
        enum MapView {
            case standard, hybrid
        }

        struct Error {
            var isShown: Bool
            var title: String
            var description: String
        }

        var error = Error(isShown: false, title: "", description: "")

        var mapView: MapView = .standard

        private(set) var locations: [Location]
        var selectedPlace: Location?
        var isUnlocked = false

        let savePath = URL.documentsDirectory.appending(path: "SavedPlaces")

        init() {
            // Reading the locations from the file
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode(
                    [Location].self,
                    from: data
                )
            } catch {
                locations = []
            }
        }

        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(
                    to: savePath,
                    options: [.atomic, .completeFileProtection]
                )
            } catch {
                print("Unable to save data.")
            }
        }

        func addLocation(at point: CLLocationCoordinate2D) {
            let newLocation = Location(
                id: UUID(),
                name: "New Location",
                description: "",
                latitude: point.latitude,
                longitude: point.longitude
            )

            locations.append(newLocation)
            save()
        }

        func update(location: Location) {
            guard let selectedPlace else { return }

            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
                save()
            }
        }

        func authenticate() {
            let context = LAContext()
            var error: NSError?

            if context.canEvaluatePolicy(
                .deviceOwnerAuthenticationWithBiometrics,
                error: &error
            ) {
                let reason =
                    "Please authenticate yourself to unlock your places."

                context.evaluatePolicy(
                    .deviceOwnerAuthenticationWithBiometrics,
                    localizedReason: reason
                ) { success, authenticationError in
                    if success {
                        self.isUnlocked = true
                    }
                }
            } else {
                // no biometrics
                self.error.isShown = true
                self.error.title = "No Biometrics"
                self.error.description = error?.localizedDescription ?? ""
            }
        }
    }
}
