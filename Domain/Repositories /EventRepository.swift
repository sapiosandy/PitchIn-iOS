//
//  EventRepository.swift
//  PitchInPractice
//
//  Created by Sandra Gomez on 2/2/26.
//

import Foundation

// Protocol defining the contract for event data operations
// This abstraction allows us to swap implementations (local, remote, mock)

protocol EventRepository {
    
    // Load all events from storage
    // - Returns: Array of events, empty if none exist
    // - Throws: RepositoryError if loading fails
    func loadEvents() async throws -> [Event]
    
    // Save events to storage
    // - Parameter events: Array of events to save
    // - Throws: RepositoryError if saving fails
    func saveEvents (_ events: [Event]) async throws
    
    // Delete and event by ID
    // - Parameter id: UUID of event to delete
    // - Throws: RepositoryError if the deletion fails
    func deleteEvent(id: UUID) async throws
}

// Errors that can occur during repository operations
enum RepositoryError: Error, LocalizedError {
    case loadFailed(underlying: Error)
    case saveFailed(underlying: Error)
    case deleteFailed(underlying: Error)
    case encodingFailed
    case decodingFailed
    
    var errorDescription: String? {
        switch self {
        case .loadFailed(let error):
            return "Failed to load events: \(error.localizedDescription)"
        case .saveFailed(let error):
            return "Failed to save events: \(error.localizedDescription)"
        case .deleteFailed(let error):
            return "Failed to delete event: \(error.localizedDescription)"
        case .encodingFailed:
            return "Failed to encode event data"
        case .decodingFailed:
            return "Failed to decode event date"
        }
    }
}

