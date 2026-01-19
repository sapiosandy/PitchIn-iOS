//
//  EventItem.swift
//  PitchInPractice
//
//  Created by Sandra Gomez on 10/10/25.
//

import Foundation

struct Item: Identifiable, Codable  {
    let id: UUID
    var name: String
    var isClaimed: Bool = false
    
    init(name: String, isClaimed: Bool = false) {
        self.id = UUID()
        self.name = name
        self.isClaimed = isClaimed
    }
}
