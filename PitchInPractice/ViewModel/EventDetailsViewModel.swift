//
//  EventDetailViewModel.swift
//  PitchInPractice
//
//  Created by Sandra Gomez on 10/17/25.
//
import Foundation
import SwiftUI
import Combine

final class EventDetailsViewModel: ObservableObject {
    @Published var event: Event
    
    init(event: Event) {
        self.event = event
    }
    
    func addItem(title: String) {
        let trimmed = title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        let newItem = Item(name: trimmed, isClaimed: false)
        event.items.append(newItem)
    }
    
    func toggleClaimed(for item: Item) {
        guard let index = event.items.firstIndex(where: {$0.id == item.id}) else { return }
        event.items[index].isClaimed.toggle()
    }
}
