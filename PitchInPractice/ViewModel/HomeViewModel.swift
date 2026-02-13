//
//  HomeViewViewModel.swift
//  PitchInPractice
//
//  Created by Sandra Gomez on 10/10/25.
//
import SwiftUI
import Observation

@Observable
final class HomeViewModel {
    
    var events: [Event] = []
    var newEventName: String = ""
    var newEventLocation: String = ""
    var newEventDate: Date = Date()
    
    private let repository: EventRepository
    
    init(repository: EventRepository) {
        self.repository = repository
    }
    
    func loadEvents() async {
        do {
            events = try await repository.loadEvents()
            print("✅ Loaded \(events.count) events")
        } catch {
            print ("❌ Failed to load: \(error.localizedDescription)")
        }
    }
    
    func saveEvents() async {
        do {
            try await repository.saveEvents(events)
            print("Saved events")
        } catch {
            print("❌ Failed to save: \(error.localizedDescription)")
        }
    }
    
    func addEvent() async {
        let trimmedName = newEventName.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedLocation = newEventLocation.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedName.isEmpty, !trimmedLocation.isEmpty else { return }
        let newEvent = Event(name: trimmedName, date: newEventDate, location: trimmedLocation, items: [])
        events.append(newEvent)
        await saveEvents()
        // Test line
        print("🔵 addEvent() was called - should have saved")
        newEventName = ""
        newEventLocation = ""
        newEventDate = Date()
    }
    
    func updateEvent( _ event: Event, name: String, location: String, date: Date) {
        if let index = events.firstIndex(where: { $0.id == event.id}) {
            events[index].name = name
            events[index].location = location
            events[index].date = date
            Task {
                await saveEvents()
            }
        }
    }
    func deleteEvent(at offsets: IndexSet) {
        events.remove(atOffsets: offsets)
        Task {
            await saveEvents()
        }
    }
}

