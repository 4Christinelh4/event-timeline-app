//
//  CreateEventView.swift
//  timeline
//
//  Created by yuweiL on 30/5/2024.
//

import SwiftUI

struct CreateEventView: View {
    @State private var closed: Bool = false
    @State private var description: String = ""
    @State private var date_: Date = Date.now
    @State private var imageURL: String = ""
    
    var currentTimeline_: Timeline = Timeline()
    
    init( currentTimeline_: Timeline) {
        self.currentTimeline_ = currentTimeline_
    }
    
    init() {
        
    }
    
    var body: some View {
            VStack {
                Form {
                    Section(header: Text("Create new event for \(currentTimeline_.timelineName)")
                        .font(.headline)) {
                            TextField("Description", text: $description)
                                .frame(height: 60, alignment: .top)
                            
                            Toggle("Closed", isOn:  $closed)
                        }.disabled(description.isEmpty)
                    
                    Section(header: Text("Date")){
                        DatePicker("Enter a valid date",
                                   selection: $date_)
                        .frame(height: 60)
                    }
                    
                    Section(header: Text("Add an image from URL or library")) {
                        TextField("URL", text: $imageURL)
                    }
                    
                    Section(header: Text("Preview")) {
                        if !imageURL.isEmpty {
                            AsyncImage(url: URL(string: imageURL)) {result in
                                
                                switch result {

                                case .success(let image):
                                    image.resizable().scaledToFit()
                                case .failure( _):
                                    Image(systemName: "photo")
                                        .font(.footnote)
                                default:
                                    ProgressView()
                                }
                                
                            }
                        }
                    }
                    
                    Button(action: {
                        currentTimeline_.addEvent(ev_: EventHappened(description, date_, imageURL, closed))
                    }, label: {
                        HStack {
                            Spacer()
                            Text("Save changes")
                            Spacer()
                        }
                    }).padding(3)
                }

            }
        
    }
}

#Preview {
    CreateEventView()
}
