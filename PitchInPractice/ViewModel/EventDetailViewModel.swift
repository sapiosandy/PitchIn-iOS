//
//  EventDetailViewModel.swift
//  PitchInPractice
//
//  Created by Sandra Gomez on 10/17/25.
//

import Foundation
import SwiftUI
import Combine

final class EventDetailViewModel: ObservableObject {
    @Published var event: Event
    @Published var newItemName: String = ""
    
    init(event: Event) {
        self.event = event
    }
    
    //CREATE
    func addItem(title: String) {
        let trimmed = title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        let newItem = Item(name: trimmed, isClaimed: false)
        event.items.append(newItem)
    }
    
    
    // READ
    var items: [Item] {
        event.items
    }
    
    // UPDATE
    func toggleClaimed(for item: Item) {
        guard let index = event.items.firstIndex(where: {$0.id == item.id}) else { return }
        event.items[index].isClaimed.toggle()
    }
    
    func renameItem(_ item: Item, to newName: String) {
        if let index = event.items.firstIndex(where: { $0.id == item.id }) {
            event.items[index].name = newName
        }
        
        // DELETE
        func deleteItem(at offsets: IndexSet) {
            event.items.remove(atOffsets: offsets)
        }
    }
}
