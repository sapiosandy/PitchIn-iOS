//
//  PersistenceManager.swift
//  PitchInPractice
//
//  Created by Sandra Gomez on 1/21/26.
//

import Foundation

class PersistenceManager {
    // Singleton - only one instance exists
    static let shared = PersistenceManager()
    
    // The key we use to store/retrieve events in UserDefaults
    private let eventsKey = "SavedEvents"
    
    // Private init - forces everyone to use .shared
    private init() {}
    
    // MARK: - Save Events
    func saveEvents(_ events: [Event]) {
        let encoder = JSONEncoder()
        
        do {
            // Convert events array to JSON Data
            let jsonData = try encoder.encode(events)
            
            // Save to UserDefaults
            UserDefaults.standard.set(jsonData, forKey: eventsKey)
            
            print("✅ Successfully saved \(events.count) events")
        } catch {
            print("❌ Failed to save events: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Load Events
    func loadEvents() -> [Event] {
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
            print("❌ Failed to decode events: \(error.localizedDescription)")
            return []
        }
    }
    
    // MARK: - Clear All Data (useful for testing)
    func clearAllData() {
        UserDefaults.standard.removeObject(forKey: eventsKey)
        print("🗑️ Cleared all saved data")
    }
}
