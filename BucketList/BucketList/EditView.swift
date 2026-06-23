//
//  EditView.swift
//  BucketList
//
//  Created by Ammar Saber on 22/06/2026.
//

import SwiftUI

struct EditView: View {
    @State private var viewModel: ViewModel

    @Environment(\.dismiss) var dismiss
    var onSave: (Location) -> Void

    init(location: Location, onSave: @escaping (Location) -> Void) {
        _viewModel = State(initialValue: ViewModel(location: location))
        self.onSave = onSave
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Place Name", text: $viewModel.name)
                    TextField("Description", text: $viewModel.description)
                }

                Section("Nearby...") {
                    switch viewModel.loadingState {
                    case .loading:
                        ProgressView()

                    case .loaded:
                        ForEach(viewModel.pages, id: \.pageid) { page in
                            Text(
                                "\(Text(page.title).font(.headline)): \(Text(page.description).italic())"
                            )
                        }

                    case .failed:
                        Text("Something went wrong. Please try again.")
                    }
                }
            }

            .navigationTitle("Place details")
            .toolbar {
                Button("Save") {
                    let newLocation = viewModel.saveLocation()
                    onSave(newLocation)
                    dismiss()
                }
            }
            .task {
                await viewModel.fetchNearbyPlaces(location: viewModel.location)
            }
        }
    }

}

#Preview {
    EditView(location: .example) { _ in }
}
