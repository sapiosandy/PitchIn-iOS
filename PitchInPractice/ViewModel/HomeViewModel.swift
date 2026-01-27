//
//  HomeViewViewModel.swift
//  PitchInPractice
//
//  Created by Sandra Gomez on 10/10/25.
//

import Foundation
import Combine
import SwiftUI

final class HomeViewModel: ObservableObject {
    //READ
    @Published var events: [Event] = []
    
    // TEMP STATE FOR FORM INPUT
    @Published var newEventName: String = ""
    @Published var newEventLocation: String = ""
    @Published var newEventDate: Date = Date()
    
    init() {
        
            // Load saved events when ViewModel is created
            // When HomeView appears (app opens), it loads any saved events from disk
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
        
        //Every time user creates an event, save the updated array to disk
        saveEvents()
        
        // Test line
        print("🔵 addEvent() was called - should have saved")
        
        // Clear form inputs
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
        
        // When user deletes an event, save the updated array
        saveEvents()
    }
}
