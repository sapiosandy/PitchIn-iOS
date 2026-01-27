//
//  EventsDetailView.swift
//  PitchInPractice
//
//  Created by Sandra Gomez on 10/15/25.
//

import Foundation
import SwiftUI

struct EventDetailsView: View {
    @ObservedObject var viewModel: EventDetailsViewModel
    @State private var newItemTitle: String = ""

    var body: some View {
        List {
            // MARK: - Event Info
            Section(header: Text("Event Info")) {
                HStack {
                    Text("Date")
                    Spacer()
                    Text(viewModel.event.date, style: .date)
                        .foregroundColor(.secondary)
                }

                HStack {
                    Text("Location")
                    Spacer()
                    Text(viewModel.event.location)
                        .foregroundColor(.secondary)
                }
            }

            // MARK: - Items Needed
            Section(header: Text("Items Needed")) {
                ForEach(viewModel.event.items) { item in
                    HStack {
                        Text(item.name)
                        Spacer()
                        Image(systemName: item.isClaimed ? "checkmark.square.fill" : "circle")
                            .foregroundColor(item.isClaimed ? .green : .gray)
                    }
                    .contentShape(Rectangle())        // whole row tappable
                    .onTapGesture {
                        viewModel.toggleClaimed(for: item)
                    }
                }
//                .onDelete { offsets in
//                    viewModel.deleteItem(at: offsets)
//                }
            }

            // MARK: - Add New Item
            HStack {
                TextField("Add new item...", text: $newItemTitle)
                    .textFieldStyle(.roundedBorder)
                    .submitLabel(.done)
                    .onSubmit {
                        addItem()
                    }

                Button(action: addItem) {
                    Image(systemName: "plus.circle.fill")
                }
                .disabled(newItemTitle.trimmingCharacters(in: .whitespaces).isEmpty)
            }
        }
        .navigationTitle(viewModel.event.name)
        .toolbar {
            EditButton()
        }
    }

    private func addItem() {
        viewModel.addItem(title: newItemTitle)
        newItemTitle = ""
    }
}
