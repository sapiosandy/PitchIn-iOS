//
//  LocalEventRepository.swift
//  PitchInPractice
//
//  Created by Sandra Gomez on 2/11/26.
//


import Foundation

class LocalEventRepository: EventRepository {
    
    private let eventsKey = "SavedEvents"
    
    func loadEvents() async throws -> [Event] {
        
        // Try to get saved data from UserDefaults
        guard let jsonData = UserDefaults.standard.data(forKey: eventsKey) else {
            print("ℹ️ No saved events found - starting fresh")
            return []
        }
        
        let decoder = JSONDecoder()
        
        do {
            // Convert JSON Data back to events array
            let events = try decoder.decode([Event].self, from: jsonData)
            
            print("✅ Successfully loaded \(events.count) events")
            return events
        } catch {
            throw RepositoryError.decodingFailed
        }
    }
    
    func saveEvents(_ events: [Event]) async throws {
        
        let encoder = JSONEncoder()
        
        do {
            // Convert events array to JSON Data
            let jsonData = try encoder.encode(events)
            
            // Save to UserDefaults
            UserDefaults.standard.set(jsonData, forKey: eventsKey)
            
            print("✅ Successfully saved \(events.count) events")
        } catch {
            throw RepositoryError.saveFailed(underlying: error)
        }
    }
    
    
    func deleteEvent(id: UUID) async throws {
        var events = try await loadEvents()
        events.removeAll {$0.id == id }
        try await saveEvents(events)
    }
}
