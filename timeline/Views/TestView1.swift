//
//  TestView1.swift
//  timeline
//
//  Created by yuweiL on 31/5/2024.
//

import SwiftUI

class ObjForTest: ObservableObject {
   @Published var environmentVar: String = "Environment Value X"
}

struct TestView1: View {
    @StateObject var envobj: ObjForTest = ObjForTest()
    
    private var countries: [String] = ["China", "Japan", "France", "US", "Korea"]
    var body: some View {
//        NavigationView {
//            ScrollView {
//                VStack(spacing: 50, content: {
//                    ForEach(countries, id: \.self) {
//                        country in
//                        NavigationLink {
//                            CountryView(country: country)
//                        } label: {
//                            Text("country [\(country)]")
//                        }
//                    }
//                })
//            }.navigationTitle("Country View")
//        }
        
        NavigationStack {
            ScrollView {
                VStack {
                    ForEach(countries, id: \.self) {
                        country in
                        NavigationLink (value: country)  {
                            Text("country - [\(country)]")
                        }
                        Spacer()
                    }
                }
            }
            .navigationTitle("test 2")
            .navigationDestination(for: String.self, destination: {
                country_ in
                CountryView(country: country_ )
            })
        }.environmentObject(envobj)
    }
}

struct CountryView: View {
    @EnvironmentObject var envVar: ObjForTest
    
    let country: String
    init(country: String) {
        self.country = country
    }
    
    var body: some View {
        Text("\(country) + \(envVar.environmentVar)")
    }
}

#Preview {
    TestView1()
}
