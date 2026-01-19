//
//  Event.swift
//  PitchInPractice
//
//  Created by Sandra Gomez on 10/10/25.
//

import Foundation
import Combine

class Event: ObservableObject, Identifiable {
    let id = UUID()
    @Published var name: String
    @Published var date: Date
    @Published var location: String
    @Published var items: [Item]
    
    init(name: String, date: Date, location: String, items: [Item]) {
        self.name = name
        self.date = date
        self.location = location
        self.items = items
    }
}
