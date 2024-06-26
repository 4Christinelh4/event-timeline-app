//
//  TimelineReader.swift
//  timeline
//
//  Created by yuweiL on 5/6/2024.
//

import Foundation


class TimelineReader: ObservableObject {
    
    var allTimelines: [Timeline] = [
        Timeline(name: "m"), Timeline(name: "a"),
    Timeline(name: "b")]
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask
                                    , appropriateFor: nil, create: false)
        .appendingPathComponent("timelines.data")
    }
    
    func load() async throws {
        let task = Task<[Timeline], Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return []
            }
            
            let events_ = try JSONDecoder().decode([Timeline].self, from: data)
            return events_
        }
        
        let curEventsFromLoad = try await task.value
        self.allTimelines = curEventsFromLoad
    }
    
    func save(timelines: [Timeline])  async throws {
        let task = Task {
            let data = try JSONEncoder().encode(timelines)
            let fileURL = try Self.fileURL()
            try data.write(to: fileURL)
        }
        
        let _ = try await task.value
    }
    
    
}
