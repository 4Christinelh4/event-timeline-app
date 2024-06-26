//
//  Timeline.swift
//  timeline
//
//  Created by yuweiL on 26/5/2024.
//

import Foundation

struct EventHappened: Hashable, Codable {
    var description: String
    var eventTime: Date
    var closed: Bool = false
    var imgURL: String?
    
    public static var emptyEvent: EventHappened = EventHappened("Empty event", Date())
    
    init(_ description: String, _ eventTime: Date) {
        self.description = description
        self.eventTime = eventTime
    }
    
    init(_ description: String, _ eventTime: Date, _ imageURL: String) {
        self.description = description
        self.eventTime = eventTime
        self.imgURL = imageURL
    }
    
    init(_ description: String, _ eventTime: Date, _ imageURL: String, _ isClosed: Bool) {
        self.description = description
        self.eventTime = eventTime
        self.imgURL = imageURL
        self.closed = isClosed
    }
}



class Timeline: ObservableObject, Identifiable, Hashable, Codable {
    enum CodingKeys: CodingKey {
        case currentEvents
        case timelineName
    }
    
    public static var emptyTimeline: Timeline = Timeline(name: "Untitled timeline")
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        timelineName = try container.decode(String.self, forKey: .timelineName)
        currentEvents = try container.decode([EventHappened].self, forKey: .currentEvents)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(timelineName, forKey: .timelineName)
        try container.encode(currentEvents, forKey: .currentEvents)
    }
    
    static func == (lhs: Timeline, rhs: Timeline) -> Bool {
        return lhs.id
        == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(timelineName)
    }
    
    var id = UUID()
    
    @Published var currentEvents: [EventHappened] = []
    @Published var timelineName: String = "Timeline X"
    
    init() {

    }
    
    init(name: String) {
        self.timelineName = name
        self.currentEvents.append(EventHappened.emptyEvent)
    }
    
    func addEvent(ev_: EventHappened) {
        currentEvents.append(ev_)
    }
    
    func displayAllEvents() {
        for e in self.currentEvents {
            print("------> \(e.description)")
        }
    }
}
