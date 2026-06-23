//
//  Location.swift
//  BucketList
//
//  Created by Ammar Saber on 22/06/2026.
//

import Foundation
import MapKit

struct Location: Codable, Equatable, Identifiable {
    var id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    // For testing
    #if DEBUG
        static let example = Location(
            id: UUID(),
            name: "Cairo",
            description: "City of a Thousand Minarets",
            latitude: 30.0444,
            longitude: 31.2357
        )
    #endif

    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
