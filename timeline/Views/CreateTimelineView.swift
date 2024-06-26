//
//  CreateTimelineView.swift
//  timeline
//
//  Created by yuweiL on 6/6/2024.
//

import SwiftUI

struct CreateTimelineView: View {
    @State private var newTimeline = Timeline.emptyTimeline
    @Binding var showingSheet: Bool
    @Binding var timelines_: [Timeline]
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Timeline name")) {
                    TextField("Title", text: $newTimeline.timelineName)
                }
            }.toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Dismiss") {
                        showingSheet = false
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        timelines_.append(newTimeline)
                        showingSheet = false
                    }
                }
            }
        }
    }
}

#Preview {
    CreateTimelineView(showingSheet: .constant(true), timelines_: .constant([]))
}
