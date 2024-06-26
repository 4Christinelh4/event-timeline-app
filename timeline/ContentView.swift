//
//  ContentView.swift
//  timeline
//
//  Created by yuweiL on 25/5/2024.
//

import SwiftUI

struct ContentView: View {
    
    @Binding var allTimelines_: [Timeline]
    @State private var isPresentCreateTimeline = false
    @Environment(\.scenePhase) private var scenePhase
    let storeUpdates: () -> Void

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ForEach(allTimelines_, id: \.self) {
                        timeline_ in
                        ZStack {
                            Rectangle().stroke(LinearGradient(colors: [.yellow, .orange], startPoint: UnitPoint.topTrailing, endPoint: UnitPoint.topLeading), lineWidth: 4)
                                .frame(height: 55)
                                .cornerRadius(8.0)
                            NavigationLink(value: timeline_){
                                Text("Link: \(timeline_.timelineName)")
                            }
                        }
                        
                        Spacer()
                    }
                    

                }.padding()
            }
            .navigationTitle("Details")
            .navigationDestination(for: Timeline.self, destination:  {
                t in
                EditTimelineView(currentTimeline: t)
            })
            .toolbar {
                Button(action: {
                    isPresentCreateTimeline = true
                } ) {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $isPresentCreateTimeline) {
            CreateTimelineView(showingSheet: $isPresentCreateTimeline, timelines_: $allTimelines_)
        }
        .onChange(of: scenePhase) {
            p in
            if p == .inactive {
                storeUpdates()
            }
        }
        

    }
}

#Preview {
    ContentView(allTimelines_: .constant([]), storeUpdates:  {} )
}
