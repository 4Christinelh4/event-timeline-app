//
//  AboutPhotoView.swift
//  timeline
//
//  Created by yuweiL on 30/5/2024.
//

import SwiftUI
import PhotosUI

struct AboutPhotoView: View {
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var image: Image?
    var body: some View {
        NavigationStack {
            ZStack {
                image?.resizable().scaledToFit()
            }
            .toolbar {
                PhotosPicker(selection: $selectedPhoto, matching: .images
                ) {
                    Image(systemName: "pencil")
                }
            }
            .task (id: selectedPhoto) {
                image = try? await selectedPhoto?.loadTransferable(type: Image.self)
            }
        }
    }
}

#Preview {
    AboutPhotoView()
}
