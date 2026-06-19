//
//  ContentView.swift
//  Instafilter
//
//  Created by Ammar Saber on 18/06/2026.
//


/*
 Challenges:
 
 1. Try making the Slider and Change Filter buttons disabled if there is no image selected.
 
 2. Experiment with having more than one slider, to control each of the input keys you care about. For example, you might have one for radius and one for intensity.
 
 3. Explore the range of available Core Image filters, and add any three of your choosing to the app.

*/

import CoreImage
import CoreImage.CIFilterBuiltins
import PhotosUI
import StoreKit
import SwiftUI

struct ContentView: View {
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var processedImage: Image?

    @State private var filterIntensity = 0.5
    @State private var filterRadius = 0.5
    @State private var filterScale = 0.5
    @State private var filterAmount = 0.5
    
    // by default currentFilter conforms to CIFilter & CISepiaTone, we only want the first part to be able to make multiple filters.
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()

    @State private var showingFilters = false

    @AppStorage("filterCount") private var filterCount = 0
    @Environment(\.requestReview) private var requestReview

    // We use a CIContext instance to render a CIImage
    // It's recommended to only use one context for multiple images (performance-wise)
    let context = CIContext()

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()

                PhotosPicker(selection: $selectedPhoto) {
                    if let processedImage {
                        processedImage
                            .resizable()
                            .scaledToFit()
                    } else {
                        ContentUnavailableView(
                            "No Picture",
                            systemImage: "photo.badge.plus",
                            description: Text("Tap to import a photo")
                        )
                    }
                }
                .onChange(of: selectedPhoto, loadImage)

                Spacer()

                VStack {
                    HStack {
                        if let processedImage {
                            Text("Intensity")
                            Slider(value: $filterIntensity)
                                .onChange(of: filterIntensity, applyProcessing)
                        }
                    }

                    HStack {
                        if let processedImage {
                            Text("Radius")
                            Slider(value: $filterRadius)
                                .onChange(of: filterRadius, applyProcessing)
                        }
                    }

                    HStack {
                        if let processedImage {
                            Text("Scale")
                            Slider(value: $filterScale)
                                .onChange(of: filterScale, applyProcessing)
                        }
                    }
                    
                    HStack {
                        if let processedImage {
                            Text("Amount")
                            Slider(value: $filterAmount)
                                .onChange(of: filterAmount, applyProcessing)
                        }
                    }
                }
                .padding(.vertical)

                HStack {
                    if let processedImage {
                        Button("Change filter") {
                            showingFilters = true
                        }
                    }

                    Spacer()

                    // share the picture
                    if let processedImage {
                        ShareLink(
                            item: processedImage,
                            preview: SharePreview(
                                "Instafilter image",
                                image: processedImage
                            )
                        )
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
            .confirmationDialog("Select a filter", isPresented: $showingFilters)
            {
                Button("Crystallize") { setFilter(CIFilter.crystallize()) }
                Button("Edges") { setFilter(CIFilter.edges()) }
                Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                Button("Pixellate") { setFilter(CIFilter.pixellate()) }
                Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
                Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
                Button("Vignette") { setFilter(CIFilter.vignette()) }
                Button("Bloom") { setFilter(CIFilter.bloom()) }
                Button("Thermal") { setFilter(CIFilter.thermal()) }
                Button("Vibrance") { setFilter(CIFilter.vibrance()) }
                Button("Cancel", role: .cancel) {}
            }
        }
    }

    func loadImage() {
        _ = Task {
            // get that selected image and convert it into Data
            guard
                let imageData = try await selectedPhoto?.loadTransferable(
                    type: Data.self
                )
            else { return }

            // Note: We converted the image into Data bacause we can't load a simple SwiftUI image because they can't be fed into Core Image. and Data is easier to deal with.

            // then create a UIImage from that data
            guard let inputImage = UIImage(data: imageData) else { return }

            // convert that UIImage into a CIImage that Core Image can work with.
            let beginImage = CIImage(image: inputImage)

            // Use beginImage as your input image
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            applyProcessing()
        }
    }

    func applyProcessing() {
        // it asks for a Float rather than a Double.
        // This won't work anymore as currentFilter is now only conforms to CIFilter.
        // currentFilter.intensity = Float(filterIntensity)
        // To fix this we could make use of setValue(:_forKey:)
        // currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        // The above line won't work well with different filters, this is a better version
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(
                filterIntensity,
                forKey: kCIInputIntensityKey
            )
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(
                filterRadius * 200,
                forKey: kCIInputRadiusKey
            )
        }
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(
                filterScale * 10,
                forKey: kCIInputScaleKey
            )
        }
        
        if inputKeys.contains(kCIInputAmountKey) {
            currentFilter.setValue(filterAmount, forKey: kCIInputAmountKey)
        }

        // get the output image (CIImage) after applying the filter
        guard let outputImage = currentFilter.outputImage else { return }

        // create a CGImage out of that outputImage (CIImage).
        guard
            let cgImage = context.createCGImage(
                outputImage,
                from: outputImage.extent
            )
        else { return }

        // convert that CGImage into a UIImage
        let uiImage = UIImage(cgImage: cgImage)

        // update our Image with that UIImage
        processedImage = Image(uiImage: uiImage)
    }

    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        // This means image loading is triggered every time a filter changes.
        loadImage()

        filterCount += 1

        if filterCount >= 2 {
            requestReview()
        }
    }
}

#Preview {
    ContentView()
}
