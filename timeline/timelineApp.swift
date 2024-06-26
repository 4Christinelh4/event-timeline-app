//
//  timelineApp.swift
//  timeline
//
//  Created by yuweiL on 25/5/2024.
//

import SwiftUI

@main
struct timelineApp: App {
    
    @StateObject private var timelineLoader = TimelineReader()
    
    var body: some Scene {
        WindowGroup {
            ContentView(allTimelines_: $timelineLoader.allTimelines) {
                Task {
                    do {
                        try await timelineLoader.save(timelines: timelineLoader.allTimelines)
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
            }
            .task {
                do {
                   try await timelineLoader.load()
                } catch {
                    fatalError(error.localizedDescription)
                }
            }
        }

    }
}
