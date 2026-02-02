//
//  HomeViewViewModel.swift
//  PitchInPractice
//
//  Created by Sandra Gomez on 10/10/25.
//

import Combine
import SwiftUI

final class HomeViewModel: ObservableObject {
    
    @Published var events: [Event] = []
    @Published var newEventName: String = ""
    @Published var newEventLocation: String = ""
    @Published var newEventDate: Date = Date()
    
    init() {
        events = PersistenceManager.shared.loadEvents()
        // Add this test line
        print ("init() was called - loaded \(events.count) events")
    }
    
    func saveEvents() {
        PersistenceManager.shared.saveEvents(events)
        print("Saved events")
    }
    
    //CREATE
    func addEvent() {
        let trimmedName = newEventName.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedLocation = newEventLocation.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedName.isEmpty, !trimmedLocation.isEmpty else { return }
        let newEvent = Event(name: trimmedName, date: newEventDate, location: trimmedLocation, items: [])
        events.append(newEvent)
        saveEvents()
        // Test line
        print("🔵 addEvent() was called - should have saved")
        newEventName = ""
        newEventLocation = ""
        newEventDate = Date()
    }
    
    // UPDATE (Optional)
    
    func updateEvent( _ event: Event, name: String, location: String, date: Date) {
        if let index = events.firstIndex(where: { $0.id == event.id}) {
            events[index].name = name
            events[index].location = location
            events[index].date = date
            saveEvents()
        }
    }
    
    func deleteEvent(at offsets: IndexSet) {
        events.remove(atOffsets: offsets)
        saveEvents()
    }
}
