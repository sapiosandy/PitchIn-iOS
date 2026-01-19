//
//  EventItem.swift
//  PitchInPractice
//
//  Created by Sandra Gomez on 10/10/25.
//

import Foundation

struct Item: Identifiable {
    let id: UUID = UUID()
    var name: String
    var isClaimed: Bool = false
}
