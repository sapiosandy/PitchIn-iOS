//
//  HomeView.swift
//  PitchInPractice
//
//  Created by Sandra Gomez on 10/15/25.
//

import Foundation
import SwiftUI


struct HomeView: View {
    @StateObject var viewModel = HomeViewModel() //Connects the view to the view model
    
    var body: some View {
        NavigationView {
            List {
                // READ - Show Events
                ForEach(viewModel.events) { event in
                    NavigationLink(
                        destination: EventDetailsView(
                                viewModel: EventDetailsViewModel(event: event)
                            )
                        ) {
                        VStack(alignment: .leading) {
                            Text(event.name)
                                .font(.headline)
                            Text("\(event.location)")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            Text("\(formattedDate(event.date))")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                .onDelete(perform: viewModel.deleteEvent) // DELETE
            }
                .navigationTitle("PitchIn Events")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Add") {
                            viewModel.addEvent() // CREATE
                        }
                        .disabled(viewModel.newEventName.isEmpty || viewModel.newEventLocation.isEmpty)
                    }
                }
                .safeAreaInset(edge: .bottom) {
                    // Add Event Form
                    VStack(alignment: .leading, spacing: 8) {
                        TextField("Event name", text: $viewModel.newEventName)
                            .textFieldStyle(.roundedBorder)
                        
                        TextField("Location", text: $viewModel.newEventLocation)
                            .textFieldStyle(.roundedBorder)
                        DatePicker("Date", selection:$viewModel.newEventDate, displayedComponents: [ .date, .hourAndMinute])
                    }
                    .padding()
                    .background(.ultraThinMaterial)
            
            }
        }
    }
    private func formattedDate(_ date: Date) -> String {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            return formatter.string(from: date)
        }
}
