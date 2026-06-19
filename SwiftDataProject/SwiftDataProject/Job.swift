//
//  Job.swift
//  SwiftDataProject
//
//  Created by Ammar Saber on 17/06/2026.
//

import Foundation
import SwiftData

@Model
final class Job {
    var name: String
    var priority: Int
    var owner: User?
    
    init(name: String, priority: Int, owner: User? = nil) {
        self.name = name
        self.priority = priority
        self.owner = owner
    }
}
