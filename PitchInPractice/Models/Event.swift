//
//  Event.swift
//  PitchInPractice
//
//  Created by Sandra Gomez on 10/10/25.
//

import Foundation
import Combine

struct Event: Identifiable, Codable {
    let id: UUID
    var name: String
    var date: Date
    var location: String
    var items: [Item]
    
    init(name: String, date: Date, location: String, items: [Item] = []) {
        self.id = UUID()
        self.name = name
        self.date = date
        self.location = location
        self.items = items
    }
}
