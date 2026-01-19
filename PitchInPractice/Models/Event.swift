//
//  Event.swift
//  PitchInPractice
//
//  Created by Sandra Gomez on 10/10/25.
//

import Foundation
import Combine

class Event: ObservableObject, Identifiable, Codable {
    let id: UUID
    @Published var name: String
    @Published var date: Date
    @Published var location: String
    @Published var items: [Item]
    
    enum CodingKeys: String, CodingKey {
        case id, name, date, location, items
    }
    
    init(name: String, date: Date, location: String, items: [Item]) {
        self.id = UUID()
        self.name = name
        self.date = date
        self.location = location
        self.items = items
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        date = try container.decode(Date.self, forKey: .date)
        location = try container.decode(String.self, forKey: .location)
        items = try container.decode([Item].self, forKey: .items)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(date, forKey: .date)
        try container.encode(location, forKey: .location)
        try container.encode(items, forKey: .items)
    }
}
