//
//  User.swift
//  SwiftDataProject
//
//  Created by Ammar Saber on 16/06/2026.
//

import Foundation
import SwiftData

@Model
final class User {
    var name: String
    var city: String
    var joinDate: Date
    
    // @Relationship(deleteRule: .cascade) tells SwiftData if the user is deleted, delete his jobs too. because SwiftData by default doesn't remove jobs if user is deleted (.nullify)
    // Even if Job has a relationship with like Location, it will be deleted in cascade.
    @Relationship(deleteRule: .cascade) var jobs = [Job]()
    
    init(name: String, city: String, joinDate: Date, jobs: [Job] = [Job]()) {
        self.name = name
        self.city = city
        self.joinDate = joinDate
        self.jobs = jobs
    }
}
