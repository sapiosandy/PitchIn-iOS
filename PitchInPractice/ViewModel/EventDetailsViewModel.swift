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
    @Published var newItemName: String = ""
    
    // Callback to notify parent when items change
    var onItemsChanged: (() -> Void)?
    
    init(event: Event) {
        self.event = event
    }
    
    // Helper to notify parent
    private func notifyChange() {
        objectWillChange.send()
        onItemsChanged?()
    }
    
    //MARK: - CREATE
    func addItem(title: String) {
        let trimmed = title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        let newItem = Item(name: trimmed, isClaimed: false)
        event.items.append(newItem)
        notifyChange()
    }
    
    
    // READ
    var items: [Item] {
        event.items
    }
    
    // MARK: - UPDATE
    func toggleClaimed(for item: Item) {
        guard let index = event.items.firstIndex(where: {$0.id == item.id}) else { return }
        event.items[index].isClaimed.toggle()
        notifyChange()
    }
    
    func renameItem(_ item: Item, to newName: String) {
        if let index = event.items.firstIndex(where: { $0.id == item.id }) {
            event.items[index].name = newName
            notifyChange()
        }
        
        // DELETE
        func deleteItem(at offsets: IndexSet) {
            event.items.remove(atOffsets: offsets)
            notifyChange()
        }
    }
}
