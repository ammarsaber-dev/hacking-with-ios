//
//  Prospect.swift
//  HotProspects
//
//  Created by Ammar Saber on 02/07/2026.
//

import Foundation
import SwiftData

@Model
final class Prospect: Identifiable {
    var id: UUID
    var name: String
    var emailAddress: String
    var isContacted: Bool
    var dateAdded: Date

    init(
        id: UUID = UUID(),
        name: String,
        emailAddress: String,
        isContacted: Bool,
        dateAdded: Date = .now
    ) {
        self.id = id
        self.name = name
        self.emailAddress = emailAddress
        self.isContacted = isContacted
        self.dateAdded = dateAdded
    }

    static var example: Prospect {
        Prospect(
            name: "Example Name",
            emailAddress: "example@mail.com",
            isContacted: false
        )
    }
}

enum FilterType {
    case none, contacted, uncontacted
}
