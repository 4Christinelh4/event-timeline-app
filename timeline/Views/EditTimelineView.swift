//
//  EditTimelineView.swift
//  timeline
//
//  Created by yuweiL on 26/5/2024.
//

import SwiftUI

struct EditTimelineView: View {
    @ObservedObject var currentTimeline: Timeline
    
    init(currentTimeline: Timeline) {
        self.currentTimeline = currentTimeline
    }
    
    var body: some View {
            VStack {
                
                NavigationLink(value: currentTimeline.timelineName) {
                   Text("Event: \(currentTimeline.timelineName)")
                        .font(.system(size: 40))
                }
                .navigationDestination(for: String.self) {_ in 
                    CreateEventView(currentTimeline_: currentTimeline)
                }
                
                Spacer()
                
                ScrollView {
                    LazyVStack {
                        ForEach(currentTimeline.currentEvents, id: \.self) {ev_ in
                            EventRow(event_: ev_)
                        }
                    }
                }
            }
            .background(.linearGradient(colors: [.orange, .yellow, .white, .cyan], startPoint: UnitPoint.topTrailing, endPoint: UnitPoint.topLeading))
        
    }
}

#Preview {
    EditTimelineView(currentTimeline: Timeline())
}
