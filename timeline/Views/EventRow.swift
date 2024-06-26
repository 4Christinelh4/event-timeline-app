//
//  EventRow.swift
//  timeline
//
//  Created by yuweiL on 26/5/2024.
//

import SwiftUI

struct EventRow: View {
    private var event_: EventHappened
    = EventHappened.emptyEvent
    
    private var eventWithImg =
    EventHappened("image", Date(), "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7a/View_of_Empire_State_Building_from_Rockefeller_Center_New_York_City_dllu_%28cropped%29.jpg/2560px-View_of_Empire_State_Building_from_Rockefeller_Center_New_York_City_dllu_%28cropped%29.jpg")
    
    private var imgPlaceholder: some View
    {
        
        Image(systemName: "photo")
        .font(.system(size: 25)).frame(width: 60, height: 100)
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .stroke(.gray, lineWidth: 2)
            HStack {
                if let eventImage = eventWithImg.imgURL {
                    if !eventImage.isEmpty {
                        AsyncImage(url: URL(string: eventImage)) {
                            result in
                            
                            switch result {

                            case .success(let image):
                                image.resizable().scaledToFit()
                                    .frame(width: 60, height: 100)
                            case .failure( _):
                                imgPlaceholder
                            default:
                                ProgressView()
                            }
                            
                        }
                    } else {
                        imgPlaceholder
                    }
                } else {
                    imgPlaceholder
                }
    
                VStack (alignment: .leading) {
                    Text(event_.eventTime.description)
                        .font(.headline)
                    Text(event_.description)
                }.padding()
            }
        }
        .padding().frame(height: 120)
    }
    
    init() {
        
    }
    
    init(event_: EventHappened) {
        self.event_ = event_
    }
}

#Preview {
    EventRow(event_: EventHappened.emptyEvent)
}
