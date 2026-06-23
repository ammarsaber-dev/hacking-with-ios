//
//  ContentView.swift
//  BucketList
//
//  Created by Ammar Saber on 20/06/2026.
//

/*
 Challenges:

 1. Allow the user to switch map modes, between the standard mode and hybrid.

 2. Our app silently fails when errors occur during biometric authentication, so add code to show those errors in an alert.

 3. Create another view model, this time for EditView. What you put in the view model is down to you, but I would recommend leaving dismiss and onSave in the view itself – the former uses the environment, which can only be read by the view, and the latter doesn’t really add anything when moved into the model.
*/

import MapKit
import SwiftUI

struct ContentView: View {

    @State private var viewModel = ViewModel()

    // Center of Egypt
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: 26.25405,
                longitude: 29.26755
            ),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )

    var body: some View {
        NavigationStack {
            if viewModel.isUnlocked {
                MapReader { proxy in
                    Map(initialPosition: startPosition) {
                        ForEach(viewModel.locations) { location in
                            Annotation(
                                location.name,
                                coordinate: location.coordinate
                            ) {
                                Image(systemName: "star.circle")
                                    .resizable()
                                    .foregroundStyle(.red)
                                    .frame(width: 44, height: 44)
                                    .background(.white)
                                    .clipShape(.circle)
                                    .onLongPressGesture(minimumDuration: 0.2) {
                                        viewModel.selectedPlace = location
                                    }
                            }
                        }
                    }
                    .mapStyle(
                        viewModel.mapView == .standard ? .standard : .hybrid
                    )
                    .onTapGesture { position in
                        if let coordinate = proxy.convert(
                            position,
                            from: .local
                        ) {
                            viewModel.addLocation(at: coordinate)
                        }
                    }
                }
                .toolbar {
                    if viewModel.mapView == .hybrid {
                        Button("Standard View", systemImage: "view.2d") {
                            viewModel.mapView = .standard
                        }
                    } else {
                        Button("Hybrid View", systemImage: "view.3d") {
                            viewModel.mapView = .hybrid
                        }
                    }
                }
                .sheet(item: $viewModel.selectedPlace) { place in
                    EditView(location: place) { newLocation in
                        viewModel.update(location: newLocation)
                    }
                }
            } else {
                Button("Unlock Places", action: viewModel.authenticate)
                    .padding()
                    .background(.blue)
                    .foregroundStyle(.white)
                    .clipShape(.capsule)
            }
        }
        .alert(viewModel.error.title, isPresented: $viewModel.error.isShown) {
            Button("OK") {}
        } message: {
            Text(viewModel.error.description)
        }
    }
}

#Preview {
    ContentView()
}
