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
    
    //CREATE
    func addEvent() {
        let trimmedName = newEventName.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedLocation = newEventLocation.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedName.isEmpty, !trimmedLocation.isEmpty else { return }
        
        let newEvent = Event(name: trimmedName, date: newEventDate, location: trimmedLocation, items: [])
        events.append(newEvent)
        
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
        }
    }
    
    func deleteEvent(at offsets: IndexSet) {
        events.remove(atOffsets: offsets)
    }
}
